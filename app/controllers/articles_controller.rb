class ArticlesController < ApplicationController
    before_action :require_user , except:[:show,:index]
    before_action :require_same_user,only:[:edit,:update,:destroy]
    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end
    
    def new
        @article = Article.new   
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(params.require(:article).permit(:title,:description))
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article Was Created Successfully"
            redirect_to @article, notice: 'Article was successfully created.'
        else
            render :new
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title,:description))
            flash[:notice] = "Article was Updated Successfully"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: "Article was successfully deleted."
    end

    private

    def require_same_user
        @article = Article.find(params[:id])
        if current_user != @article.user && !current_user.admin?
            flash[:notice] = "You Can only Edit Your Articles"
            redirect_to @article
        end
    end

end