require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'Nice post', user_id: 1, post_id: 1) }

  before { subject.save }

  it 'new comment should be saved in the database' do
    expect(subject.new_record?).to be_truthy
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  describe 'update posts counter' do
    let(:user) { User.create(name: 'Man', photo: 'photo', bio: 'bio', posts_counter: 0) }
    let(:post) do
      Post.create(title: 'post', text: 'This is my post', author_id: user.id, comments_counter: 0, likes_counter: 0)
    end

    subject { described_class.create(text: 'My comment', post_id: post.id, user_id: user.id) }

    it 'posts comments count should increase' do
      expect do
        subject
        post.reload
      end.to change { post.comments_counter }.by(1)
    end
  end
end
