require_relative './account'
require_relative './database_connection'

class AccountsRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = 'SELECT id, username, email_address FROM accounts;'
      results = DatabaseConnection.exec_params(sql, [])

      accounts = []

      results.each do |result|
        account = Account.new
        account.id = result['id']
        account.username = result['username']
        account.email_address = result['email_address']

        accounts << account
      end

      return accounts
      # Returns an array of Artist objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      sql = 'SELECT id, username, email_address FROM accounts WHERE id = $1;'
      params = [id]
      result = DatabaseConnection.exec_params(sql, params)

      account = Account.new
      account.id = result[0]['id']
      account.username = result[0]['username']
      account.email_address = result[0]['email_address']

      return account
  
      # Returns a single Artist object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
     def create(account)
        sql = 'INSERT INTO accounts (username, email_address) VALUES ($1, $2);'
        params = [account.username, account.email_address]
        DatabaseConnection.exec_params(sql, params)
     end
  
     #def update(account)
     #   sql = 'UPDATE accounts SET $1 = $2 WHERE id = $3;'
     #   params = []
     #end
  
    def delete(id)
        sql = 'DELETE FROM accounts WHERE id=$1'
        params = [id]
        DatabaseConnection.exec_params(sql, params)
    end
  end