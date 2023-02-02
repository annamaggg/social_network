require 'database_connection.rb'
require 'posts_repository.rb'
DatabaseConnection.connect('social_network')

def reset_posts_table
    seed_sql = File.read('spec/seeds_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
end

RSpec.describe PostsRepository do 
    before(:each) do 
        reset_posts_table
    end 

    it "returns all posts" do 
        repo = PostsRepository.new
        posts = repo.all
        
        expect(posts.length).to eq 3
        expect(posts[0].title).to eq 'Thursday'
        expect(posts[1].content).to eq 'I love coding'
    end 

    it "finds a post by id number" do 
        repo = PostsRepository.new
        post = repo.find(1)

        expect(post.views).to eq '12'
    end

    it "creates post" do
        repo = PostsRepository.new
        post = Post.new
        post.title = 'Hello'
        post.content = 'Hello world'
        post.views = '1'
        username = 'am305'

        repo.create(post, username)
        all_posts = repo.all
        
        expect(all_posts.length).to eq 4
        expect(all_posts[3].title).to eq 'Hello'
    end

    it "deletes a post" do 
        repo = PostsRepository.new
        repo.delete(1)
        expect(repo.all.length).to eq 2
    end
end