class InformController < ApplicationController
  before_action :authenticate_user!, only: [:add, :create]
  before_action :parse_params, only: :create
  before_action :select_class, only: [:add, :view]

  def view
    @records = Progress.all
  end

  def add
    @res = ['Победитель', 'Призер', 'Участник']
  end

  def create
    res = Progress.find_by(parse_params)
    if res.nil?
      record = Progress.new(parse_params)
      if record.save
        respond_to do |format|
          format.html { redirect_to inform_add_path, notice: 'Новые данные добавлены' }
          #format.html { render :add, notice: 'Successfully create new record'}
          format.json { render json: record.to_json}
        end
      else 
        respond_to do |format|
          format.html { redirect_to inform_add_path, notice:'Поля заполнены неправильно' }
          format.json { render json: 'invalid data'}
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to inform_add_path, notice:'Данная запись уже существует' }
        format.json { render json: 'invalid data'}
      end
    end
  end 

  private

  def parse_params
    hash = {name: params[:name], surname: params[:surname], classroom: params[:classroom], activity: params[:activity], result: params[:result]}
  end

  def select_class
    @classes = [1,2,3,4,5,6,7,8,9,10,11]
  end
end
