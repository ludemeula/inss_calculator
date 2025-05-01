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

    private

    def set_proponent
      @proponent = Proponent.find(params[:id])
    end

    def proponent_params
      params.require(:proponent).permit(
        :name, :documents, :birth_date, :salary,
        addresses_attributes: [ :id, :street, :number, :neighborhood, :city, :state, :zip_code, :_destroy ],
        contacts_attributes: [ :id, :contact_type, :value, :_destroy ]
      )
    end
end
