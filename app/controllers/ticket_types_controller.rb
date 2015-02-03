class TicketTypesController < ApplicationController

  before_filter :check_user_logged
  before_filter :check_admin_logged

  def create
    @stage = Stage.find(params[:stage_id])
    @ticket_type = @stage.ticket_types.build(params[:ticket_type])

    respond_to do |format|
      if @ticket_type.save
        format.html { redirect_to event_stage_path(@stage.event, @stage), notice:
            'TicketType was successfully created.' }
        format.json { render json: @ticket_type, status: :created, location: @ticket_type }
      else
        format.html { redirect_to event_stage_path(@stage.event, @stage) }
        format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @ticket_type = TicketType.find(params[:id])
    @stage = @ticket_type.stage
    @ticket_type.destroy


    respond_to do |format|
      format.html { redirect_to event_stage_path(@stage.event_id, @stage)}
      format.json { head :ok }
    end
  end
end
