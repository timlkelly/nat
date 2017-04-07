class SnacksController < ApplicationController
  def index
    @title = 'Nerdery OCD Snacks'

    @permanent_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(optional: true)
  end
end
