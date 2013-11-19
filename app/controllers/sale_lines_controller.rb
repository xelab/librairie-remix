class SaleLinesController < ApplicationController
  before_action :set_sale_line, only: [:show, :edit, :update, :destroy]

  # GET /sale_lines
  # GET /sale_lines.json
  def index
    @sale_lines = SaleLine.all
  end

  # GET /sale_lines/1
  # GET /sale_lines/1.json
  def show
  end

  # GET /sale_lines/new
  def new
    @sale_line = SaleLine.new
  end

  # GET /sale_lines/1/edit
  def edit
  end

  # POST /sale_lines
  # POST /sale_lines.json
  def create
    @sale_line = SaleLine.new(sale_line_params)

    respond_to do |format|
      if @sale_line.save
        format.html { redirect_to @sale_line, notice: 'Sale line was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sale_line }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sale_lines/1
  # PATCH/PUT /sale_lines/1.json
  def update
    respond_to do |format|
      if @sale_line.update(sale_line_params)
        format.html { redirect_to @sale_line, notice: 'Sale line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_lines/1
  # DELETE /sale_lines/1.json
  def destroy
    @sale_line.destroy
    respond_to do |format|
      format.html { redirect_to sale_lines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale_line
      @sale_line = SaleLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_line_params
      params.require(:sale_line).permit(:sale_id, :book_id, :buy_quantity, :deposit_quantity, :price)
    end
end
