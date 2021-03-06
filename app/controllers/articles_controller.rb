# -*- coding: utf-8 -*-
class ArticlesController < ApplicationController
  before_filter :login_required
  before_filter :set_diary

  # GET /articles
  # GET /articles.json
  def index
    @articles = @diary.articles.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = @diary.articles.find(params[:id])
    @last_article = @diary.articles.order('updated_at')[-2]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @last_article = if id = params[:article_id]
                      Article.find(id)
                    else
                      @diary.articles.order('updated_at').last
                    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = @diary.articles.find(params[:id])
    @last_article = if id = params[:article_id]
                      Article.find(id)
                    else
                      @diary.articles.order('updated_at')[-2]
                    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    @article.user = current_user
    @article.diary = @diary
    @article.member = @diary.members.find_by_user_id(current_user.id)

    respond_to do |format|
      if @article.save
        format.html { redirect_to edit_diary_article_path(@diary, @article),
                      notice: '日記を次の人にまわしますか？' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = @diary.articles.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        if params[:next_member]
          @diary.baton_pass!
          format.html { redirect_to diaries_path }
        else
          format.html { redirect_to edit_diary_article_path(@diary, @article),
            notice: '日記を次の人にまわしますか？' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = @diary.articles.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to diary_articles_url }
      format.json { head :no_content }
    end
  end

  def baton_pass
    @diary.baton_pass!
    redirect_to diaries_path
  end

  def picture
    @article = Article.find(params[:article_id])
    send_data(Base64.decode64(@article.picture.sub('data:image/png;base64,', '')),
              type: 'image/png')
  end
end
