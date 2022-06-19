class VisitorsController < ApplicationController
  before_action :set_visitor, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /visitors or /visitors.json
  def index
    @visitors = Visitor.all
    time = Time.now
    @today_visitors = @visitors.where(:last_visited => time.beginning_of_day..time.end_of_day)
    @weekly_visitors = @visitors.where(:last_visited => (time - 7.days).beginning_of_day..time.end_of_day)
  end

  # GET /visitors/1 or /visitors/1.json
  def show
  end

  # GET /visitors/new
  def new
    @visitor = Visitor.new
  end

  # GET /visitors/1/edit
  def edit
  end

  # POST /visitors or /visitors.json
  def create
    @visitor = Visitor.new(visitor_params)

    respond_to do |format|
      if @visitor.save
        format.html { redirect_to visitor_url(@visitor), notice: "Visitor was successfully created." }
        format.json { render :show, status: :created, location: @visitor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_visitor
    access_key_id = ENV['ACCESS_KEY_ID']
    secret_access_key = ENV['SECRET_ACCESS_KEY']
    s3 = Aws::S3::Client.new(access_key_id: access_key_id, secret_access_key: secret_access_key)
    bucket = 'visitorsreco'
    s3.list_objects(bucket: bucket).each do |response|
      response.contents.each do |object|
        photo  = object.key
        client   = Aws::Rekognition::Client.new(region: 'ap-south-1', access_key_id: access_key_id, secret_access_key: secret_access_key)
        attrs = {image: { s3_object: { bucket: bucket, name: photo},}, attributes: ['ALL']}
        response = client.detect_faces attrs
        low  = 0
        high = 0
        gender = nil
        response.face_details.each do |face_detail|
          low  = face_detail.age_range.low
          high = face_detail.age_range.high
          gender = face_detail.gender.value
        end
        File.open(Rails.root.join("public/camera_images")+"#{object.key}", 'wb') do |file|
          reap = s3.get_object({ bucket:bucket, key: photo }, target: file)
          base_64_string = Base64.encode64(open(file) { |io| io.read })
          visitor = Visitor.find_or_create_by(image_string: base_64_string)
          classification = visitor.no_of_visit.nil? ? 'stranger' : visitor.classification
          visitor.update(no_of_visit: visitor.no_of_visit.to_i + 1, last_visited: Time.now, classification: classification, gender: gender)
          File.delete(file) if File.exist?(file)
          s3.delete_object({ bucket:bucket, key: photo })
        end
      end
    end
    redirect_to visitors_url
  end

  # PATCH/PUT /visitors/1 or /visitors/1.json
  def update
    respond_to do |format|
      if @visitor.update(visitor_params)
        format.html { redirect_to visitor_url(@visitor), notice: "Visitor was successfully updated." }
        format.json { render :show, status: :ok, location: @visitor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitors/1 or /visitors/1.json
  def destroy
    @visitor.destroy

    respond_to do |format|
      format.html { redirect_to visitors_url, notice: "Visitor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor
      @visitor = Visitor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visitor_params
      params.require(:visitor).permit(:name, :relation, :classification, :no_of_visit, :last_visited, :notes)
    end
end
