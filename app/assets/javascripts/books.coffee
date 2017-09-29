$(document).ready ->
  $('#read_link').click (event) ->
    event.preventDefault()
    $('#full_desc').toggle(true)
    $('#short_desc').toggle(false)

  $('#hide_link').click (event) ->
    event.preventDefault()
    $('#full_desc').toggle(false)
    $('#short_desc').toggle(true)

  $('.quantity-plus').click (event) ->
    event.preventDefault()
    old_value = parseInt($('.quantity-input').val())
    $('.quantity-input').val(old_value + 1)

  $('.quantity-minus').click (event) ->
    event.preventDefault()
    old_value = parseInt($('.quantity-input').val())
    if old_value > 1
      $('.quantity-input').val(old_value - 1)

  $('#add_button').click (event) ->
    $('#add_button').addClass('disabled')
    $('#buttons').toggle(false)