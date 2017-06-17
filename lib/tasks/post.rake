namespace :post do
  task doing: :environment do
    Post.make(3)
  end
end