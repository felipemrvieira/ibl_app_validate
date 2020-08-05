require 'test_helper'

class WeeklyChallengesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weekly_challenge = weekly_challenges(:one)
  end

  test "should get index" do
    get weekly_challenges_url
    assert_response :success
  end

  test "should get new" do
    get new_weekly_challenge_url
    assert_response :success
  end

  test "should create weekly_challenge" do
    assert_difference('WeeklyChallenge.count') do
      post weekly_challenges_url, params: { weekly_challenge: { exp: @weekly_challenge.exp, question_id: @weekly_challenge.question_id } }
    end

    assert_redirected_to weekly_challenge_url(WeeklyChallenge.last)
  end

  test "should show weekly_challenge" do
    get weekly_challenge_url(@weekly_challenge)
    assert_response :success
  end

  test "should get edit" do
    get edit_weekly_challenge_url(@weekly_challenge)
    assert_response :success
  end

  test "should update weekly_challenge" do
    patch weekly_challenge_url(@weekly_challenge), params: { weekly_challenge: { exp: @weekly_challenge.exp, question_id: @weekly_challenge.question_id } }
    assert_redirected_to weekly_challenge_url(@weekly_challenge)
  end

  test "should destroy weekly_challenge" do
    assert_difference('WeeklyChallenge.count', -1) do
      delete weekly_challenge_url(@weekly_challenge)
    end

    assert_redirected_to weekly_challenges_url
  end
end
