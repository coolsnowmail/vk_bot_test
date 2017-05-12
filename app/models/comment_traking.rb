# tracks all comments was made
class CommentTraking < ActiveRecord::Base
  belongs_to :task
end
