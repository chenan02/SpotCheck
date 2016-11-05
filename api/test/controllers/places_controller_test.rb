require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get get_occupancy" do
    get places_get_occupancy_url
    assert_response :success
  end

  test "should get post_occupancy" do
    get places_post_occupancy_url
    assert_response :success
  end

end
