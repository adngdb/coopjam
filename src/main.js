// Constants.
const MAX_SPEED = 100;
const SPEED_INCREMENT = 10;
const SPEED_DECREASE_PER_SECOND = 20;

// Variables we need.
let speed = 0;
let previousTimestamp = null;


// On touch, increase speed.
window.addEventListener('touchend', () => {
    speed += SPEED_INCREMENT;
    if (speed > MAX_SPEED) {
        speed = MAX_SPEED;
    }
}, false);


function decreaseSpeed(elapsedTime) {
    speed = speed - (elapsedTime / 1000 * SPEED_DECREASE_PER_SECOND);
    if (speed < 0) {
        speed = 0;
    }
}

function render() {
    document.getElementById('speed').innerText = Math.round(speed);
}

function step(timestamp) {
    if (previousTimestamp === null) {
        previousTimestamp = timestamp;
    }
    let elapsed = timestamp - previousTimestamp;
    previousTimestamp = timestamp;

    decreaseSpeed(elapsed);
    render();

    console.log(speed);
    window.requestAnimationFrame(step);
}

window.requestAnimationFrame(step);
