class EstadosController < ApplicationController
  include Pagy::Backend
  before_action :set_estado, only: %i[ show edit update destroy ]

  # GET /estados or /estados.json
  def index
    @q = Estado.ransack(params[:q])
    # @estados = Estado.all
    @pagy, @estados = pagy(@q.result, items: 10)
  end

  # GET /estados/1 or /estados/1.json
  def show
  end

  # GET /estados/new
  def new
    @estado = Estado.new
  end

  # GET /estados/1/edit
  def edit
  end

  # POST /estados or /estados.json
  # def create
  #   @estado = Estado.new(estado_params)

  #   respond_to do |format|
  #     if @estado.save
  #       format.html { redirect_to estado_url(@estado), notice: "Estado criado com sucesso!" }
  #       format.json { render :show, status: :created, location: @estado }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @estado.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    p "EstadosController#create"
    p "estado params: ",estado_params
    @estado = Estado.new(estado_params)

    respond_to do |format|
      if @estado.save
        flash.now[:notice] = "Estado #{@estado.id} Criado!"
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_estado', partial: 'estados/form', locals: { estado: Estado.new }),
            turbo_stream.prepend('estados', partial: 'estados/estado', locals: { estado: @estado }),
            render_turbo_flash,
          ]
        end
        format.html { redirect_to estado_url(@estado), notice: "Estado criado com sucesso!" }
        # format.json { render :show, status: :created, location: @estado }
      else
        # flash.now[:alert] = "Erro ao incluir estado!"
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_estado', partial: 'estados/form', locals: { estado: @estado }),
            render_turbo_flash,
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @estado.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /estados/1 or /estados/1.json
  def update
    respond_to do |format|
      if @estado.update(estado_params)
        format.html { redirect_to estado_url(@estado), notice: "Estado atualizado com sucesso!" }
        format.json { render :show, status: :ok, location: @estado }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estados/1 or /estados/1.json
  def destroy
    @estado.destroy!

    respond_to do |format|
      format.html { redirect_to estados_url, notice: "Estado deletado com sucesso!" }
      format.json { head :no_content }
    end
  end

  def clear_filters
    # Você pode redefinir os parâmetros de pesquisa para seus valores padrão aqui
    p "caiu no clear_filters"
    redirect_to estados_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estado
      @estado = Estado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def estado_params
      params.require(:estado).permit(:nome, :sigla)
    end
end