class SnacksController < ApplicationController
  def index
    @title = 'Nerdery OCD Snacks: Vote for a Snack'

    @permanent_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(optional: true, suggested: true)
  end

  def new
    @title = 'Nerdery OCD Snacks: Suggest a Snack'

    @suggestible_snacks = Snack.where(optional: true, suggested: false)
  end

  def create
    if already_voted?
      flash[:error] = ['You have already voted this month']
      redirect_to snacks_path and return
    end

    snack = Snack.new(snack_params)
    snack.optional = true

    if snack.save
      cookies['voted'] = true
      redirect_to snacks_path
    else
      flash[:error] = snack.errors.full_messages
      @snack = snack # return snack so the completed fields are filled out
      render 'new'
    end
  end

  private

  def snack_params
    params.require(:snack).permit(:name, :purchase_location)
  end

  def already_voted?
    true if cookies['voted']
  end
end
