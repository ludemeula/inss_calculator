class ProponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proponent, only: %i[show edit update destroy]
  before_action :filter_empty_addresses!, only: %i[create update]
  before_action :set_inss_discount, only: %i[create update]

  def index
    @proponents = Proponent.order(:id).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.json { render json: @proponents, include: %i[addresses contacts] }
    end
  end

  def new
    @proponent = Proponent.new
    build_missing_associations
  end

  def create
    @proponent = Proponent.new(proponent_params)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponents_path, notice: 'Proponente criado com sucesso!' }
        format.json { render json: @proponent, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @proponent, include: %i[addresses contacts] }
    end
  end

  def edit
    build_missing_associations
  end

  def update
    respond_to do |format|
      if @proponent.update(proponent_params)
        format.html { redirect_to @proponent, notice: 'Proponente atualizado com sucesso.' }
        format.json { render json: @proponent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @proponent.destroy
        format.html { redirect_to proponents_path, notice: 'Proponente removido com sucesso!' }
        format.json { head :no_content }
      else
        format.html { redirect_to proponents_path, alert: 'Erro ao remover o proponente.' }
        format.json { render json: { error: 'Erro ao remover o proponente' }, status: :unprocessable_entity }
      end
    end
  end

  def calculate_inss
    salary = params[:salary].to_f
    discount = InssCalculator.calculate(salary)
    render json: { inss_discount: discount }
  end

  private

  def set_proponent
    @proponent = Proponent.find_by(id: params[:id])
    return if @proponent

    respond_to do |format|
      format.html { redirect_to proponents_path, alert: 'Proponente não encontrado.' }
      format.json { render json: { error: 'Proponente não encontrado' }, status: :not_found }
    end
  end

  def build_missing_associations
    types = @proponent.addresses.map(&:address_type)
    @proponent.addresses.build(address_type: 'principal') unless types.include?('principal')
    @proponent.addresses.build(address_type: 'secundario') unless types.include?('secundario')
    @proponent.contacts.build if @proponent.contacts.empty?
  end

  def filter_empty_addresses!
    return unless params[:proponent]&.dig(:addresses_attributes)

    params[:proponent][:addresses_attributes].reject! do |_, address|
      %i[street number neighborhood city state zip_code].all? { |field| address[field].blank? }
    end
  end

  def set_inss_discount
    salary = params[:proponent][:salary].to_f
    @proponent ||= Proponent.new
    @proponent.inss_discount = InssCalculator.calculate(salary)
  end

  def proponent_params
    params.require(:proponent).permit(
      :id,
      :name,
      :cpf,
      :rg,
      :birth_date,
      :salary,
      :inss_discount,
      addresses_attributes: %i[
        id street number neighborhood city state zip_code address_type _destroy
      ],
      contacts_attributes: %i[id contact_type value _destroy]
    )
  end
end
