require 'net/ftp'
require 'tempfile'

class SitesController < ApplicationController
  before_filter :require_user #, :only => [:show, :edit, :update]


  def index
    @sites = current_user.sites

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sites }
    end
  end
  
  def post
    # do stuff
    
    @site = current_user.sites.find(params[:id])
    @server = @site.servers.first
    
    file_path = Rails.root.join('tmp/index.html')
    
    if File.exists?( file_path )
      
      doc = Nokogiri::HTML(File.open(file_path))
      hastys = doc.css('.editable')
      
      hastys_params = params[:hasty]
      hastys_params.each_index do |index|
        
        hasty = hastys[index]
        hasty_param = hastys_params[index]
        
        hasty.content = hasty_param
        
      end
      
      begin
        # write to file
        f = File.new( file_path, "w" )
        f.write( doc.to_html )
        f.close
      
      
        Net::FTP.open(@server.url) do |ftp|
          ftp.login( @server.username, @server.password )
          ftp.passive = true
          ftp.chdir @site.path unless @site.path.empty?
          #@files = ftp.list
          # pull down index.html
          # index_file = Tempfile.new("index.html", Rails.root.join('tmp'))
          ftp.puttextfile(file_path, 'index.html')
        end
      rescue Exception => e
        flash[:error] = e.message
      end
      
    end
    
    
    external_site = @site.url
    external_site = "http://" + external_site unless external_site.index("http://") == 0
    flash[:notice] = "Site posted! <a href='" + external_site + "'>View your site</a>"
    redirect_to(@site)
    
    
  end

  def show
    @site = current_user.sites.find(params[:id])
    
    # connect to ftp
    @files = []
    @hastys = []
    begin
      unless @site.servers.empty?
        @server = @site.servers.first
      
        file_path = Rails.root.join('tmp/index.html')
        
        #unless File.exists?( file_path )
          Net::FTP.open(@server.url) do |ftp|
            ftp.login( @server.username, @server.password )
            ftp.passive = true
            ftp.chdir @site.path unless @site.path.empty?
            @files = ftp.list
          
            # pull down index.html
            # index_file = Tempfile.new("index.html", Rails.root.join('tmp'))
            ftp.gettextfile('index.html', file_path)
          end
        #end
        
        if File.exists?( file_path )
          
          doc = Nokogiri::HTML(File.open(file_path))
          @hastys = doc.css('.editable')
          
        end
      end
    rescue Exception => e
      flash.now[:error] = e.message
    end
    
    
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
