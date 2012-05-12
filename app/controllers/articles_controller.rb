# -*- coding: utf-8 -*-
class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @diary = Diary.find(params[:diary_id])
    @member = Member.find_by_user_id_and_diary_id(current_user.id, @diary.id)
    @last_article = @member.prev_member.articles.order('updated_at').last

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @diary = Diary.find(params[:diary_id])
    @member = Member.find_by_user_id_and_diary_id(current_user.id, @diary.id)
    @last_article = @member.prev_member.articles.order('updated_at').last
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    diary = Diary.find(params[:diary_id])
    member = Member.find_by_user_id_and_diary_id(current_user.id, diary.id)

    respond_to do |format|
      if @article.save
        member.articles << @article
        format.html { redirect_to @article, notice: '日記を次の人にまわしますか？' }
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
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
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
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def baton_pass
    member = Member.find(params[:member_id])
    member.baton_pass
    redirect_to diaries_path
  end
end
