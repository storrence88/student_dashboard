class StudentsController < ApplicationController

    def new
        @dojo = Dojo.find(params[:id])
        render 'new'
    end

    def create
        # p "*"*20
        # p params
        new_student = Student.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], dojo: Dojo.find(params[:id]))
        if new_student.valid? == true
            flash[:success] = "You have successfully created a Student!"
            redirect_to "/dojos/#{params[:id]}"
        else
            flash[:errors] = new_student.errors.full_messages
            redirect_to "/dojos/#{params[:id]}/students/new"
        end
        p new_student.errors.full_messages 
    end

    def show
        @this_student = Student.find(params[:id])
        # p @this_student 
        # p "*" * 20
        @this_dojo = Dojo.find(@this_student.dojo_id)
        # p @this_dojo
        # p "*" * 20
        @these_students = @this_dojo.students.where.not(id: params[:id])
        # p @these_students
        # p "*" * 20
    end

    def edit
        @this_student = Student.find(params[:id])
        # p @this_student 
        # p "*" * 20
        @this_dojo = Dojo.find(@this_student.dojo_id)
        # p @this_dojo
        # p "*" * 20
        @all_dojos = Dojo.where.not(id: @this_dojo.id)
        # p @all_dojos
        # p "*" * 20
    end

    def update
        update_student = Student.update(params[:id], first_name: params[:first_name], last_name: params[:last_name], email: params[:email], dojo: Dojo.find(params[:dojo]))
        # p update_student
        # p "*" * 30
        if update_student.valid?
            redirect_to "/dojos/#{params[:dojo]}/students/#{params[:id]}"
        else
            flash[:errors] = update_student.errors.full_messages
            redirect_to :back
        end
    end

    def destroy
        destroy_student = Student.destroy(params[:id])
        redirect_to :back
    end

    private
        def student_params
            params.require(:student).permit(:first_name, :last_name, :email, :dojo)
        end

end
