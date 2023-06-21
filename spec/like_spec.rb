require 'rails_helper'

RSpec.describe Like, type: :model do
  like = Like.new(author_id: 1, post_id: 1)

  it 'has an author id' do
    expect(like.author_id).to_not eql 5
    expect(like.author_id).to eql 1
  end

  it 'has an post id' do
    expect(like.post_id).to_not eql(-5)
    expect(like.post_id).to eql 1
  end

  it 'checks likes_counter method' do
    User.new(name: 'Mert', photo: 'www.unsplash.com', bio: 'Lorem ipsum', posts_counter: 5)

    post = Post.new(author_id: 1, title: 'first post', text: 'this is the first post', comments_counter: 3,
                    likes_counter: 2)

    like = Like.new(author_id: 1, post:)

    post.likes_counter = 2
    post.save

    like.increase_like_counter
    like.increase_like_counter

    expect(post.likes_counter).to eq(4)
  end
end
