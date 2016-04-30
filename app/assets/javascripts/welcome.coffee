# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # Flash stripper
  if window.location.search.match /flash/
    window.history.pushState('', '', window.location.origin);

  # Checkout button
  if $('#check-out')
    $('#check-out a').on 'click', (e) ->
      e.preventDefault()
      passId = window.prompt('Enter Pass Id')
      if passId
        $.ajax
          type: 'PUT'
          url: "/visits/#{passId}"
          data: visit: owner_id: passId
          dataType: 'json'
          success: (resp) =>
            if resp.checked_out
              currentLocation = window.location.href
              window.location = "#{currentLocation}?flash=#{resp.notice}"
              return
            if resp.notice
              $('#notice').text(resp.notice)
