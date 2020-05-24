const defaultTextPrefix = 'Podríamos pedir';
$(document).ready(function () {
  getFromEndpoint('clasicas', defaultTextPrefix);
});

function getFromEndpoint(endpoint, textPrefix) {
  $(document).ready(function () {
    $.get('que' + '/' + endpoint, function (data) {
      $('#que-pido').html(
        `${textPrefix} <strong class="item-chosen"> ${data} </strong>`
      );
    });
  });
}

function acceptOrGetAnotherMeal(acceptOrReject) {
  if (acceptOrReject == 'accept-btn') {
    // TODO show snackbar
  } else {
    const alternativeTextPrefix = 'Entonces pidamos';
    let mealType = $("input[name='categorias']:checked").val();
    console.log(`mealType: ${mealType}`);
    getFromEndpoint(mealType, alternativeTextPrefix);
  }
}

$(document).ready(function () {
  $('.categorias').click(function () {
    let endpoint = $(this).attr('id');
    getFromEndpoint(endpoint, defaultTextPrefix);
  });
  $('.accept-reject-btn').click(function () {
    let acceptOrReject = $(this).attr('id');
    console.log('Clicked categories with value: ' + acceptOrReject);
    acceptOrGetAnotherMeal(acceptOrReject);
  });
});
