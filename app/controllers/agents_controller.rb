class AgentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_agent, only: %i[show edit update destroy]
  before_action :set_directions, only: %i[new edit create update]

  def index
    @directions = Direction.all
    @statuses = ['Président', 'Vice-Président', 'Membre', 'Admin', 'S.G']
    @agents = Agent.all

    filter_agents

    if params[:export].present?
      export_agents(@agents) 
    end
  end

  def import
    if params[:file].present?
      AgentImportService.new(params[:file]).call
      redirect_to agents_path, notice: 'Agents importés avec succès!'
    else
      redirect_to agents_path, alert: 'Veuillez télécharger un fichier.'
    end
  end

  def show
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    if @agent.save
      redirect_to @agent, notice: 'Agent créé avec succès.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @agent.update(agent_params)
      redirect_to agents_path, notice: 'Agent mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @agent.destroy
    redirect_to agents_path, status: :see_other, notice: 'Agent supprimé avec succès.'
  end

  private

  def set_agent
    @agent = Agent.find(params[:id]).decorate
  end

  def set_directions
    @directions = Direction.all
  end

  def agent_params
    params.require(:agent).permit(:name, :email, :code, :birthday, :status, :direction_id)
  end

  def filter_agents
    if params[:name].present?
      @agents = @agents.where("name ILIKE ?", "%#{params[:name]}%")
    end

    if params[:direction_id].present?
      @agents = @agents.where(direction_id: params[:direction_id])
    end

    if params[:status].present?
      @agents = @agents.where(status: params[:status])
    end

    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date]) rescue nil
      end_date = Date.parse(params[:end_date]) rescue nil

      if start_date && end_date
        @agents = @agents.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
      else
        flash.now[:alert] = "Dates invalides"
      end
    end
  end

  def export_agents(agents)
    AgentExportService.new(agents).call
    send_file Rails.root.join('public', 'agents.xlsx'), type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', disposition: 'attachment'
  end
  
end
