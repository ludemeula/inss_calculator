class ProponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proponent, only: %i[show edit update destroy]

  def index
    @proponents = Proponent.page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.json { render json: @proponents, include: [ :addresses, :contacts ] }
    end
  end

  def new
    @proponent = Proponent.new
    @proponent.addresses.build
    @proponent.contacts.build
  end

  def create
    @proponent = Proponent.new(proponent_params)
    @proponent.inss_discount = InssCalculator.calculate(@proponent.salary)

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
      format.json { render json: @proponent, include: [ :addresses, :contacts ] }
    end
  end

  def edit
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

  def salary_report
    @ranges = {
      'Até R$ 2.000' => 0...2000,
      'R$ 2.000 - R$ 5.000' => 2000...5000,
      'R$ 5.000 - R$ 10.000' => 5000...10_000,
      'Acima de R$ 10.000' => 10_000..Float::INFINITY
    }

    @report_data = @ranges.transform_values do |range|
      Proponent.where(salary: range).count
    end

    respond_to do |format|
      format.html
      format.json { render json: @report_data }
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

    unless @proponent
      respond_to do |format|
        format.html { redirect_to proponents_path, alert: 'Proponente não encontrado.' }
        format.json { render json: { error: 'Proponente não encontrado' }, status: :not_found }
      end
    end
  end

  def proponent_params
    params.require(:proponent).permit(
      :name,
      :documents,
      :birth_date,
      :salary,
      :inss_discount,
      addresses_attributes: %i[id street number neighborhood city state zip_code _destroy],
      contacts_attributes: %i[id contact_type value _destroy]
    )
  end
end
