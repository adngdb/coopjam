// Constants.
const MAX_SPEED = 100;
const SPEED_INCREMENT = 10;
const SPEED_DECREASE_PER_SECOND = 20;

const SCREEN_WIDTH = 375;
const SCREEN_HEIGHT = 667;
const CAR_HEIGHT = 196;

// Variables we need.
let speed = 0;
let previousTimestamp = null;

// Nodes.
const speedText = document.getElementById("speed");
const road = document.getElementById("road");
const playerCar = document.getElementById("player-car");
const otherCar = document.getElementById("other-car");

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
  updatePositions(intSpeed);
}

function updatePositions(intSpeed) {
  const backgroundPositionY = parseInt(road.style.backgroundPositionY) || 0;
  const updatedPosition = (backgroundPositionY + intSpeed) % SCREEN_HEIGHT;
  road.style.backgroundPositionY = `${updatedPosition}px`;
  updateNodePosition(otherCar, intSpeed);
}

function updateNodePosition(node, amount) {
  const currentPosition = parseInt(node.style.top) || 0;
  let updatedPosition = currentPosition + amount;
  if (updatedPosition > SCREEN_HEIGHT) {
      updatedPosition = -CAR_HEIGHT;
  }
  node.style.top = `${updatedPosition}px`;
}

function step(timestamp) {
  if (previousTimestamp === null) {
    previousTimestamp = timestamp;
  }
  let elapsed = timestamp - previousTimestamp;
  previousTimestamp = timestamp;

  decreaseSpeed(elapsed);
  render();

  window.requestAnimationFrame(step);
}

window.requestAnimationFrame(step);
