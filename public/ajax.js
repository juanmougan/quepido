const DEFAULT_TEXT_PREFIX = 'Podríamos pedir';
let rejectedMeals = [];

$(document).ready(function () {
  getFromEndpoint('clasicas', DEFAULT_TEXT_PREFIX);
});

function getFromEndpoint(endpoint, textPrefix) {
  const url = `que/${endpoint}`;
  performGet(url, textPrefix);
}

function getFromEndpointExcept(endpoint, textPrefix, blacklist) {
  const url = `que/${endpoint}?except=${blacklist}`;
  performGet(url, textPrefix);
}

function performGet(url, textPrefix) {
  $.get(url, function (data) {
    $('#que-pido').html(
      `${textPrefix} <strong class="item-chosen"> ${data} </strong>`
    );
  }).fail(function (jqXHR, textStatus, errorThrown) {
    const errorMsg = jqXHR.responseText;
    disableAcceptRejectButtons();
    showNoMoreMeals(errorMsg);
  });
}

function setAcceptRejectButtonsDisabledStatus(status) {
  $('#accept-btn').prop('disabled', status);
  $('#reject-btn').prop('disabled', status);
}

function disableAcceptRejectButtons() {
  setAcceptRejectButtonsDisabledStatus(true);
}

function enableAcceptRejectButtons() {
  setAcceptRejectButtonsDisabledStatus(false);
}

function acceptOrGetAnotherMeal(acceptOrReject) {
  if (acceptOrReject == 'accept-btn') {
    disableAcceptRejectButtons();
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

function showNoMoreMeals(errorMsg) {
  $('#no-more-meals-error').text(errorMsg);
  $('#no-more-meals-alert').show();
}

function handleCategoryClick() {
  $('.categorias').one('click', function () {
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
    enableAcceptRejectButtons();
    localStorage.clear();
    rejectedMeals = [];
  });
}

$(document).ready(function () {
  handleCategoryClick();
  handleAcceptRejectClick();
  handleCloseCongrats();
});
