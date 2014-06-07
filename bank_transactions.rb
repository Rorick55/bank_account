require 'csv'
class BankTransaction
  attr_reader :date, :amount, :description, :account

  def initialize(date, amount, description, account)
    @date = date
    @amount = amount
    @description = description
    @account = account
  end

  def deposit?
    if @amount.to_i < 0
      false
    else
      true
    end
  end

  def debit_credit
    if @amount.to_ < 0
      "WITHDRAWAL"
    else
      "DEPOSIT"
    end
  end

  def summary
    if self.deposit?
      return "$#{@amount} DEPOSIT #{@date} - #{@description}"
    else
      return "$#{@amount} WITHDRAWAL #{@date} - #{@description}"
    end
  end
end




