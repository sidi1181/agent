class MaisonsController < ApplicationController
  def index
    @agents_count = Agent.count
    @directions_count = Direction.count
    @contrats_count = Contrat.count
  end
end
