# Renders a partial
alert "pipo"
$("#items-list").html "<%= escape_javascript(render partial: 'list') %>"
