module ApplicationHelper
    include Pagy::Frontend
    def user_avatar(student, size=40)
        if student.avatar.attached?
            student.avatar.variant(resize: "#{size}x#{size}!")
        else
            gravatar_image_url(student.email, size: size)
        end
    end
end
