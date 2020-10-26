class Site::StudentInstructionsController < ApplicationController
  layout "site"

  def create
    if Instruction.any?
      StudentInstruction.create(student_id: current_student.id,
        read: true,
        instruction_id: Instruction.last.id
      )
      redirect_back(fallback_location: root_path)
    end

  end




end
