class UrlsController < ApplicationController
  require 'SecureRandom'
  def index
    @user = User.find(params[:user_id])
    @urls = @user.urls
  end

  def new
    @url = Url.new
  end

  def create
    url = Url.create!(name: params[:url][:name], original_url: params[:url][:original_url], shortened_url: SecureRandom.urlsafe_base64(n=4))

    redirect_to user_urls_path
  end

  def show
    @url = Url.where(id: params[:id], user: current_user)
  end

  def destroy
    Url.destroy(params[:id])
    redirect_to user_urls_path
  end

  def short_code
    shortened_url = Url.find_by(shortened_url: params[:shortened_url])
    real_url = "http://#{shortened_url.original_url}"

    redirect_to real_url
  end

  private

  def url_params
    params.require(:url).permit(:name, :original_url)
  end
end

