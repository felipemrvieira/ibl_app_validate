namespace :weekly_challenge do
  desc 'Create Weekly Chalenge'
  task run_weekly_challenges: :environment do

    power_link = Course.where(title: "Power Link").last

    power_link.levels.each do |level|
      bank = level.weekly_challenge_bank_questions.last
      sorted_question = bank.questions.sample(1).first.id

      WeeklyChallenge.create(question_id: sorted_question,
        exp: Date.today + 7, level_id: level.id
      )
    end

  end
end
