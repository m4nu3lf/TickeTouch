class EventsController < ApplicationController

  before_filter :check_user_logged, :except => [:search, :index, :show]
  before_filter :check_admin_logged, :except => [:search, :index, :show]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # _stage.html.erb
      format.json { render json: @events }
      format.rss { render :layout => false }
    end
  end

  def search
    query = "%" + params[:event_search] + "%";
    @events = Event.joins(:artists).where('events.title like ? or artists.art_name like ?', query, query)
    @stages = Array.new

    if params[:search_nearby]
      case params[:transport_type]
        when "by_foot" then filter_nearby(0.5, 2);
        when "by_car" then filter_nearby(5, 20);
        when "" then redirect_to request.referer, :notice => "Scegliere il mezzo di trasporto" and return
      end
    end

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @events }
    end
  end

  def add_artist
     if (params[:artist_id] == "")
       redirect_to request.referer, :notice => "Scegliere un artista" and return
     end
     artist = Artist.find(params[:artist_id])
     event = Event.find(params[:event_id])
     event.artists << artist
     redirect_to event
  end

  def remove_artist
    event = Event.find(params[:event_id])
    artist = Artist.find(params[:artist_id])
    event.artists.delete(artist)
    redirect_to event
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end

  private

  def filter_nearby(a, b)
    @events = @events.select do |event|
      nearby_stages = event.nearby_stages(current_user.address, a, b)
      nearby_stages.each do |stage|
        @stages << stage
      end
      !nearby_stages.empty?
    end
  end

end
