require 'rails_helper'

RSpec.describe "Posts API (Awesome Controller)", type: :request do
describe "GET /awesome/api/posts/1" do
  let(:post) { FactoryBot.create(:post) }

  it 'returns the details of a post' do
    get "/awesome/api/posts/#{ post.id }"

    aggregate_failures do
      expect(response).to have_http_status(200)
      expect(response.content_type).to match("application/json")
      expect(response.headers.keys).to_not eq(nil)
      expect(response.body).to eq({ post: post }.to_json)
    end
  end
end

  describe "POST /awesome/api/posts" do
    let(:title) { "Hello again!" }
    let(:content) { "It's good to see you!" }
    let(:post_params) do
      { post: { title: title, content: content } }
    end

    it "returns the newly created post" do
      post "/awesome/api/posts", params: post_params
      expected_post = Post.first

      header_keys = ["ETag", "Cache-Control", "X-Request-Id", "X-Runtime", "Content-Length"]
      expected_body = {
        "post" =>  {
          "id" => expected_post.id,
          "title" => title,
          "content" => content,
          "created_at" => expected_post.created_at.iso8601,
          "updated_at" => expected_post.updated_at.iso8601
        }
      }

      body_details = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(201)
        expect(response.content_type).to match("application/json")
        expect(response.headers.keys).to include(*header_keys)
        expect(body_details).to eq(expected_body)
      end
    end
  end
end
