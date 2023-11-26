class User::UsersController < ApplicationController
  def show
    puts "show アクションが呼ばれました"
  end

  def check
    puts "check アクションが呼ばれました"
  end

  def withdraw
    puts "withdraw アクションが呼ばれました"
  end

end
