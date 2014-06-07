require 'sinatra'
require 'pry'
require_relative 'bank_account'


get '/' do

  redirect '/accounts'
end

get '/accounts' do
  @accounts = BankAccount.new('balances.csv', 'bank_data.csv')
  erb :index
end

