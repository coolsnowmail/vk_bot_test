namespace :post do
  task doing: :environment do
    Post.make(4)
  end
end