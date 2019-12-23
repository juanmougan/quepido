$(document).ready(function() {
  getFromEndpoint('clasicas');
});

function getFromEndpoint(endpoint) {
  $(document).ready(function() {
    $.get('que' + '/' + endpoint, function(data) {
      $('#que-pido').html(
        'Podríamos pedir <strong class="item-chosen">' + data + '</strong>'
      );
    });
  });
}

$(document).ready(function() {
  $('.categorias').click(function() {
    var endpoint = $(this).attr('id');
    getFromEndpoint(endpoint);
  });
});
