require 'rails_helper'

RSpec.describe Post, type: :model do
  second_user = User.create(Name: 'Lilly', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                            Bio: 'Teacher from Poland.')

  first_post = Post.create(user: second_user, title: 'Hello', text: 'This is my first post', comments_counter: 2,
                           likes_counter: 3)

  first_comment = Comment.new(post: first_post, user: second_user, text: 'Hi Ben!')
  second_comment = Comment.new(post: first_post, user: second_user, text: 'Hi Ben!')
  third_comment = Comment.new(post: first_post, user: second_user, text: 'Hi Ben!')
  fourth_comment = Comment.new(post: first_post, user: second_user, text: 'Hi Ben!')
  fifth_comment = Comment.new(post: first_post, user: second_user, text: 'Hi Ben!')
  sixth_comment = Comment.new(post: first_post, user: second_user, text: 'Hi Ben!')

  context 'Write validation tests for Post Model' do
    it 'is not valid without a title' do
      first_post.title = nil
      expect(first_post).to_not be_valid
    end

    it 'is not valid if title exceed 250 characters' do
      first_post.title = 'M' * 251
      expect(first_post).to_not be_valid
    end

    it 'is valid with a name' do
      first_post.text = 'This is the content of the post.'
      expect(first_post).to_not be_valid
    end

    it 'is not valid if comments_counter is not integer' do
      first_post.comments_counter = 'Benard'
      expect(first_post).to_not be_valid
    end

    it 'is not valid if comments_counter is negative' do
      first_post.comments_counter = -5
      expect(first_post).to_not be_valid
    end

    it 'is not valid if likes_counter is not an integer' do
      first_post.likes_counter = 'Benard'
      expect(first_post).to_not be_valid
    end

    it 'is not valid if likes_counter is negative' do
      first_post.likes_counter = -21
      expect(first_post).to_not be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:author) }
  end

  context 'Write unit tests for Post Model Methods' do
    it 'returns 0 for no comment' do
      number_of_comments = first_post.recent_5_comments.count
      expect(number_of_comments).to be 0
    end

    it 'returns 1 for one comment' do
      first_comment.save
      number_of_comments = first_post.recent_5_comments.count
      expect(number_of_comments).to be 1
    end

    it 'returns 5 for five comments' do
      second_comment.save
      third_comment.save
      fourth_comment.save
      fifth_comment.save
      sixth_comment.save

      comments = first_post.recent_5_comments
      number_of_comments = first_post.recent_5_comments.count
      texts = comments.pluck(:text)
      expect(number_of_comments).to be 5
      expect(texts).to eql [sixth_comment.text, fifth_comment.text, fourth_comment.text, third_comment.text,
                            second_comment.text]
    end
  end

  context 'Write unit tests for Post Model Methods' do
    it 'updates post counter equal to 1 for a given user' do
      first_post.update_posts_counter
      number_of_posts = second_user.posts_counter
      expect(number_of_posts).to be 1
    end

    it 'updates post counter equal to 2 for a given user' do
      first_post.update_posts_counter
      second_post = Post.create(user: second_user, title: 'Hello', text: 'This is my second post', comments_counter: 2,
                                likes_counter: 3)
      second_post.update_posts_counter
      number_of_posts = second_user.posts_counter
      expect(number_of_posts).to be 2
    end
  end
end
