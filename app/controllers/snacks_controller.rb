class SnacksController < ApplicationController
  def index
    @title = 'Nerdery OCD Snacks'
    @snacks = Snack.all
  end
end
