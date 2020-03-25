require "rails_helper"

describe "Creating and Viewing Posts (Custom Controller)", type: :feature do
  describe "creating posts" do
    pending "allows a user to create a post" do
      visit "/other_posts/new"
      within("form#post") do
        fill_in "Title", with: "Creating the world"
        fill_in "Content", with: "It all started with a 'hello'."
      end
      click_button "Create Post"
      expect(page).to have_content "Congratulations on your successful post."
    end
  end

  describe "viewing posts" do
    let!(:post) { FactoryBot.create(:post) }

    pending "allows a user to see the posts available" do
      visit "/other_posts"

      expect(page).to have_selector ".post", count: 1
      expect(page).to have_content post.title
    end

    pending "allows a user to view a post" do
      visit "/other_posts/#{ post.id }"

      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
end
