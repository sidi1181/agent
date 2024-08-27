class AgentsListComponent < ViewComponent::Base
    def initialize(agents:)
      @agents = agents
    end
end
