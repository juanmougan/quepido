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
    showMealAccepted();
  } else {
    const alternativeTextPrefix = 'Entonces pidamos';
    let mealType = $("input[name='categorias']:checked").val();
    console.log(`mealType: ${mealType}`);
    getFromEndpoint(mealType, alternativeTextPrefix);
  }
}

function showMealAccepted() {
  $('#accepted-meal-alert').html(
    '<p>Genial que te haya gustado la idea!</p><button type="button" class="close">&times;</button>'
  );
  $('#accept-btn').prop('disabled', true);
  $('#reject-btn').prop('disabled', true);
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
  $('.close').click(function () {
    $('#accepted-meal-alert').alert('close');
  });
});
