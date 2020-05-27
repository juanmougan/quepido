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
    console.log('Meal accepted.');
    $('#accept-btn').prop('disabled', true);
    $('#reject-btn').prop('disabled', true);
    showMealAccepted();
  } else {
    console.log('Meal rejected!');
    const alternativeTextPrefix = 'Entonces pidamos';
    let mealType = $("input[name='categorias']:checked").val();
    console.log(`mealType: ${mealType}`);
    getFromEndpoint(mealType, alternativeTextPrefix);
  }
}

function showMealAccepted() {
  console.log('showing meal accepted...');
  $('#accepted-meal-alert').show();
}

$(document).ready(function () {
  $('.categorias').click(function () {
    let endpoint = $(this).attr('id');
    getFromEndpoint(endpoint, defaultTextPrefix);
  });
  $('#js input[type=radio]').hide();
  $(document.body).on('click', '.accept-reject-btn', function () {
    console.log('Clicked accept-reject button...');

    let acceptOrReject = $(this).attr('id');
    acceptOrGetAnotherMeal(acceptOrReject);
  });
  $(document.body).on('click', '.alert .close', function (e) {
    $(this).parent().hide();
  });
});
