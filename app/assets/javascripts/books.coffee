$(document).on "turbolinks:load", ->
  $ ->
    $('#read_link').click (event) ->
      event.preventDefault()
      $('#full_desc').toggle()
      $('#short_desc').toggle()
      return
    return