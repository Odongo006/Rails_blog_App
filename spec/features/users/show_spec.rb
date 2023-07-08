require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.describe 'Users', type: :feature do
    before do
      @user1 = User.create!(name: 'Tom', photo: 'www.unsplash.com', posts_counter: 0 )
      @user2 = User.create!(name: 'Toro', photo: 'www.unsplash.com', posts_counter: 0, bio: 'developer')
      @user3 = User.create!(name: 'Ted', photo: 'www.unsplash.com', posts_counter: 0)
  
      visit users_path
    end

    describe 'show page' do
        before do
          @post = Post.create!(title: 'Tests', text: 'Test are good', author: @user2, comments_counter: 0, likes_counter: 0)
          @comment = Comment.create!(text: 'Nice post', author: @user2, post: @post)
          visit user_path(@user2)
        end
    
        it 'displays the user\'s profile picture' do
          expect(page).to have_css('div.user-photo')
        end
    
        it 'displays the user\'s username' do
          expect(page).to have_content('Toro')
        end
    
        it 'displays the number of posts the user has written' do
          expect(page).to have_content('Number of posts: 1')
        end
    
        it 'displays the user\'s bio' do
          expect(page).to have_content('developer')
        end
    
        it 'displays the user\'s first 3 posts or less' do
          expect(page).to have_selector('.post', count: 1)
        end
    
        it 'redirects to the post\'s show page when clicking on a user\'s post' do
          click_link 'Post #1'
          expect(page).to have_current_path(user_post_path(user_id: @user2.id, id: @user2.posts.first.id))
        end
    
        it "displays a button that lets me view all of a user's posts" do
          expect(page).to have_button('See all posts')
        end
    
        it "redirects me to the user's post index page when clicking 'See all posts'" do
          click_link 'See all posts'
          expect(page).to have_current_path(user_posts_path(@user2))
        end
      end
    
end    