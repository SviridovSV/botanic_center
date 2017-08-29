$(document).on "turbolinks:load", ->
  $ ->
    $('#check_clone').change (event) ->
      event.preventDefault()
      $('#shipping_form').toggle()
      return
    return
