class SnacksController < ApplicationController
  def index
    @title = 'Nerdery OCD Snacks: Vote for a Snack'

    @permanent_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(optional: true, suggested: true)

    check_vote_cookie
  end

  def new
    @title = 'Nerdery OCD Snacks: Suggest a Snack'

    @suggestible_snacks = Snack.where(optional: true, suggested: true)
  end

  def create
    already_voted_error and return if already_voted?

    snack = Snack.new(snack_params)
    snack.optional = true
    snack.added_by_employee = true
    snack.suggested = true

    if snack.save
      mark_as_voted
      redirect_to snacks_path
    else
      flash[:error] = snack.errors.full_messages
      redirect_to new_snack_path
    end
  end

  def update
    already_voted_error and return if already_voted?
    @snack = Snack.find(params[:snack][:id])

    already_suggested_error and return if @snack.suggested
    @snack.update_attribute(:suggested, true)

    mark_as_voted
    redirect_to snacks_path
  end

  def update_vote_count
    @snack = Snack.find(params['id'].to_i)
    @snack.votes += 1
    @snack.save
    # Also see javascript notes; This was a bit off to implement.
    # I realize it isn't RESTful and for that reason, I'm not super
    # found of it. While I like the user experience that the javascript
    # implementation allows, it was strange to develop and I wasn't
    # sure exactly of the best practices here.
  end

  private

  def snack_params
    params.require(:snack).permit(:name, :purchase_location)
  end

  def mark_as_voted
    cookies['voted'] = { value: true, expires: 1.month.from_now }
  end

  def already_voted_error
    flash[:error] = ['You have already voted this month']
    redirect_to snacks_path
  end

  def already_suggested_error
    flash[:error] = ['That snack has already been suggested']
    redirect_to new_snack_path
  end

  def already_voted?
    true if cookies['voted']
  end

  def check_vote_cookie
    return if cookies['remaining_snack_votes'].present?
    cookies['remaining_snack_votes'] = { value: 3, expires: 1.month.from_now }
  end
end
