require 'sinatra'
require 'pry'
require_relative 'bank_account'


get '/' do

  redirect '/accounts'
end

get '/accounts' do
  @purchasing_accounts = BankAccount.new('balances.csv', 'bank_data.csv', 'Purchasing Account')
  @business_checking = BankAccount.new('balances.csv', 'bank_data.csv', 'Business Checking')
  erb :index
end

get '/add' do

  erb :add
end

post '/adding' do
  @account = BankAccount.new('balances.csv', 'bank_data.csv', "#{params[:account]}")
  @account.add_transaction("#{params[:amount]}", "#{params[:description]}")
  redirect '/'
end
