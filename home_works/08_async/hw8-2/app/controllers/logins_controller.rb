class LoginsController < ApplicationController
    def show
    end
    def create
        raise if params[:password] != '123'
        if params[:balance]==""
            session[:balance]=1000
        else
            session[:balance]=params[:balance]
        end
        session[:login] = params[:login]
        redirect_to :login, notice: "Вы вошли #{session[:login]}"
        
    end
    def destroy
        session.delete(:login)
        session.delete(:balance)
        redirect_to :login, notice: 'Вы вышли'
    end
end