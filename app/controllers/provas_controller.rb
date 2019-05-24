class ProvasController < ApplicationController
  def index
    if params[:filtro].present? && params[:valor].present?
      valor = params[:filtro] == 'data' ? data_us(params[:valor]) : params[:valor]
      valor = case params[:filtro]
      when 'data'
        data_us(params[:valor])
      when 'nota'
        params[:valor].gsub(',','.')
      else
        params[:valor]
      end
      where = "#{params[:filtro]} = '#{valor}'"
    else
      where = nil
      params[:valor] = nil
    end
    @provas = where.nil? ? Prova.all : Prova.where(where)

    respond_to do |format|
      format.html
      format.json { render json: @provas }
    end
  end

  def show
    @prova = Prova.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @prova }
    end
  end

  def new
    @prova = Prova.new
    $alunos = Aluno.all
    $materias = Materium.all

    respond_to do |format|
      format.html
      format.json { render json: @prova }
    end
  end

  def edit
    @prova = Prova.find(params[:id])
    $alunos = Aluno.all
    $materias = Materium.all

    respond_to do |format|
      format.html
      format.json { render json: @prova }
    end
  end

  def create
    params[:prova][:nota] = params[:prova][:nota].gsub(',','.')
    @prova = Prova.new(params[:prova])

    respond_to do |format|
      if @prova.save
        format.html { redirect_to provas_url, notice: 'Prova criada com sucesso!' }
        format.json { render json: @prova, status: :ok, location: @prova }
      else
        format.html { render action: "new" }
        format.json { render json: @prova.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @prova = Prova.find(params[:id])

    respond_to do |format|
      params[:prova][:nota] = params[:prova][:nota].gsub(',','.')
      if @prova.update_attributes(params[:prova])
        format.html { redirect_to provas_url, notice: 'Prova atualizada com sucesso!' }
        format.json { render json: @prova, status: :ok, location: @prova }
      else
        format.html { render action: "edit" }
        format.json { render json: @prova.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @prova = Prova.find(params[:id])
    @prova.destroy

    respond_to do |format|
      format.html { redirect_to provas_url }
      format.json { render json: @prova, status: :ok, location: @prova }
    end
  end
end
