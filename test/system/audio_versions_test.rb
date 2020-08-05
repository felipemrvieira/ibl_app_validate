require "application_system_test_case"

class AudioVersionsTest < ApplicationSystemTestCase
  setup do
    @audio_version = audio_versions(:one)
  end

  test "visiting the index" do
    visit audio_versions_url
    assert_selector "h1", text: "Audio Versions"
  end

  test "creating a Audio version" do
    visit audio_versions_url
    click_on "New Audio Version"

    fill_in "Level", with: @audio_version.level_id
    fill_in "Title", with: @audio_version.title
    click_on "Create Audio version"

    assert_text "Audio version was successfully created"
    click_on "Back"
  end

  test "updating a Audio version" do
    visit audio_versions_url
    click_on "Edit", match: :first

    fill_in "Level", with: @audio_version.level_id
    fill_in "Title", with: @audio_version.title
    click_on "Update Audio version"

    assert_text "Audio version was successfully updated"
    click_on "Back"
  end

  test "destroying a Audio version" do
    visit audio_versions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Audio version was successfully destroyed"
  end
end
