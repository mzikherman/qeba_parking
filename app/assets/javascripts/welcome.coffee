# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if $('#check-out')
    $('#check-out a').on 'click', ->
      passId = window.prompt('Enter Pass Id')
      $.ajax
        type: 'PUT'
        url: "/visits/#{passId}"
        data: visit: owner_id: passId
        dataType: 'json'
        success: (e,f,g) =>
          if e.notice
            $('#notice').text(e.notice)
          if e.checked_out
            val = parseInt($('#occupied-spots').text())
            $('#occupied-spots').text(val - 1)