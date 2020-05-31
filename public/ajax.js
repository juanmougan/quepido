const DEFAULT_TEXT_PREFIX = 'Podríamos pedir';
let rejectedMeals = [];

$(document).ready(function () {
  getFromEndpoint('clasicas', DEFAULT_TEXT_PREFIX);
});

function getFromEndpoint(endpoint, textPrefix) {
  const url = `que/${endpoint}`;
  console.log(`URL: ${url}`);
  performGet(url, textPrefix);
}

function getFromEndpointExcept(endpoint, textPrefix, blacklist) {
  console.log(`blacklist: ${blacklist}`);
  const url = `que/${endpoint}?except=${blacklist}`;
  console.log(`URL: ${url}`);
  performGet(url, textPrefix);
}

function performGet(url, textPrefix) {
  // $(document).ready(function () {
  $.get(url, function (data) {
    $('#que-pido').html(
      `${textPrefix} <strong class="item-chosen"> ${data} </strong>`
    );
  });
  // });
}

function acceptOrGetAnotherMeal(acceptOrReject) {
  if (acceptOrReject == 'accept-btn') {
    $('#accept-btn').prop('disabled', true);
    $('#reject-btn').prop('disabled', true);
    showMealAccepted();
  } else {
    const rejectedMeal = $('.item-chosen').text().trim();
    rejectedMeals.push(rejectedMeal);
    localStorage.setItem('blacklist', rejectedMeals);
    const alternativeTextPrefix = 'Entonces pidamos';
    let mealType = $("input[name='categorias']:checked").val();
    getFromEndpointExcept(
      mealType,
      alternativeTextPrefix,
      localStorage.getItem('blacklist')
    );
  }
}

function showMealAccepted() {
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
    let acceptOrReject = $(this).attr('id');
    acceptOrGetAnotherMeal(acceptOrReject);
  });
}

function handleCloseCongrats() {
  $(document.body).on('click', '.alert .close', function (e) {
    $(this).parent().hide();
    $('#accept-btn').prop('disabled', false);
    $('#reject-btn').prop('disabled', false);
    localStorage.clear();
    rejectedMeals = [];
  });
}

$(document).ready(function () {
  loadClassicMeal();
  handleAcceptRejectClick();
  handleCloseCongrats();
});
