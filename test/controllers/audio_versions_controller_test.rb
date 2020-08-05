require 'test_helper'

class AudioVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audio_version = audio_versions(:one)
  end

  test "should get index" do
    get audio_versions_url
    assert_response :success
  end

  test "should get new" do
    get new_audio_version_url
    assert_response :success
  end

  test "should create audio_version" do
    assert_difference('AudioVersion.count') do
      post audio_versions_url, params: { audio_version: { level_id: @audio_version.level_id, title: @audio_version.title } }
    end

    assert_redirected_to audio_version_url(AudioVersion.last)
  end

  test "should show audio_version" do
    get audio_version_url(@audio_version)
    assert_response :success
  end

  test "should get edit" do
    get edit_audio_version_url(@audio_version)
    assert_response :success
  end

  test "should update audio_version" do
    patch audio_version_url(@audio_version), params: { audio_version: { level_id: @audio_version.level_id, title: @audio_version.title } }
    assert_redirected_to audio_version_url(@audio_version)
  end

  test "should destroy audio_version" do
    assert_difference('AudioVersion.count', -1) do
      delete audio_version_url(@audio_version)
    end

    assert_redirected_to audio_versions_url
  end
end
