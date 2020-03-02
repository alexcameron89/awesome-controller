require 'rails_helper'

RSpec.describe "Posts API (Custom Controller)", type: :request do
  describe "GET /posts" do
    let!(:post) { FactoryBot.create(:post) }

    it 'returns a list of posts' do
      get api_posts_path

      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to match(post.title)
        expect(response.body).to match(post.content)
      end
    end
  end

  describe "GET /post/:id" do
    let!(:post) { FactoryBot.create(:post) }

    it 'returns the details of a post' do
      get "/api/posts/#{ post.id }"

      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to match(post.title)
        expect(response.body).to match(post.content)
      end
    end
  end

  describe "POST /api/posts" do
    let(:title) { "Hello again!" }
    let(:content) { "It's good to see you!" }
    let(:post_params) do
      { post: { title: title, content: content } }
    end

    it "returns the newly created post" do
      post "/api/posts", params: post_params

      aggregate_failures do
        expect(response).to have_http_status(201)
        expect(response.body).to match(title)
        expect(response.body).to match(content)
      end
    end
  end
end
