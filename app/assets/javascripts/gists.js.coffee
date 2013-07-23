# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#gist_paper_attributes_identifier").on "input", (e) ->
    that = this
    $.ajax
      url: "/papers_metadata.json"
      data:
        q: that.value

      success: (data) ->
        $('#title').val(data.title)
        $('#authors').val(data.authors)
        $('#journal').val(data.journal)
        $(".gist_paper_identifier").removeClass('error')
        $(".gist_paper_identifier small").remove()
      error: (data) ->
        if $(".gist_paper_identifier small").length == 0 
          $(".gist_paper_identifier").append('<small>DOI or arXiv identifier not found. Must be in exact format, e.g. <strong>doi: 10.1021/ac1014832</strong> or <strong>arXiv:1301.7746</strong>');
        $(".gist_paper_identifier").addClass('error')
$ ->
  login_popup = (data) ->
    if data.status == 401
      $('#overlay').show()
      $('#signup_form').show()

  $('.vote_up').on "click", (e) ->
    e.preventDefault()
    that = this
    $.get(that.href, (data) ->
      $('#gist_' + data.id).html(data.score)
    ).fail( (data) ->
      login_popup(data)
    )

  $('.vote_down').on "click", (e) ->
    e.preventDefault()
    that = this
    $.get(that.href, (data) ->
      $('#gist_' + data.id).html(data.score)
    ).fail( (data) ->
      login_popup(data)
    )

  $('#overlay, #close').on "click", (e) ->
    e.preventDefault()
    $('#overlay').hide()
    $('#signup_form').hide()


  