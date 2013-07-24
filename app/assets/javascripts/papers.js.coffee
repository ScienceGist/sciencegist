# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#gist_paper_attributes_tag_list").tagit
    tagSource: (search, showChoices) ->
      that = this
      $.ajax
        url: "/tags/search.json"
        data:
          q: search.term

        success: (choices) ->
          showChoices that._subtractArray(choices, that.assignedTags())


    show_tag_url: "/tags/"
    singleField: true
    allowSpaces: true

