// Constants.
const MAX_SPEED = 100;
const SPEED_INCREMENT = 5;
const SPEED_DECREASE_PER_SECOND = 20;

const SCREEN_HEIGHT = 667;
const SCREEN_WIDTH = 375;
const CAR_HEIGHT = 196;
const CAR_WIDTH = 90;

const LENIENCY = 50;

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

// On swipe, change line.
window.addEventListener(
  "swiped",
  (e) => {
    const dir = e.detail.dir;
    if (dir === "left" || dir === "right") {
      updateNodeColumn(playerCar, dir);
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
  if (hasCollisions(playerCar, otherCar)) {
    console.log("collided!");
  }
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

function updateNodeColumn(node, column) {
  let position;
  if (column === "right") {
    position = 80;
  } else if (column === "left") {
    position = SCREEN_WIDTH - CAR_WIDTH - 80;
  }
  node.style.right = `${position}px`;
}

function hasCollisions(car, obstacle) {
  const carRect = car.getBoundingClientRect();
  const obstacleRect = obstacle.getBoundingClientRect();
  return intersectRect(carRect, obstacleRect, LENIENCY);
}

function intersectRect(r1, r2, leniency) {
  return !(
    r2.left + leniency > r1.right ||
    r2.right - leniency < r1.left ||
    r2.top + leniency > r1.bottom ||
    r2.bottom - leniency < r1.top
  );
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
