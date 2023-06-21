class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_post_likes_counter
  after_destroy :update_post_likes_counter

  def increase_like_counter
    post.increment!(:likes_counter)
  end

  private

  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
