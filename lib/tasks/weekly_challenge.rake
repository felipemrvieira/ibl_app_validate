namespace :weekly_challenge do
  desc 'Create Weekly Chalenge'
  task run_weekly_challenges: :environment do
    WeeklyChallenge.create(question_id: Question.power_link_sample_question, exp: Date.today + 7)
  end
end
