require "application_system_test_case"

class WeeklyChallengesTest < ApplicationSystemTestCase
  setup do
    @weekly_challenge = weekly_challenges(:one)
  end

  test "visiting the index" do
    visit weekly_challenges_url
    assert_selector "h1", text: "Weekly Challenges"
  end

  test "creating a Weekly challenge" do
    visit weekly_challenges_url
    click_on "New Weekly Challenge"

    fill_in "Exp", with: @weekly_challenge.exp
    fill_in "Question", with: @weekly_challenge.question_id
    click_on "Create Weekly challenge"

    assert_text "Weekly challenge was successfully created"
    click_on "Back"
  end

  test "updating a Weekly challenge" do
    visit weekly_challenges_url
    click_on "Edit", match: :first

    fill_in "Exp", with: @weekly_challenge.exp
    fill_in "Question", with: @weekly_challenge.question_id
    click_on "Update Weekly challenge"

    assert_text "Weekly challenge was successfully updated"
    click_on "Back"
  end

  test "destroying a Weekly challenge" do
    visit weekly_challenges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weekly challenge was successfully destroyed"
  end
end
