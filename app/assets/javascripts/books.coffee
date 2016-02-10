# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
load_function = () ->
  $("#output").html "SAFE"

$(document).ready ->
  $.getJSON '/books.json', (json, status, xhr) ->
    counter = 0
    book_container = $("#books-container")
    html = '<table class="table">'

    for book, i in json
      
      book_url = JSON.stringify book["url"].substring(0, book["url"].indexOf(".json"))
      if counter % 4 == 0
        html += "<tr>"
        
      html += '<td><table class="table">'
        
      html += '<tr><td><a href='+book_url+'><img width="150" src="'+ book.picture["picture"]["url"] + '"></img></a></td></tr>'
      html += '<tr><td><a href='+book_url+'>'                      + book.name                      + '</a></td></tr>'
      html += '<tr><td>Author: '                                   + book.author                    + '</td></tr>'
      
      html += '</table></td>'      
      
      counter += 1
      if counter % 4 == 0
        html += "</tr>"

    html += "</table>"
    book_container.html html

