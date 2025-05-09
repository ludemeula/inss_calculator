class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit update destroy]

  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  def new
    @proponent = Proponent.new
    @proponent.addresses.build
    @proponent.contacts.build
  end

  def create
    @proponent = Proponent.new(proponent_params)
    @proponent.inss_discount = InssCalculator.calculate(@proponent.salary)

    if @proponent.save
      redirect_to proponents_path, notice: "Proponente criado com sucesso!"
    else
      render :new
    end
  end

  def show
    @proponent = Proponent.find(params[:id])
  end

  def edit
    @proponent = Proponent.find(params[:id])
  end

  def update
    @proponent = Proponent.find(params[:id])
    if @proponent.update(proponent_params)
      redirect_to @proponent, notice: "Proponente atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @proponent.destroy
    redirect_to proponents_path, notice: "Proponente removido com sucesso!"
  end

  def salary_report
    @ranges = {
      "At\u00E9 R$ 2.000" => 0...2000,
      "R$ 2.000 - R$ 5.000" => 2000...5000,
      "R$ 5.000 - R$ 10.000" => 5000...10_000,
      "Acima de R$ 10.000" => 10_000..Float::INFINITY
    }

    @report_data =
      @ranges.transform_values { |range| Proponent.where(salary: range).count }
  end

  def calculate_inss
    salary = params[:salary].to_f
    discount = InssCalculator.calculate(salary)
    render json: { inss_discount: discount }
  end

  def new_contact
    @proponent = Proponent.find(params[:proponent_id])
    @contact = @proponent.contacts.build
  end
  
  def create_contact
    @proponent = Proponent.find(params[:proponent_id])
    @contact = @proponent.contacts.build(contact_params)
  
    if @contact.save
      redirect_to edit_proponent_path(@proponent), notice: 'Contato adicionado com sucesso.'
    else
      render :new_contact
    end
  end
  
  def destroy_contact
    @proponent = Proponent.find(params[:proponent_id])
    @contact = @proponent.contacts.find(params[:id])

    if @contact.destroy
      redirect_to edit_proponent_path(@proponent), notice: 'Contato removido com sucesso.'
    else
      redirect_to edit_proponent_path(@proponent), alert: 'Não foi possível remover o contato.'
    end
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params
      .require(:proponent)
      .permit(
        :name,
        :documents,
        :birth_date,
        :salary,
        :inss_discount,
        addresses_attributes: %i[ id street number neighborhood city state zip_code _destroy  ],
        contacts_attributes: %i[id contact_type value _destroy],
      )
  end
end
