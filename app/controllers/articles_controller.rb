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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @last_article = @diary.articles.order('updated_at').last

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = @diary.articles.find(params[:id])
    @last_article = @diary.articles.order('updated_at').last
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
        format.html { redirect_to diary_article_path(@article), notice: '日記を次の人にまわしますか？' }
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
        format.html { redirect_to diary_article_path(@article), notice: '日記を次の人にまわしますか？' }
        format.json { head :no_content }
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
    article = Article.find(params[:id])
    article.member.baton_pass
    redirect_to diaries_path
  end
end
