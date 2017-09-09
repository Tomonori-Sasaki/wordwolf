class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    player_num = User.all.count + 1
    @user = User.new(name: "player#{player_num}",image: params[:image])
    @user.save
    flash[:notice] = '新たなデュエリストが登録されました'
    redirect_to(users_path)
  end

  def setting
    if User.all.count < 3
      flash[:notice] = '友達が少なすぎてプレイできません。まずはお友達を作りましょう。'
      redirect_to(users_path)
    end
    @users = User.all
  end

  def setting_create
    @users = User.all

    @users.each do |user|
      user.word = nil
    end

    word1 = params[:user][:word1]
    word2 = params[:user][:word2]

    unless word1.empty? || word2.empty?
      if word1 != word2
        save_words_at_random(word1,word2)
        redirect_to(users_not_seen_path)
      else
        flash[:notice] = '2つの異なるワードを設定してくれよな'
        redirect_to(users_setting_path)
      end
    else
      flash[:notice] = 'ワードを設定しろって言ってるやん。頭悪いんか？？'
      redirect_to(users_setting_path)
    end
  end

  def not_seen
  end

  def destroy
    if User.all[0]
      User.last.destroy
      flash[:notice] = '1名のデュエリストを闇に葬むりました'
    end
    redirect_to(users_path)
  end

  def destroy_all
    if User.all[0]
      User.destroy_all
      flash[:notice] = '全てのデュエリストを闇に葬りました'
    end
    redirect_to(users_path)
  end

  def set_words_at_random(w3,w4)
    @users[rand(1..@users.count)-1].word = w3
    @users.each do |user|
      if user.word.nil?
        user.word = w4
      end
    end
  end

  def save_words_at_random(w1,w2)
    if rand(0..1) == 0
      set_words_at_random(w1,w2)
    else
      set_words_at_random(w2,w1)
    end
    @users.each do |user|
      user.save
    end
  end




end
