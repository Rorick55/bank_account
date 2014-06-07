require 'csv'
require 'pry'
require_relative 'bank_transactions'

class BankAccount
  def initialize(csv_balance, csv_data, account)
    @csv_balance = csv_balance
    @csv_data = csv_data
    @account = account
  end

  def balances
    balances = []
    CSV.foreach(@csv_balance, headers: true) do |row|
      balance = Hash[row]
      if balance['Account'] == @account
        balances << balance
      end
    end
    balances
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
    end
    final_transactions
  end


  def current_balance
    return "Current Balance: $#{self.balances[-1]['Balance'].to_f}"
  end

  def starting_balance
    return "Starting Balance: $#{self.balances[0]['Balance'].to_f}"
  end

  def add_transaction(amount, description)
    CSV.open(@csv_data, 'a') do |csv|
      csv << ["#{Time.now.strftime("%m/%d/%Y")}", "#{amount}", "#{description}", "#{@account}"]
    end
    new_balance = self.balances[-1]['Balance'].to_f + amount.to_f
    CSV.open(@csv_balance, 'a') do |file|
      file << ["#{@account}", "#{new_balance}"]
    end
  end



end

my_bank_account = BankAccount.new('balances.csv', 'bank_data.csv', 'Purchasing Account')

p my_bank_account.transactions

p my_bank_account.current_balance



