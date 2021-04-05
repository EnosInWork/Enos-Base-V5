$(document).ready(function () {
    window.addEventListener("message", function (event) {
        if (event.data.showhud == true) {
            $("#speedo").fadeIn();
            setSpeed(event.data.speed, event.data.acceleration, event.data.maxSpeed);
            setTurnSignals(event.data.turnLeft, event.data.turnRight);
            setFuel(event.data.fuel);
        }
        if (event.data.showhud == false) {
            $("#speedo").fadeOut();
        }
    });

    function setSpeed(speed, accel, maxSpeed) {
        const speedPercent = (speed * 100) / maxSpeed;

        const speedV = Math.min(100, speedPercent * 2.27) + "%";
        $("#lgv-speed-stop").attr("offset", speedV);
        const speedH = Math.max(0, (speedPercent - 44) * 1.15) + "%";
        $("#lgh-speed-stop").attr("offset", speedH);

        const accelV = Math.min(100, accel * 2.27) + "%";
        $("#lgv-acceleration-stop").attr("offset", accelV);
        const accelH = Math.max(0, (accel - 44) * 1.15) + "%";
        $("#lgh-acceleration-stop").attr("offset", accelH);

        $("#kmh-digits").html(speed);
    }

    function setTurnSignals(left, right) {
        $("#turn-left").attr("class", left ? "active" : "");
        $("#turn-right").attr("class", right ? "active" : "");
    }

    function setFuel(level) {
        $("#fuel-circle-progress").attr("stroke-dashoffset", 110 - Math.ceil(level * 1.1));
        const className = level > 50 ? "full" : (level > 20 ? "warning" : "danger");
        $("#fuel").attr("class",className);
        $("#fuel-circle-progress").attr("class",className);
    }
});
