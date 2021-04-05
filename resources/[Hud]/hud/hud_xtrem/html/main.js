﻿var rgbStart = [139, 195, 74];
var rgbEnd = [183, 28, 28];

$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.action == "setValue") {
      if (event.data.key == "job") {
        // setJobIcon(event.data.icon);
      }
      setValue(event.data.key, event.data.value);
    } else if (event.data.action == "setValue2") {
      if (event.data.key == "job2") {
        setJob2Icon(event.data.icon2);
      }
      setValue(event.data.key, event.data.value);
    } else if (event.data.action == "setTalking") {
      setTalking(event.data.value);
    } else if (event.data.action == "setProximity") {
      setProximity(event.data.value);
    } else if (event.data.action == "toggle") {
      if (event.data.show) {
        $("#ui").show();
      } else {
        $("#ui").hide();
      }
    } else if (event.data.action == "toggleCar") {
      if (event.data.show) {
        //$('.carStats').show();
      } else {
        //$('.carStats').hide();
      }
    } else if (event.data.action == "updateCarStatus") {
      updateCarStatus(event.data.status);
      /*}else if (event.data.action == "updateWeight"){
			updateWeight(event.data.weight)*/
    }
  });
});

function updateWeight(weight) {
  var bgcolor = colourGradient(weight / 100, rgbEnd, rgbStart);
  $("#weight .bg").css("height", weight + "%");
  $("#weight .bg").css(
    "background-color",
    "rgb(" + bgcolor[0] + "," + bgcolor[1] + "," + bgcolor[2] + ")"
  );
}

function updateCarStatus(status) {
  var gas = status[0];
  $("#gas .bg").css("height", gas.percent + "%");
  var bgcolor = colourGradient(gas.percent / 100, rgbStart, rgbEnd);
  //var bgcolor = colourGradient(0.1, rgbStart, rgbEnd)
  //$('#gas .bg').css('height', '10%')
  $("#gas .bg").css(
    "background-color",
    "rgb(" + bgcolor[0] + "," + bgcolor[1] + "," + bgcolor[2] + ")"
  );
}

function setValue(key, value) {
  $("#" + key + " span").html(value);
}

//API Shit
function colourGradient(p, rgb_beginning, rgb_end) {
  var w = p * 2 - 1;

  var w1 = (w + 1) / 2.0;
  var w2 = 1 - w1;

  var rgb = [
    parseInt(rgb_beginning[0] * w1 + rgb_end[0] * w2),
    parseInt(rgb_beginning[1] * w1 + rgb_end[1] * w2),
    parseInt(rgb_beginning[2] * w1 + rgb_end[2] * w2),
  ];
  return rgb;
}
