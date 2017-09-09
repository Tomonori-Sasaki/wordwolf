class UsersController < ApplicationController

  def index
    @users = User.all
    @users.each do |user|
      if user.voted
        user.voted = 0
        user.save
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    player_num = User.all.count + 1
    @user = User.new(name: "player#{player_num}",image: params[:image], voted: 0, user_id: player_num)
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
        redirect_to(users_not_seen_path(1))
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
    @player_num = params[:num].to_i - 1
    @user = User.all[@player_num]
    if @user.nil?
      redirect_to(users_start_path)
    end
  end

  def subject
    @player_num = params[:num].to_i - 1
    @user = User.all[@player_num]
  end

  def start
  end

  def finish
  end

  def vote
    @player_num = params[:num].to_i - 1
    @users = User.all
    @user = @users[@player_num]
    if @user.nil?
      redirect_to(users_kill_path)
    end
  end

  def vote_create
    user = User.find_by(user_id: params[:user_id])
    user.voted += 1
    user.save
    redirect_to(users_vote_path(params[:num].to_i + 1))
  end

  def kill
    @voted_max = User.maximum('voted')
    @killed_users = User.where(voted: @voted_max)
  end

  def result
    @users = User.all
    @voted_max = User.maximum('voted')
    @killed_users = User.where(voted: @voted_max)

    if @killed_users == @users[$wolf_num]
      @message = "市民の勝利です"
    elsif @killed_users.pluck(:user_id).include?($wolf_num + 1)
      @message = "喧嘩両成敗です"
    else
      @message = "人狼の勝利です"
    end

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
    $wolf_num = rand(1..@users.count)-1
    @users[$wolf_num].word = w3
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
