require 'rails_helper'

RSpec.describe "Posts API (Rails Controller)", type: :request do
  describe "GET /api/other_posts" do
    let!(:post) { FactoryBot.create(:post) }

    it 'returns a list of posts' do
      get api_other_posts_path

      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to match(post.title)
        expect(response.body).to match(post.content)
      end
    end
  end

  describe "POST /api/other_posts" do
    let(:title) { "Hello again!" }
    let(:content) { "It's good to see you!" }
    let(:post_params) do
      { post: { title: title, content: content } }
    end

    it "returns the newly created post" do
      post "/api/other_posts", params: post_params

      aggregate_failures do
        expect(response).to have_http_status(201)
        expect(response.body).to match(title)
        expect(response.body).to match(content)
      end
    end
  end
end