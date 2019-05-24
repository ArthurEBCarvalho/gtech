# encoding: utf-8
class AlunosController < ApplicationController
  def index
    if params[:filtro].present? && params[:valor].present?
      if params[:filtro] == 'nascimento'
        begin
          Date.parse(data_us(params[:valor]))
        rescue
          redirect_to alunos_url, notice: 'Data inválida!'
          return
        end
      end
      valor = params[:filtro] == 'nascimento' ? data_us(params[:valor]) : params[:valor]
      where = params[:filtro] == 'endereco' ? "endereco LIKE '%#{valor}%'" : "#{params[:filtro]} = '#{params[:valor]}'"
    else
      where = nil
      params[:valor] = nil
    end
    @alunos = where.nil? ? Aluno.all : Aluno.where(where)

    respond_to do |format|
      format.html
      format.json { render json: @alunos }
    end
  end

  def show
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @aluno }
    end
  end

  def new
    @aluno = Aluno.new

    respond_to do |format|
      format.html
      format.json { render json: @aluno }
    end
  end

  def edit
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @aluno }
    end
  end

  def create
    params[:aluno][:nascimento] = data_br params[:aluno][:nascimento]
    @aluno = Aluno.new(params[:aluno])

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to alunos_url, notice: 'Aluno cadastrado com sucesso!' }
        format.json { render json: @aluno.id, status: :ok, location: @aluno }
      else
        format.html { render action: "new" }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      params[:aluno][:nascimento] = data_br params[:aluno][:nascimento]
      if @aluno.update_attributes(params[:aluno])
        format.html { redirect_to alunos_url, notice: 'Aluno atualizado com sucesso!' }
        format.json { render json: @aluno, status: :ok, location: @aluno }
      else
        format.html { render action: "edit" }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @aluno = Aluno.find(params[:id])
    @aluno.destroy

    respond_to do |format|
      format.html { redirect_to alunos_url }
      format.json { render json: @aluno, status: :ok, location: @aluno }
    end
  end
end
