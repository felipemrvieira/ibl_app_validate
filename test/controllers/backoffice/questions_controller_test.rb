require 'test_helper'

class Backoffice::QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @backoffice_question = backoffice_questions(:one)
  end

  test "should get index" do
    get backoffice_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_backoffice_question_url
    assert_response :success
  end

  test "should create backoffice_question" do
    assert_difference('Backoffice::Question.count') do
      post backoffice_questions_url, params: { backoffice_question: { description: @backoffice_question.description, order: @backoffice_question.order, path_id: @backoffice_question.path_id } }
    end

    assert_redirected_to backoffice_question_url(Backoffice::Question.last)
  end

  test "should show backoffice_question" do
    get backoffice_question_url(@backoffice_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_backoffice_question_url(@backoffice_question)
    assert_response :success
  end

  test "should update backoffice_question" do
    patch backoffice_question_url(@backoffice_question), params: { backoffice_question: { description: @backoffice_question.description, order: @backoffice_question.order, path_id: @backoffice_question.path_id } }
    assert_redirected_to backoffice_question_url(@backoffice_question)
  end

  test "should destroy backoffice_question" do
    assert_difference('Backoffice::Question.count', -1) do
      delete backoffice_question_url(@backoffice_question)
    end

    assert_redirected_to backoffice_questions_url
  end
end
