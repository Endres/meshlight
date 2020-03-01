function drawCircle(selector) {
  var total = $(selector).length;
  var alpha = Math.PI * 2 / total;
  var angle = -90;
  angle *= Math.PI / 180;
  var radius = $(selector).parent().width() / 2;

  $(selector).each(function(index) {
    var theta = alpha * index;
    var pointx  =  Math.floor(Math.cos( theta + angle ) * radius) + radius;
    var pointy  = Math.floor(Math.sin( theta + angle ) * radius) + radius;

    $(this).css("margin-left", pointx - $(selector).width()/2 + "px");
    $(this).css("margin-top", pointy - $(selector).height()/2 + "px");
  });
}
var circleLength = 0;

function updateCircles(newLength) {
  while (newLength > circleLength) {
    circleLength += 1;
    $("ul.circle").append($("<li />").text(circleLength));
    drawCircle("ul.circle li");
  }
  while (newLength < circleLength) {
    circleLength -= 1;
    $("ul.circle li").last().remove();
    drawCircle("ul.circle li");
  }
}

function updateFrame() {
  $.get("/api/get_frame").done(function(response) {
    $("#fps").text(response["fps"]);
    updateCircles(response["pixel_count"]);
    var count = Math.min(response["color_data"].length / 3, $("ul.circle li").length);
    for (var i = 0; i < count; i++) {
      $("ul.circle li").eq(i).text(i);
      var r = response["color_data"][i * 3];
      var g = response["color_data"][i * 3 + 1];
      var b = response["color_data"][i * 3 + 2];
      $("ul.circle li").eq(i).css("backgroundColor", "rgb(" + r + "," + g + "," + b + ")");
    }
    setTimeout("updateFrame();", 50);
  }).fail(function() {
    $("ul.circle li").text("?");
    // TODO: implement same as on arduino, fade to black after some time
    setTimeout("updateFrame();", 1000);
  });
}

var sequence_data = null;
var animations = [];

function isEqual(obj1, obj2) {
  return JSON.stringify(obj1) === JSON.stringify(obj2);
}

function eventString(e) {
  if (e["type"] == "Always") {
    return e["type"];
  }
  var s = "";
  if (e["until_flag"]) { //TODO
    s = "Until ";
  }
  s += e["type"];
  if (e["params"]) { //TODO
    s += "(" + e["params"].join(", ") + ")"; // maybe extend to support various formats like hours:minutes etc.
  }
  return s;
}

function durationString(d) {
  var s = [];
  if (d > 24*60*60) {
    var n = Math.floor(d / (24*60*60));
    s.push(n + (n == 1 ? " Day" : " Days"));
    d = (d % (24*60*60));
  }
  if (d > 60*60) {
    var n = Math.floor(d / (60*60));
    s.push(n + (n == 1 ? " Hour" : " Hours"));
    d = (d % (60*60));
  }
  if (d > 60) {
    var n = Math.floor(d / 60);
    s.push(n + (n == 1 ? " Minute" : " Minutes"));
    d = (d % 60);
  }
  if (d != 0) {
    s.push(d + (d == 1 ? " Second" : " Seconds"));
  }
  if (s.length < 2) {
    return s[0];
  } else {
    s[s.length - 2] += " and " + s.pop();
    //s[s.length - 1] = "and " + s[s.length - 1];
  }
  return s.join(", ");
}

function updateData() {
  $.get("/api/get_data").done(function(response) {
    $("#fps").text(response["fps"]);
    if (!isEqual(response["animations"], animations)) {
      animations = response["animations"];
      mode = "auto"; // TODO
      var options = $.map(animations, function(o, name) {
        return $("<option />").text(name).prop("selected", response["mode"] == name);
      });
      $("#mode").empty().append($("<option />").text("Automatic Mode").prop("selected", response["mode"] == "auto")).append(options).change();
    } else {
      $("#mode option").each(function() {
        $(this).prop("selected", $(this).text() == response["mode"] || (response["mode"] == "auto" && $(this).text() == "Automatic Mode"));
      });
    }
    if (!isEqual(response["sequence"], sequence_data)) {
      sequence_data = response["sequence"];
      var rows = $.map(sequence_data, function(row) {
        var active = ("is_active" in row && row["is_active"]);
        //if (active)
        //  $("#options").html(row["animation"]); // TODO params
        return "<tr><td>" +
          (active ? "<i class='fa fa-arrow-right'></i>" : "") +
          "</td><td>" + row["animation"] + "</td><td>" +
          durationString(row["duration"]) + "</td><td>" +
          eventString(row["event"]) + "</td></tr>";
      });
      $("#sequence tbody").html(rows.join(""));
    }
    setTimeout("updateData();", 1000);
  }).fail(function() {
    // TODO: what to do on fail?
    setTimeout("updateData();", 1000);
  });
}

var option_animation = null;

function changeOption() {
  if (!option_animation)
    return;
  console.log($(this).attr("data-option"), $(this).val());
  // TODO send back to server
}

function updateOptions(animation) {
  $("#options-title").text(animation);
  option_animation = animation;
  var option_id = 0;
  var options = $.map(animations[animation], function(params, option) {
    var min_value = params[0];
    var max_value = params[1];
    var default_value = params[2];
    var type = params[3];

    var ret = [$("<label />").attr("for", "opt-" + option_id).text(option)];

    switch (type) {
      case "slider-int":
      case "slider-duration":
      case "slider-float":
      // TODO maybe handle different sliders differently
      var input = $("<input />").attr("type", "range").
        addClass("custom-range").attr("id", "opt-" + option_id).
        attr("min", min_value).attr("max", max_value).val(default_value).
        attr("data-option", option).change(changeOption).
        on("input", function() {
          $("#" + this.id + "-val").val($(this).val());
        });
      if (type == "slider-float") {
        input.attr("step", "0.01");
      }
      ret.push($("<div />").addClass("range-container").append(input).
        append($("<output />").attr("id", "opt-" + option_id + "-val").
        val(default_value)));
      break;

      case "color":
      var color = "rgb(" + default_value[0] + "," + default_value[1] + "," +
        default_value[2] + ")";
      ret.push($("<input/>").attr("id", "opt-" + option_id).val(color).
        addClass("spectrum-color"));
      break;

      default:
      ret.push($("<input />").attr("type", "text").addClass("form-control").
        attr("id", "opt-" + option_id).val(default_value).
        attr("data-option", option).change(changeOption));
    }

    option_id ++;

    return ret;
  });
  $("#options").empty().append(options);
  $("#options .spectrum-color").spectrum({type: "color", showAlpha: false, allowEmpty: false});
}

$("#add_sequence").click(function() {
  if (!option_animation)
    return;
  alert("not implemented");
});

function sendApiData(url, data, ttl) {
  if (!ttl) {
    ttl = 10;
  }
  $.ajax({
    url: url,
    type: "POST",
    data: JSON.stringify(data),
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    error: function() {
      if (ttl > 1) {
        setTimeout(function() {sendApiData(url, data, ttl - 1);}, 1000);
      }
    }
  });
}

$("#mode").change(function(e) {
  var new_animation = $(this).val();
  if (new_animation in animations) {
    // load config options for single animation
    updateOptions(new_animation);
    $("#add_sequence").removeClass("disabled");
  } else {
    // Automatic Mode
    option_animation = null;
    $("#options-title").text("Automatic Mode");
    $("#options").text("Not implemented"); // TODO
    $("#add_sequence").addClass("disabled");
  }
  if (e.originalEvent) {
    // send single / auto animation change
    sendApiData("/api/set_data", {mode: new_animation in animations ? new_animation : "auto"});
  }
});

$(document).ready(function() {
  drawCircle("ul.circle li");
  updateData();
  updateFrame();
  $('tbody').sortable({
    removeOnSpill: true
  });
});

$(window).bind('beforeunload', function(e) {
  if (false) { // TODO
    var message = "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
    e.returnValue = message;
    return message;
  }
});
