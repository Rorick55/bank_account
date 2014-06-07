require 'csv'
require 'pry'
require_relative 'bank_transactions'

class BankAccount
  def initialize(csv_balance, csv_data, account)
    @csv_balance = csv_balance
    @csv_data = csv_data
    @account = account
  end

  def transactions
     transactions_array = []
     CSV.foreach(@csv_data, headers: true) do |row|
      single_transaction = Hash[row]
      transactions_array << single_transaction
    end
    final_transactions = []
    transactions_array.each do |trans|
      if trans['Account'] == @account
      new_transaction = BankTransaction.new(trans['Date'], trans['Amount'], trans['Description'], trans['Account'])
      final_transactions << new_transaction
    end
    final_transactions
  end


  def current_purchasing_balance
    return "Current Balance: $#{self.balances[-1]['Balance'].to_i}"
  end

  def starting_purchasing_balance
    return "Starting Balance: $#{self.balances[1]['Balance'].to_i}"
  end

  def current_checking_balance
    return "Current Balance: $#{self.balances[-2]['Balance'].to_i}"
  end

  def starting_checking_balance
    return "Starting Balance: $#{self.balances[0]['Balance'].to_i}"
  end

end

my_bank_account = BankAccount.new('balances.csv', 'bank_data.csv')

p my_bank_account.purchasing_transactions

p my_bank_account.checking_transactions



