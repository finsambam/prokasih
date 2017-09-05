class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, :only => [:index,:new,:edit]
  before_action :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
 
  # GET /users
  # GET /users.xml                                                
  # GET /users.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    @users = User.accessible_by(current_ability, :index).limit(20)
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end
 
  # GET /users/new
  # GET /users/new.xml                                            
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
 
  # GET /users/1/edit                                                      
  # GET /users/1/edit.xml                                                      
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # PUT /users/1
  # PUT /users/1.xml
  # PUT /users/1.json                                            HTML AND AJAX
  #----------------------------------------------------------------------------
  def update
    if params[:user][:password].blank?
      [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    else
      @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
    end
  
    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(user_params)
        # set as administrator when role_id appear
        @user.roles << accessible_roles.find(params[:user][:role_id]) unless params[:user][:role_id].blank?
        # set as staff when role_id not appear
        @user.roles << accessible_roles.find_by(name: "Staff") if params[:user][:role_id].blank?
        
        flash[:success] = "Akun anda berhasil di update"
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { render :action => :edit }
      else
        format.json { render :text => "Pembaharuan user gagal", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml, :html)
  end
 
  # DELETE /users/1     
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @user.destroy!
 
    respond_to do |format|
      format.html { redirect_to :action => :index }      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # POST /users
  # POST /users.xml         
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    begin
      @user = User.new(user_params)
      if @user.save
        # set as administrator when role_id appear
        @user.roles << accessible_roles.find(params[:user][:role_id]) unless params[:user][:role_id].blank?
        # set as staff when role_id not appear
        @user.roles << accessible_roles.find_by(name: "Staff") if params[:user][:role_id].blank?

        # send email to new user
        job_params = {type: "user_registration", user: @user, password: user_params[:password]}
        SendEmailJob.set(wait: 10.seconds).perform_later(job_params)

        respond_to do |format|
          format.json { render :json => @user.to_json, :status => 200 }
          format.xml  { head :ok }
          format.html { redirect_to :action => :index }
        end
      else
        respond_to do |format|
          format.json { render :text => "Pendaftaran user gagal", :status => :unprocessable_entity } # placeholder
          format.xml  { head :ok }
          format.html { render :action => :new, :status => :unprocessable_entity }
        end
      end  
    rescue Exception => e
      respond_to do |format|
        format.json { render :text => "Pendaftaran user gagal", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
