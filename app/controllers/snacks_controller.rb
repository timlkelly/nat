class SnacksController < ApplicationController
  def index
    @title = 'Nerdery OCD Snacks: Vote for a Snack'

    @permanent_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(optional: true)
  end

  def new
    @title = 'Nerdery OCD Snacks: Suggest a Snack'

    @snack = Snack.new
  end

  def create
    return if already_voted?

    snack = Snack.new(snack_params)
    snack.optional = true

    if snack.save
      cookies['voted'] = true
      redirect_to snacks_path
    else
      flash[:error] = snack.errors.full_messages
      render 'new'
    end
  end

  private

  def snack_params
    params.require(:snack).permit(:name, :purchase_location)
  end

  def already_voted?
    if cookies['voted']
      flash[:error] = ['You have already voted this month']
      render 'new'
    end
  end
end
