$(document).ready(function() {
  getFromEndpoint("clasicas");    
});

function getFromEndpoint(endpoint) {
  $(document).ready(function() {
    $.get( "que" + "/" + endpoint, function( data ) {
      console.log(data);
      $( "#que-pido" ).html( "Podríamos pedir <strong>" + data + "</strong>");
    });
  });
}

$(document).ready(function() {
  $(".categorias").click(function() {
    console.log("clicked: " + $(this));
    var endpoint = $(this).attr('id');
    getFromEndpoint(endpoint);
  });
});
