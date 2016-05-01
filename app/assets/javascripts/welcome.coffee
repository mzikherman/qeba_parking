# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # Flash stripper
  if window.location.search.match /flash/
    window.history.pushState('', '', window.location.origin);

  onCheckOutClick = (e) ->
    e.preventDefault()
    $('#check-out-modal').show()

  onCheckInClick = (e) ->
    e.preventDefault()
    $('#check-in-modal').show()

  onCheckInSubmit = (e) ->
    e.preventDefault()
    window.scrollTo(document.body.scrollLeft, document.body.scrollTop);
    passId = $('#check-in-pass-id').val()
    if passId
      $.ajax
        type: 'POST'
        url: "/visits"
        data: visit: owner_id: passId
        dataType: 'json'
        success: (resp) =>
          if resp.checked_in
            currentLocation = window.location.href
            window.location = "#{currentLocation}?flash=#{resp.notice}"
            return
          if resp.notice
            $(e.currentTarget).siblings('.modal-notice').text(resp.notice.base[0])

  onCheckOutSubmit = (e) ->
    e.preventDefault()
    passId = $('#check-out-pass-id').val()
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
            $(e.currentTarget).siblings('.modal-notice').text(resp.notice)

  $('#check-in-button').on 'click', onCheckInClick
  $('#check-out-button').on 'click', onCheckOutClick
  $('.modal-content .close').on 'click', (e) ->
    $(e.currentTarget).siblings('.modal-notice').text ''
    $(e.currentTarget).siblings('input').val ''
    $(e.currentTarget).parent().parent().hide()
  $('#check-in-submit').on 'click', onCheckInSubmit
  $('#check-out-submit').on 'click', onCheckOutSubmit

