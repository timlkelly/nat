// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap.min
//= require_tree .

function upVote(id) {
  if(ableToVote()) {
    return false;
  }

  increaseVoteCount(id);
  decreaseRemainingVotes();
  sendVoteToServer(id);
}

function ableToVote() {
  var cookieValue = document.cookie.replace(/(?:(?:^|.*;\s*)remaining_snack_votes\s*\=\s*([^;]*).*$)|^.*$/, "$1");
  console.log(cookieValue)
  if(cookieValue == 0) {
    alert('You have no more votes')
    return true;
  }
}

function increaseVoteCount(id) {
  var votesPageElement = document.getElementById('vote-' + id)
  var votes = parseInt(votesPageElement.innerHTML) + 1

  votesPageElement.innerHTML = votes
}

function decreaseRemainingVotes() {
  var remainingVotes = document.getElementById('remaining-votes')
  var voteCount = parseInt(remainingVotes.innerHTML)

  if(voteCount > 0){
    newVoteCount = voteCount - 1
    var newCookie = 'remaining_snack_votes='.concat(newVoteCount)
    document.cookie = newCookie
  } else {
    newVoteCount = 0
  }

  remainingVotes.innerHTML = newVoteCount
}

function sendVoteToServer(id) {
  $.ajax({
    url: '/update_vote_count',
    data: { id: id },
    type: 'POST'
  })
}

// I decided to use Javascript to implement the voting feature because it makes
// for a more seemless user experience. If it was just through html and rails,
// the page would refresh after every vote. This minimizes the amount of data
// back and forth between server as well.
// That said, it was definitely a little strange and storing the data in
// the cookies is not what I would normally do either, but makes sense for
// the prototype/MVP nature of this project.
