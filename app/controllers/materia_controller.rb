class MateriaController < ApplicationController
  def index
    if params[:filtro].present? && params[:valor].present?
      where = params[:filtro] == 'descricao' ? "descricao LIKE '%#{params[:valor]}%'" : "#{params[:filtro]} = '#{params[:valor]}'"
    else
      where = nil
      params[:valor] = nil
    end
    @materias = where.nil? ? Materium.all : Materium.where(where)

    respond_to do |format|
      format.html
      format.json { render json: @materias }
    end
  end

  def show
    @materium = Materium.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @materium }
    end
  end

  def new
    @materium = Materium.new

    respond_to do |format|
      format.html
      format.json { render json: @materium }
    end
  end

  def edit
    @materium = Materium.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @materium }
    end
  end

  def create
    @materium = Materium.new(params[:materium])

    respond_to do |format|
      if @materium.save
        format.html { redirect_to materia_url, notice: 'Materia criado com sucesso!' }
        format.json { render json: @materium, status: :ok, location: @materium }
      else
        format.html { render action: "new" }
        format.json { render json: @materium.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @materium = Materium.find(params[:id])

    respond_to do |format|
      if @materium.update_attributes(params[:materium])
        format.html { redirect_to materia_url, notice: 'Materia atualizado com sucesso!' }
        format.json { render json: @materium, status: :ok, location: @materium }
      else
        format.html { render action: "edit" }
        format.json { render json: @materium.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @materium = Materium.find(params[:id])
    @materium.destroy

    respond_to do |format|
      format.html { redirect_to materia_url }
      format.json { render json: @materium, status: :ok, location: @materium }
    end
  end
end
