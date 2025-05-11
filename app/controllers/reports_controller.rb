class ReportsController < ApplicationController
  before_action :authenticate_user!

  def salary_report
    @ranges = {
      'Até R$ 1.518,00' => 0...1518.00,
      'R$ 1.518,01 - R$ 2.793,88' => 1518.01...2793.88,
      'R$ 2.793,89 - R$ 4.190,83' => 2793.89...4190.83,
      'R$ 4.190,84 - R$ 8.157,41' => 4190.84...8157.41,
      'Acima de R$ 8.157,42' => 8157.42..Float::INFINITY,
    }

    @report_data = @ranges.transform_values { |range| Proponent.where(salary: range).count }

    respond_to do |format|
      format.html
      format.json { render json: @report_data }
    end
  end
end
