require "rails_helper"

describe "Creating and Viewing Posts (Through Awesome Controller)", type: :feature do
  describe "creating posts" do
    it "allows a user to create a post" do
      visit "/awesome/posts/new"
      within("form#post") do
        fill_in "Title", with: "Creating the world"
        fill_in "Content", with: "It all started with a 'hello'."
      end
      click_button "Create Post"
      expect(page).to have_content "Creating the world"
      expect(page).to have_content "It all started with a 'hello'."
      expect(page).to have_content "Congratulations on your successful post."
    end
  end

  describe "viewing posts" do
    let!(:post) { FactoryBot.create(:post) }

    it "allows a user to see the posts available" do
      visit "/awesome/posts"

      expect(page).to have_selector ".post", count: 1
      expect(page).to have_content post.title
      expect(page).to have_link("Show")
    end

    it "allows a user to view a post" do
      visit "/awesome/posts/#{ post.id }"

      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
end
