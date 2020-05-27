const DEFAULT_TEXT_PREFIX = 'Podríamos pedir';
$(document).ready(function () {
  getFromEndpoint('clasicas', DEFAULT_TEXT_PREFIX);
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

function loadClassicMeal() {
  $('.categorias').click(function () {
    let endpoint = $(this).attr('id');
    getFromEndpoint(endpoint, DEFAULT_TEXT_PREFIX);
  });
}

function handleAcceptRejectClick(params) {
  $(document.body).on('click', '.accept-reject-btn', function () {
    console.log('Clicked accept-reject button...');
    let acceptOrReject = $(this).attr('id');
    acceptOrGetAnotherMeal(acceptOrReject);
  });
}

function handleCloseCongrats() {
  $(document.body).on('click', '.alert .close', function (e) {
    $(this).parent().hide();
    $('#accept-btn').prop('disabled', false);
    $('#reject-btn').prop('disabled', false);
  });
}

$(document).ready(function () {
  loadClassicMeal();
  handleAcceptRejectClick();
  handleCloseCongrats();
});
