require 'test_helper'

class ErrolmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @errolment = errolments(:one)
  end

  test "should get index" do
    get errolments_url
    assert_response :success
  end

  test "should get new" do
    get new_errolment_url
    assert_response :success
  end

  test "should create errolment" do
    assert_difference('Errolment.count') do
      post errolments_url, params: { errolment: { level_id: @errolment.level_id, student_id: @errolment.student_id } }
    end

    assert_redirected_to errolment_url(Errolment.last)
  end

  test "should show errolment" do
    get errolment_url(@errolment)
    assert_response :success
  end

  test "should get edit" do
    get edit_errolment_url(@errolment)
    assert_response :success
  end

  test "should update errolment" do
    patch errolment_url(@errolment), params: { errolment: { level_id: @errolment.level_id, student_id: @errolment.student_id } }
    assert_redirected_to errolment_url(@errolment)
  end

  test "should destroy errolment" do
    assert_difference('Errolment.count', -1) do
      delete errolment_url(@errolment)
    end

    assert_redirected_to errolments_url
  end
end
