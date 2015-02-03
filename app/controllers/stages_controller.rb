class StagesController < ApplicationController
  before_filter :check_user_logged, :except => [:search, :index, :show]
  before_filter :check_admin_logged, :except => [:search, :index, :show]

  # GET /stages
  # GET /stages.json
  def index
    @stages = Stage.all

    respond_to do |format|
      format.html # _stage.html.erb
      format.json { render json: @stages }
    end
  end

  # GET /stages/1
  # GET /stages/1.json
  def show
    @stage = Stage.find(params[:id])
    @event = @stage.event

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage }
    end
  end

  # GET /stages/new
  # GET /stages/new.json
  def new
    @event = Event.find(params[:event_id])
    @stage = @event.stages.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage }
    end
  end

  # GET /stages/1/edit
  def edit
    @stage = Stage.find(params[:id])
    @event = @stage.event
  end

  # POST /stages
  # POST /stages.json
  def create
    @event = Event.find(params[:event_id])
    @stage = @event.stages.build(params[:stage])

    respond_to do |format|
      if @stage.save
        format.html { redirect_to event_stage_url(@event, @stage)}
        format.json { render json: @stage, status: :created, location: @stage }
      else
        format.html { render action: "new" }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stages/1
  # PUT /stages/1.json
  def update
    @stage = Stage.find(params[:id])

    respond_to do |format|
      if @stage.update_attributes(params[:stage])
        format.html { redirect_to event_stage_path(@stage.event, @stage), notice: 'Stage was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stages/1
  # DELETE /stages/1.json
  def destroy
    @stage = Stage.find(params[:id])
    event = @stage.event
    @stage.destroy

    respond_to do |format|
      format.html { redirect_to event_path(event)}
      format.json { head :ok }
    end
  end

end
