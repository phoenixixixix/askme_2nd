class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Oleg',
        username: 'phoenixixixix',
        avatar_url: 'https://avatarfiles.alphacoders.com/158/15867.jpg'
      ),
      User.new(
        id: 2,
        name: 'Vitaliy',
        username: 'vetal',
        avatar_url: nil
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Oleg',
      username: 'phoenixixixix',
      avatar_url: 'https://avatarfiles.alphacoders.com/158/15867.jpg'
    )

    @question = [
      Question.new(text: 'How are you?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Ti pidor azazazzz', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Where you from?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
