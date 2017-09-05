class DiscussionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :find_discussion, only: [:edit, :update]

  def index
    session[:offset] = 0
    get_data(session[:offset])
  end

  def create
    begin
      @comment = Comment.new(name: params[:name], email: params[:email], message: params[:message])
      @comment.parent_id = params[:parent_id] if params[:parent_id].present?
      if @comment.save!
        @response = {success: true}
        job_params = {type: "discuss", comment: @comment}
        SendEmailJob.set(wait: 10.seconds).perform_later(job_params)
      else
        @response = {success: false, error: "Terjadi kesalahan pada saat penyimpanan data, silakan coba lagi"}
      end
        
    rescue Exception => e
      @response = {success: false, comment: @comment}
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    begin
      @comment.message = params[:message]
      if @comment.save!
        @response = {success: true}
      else
        @response = {success: false, error: "Terjadi kesalahan pada saat penyimpanan data, silakan coba lagi"}
      end
    rescue Exception => e
      @response = {success: false, comment: @comment}
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def get_more_data
    session[:offset] = session[:offset] + 1
    get_data(session[:offset])
    respond_to do |format|
      format.js
    end
  end

  private
  def get_data(offset)
    limit = 5
    @comments = Comment.isParent().order('created_at DESC').limit(limit).offset(offset * limit)
  end

  def find_discussion
    @comment = Comment.find(params[:id])
  end
end