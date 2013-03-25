class Post
  include MongoMapper::Document

  def initializer
    comments = []
  end
  key :name, String
  key :text, String
  timestamps!
  
  many :comments

end
