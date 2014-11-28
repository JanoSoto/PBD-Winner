class OrganizadorsController < ApplicationController
  before_action :set_organizador, only: [:show, :edit, :update, :destroy]

  # GET /organizadors
  # GET /organizadors.json
  def index
    @organizadors = Organizador.all
  end

  # GET /organizadors/1
  # GET /organizadors/1.json
  def show
  end

  # GET /organizadors/new
  def new
    @organizador = Organizador.new
  end

  # GET /organizadors/1/edit
  def edit
  end

  # POST /organizadors
  # POST /organizadors.json
  def create
    @organizador = Organizador.new(organizador_params)

    respond_to do |format|
      if @organizador.save
        format.html { redirect_to @organizador, notice: 'Organizador was successfully created.' }
        format.json { render :show, status: :created, location: @organizador }
      else
        format.html { render :new }
        format.json { render json: @organizador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizadors/1
  # PATCH/PUT /organizadors/1.json
  def update
    respond_to do |format|
      if @organizador.update(organizador_params)
        format.html { redirect_to @organizador, notice: 'Organizador was successfully updated.' }
        format.json { render :show, status: :ok, location: @organizador }
      else
        format.html { render :edit }
        format.json { render json: @organizador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizadors/1
  # DELETE /organizadors/1.json
  def destroy
    @organizador.destroy
    respond_to do |format|
      format.html { redirect_to organizadors_url, notice: 'Organizador was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organizador
      @organizador = Organizador.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organizador_params
      params.require(:organizador).permit(:nombre_org, :apellido_pat_org, :apellido_mat_org, :rut_org, :sexo_org, :fecha_nac_org, :email_org, :foto_org)
    end
end
