class VisitorsController < ApplicationController
  before_action :set_visitor, only: %i[ show edit update destroy ]

  # GET /visitors or /visitors.json
  def index
    @visitors = Visitor.all
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
    folder_path = Rails.root.join("public/camera_images")
    @files = Dir["#{folder_path}"+"/*"]
    if @files.present?
      @files.each do |file|
        base_64_string = Base64.encode64(open(file) { |io| io.read })
        visitor = Visitor.find_or_create_by(image_string: base_64_string)
        classification = visitor.no_of_visit.nil? ? 'stranger' : visitor.classification
        visitor.update(no_of_visit: visitor.no_of_visit + 1, last_visited: Time.now, classification: classification)
        File.delete(file) if File.exist?(file)
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
