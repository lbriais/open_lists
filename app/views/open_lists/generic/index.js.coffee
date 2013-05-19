# Renders a partial
$("#items-list").html "<%= escape_javascript(render('list')) %>"
