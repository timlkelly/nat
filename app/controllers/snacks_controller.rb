class SnacksController < ApplicationController
  def index
    @title = 'Nerdery OCD Snacks: Vote for a Snack'

    @permanent_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(optional: true)
  end

  def new
    @title = 'Nerdery OCD Snacks: Suggest a Snack'

    @suggestible_snacks = Snack.where(optional: true, suggestion: false)
  end
end
