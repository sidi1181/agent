class DirectionsController < ApplicationController
    def index
      
      if params[:query].present?
        @directions = Direction.search_by_name(params[:query])
      else
        @directions = Direction.all
      end
    
    end
  
    def show
      @direction = Direction.find(params[:id])
      @agents = @direction.agents
    end
    
    def new
      @direction = Direction.new 
    end

    def create
      @direction = Direction.new(direction_params)

      if @direction.save
        redirect_to directions_path
      else
        render :new, status: :unprocessable_entity
      end

    end
  
    def edit
      @direction = Direction.find(params[:id])
    end

    def update
      @direction = Direction.find(params[:id])

      if @direction.update(direction_params)
        redirect_to directions_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      @direction = Direction.find(params[:id])
      @direction.destroy

      redirect_to directions_path, status: :see_other
    end

  private 
  def direction_params
    params.require(:direction).permit(:name)
  end
end
