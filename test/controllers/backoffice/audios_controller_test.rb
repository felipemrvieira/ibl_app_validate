require 'test_helper'

class Backoffice::AudiosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backoffice_audios_index_url
    assert_response :success
  end

  test "should get new" do
    get backoffice_audios_new_url
    assert_response :success
  end

  test "should get create" do
    get backoffice_audios_create_url
    assert_response :success
  end

  test "should get destroy" do
    get backoffice_audios_destroy_url
    assert_response :success
  end

end
