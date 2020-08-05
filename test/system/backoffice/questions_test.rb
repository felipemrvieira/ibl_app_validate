require "application_system_test_case"

class Backoffice::QuestionsTest < ApplicationSystemTestCase
  setup do
    @backoffice_question = backoffice_questions(:one)
  end

  test "visiting the index" do
    visit backoffice_questions_url
    assert_selector "h1", text: "Backoffice/Questions"
  end

  test "creating a Question" do
    visit backoffice_questions_url
    click_on "New Backoffice/Question"

    fill_in "Description", with: @backoffice_question.description
    fill_in "Order", with: @backoffice_question.order
    fill_in "Path", with: @backoffice_question.path_id
    click_on "Create Question"

    assert_text "Question was successfully created"
    click_on "Back"
  end

  test "updating a Question" do
    visit backoffice_questions_url
    click_on "Edit", match: :first

    fill_in "Description", with: @backoffice_question.description
    fill_in "Order", with: @backoffice_question.order
    fill_in "Path", with: @backoffice_question.path_id
    click_on "Update Question"

    assert_text "Question was successfully updated"
    click_on "Back"
  end

  test "destroying a Question" do
    visit backoffice_questions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Question was successfully destroyed"
  end
end
