$(document).on "turbolinks:load", ->
  $ ->
    $('#read_link').click(event) ->
      event.preventDefault()
      $('#full_desc').toggle(true)
      $('#short_desc').toggle(false)
      return
    return
  $ ->
    $('#hide_link').click (event) ->
      event.preventDefault()
      $('#full_desc').toggle(false)
      $('#short_desc').toggle(true)
      return
    return
  $ ->
    $('.quantity-plus').click (event) ->
      event.preventDefault()
      old_value = parseInt($('.quantity-input').val())
      $('.quantity-input').val(old_value + 1)
      return
    return
  $ ->
    $('.quantity-minus').click (event) ->
      event.preventDefault()
      old_value = parseInt($('.quantity-input').val())
      if old_value > 1
        $('.quantity-input').val(old_value - 1)
      return
    return