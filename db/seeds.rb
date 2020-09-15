# Unit.create!(
#     title: "Sede",
#     location: FFaker::AddressBR.full_address ,
#     email: "pontaverde@ibl.com.br",
#     password: "123123",
#     password_confirmation: "123123",
#     admin: true

# )

# 30.times do
#     Unit.create!(
#         title:  FFaker::AddressBR.city ,
#         location:  FFaker::AddressBR.full_address ,
#         email:  FFaker::Internet.email ,
#         password: "123123",
#         password_confirmation: "123123",
#         admin: false
#     )
# end

# id_unidades = Unit.ids

# Student.create!(
#     name: "Kunlatek",
#     email: "contato@kunlatek.com",
#     birthday:  FFaker::Time.date ,
#     phone:   FFaker::PhoneNumberBR.mobile_phone_number,
#     points: 0,
#     password: "123123",
#     password_confirmation: "123123",
#     unit_id: id_unidades.sample
# )

# Student.create!(
#     name: "Thiago Maciel Ramos",
#     email: "thiagomrvieira@gmail.com",
#     birthday:  FFaker::Time.date ,
#     phone:   FFaker::PhoneNumberBR.mobile_phone_number,
#     points: 0,
#     password: "123123",
#     password_confirmation: "123123",
#     unit_id: id_unidades.sample
# )

# 100.times do
#     Student.create!(
#         name:  FFaker::Internet.user_name ,
#         email:  FFaker::Internet.email ,
#         birthday:  FFaker::Time.date ,
#         phone:   FFaker::PhoneNumberBR.mobile_phone_number,
#         points: 0,
#         password: "123123",
#         password_confirmation: "123123",
#         unit_id: id_unidades.sample
#     )
# end

# Course.create!(
#     title: "Inglês",
#     unit_id: Unit.last.id
# )

# Level.create!(
#     title: "Beginner",
#     course_id: Course.last.id
# )
# Level.create!(
#     title: "Intermediate",
#     course_id: Course.last.id
# )
# Level.create!(
#     title: "Upper Intermediate",
#     course_id: Course.last.id
# )
# Level.create!(
#     title: "Advanced",
#     course_id: Course.last.id
# )

# Path.create!(
#     title: "Exercício 1",
#     level_id: Level.first.id
# )

# Path.create!(
#     title: "Exercício 2",
#     level_id: Level.first.id
# )

# 10.times do
#     phrase =  FFaker::BaconIpsum.phrase
#     Question.create!(
#         title: phrase,
#         description:  FFaker::BaconIpsum.sentence ,
#         type_question: "Questão Aberta",
#         path_id: Path.first.id
#     )
#     QuestionText.create!(
#         student_answer: phrase,
#         question_id: Question.last.id
#     )

# end

# 10.times do
#     phrase =  FFaker::BaconIpsum.phrase
#     Question.create!(
#         title: phrase,
#         description:  FFaker::BaconIpsum.sentence ,
#         type_question: "Questão Aberta",
#         path_id: Path.second.id
#     )
#     QuestionText.create!(
#         student_answer: phrase,
#         question_id: Question.last.id
#     )

# end

# 50.times do
#     LoginActivity.create!(
#         :scope => "student",
#         :strategy => "database_authenticatable",
#         :identity => "felipemrvieira@gmail.com",
#         :success => true,
#         :failure_reason => nil,
#         :user_type => "Student",
#         :user_id => 103,
#         :context => "students/sessions#create",
#         :ip => "::1",
#         :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36",
#         :referrer => "http://localhost:3000/students/sign_in",
#         :city => nil,
#         :region => nil,
#         :country => nil,
#         :created_at => FFaker::Time.between('2012-11-12 16:20', '2019-11-12 16:20')

#     )
# end
