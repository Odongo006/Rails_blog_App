require 'rails_helper'

RSpec.describe 'User Posts', type: :feature do
  before do
    @user = User.create!(name: 'Toro', posts_counter: 0)
    @post1 = Post.create!(title: 'Post 1', text: 'This is post 1', author: @user, comments_counter: 0, likes_counter: 0)
    @post2 = Post.create!(title: 'Post 2', text: 'This is post 2', author: @user, comments_counter: 0, likes_counter: 0)
    @post3 = Post.create!(title: 'Post 3', text: 'This is post 3', author: @user, comments_counter: 0, likes_counter: 0)
    @comment = Comment.create!(text: 'Nice post', author: @user, post: @post1)

    visit user_posts_path(@user)
  end

  describe 'Index Page' do
    it 'displays the user\'s profile picture' do
      expect(page).to have_css('div.user-photo')
    end

    it 'displays the user\'s username' do
      expect(page).to have_content('Toro')
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 3')
    end

    it 'displays a post\'s title' do
      expect(page).to have_content('Post #1')
      expect(page).to have_content('Post #2')
      expect(page).to have_content('Post #3')
    end

    it 'displays some of the post\'s body' do
      expect(page).to have_content('This is post 1')
      expect(page).to have_content('This is post 2')
      expect(page).to have_content('This is post 3')
    end

    it 'displays the first comments on a post' do
      expect(page).to have_content('Nice post')
    end

    it 'displays how many comments a post has' do
      expect(page).to have_content('Comments: 0', count: 2)
      expect(page).to have_content('Comments: 1')
    end

    it 'displays how many likes a post has' do
      expect(page).to have_content('Likes: 0', count: 3)
    end

    it 'displays a section for pagination if there are more posts than fit on the view' do
      # Add more posts to exceed the view limit
      10.times do
        Post.create!(title: 'Extra Post', text: 'This is an extra post', author: @user, comments_counter: 0,
                     likes_counter: 0)
      end

      visit user_posts_path(@user)

      expect(page).to have_content('Pagination')
    end
  end
end
