require_relative './database_connection'
require_relative './post'

class PostsRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = 'SELECT id, title, content, views, account_id FROM posts;'
      results = DatabaseConnection.exec_params(sql, [])

      posts = []

      results.each do |item|
        post = Post.new
        post.id = item['id']
        post.title = item['title']
        post.content = item['content']
        post.views = item['views']
        post.account_id = item['account_id']

        posts << post
      end 

      return posts
      # Returns an array of Artist objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      sql = 'SELECT id, title, content, views, account_id FROM posts WHERE id = $1;'
      params = [id]
      result = DatabaseConnection.exec_params(sql, params)

      post = Post.new
      post.id = result[0]['id']
      post.title = result[0]['title']
      post.content = result[0]['content']
      post.views = result[0]['views']
      post.account_id = result[0]['account_id']

      return post
      # Returns a single Artist object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(post, username)
        sql = 'INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, (SELECT id from accounts WHERE username = $4))' 
        params = [post.title, post.content, post.views, username]
        DatabaseConnection.exec_params(sql, params)
    end
  
    # def update(artist)
    # end
  
    def delete(id)
        sql = 'DELETE FROM posts WHERE id = $1'
        params = [id]
        DatabaseConnection.exec_params(sql, params)
    end
end