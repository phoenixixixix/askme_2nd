class UsersController < ApplicationController

  before_action :load_user, except: %i[index new create]

  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_path, alert: 'Ви вже ввійшли' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Ви вже ввійшли' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Профіль створено'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Дані профілю оновлено'
    else
      render 'edit'
    end
  end

  def show
    @question = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @question.count
    @answers_count = @question.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Профіль видалено'
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :name,
                                 :username,
                                 :avatar_url,
                                 :prof_bg_color)
  end
end
