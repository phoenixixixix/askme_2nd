class UsersController < ApplicationController

  before_action :load_user, except: [:index, :new, :create]

  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Ви вже залогінені' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Ви вже залогінені' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'User created'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User updated'
    else
      render 'edit'
    end
  end

  def show
    @question = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @question_count = @question.count
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
                                 :avatar_url)
  end
end
