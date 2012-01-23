$(function () {
  $(window.applicationCache).bind('error', function () {
    alert('There was an error when loading the cache manifest.');
  });

 //  $("#items").html($("#coversheet_template").tmpl({"b":{"PropertyId":"150"}}));
  //$("#items").html($("#item_template").tmpl({"item":{"name":"cake"}}));
    $.retrieveJSON("/coversheet.json", function(data) {
    $("#items").html($("#coversheet_template").tmpl(data));

  });
//});

  //   $("#items").html($("#coversheet_template").tmpl({"b":{"PropertyId":"150"}}));
});

                










