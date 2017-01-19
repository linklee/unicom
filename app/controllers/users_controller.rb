class UsersController < ApplicationController
  before_action :authenticate_admin! 

  before_action :set_user, only: [:show, :edit, :update, :destroy] 
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end
  def csv
    @users = User.all
    upd_statuses
  end
  def upd_statuses_old
    auth = { username: Rails.application.secrets[:user], password:  Rails.application.secrets[:pwd]}

    @users.each do |user| 
      url = "https://unicom24.ru/api/partners/requests/v1/"
      result = HTTParty.get(
        url + user.id.to_s, 
        basic_auth: auth,
      )
      user.update :status => result.parsed_response['status']
    end
  end

  def upd_statuses
    url = 'https://unicom24.ru/api/partners/requests/v1/list/'
    auth = { username: Rails.application.secrets[:user], password:  Rails.application.secrets[:pwd]}
    result = HTTParty.get(
        url, 
        basic_auth: auth,
    )
    results = result.parsed_response['results']
    results.each do |r|
      user = User.where :app_id => r['id']
      user = user.first
      byebug
      if user && user.status != r['status']
        user.update :status => r['status']
      end
    end
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def auth 
      if params[:key] != Rails.application.secrets[:key]
        redirect_to "/"
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fact_locality_name, :fact_street, :reg_house, :fact_flat, :same_address, :reg_locality_name, :reg_street, :reg_house, :reg_flat, :surname, :name, :patronymic, :mobile_phone, :email, :desired_amount, :agree_rules, :fact_city, :fact_house, :reg_city)
    end
end
