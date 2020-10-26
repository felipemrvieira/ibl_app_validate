# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
set :environment, "development"

#
every 1.minutes do
  # command "/usr/bin/some_great_command"

  runner "WeeklyChallenge.create(question_id: Question.power_link_sample_question, exp: Date.today + 7)"
  # runner "WeeklyChallenge.create(question_id: Question.find(14).id, exp: Date.today + 7)"

  # rake "some:great:rake:task"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
