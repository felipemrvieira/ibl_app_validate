Rails.application.routes.draw do

  namespace :backoffice do
    get 'audios/index'
    get 'audios/new'
    get 'audios/create'
    get 'audios/destroy'
    # post 'messages', to: 'messages#create'
    get 'states', to: 'messages#states'
    # get 'posts', to: 'messages#posts'
  end

  namespace :site do
    get 'home/index'
  end

  namespace :api do
    get 'units/index', to: 'units#index'
    get 'units/states', to: 'units#states'
    get 'units/cities', to: 'units#cities'
    get 'units/:id', to: 'units#show'
    get 'courses/index', to: 'courses#index'
    get 'posts', to: 'posts#index'
    get 'posts/categories', to: 'posts#categories'
    get 'posts/categories/:id', to: 'posts#categories_show'
    get 'search', to: 'posts#search'
    get 'posts/:id', to: 'posts#show'
    get 'galleries/last', to: 'galleries#last'
    get 'pages/:id', to: 'pages#show'
    get 'question_answers', to: 'question_answers#index'
    post 'messages', to: 'messages#create'
    post 'discount_messages', to: 'discount_messages#create'


  end

  authenticate :unit do
    # root 'backoffice/dashboard#index'
    namespace :backoffice do
      get 'dashboard', to: 'dashboard#index'
      resources :weekly_challenges
      resources :audio_versions
      resources :galleries
      resources :units
      resources :students
      resources :courses
      resources :levels
      resources :errolments
      resources :posts
      resources :categories
      resources :pages
      resources :messages
      resources :discount_messages
      get 'sign_form', to: 'discount_messages#sign_form'

      resources :question_answers

      put 'errolments/change/:id', to: 'errolments#change_status', as: :change_status
      put 'student/errolments/change/:id', to: 'students#change_status', as: :student_change_status
      get 'student/lesson/delete/:id', to: 'students#delete_lesson', as: :student_delete_lesson
      get 'unit/achievements', to: 'student_achievements#by_unit', as: :student_achievements_unit
      get 'questions/attempts', to: 'questions#attempts', as: :questions_attempts
      get 'questions/attempts/delete/:id', to: 'questions#delete_attempt', as: :delete_questions_attempts

      resources :paths
      resources :questions
      resources :question_errors
      resources :achievements
      resources :student_achievements
      resources :audios
      resources :exams
      resources :books
      resources :student_books
      resources :instructions

    end
  end

  authenticate :student do
    root 'site/courses#index'

    namespace :site do
      resources :quizzes
      get '/quizzes/courses/:id', to: 'quizzes#course', as: 'course'
      get '/quizzes/level/:id', to: 'quizzes#level', as: 'level'

      post '/quizzes/start_lesson', to: 'quizzes#start_lesson', as: :start_lesson
      # map to custom action
      post '/quizzes/report', to: 'quizzes#report', as: :report_question
      resources :weekly_challenge_quizzes
      resources :student_instructions


      patch 'students', to: 'students#update'
      get 'simulados', to: 'simulados#index'
      get 'audios', to: 'audios#index'

      get '/courses/:id/audios', to: 'audios#course', as: 'course_audio'
      get '/courses/:id', to: 'courses#show', as: 'show_course'

      get '/courses/:id/books', to: 'books#course', as: 'course_book'
      get '/courses/:id/books/:book_id', to: 'books#index', as: 'show_book'

      post 'book_save_page', to: 'books#save_page'
    end
  end

  devise_for :students, controllers: { sessions: 'students/sessions' }
  devise_for :units, controllers: { sessions: 'units/sessions' }



end
