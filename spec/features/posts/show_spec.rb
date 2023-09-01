require 'rails_helper'

RSpec.describe 'User Posts', type: :feature do
  before do
    @user = User.create!(name: 'Toro', posts_counter: 0)
    @post1 = Post.create!(title: 'Post 1', text: 'This is post 1', author: @user, comments_counter: 0, likes_counter: 0)
    @comment = Comment.create!(text: 'Nice post', author: @user, post: @post1)

    visit user_posts_path(@user)
  end

  describe 'Show Page' do
    before do
      @comment2 = Comment.create!(text: 'Great post', author: @user, post: @post1)
      visit user_post_path(@user, @post1)
    end

    it 'displays the post\'s title' do
      expect(page).to have_content('Post 1')
    end

    it 'displays the post\'s author' do
      expect(page).to have_content('by Toro')
    end

    it 'displays the number of comments the post has' do
      expect(page).to have_content('Comments: 2')
    end

    it 'displays the number of likes the post has' do
      expect(page).to have_content('Likes: 0')
    end

    it 'displays the post\'s body' do
      expect(page).to have_content('This is post 1')
    end

    it 'displays the username of each commentor' do
      expect(page).to have_content('Toro')
    end

    it 'displays the comment each commentor left' do
      expect(page).to have_content('Nice post')
      expect(page).to have_content('Great post')
    end

    it 'displays a button to add a comment' do
      expect(page).to have_button('Add comment')
    end

    it 'displays a button to like the post' do
      expect(page).to have_button('Like Post')
    end
  end
end
