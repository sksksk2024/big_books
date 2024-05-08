require "test_helper"

class TopAuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get top_authors_index_url
    assert_response :success
  end
end
