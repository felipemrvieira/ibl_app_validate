require "application_system_test_case"

class ErrolmentsTest < ApplicationSystemTestCase
  setup do
    @errolment = errolments(:one)
  end

  test "visiting the index" do
    visit errolments_url
    assert_selector "h1", text: "Errolments"
  end

  test "creating a Errolment" do
    visit errolments_url
    click_on "New Errolment"

    fill_in "Level", with: @errolment.level_id
    fill_in "Student", with: @errolment.student_id
    click_on "Create Errolment"

    assert_text "Errolment was successfully created"
    click_on "Back"
  end

  test "updating a Errolment" do
    visit errolments_url
    click_on "Edit", match: :first

    fill_in "Level", with: @errolment.level_id
    fill_in "Student", with: @errolment.student_id
    click_on "Update Errolment"

    assert_text "Errolment was successfully updated"
    click_on "Back"
  end

  test "destroying a Errolment" do
    visit errolments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Errolment was successfully destroyed"
  end
end
