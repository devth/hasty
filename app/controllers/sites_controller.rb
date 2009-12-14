class SitesController < ApplicationController
  before_filter :require_user #, :only => [:show, :edit, :update]


  def index
    @sites = current_user.sites

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sites }
    end
  end

  def show
    @site = current_user.sites.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  def new
    @user = current_user
    @site = @user.sites.build
    @servers = @user.servers.all
    
    # let there be one server linked
    @site.site_servers.build
    
    # build empty server in case they want to add a new one
    @site.servers.build if @site.servers.empty?
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  def edit
    @site = current_user.sites.find(params[:id])
    @servers = current_user.servers.all
    
    # let there be one server linked
    @site.site_servers.build if @site.site_servers.empty?
    
  end

  def create
    @site = current_user.sites.build(params[:site])
    # populate user id manually so it can't be hijacked in the form
    @site.servers.each do |server|
      server.user_id = current_user.id
    end
    
    respond_to do |format|
      if @site.save
        flash[:notice] = 'Site was successfully created.'
        format.html { redirect_to(@site) }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @site = current_user.sites.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        flash[:notice] = 'Site was successfully updated.'
        format.html { redirect_to(@site) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @site = current_user.sites.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(sites_url) }
      format.xml  { head :ok }
    end
  end
end
