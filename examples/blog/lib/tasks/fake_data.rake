$rails_rake_task = true
require 'factory_girl'


namespace :db do
  desc "Popula a base com dados de teste."  
  task :fake_data => :environment do
    
    load 'test/factories/posts.rb'
    load 'test/factories/comentarios.rb'

    10.times do
      post = FactoryGirl.create(:post)
      10.times do
        comentario = FactoryGirl.create(:comentario, post_id: post.id)
      end
    end

  end
end