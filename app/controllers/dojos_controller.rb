class DojosController < ApplicationController
    def index
        @count = Dojo.all.count
        @dojos = Dojo.all
        #p @dojos
    end

    def new
        flash[:success] = ""
    end

    def create
        new_dojo = Dojo.create(dojo_params)
        if new_dojo.valid? == true
            flash[:success] = "You have successfully created a Dojo!"
            redirect_to '/dojos/new'
        else
            flash[:errors] = new_dojo.errors.full_messages
            redirect_to '/dojos/new'
        end
        p new_dojo.errors.full_messages
    end

    def show
        @dojo = Dojo.find(params[:id])
        @students = @dojo.students
        # p @students
        render 'show'
    end

    def edit
        @dojo = Dojo.find(params[:id])
        render 'edit'
    end

    def update
        Dojo.update(params[:id], dojo_params)
        redirect_to '/dojos'
    end

    def delete
        Dojo.destroy(params[:id])
        redirect_to '/dojos'
    end

    private
        def dojo_params
            params.require(:dojo).permit(:branch, :street, :city, :state)
        end
        
end
