require 'rails_helper'

RSpec.describe "Posts API (Rails Controller)", type: :request do
  describe "GET /api/other_posts/1" do
    let!(:post) { FactoryBot.create(:post) }

    it 'returns the details of a post' do
      get api_other_post_path(post)

      header_keys = ["ETag", "Cache-Control", "X-Request-Id", "X-Runtime", "Content-Length"]
      expected_body = {
        "post" =>  {
          "id" => post.id,
          "title" => post.title,
          "author_id" => post.author_id,
          "content" => post.content,
          "created_at" => post.created_at.iso8601,
          "updated_at" => post.updated_at.iso8601
        }
      }

      body_details = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.headers.keys).to include(*header_keys)
        expect(body_details).to eq(expected_body)
      end
    end
  end

  describe "POST /api/other_posts" do
    let(:title) { "Hello again!" }
    let(:content) { "It's good to see you!" }
    let(:author) { FactoryBot.create(:author) }
    let(:post_params) do
      { post: { title: title, content: content, author_id: author.id  } }
    end

    it "returns the newly created post" do
      post "/api/other_posts", params: post_params
      expected_post = Post.first

      header_keys = ["ETag", "Cache-Control", "X-Request-Id", "X-Runtime", "Content-Length"]
      expected_body = {
        "post" =>  {
          "id" => expected_post.id,
          "title" => title,
          "author_id" => author.id,
          "content" => content,
          "created_at" => expected_post.created_at.iso8601,
          "updated_at" => expected_post.updated_at.iso8601
        }
      }

      body_details = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(201)
        expect(response.headers.keys).to include(*header_keys)
        expect(body_details).to eq(expected_body)
      end
    end
  end
end
