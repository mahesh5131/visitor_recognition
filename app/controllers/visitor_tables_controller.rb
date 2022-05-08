class VisitorTablesController < ApplicationController
  before_action :set_visitor_table, only: %i[ show edit update destroy ]

  # GET /visitor_tables or /visitor_tables.json
  def index
    @visitor_tables = VisitorTable.all
  end

  # GET /visitor_tables/1 or /visitor_tables/1.json
  def show
  end

  # GET /visitor_tables/new
  def new
    @visitor_table = VisitorTable.new
  end

  # GET /visitor_tables/1/edit
  def edit
  end

  # POST /visitor_tables or /visitor_tables.json
  def create
    @visitor_table = VisitorTable.new(visitor_table_params)

    respond_to do |format|
      if @visitor_table.save
        #send mail
        UserMailer.visitor_information(@visitor_table).deliver
        format.html { redirect_to visitor_table_url(@visitor_table), notice: "Visitor table was successfully created." }
        format.json { render :show, status: :created, location: @visitor_table }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visitor_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitor_tables/1 or /visitor_tables/1.json
  def update
    respond_to do |format|
      if @visitor_table.update(visitor_table_params)
        format.html { redirect_to visitor_table_url(@visitor_table), notice: "Visitor table was successfully updated." }
        format.json { render :show, status: :ok, location: @visitor_table }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visitor_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitor_tables/1 or /visitor_tables/1.json
  def destroy
    @visitor_table.destroy

    respond_to do |format|
      format.html { redirect_to visitor_tables_url, notice: "Visitor table was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor_table
      @visitor_table = VisitorTable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visitor_table_params
      params.require(:visitor_table).permit(:name, :relation, :classification, :no_of_visits, :last_visited, :notes)
    end
end
