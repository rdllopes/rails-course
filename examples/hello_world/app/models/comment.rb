class Comment
  include MongoMapper::EmbeddedDocument
  timestamps!

  key :commenter, String
  key :body, String
    
  belongs_to :post 
  
end