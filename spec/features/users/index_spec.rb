require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

describe 'testing users/index', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mert', photo: 'www.unsplash.com', bio: 'Web Developer guy', posts_counter: 3)

    @user2 = User.create(name: 'Larissa', photo: 'www.unsplash.com', bio: 'Bee keeper and bee lover', posts_counter: 2)

    @user3 = User.create(name: 'Burak', photo: 'www.unsplash.com', bio: 'Software developer from Turkey',
                         posts_counter: 2)

    @users = User.all
    visit users_path
  end

  it 'diplays user name of all users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays profile picture for each user' do
    @users.each do |_user|
      expect(page).to have_css('img')
    end
  end


  it 'redirects to user\'s show page when clicked' do
    @users.each do |user|
      click_link("user-link-#{user.id}")
      expect(page).to have_current_path(user_path(user))
      visit users_path
    end
  end
end
