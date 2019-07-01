class EmployeesController < ApplicationController
  def index
    @employee = Employee.active

    render json: @employee
  end

  def show
    @employee = Employee.find(params[:id])

    render json: @employee
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: employee_url(@employee)
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :rewards_balance)
  end
end
