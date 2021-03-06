include OwnershipAuthentication

class ReadingGroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :reading_group_owner?, only: [:edit, :update, :destroy]
  before_action :set_reading_group, only: [:show, :edit, :update, :destroy]

  # GET /reading_groups/new
  def new
    @reading_group = ReadingGroup.new
  end

  # GET /reading_groups
  # GET /reading_groups.json
  def index
    @reading_groups = ReadingGroup.all
  end

  # POST /reading_groups
  # POST /reading_groups.json
  def create
    @reading_group = ReadingGroup.new(reading_group_params)
    respond_to do |format|
      create_and_redir(format)
    end
  end

  # GET /reading_group/1
  # GET /reading_group/1.json
  def show; end

  # GET /reading_groups/1/edit
  # GET /reading_groups/1/edit.json
  def edit; end 

  def update
    if @reading_group.update(reading_group_params)
      redirect_to(reading_group_path(@reading_group.id))
    else
      render "edit"
    end
  end

  # DELETE /reading_group/1
  # DELETE /reading_group/1.json
  def destroy
    current_user.reading_group_ownerships.find_by_reading_group_id(@reading_group.id).destroy
    @reading_group.destroy
    respond_to do |format|
      format.html { redirect_to reading_groups_url }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_reading_group
    @reading_group = ReadingGroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reading_group_params
    params[:reading_group]
  end

  # Extracted code from create action
  def create_and_redir(format)
    if @reading_group.save
      current_user.reading_group_ownerships.create reading_group_id: @reading_group.id

      format.html { redirect_to reading_group_path(@reading_group.id), notice: 'Reading Group was successfully created.' }
      format.json { render action: 'show', status: :created, location: @reading_group }
    else
      format.html { render action: 'new' }
      format.json { render json: @reading_group.errors, status: :unprocessable_entity }
    end
  end
end
