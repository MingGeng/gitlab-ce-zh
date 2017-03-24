class Profiles::PreferencesController < Profiles::ApplicationController
  before_action :user

  def show
  end

  def update
    begin
      if @user.update_attributes(preferences_params)
        flash[:notice] = '偏好设置已保存。'
      else
        flash[:alert] = '保存偏好设置失败。'
      end
    rescue ArgumentError => e
      # Raised when `dashboard` is given an invalid value.
      flash[:alert] = "保存偏好设置失败(#{e.message})。"
    end

    respond_to do |format|
      format.html { redirect_to profile_preferences_path }
      format.js
    end
  end

  private

  def user
    @user = current_user
  end

  def preferences_params
    params.require(:user).permit(
      :color_scheme_id,
      :layout,
      :dashboard,
      :project_view,
    )
  end
end