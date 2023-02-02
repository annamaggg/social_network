require 'accounts_repository.rb'
require 'database_connection.rb'
DatabaseConnection.connect('social_network')

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
end

RSpec.describe AccountsRepository do 
    before(:each) do 
        reset_accounts_table
    end

    it "returns all accounts" do 
        repo = AccountsRepository.new

        accounts = repo.all

        expect(accounts.length).to eq 2 # =>  2

        expect(accounts[0].id).to eq '1' # =>  1
        expect(accounts[1].username).to eq 'bg290'
        expect(accounts[0].email_address).to eq 'annamag@email.com'
    end

    it "returns an account through find method" do
        repo = AccountsRepository.new

        account = repo.find(1)

        expect(account.id).to eq '1' # =>  1
        expect(account.username).to eq 'am305'
        expect(account.email_address).to eq 'annamag@email.com'
    end

    it "creates an account" do
        repo = AccountsRepository.new
        account = Account.new
        account.username = 'go234'
        account.email_address = 'gerryobrien@email.com'
        repo.create(account)
        
        all_accounts = repo.all
        
        expect(all_accounts.length).to eq 3
        expect(all_accounts[2].id).to eq '3'
        expect(all_accounts[2].username).to eq 'go234'
        expect(all_accounts[2].email_address).to eq 'gerryobrien@email.com'
    end

    it "deletes account where id=1" do
        repo = AccountsRepository.new
        repo.delete(1)
        
        expect(repo.all.length).to eq 1
    end 
end