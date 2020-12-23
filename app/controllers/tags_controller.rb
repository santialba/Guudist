class TagsController < ApplicationController
  def new
    @tag = current_user.tags.build
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
