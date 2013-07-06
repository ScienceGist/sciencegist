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
        $('#title').html(data.title)
        $('#authors').html(data.authors)
        $('#journal').html('(' + data.journal + ')')
        $('#hidden_title').val(data.title)
        $('#hidden_authors').val(data.authors)
        $('#hidden_journal').val(data.journal)

