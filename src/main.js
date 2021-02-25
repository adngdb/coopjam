// Constants.
const MAX_SPEED = 100;
const SPEED_INCREMENT = 10;
const SPEED_DECREASE_PER_SECOND = 20;

// Variables we need.
let speed = 0;
let previousTimestamp = null;

// Nodes.
const speedText = document.getElementById("speed");
const road = document.getElementById("road");

// On touch, increase speed.
window.addEventListener(
  "touchend",
  () => {
    speed += SPEED_INCREMENT;
    if (speed > MAX_SPEED) {
      speed = MAX_SPEED;
    }
  },
  false
);

function decreaseSpeed(elapsedTime) {
  speed = speed - (elapsedTime / 1000) * SPEED_DECREASE_PER_SECOND;
  if (speed < 0) {
    speed = 0;
  }
}

function render() {
  const intSpeed = Math.round(speed);
  speedText.innerText = intSpeed;
  updateRoadPosition(intSpeed);
}

function updateRoadPosition(intSpeed) {
  const backgroundPositionY = parseInt(road.style.backgroundPositionY) || 0;
  const updatedPosition = (backgroundPositionY + intSpeed) % 667;
  road.style.backgroundPositionY = `${updatedPosition}px`;
}

function step(timestamp) {
  if (previousTimestamp === null) {
    previousTimestamp = timestamp;
  }
  let elapsed = timestamp - previousTimestamp;
  previousTimestamp = timestamp;

  decreaseSpeed(elapsed);
  render();

  // console.log(speed);
  window.requestAnimationFrame(step);
}

window.requestAnimationFrame(step);
