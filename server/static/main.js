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

var properties = new Object();

function updateData() {
  $.get("/api/get_data").done(function(response) {
    $("#fps").text(response["fps"]);
    var mode = response["mode"];
    properties[mode] = response["properties"];
    if (!isEqual(response["animations"], animations)) {
      animations = response["animations"];
      var options = $.map(animations, function(o, name) {
        return $("<option />").text(name).prop("selected", mode == name);
      });
      $("#mode").empty().append($("<option />").text("Automatic Mode").prop("selected", mode == "auto")).append(options).change();
    } else {
      $("#mode option").each(function() {
        $(this).prop("selected", $(this).text() == mode || (mode == "auto" && $(this).text() == "Automatic Mode"));
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
    $("#masterswitch").prop("checked", !response["blackout"]);
    setTimeout("updateData();", 1000);
  }).fail(function() {
    setTimeout("updateData();", 1000);
  });
}

var option_animation = null;

function changeOption() {
  if (!option_animation)
    return;
  var properties_ = new Object();
  var value = $(this).val();
  switch ($(this).data("type")) {
    case "slider-float":
    value = parseFloat(value);
    break;

    case "slider-duration":
    case "slider-int":
    value = parseInt(value);
    break;

    default:
  }
  properties_[$(this).data("option")] = value;
  var mode = option_animation ? option_animation : "auto";
  Object.assign(properties[mode], properties_);
  sendApiData("/api/set_data", {propertiesTarget: {"mode": mode},
    properties: properties_});
  // todo unify with rgbcolor
}

function buildRgbFromArray(arr) {
  return "rgb(" + arr[0] + "," + arr[1] + "," + arr[2] + ")";
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

    if (properties[animation] && properties[animation][option]) {
      default_value = properties[animation][option];
    }

    switch (type) {
      // todo make sliders configurable if transmission is allowed during drag
      case "slider-int":
      case "slider-duration":
      case "slider-float":
      var input = $("<input />").attr("type", "range").
        addClass("custom-range").attr("id", "opt-" + option_id);
      if (type == "slider-float") {
        input.attr("step", "0.01");
      }
      input.attr("min", min_value).attr("max", max_value).val(default_value).
        data("option", option).data("type", type).change(changeOption).
        on("input", function() {
          $("#" + this.id + "-val").val($(this).val());
        });
      ret.push($("<div />").addClass("range-container").append(input).
        append($("<output />").attr("id", "opt-" + option_id + "-val").
        val(default_value)));
      break;

      case "color":
      var color = buildRgbFromArray(default_value);
      ret.push($("<input/>").attr("id", "opt-" + option_id).val(color).
        addClass("spectrum-color").data("option", option).data("type", type));
      break;

      default:
      ret.push($("<input />").attr("type", "text").addClass("form-control").
        attr("id", "opt-" + option_id).val(default_value).
        data("option", option).change(changeOption));
    }

    option_id ++;

    return ret;
  });
  $("#options").empty().append(options);
  $("#options .spectrum-color").spectrum({type: "color", showAlpha: false,
    allowEmpty: false, move: function(color) {
      var rgb = color.toRgb();
      var properties_ = new Object();
      var value = [rgb.r, rgb.g, rgb.b];
      if (value == $(this).data("value"))
        return;
      $(this).data("value", value);
      properties_[$(this).data("option")] = value;
      var mode = option_animation ? option_animation : "auto";
      Object.assign(properties[mode], properties_);
      sendApiData("/api/set_data", {propertiesTarget: {"mode": mode},
        properties: properties_});
    }});
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
    // TODO auto params
  }
  if (e.originalEvent) {
    // send single / auto animation change
    var mode = new_animation in animations ? new_animation : "auto";
    var data = {mode: mode};
    if (properties[mode]) {
      data["propertiesTarget"] = {"mode": mode};
      data["properties"] = properties[mode];
    }
    sendApiData("/api/set_data", data);
  }
});

// TODO: reset button for animations, to reset properties to default entries of options...

$("#masterswitch").change(function(e) {
  if (e.originalEvent) {
    sendApiData("/api/set_data", {blackout: !$(this).prop("checked")});
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
