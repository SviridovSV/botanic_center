$(document).on "turbolinks:load", ->
  $ ->
    $('#read_link').click(event) ->
      event.preventDefault()
      $('#full_desc').toggle(true)
      $('#short_desc').toggle(false)
      return
    return