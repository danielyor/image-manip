export function invert(width: i32, height: i32): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);

    store<u8>(i,     255 - r);
    store<u8>(i + 1, 255 - g);
    store<u8>(i + 2, 255 - b);
  }
}

export function grayscale(width: i32, height: i32): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);

    const gray = u8(r * 0.2126 + g * 0.7152 + b * 0.0722);

    store<u8>(i,     gray);
    store<u8>(i + 1, gray);
    store<u8>(i + 2, gray);
  }
}

export function basicMonochrome(width: i32, height: i32, threshold: u8): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);

    const gray = r * 0.2126 + g * 0.7152 + b * 0.0722;

    const mono = threshold > gray ? 0 : 255;

    store<u8>(i,     mono);
    store<u8>(i + 1, mono);
    store<u8>(i + 2, mono);
  }
}

export function randomMonochrome(width: i32, height: i32, offset: u8): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);

    const gray = r * 0.2126 + g * 0.7152 + b * 0.0722;

    const threshold = Math.random() * (255 - offset * 2) + offset;
    const mono = threshold > gray ? 0 : 255;

    store<u8>(i,     mono);
    store<u8>(i + 1, mono);
    store<u8>(i + 2, mono);
  }
}

export function incBrightness(width: i32, height: i32, offset: i32): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);

    const nr = r + offset > 255 ? 255 : r+offset;
    const ng = g + offset > 255 ? 255 : g+offset;
    const nb = b + offset > 255 ? 255 : b+offset;

    store<u8>(i,     nr);
    store<u8>(i + 1, ng);
    store<u8>(i + 2, nb);
  }
}

export function decBrightness(width: i32, height: i32, offset: i32): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);

    const nr = r - offset < 0 ? 0 : r-offset;
    const ng = g - offset < 0 ? 0 : g-offset;
    const nb = b - offset < 0 ? 0 : b-offset;

    store<u8>(i,     nr);
    store<u8>(i + 1, ng);
    store<u8>(i + 2, nb);
  }
}

function getLightnessOfRGB(r: u8, g: u8, b: u8): f64 {
  const high = Math.max(r, g);
  const highest = Math.max(high, b);

  const low = Math.min(r, g);
  const lowest = Math.min(low, b);

  return (highest + lowest) / 2 / 255;
}

export function saturation(width: i32, height: i32, change: i32): void {
  for (let i = 0; i < width * height * 4; i += 4 /*rgba*/) {
    const r = load<u8>(i);
    const g = load<u8>(i + 1);
    const b = load<u8>(i + 2);
    const rInd = i;
    const gInd = i + 1;
    const bInd = i + 2;

    let lowest = -1;
    let lowestVal = -1;
    let middle = -1;
    let middleVal = -1;
    let highest = -1;
    let highestVal = -1;

    if (r > g) {
      if (r > b) {
        highest = rInd;
        highestVal = r;
        if (b > g) {
          middle = bInd;
          middleVal = b;
          lowest = gInd;
          lowestVal = g;
        }
        else {
          middle = gInd;
          middleVal = g;
          lowest = bInd;
          lowestVal = b;
        }
      }
      else {
        highest = bInd;
        highestVal = b;
        middle = rInd;
        middleVal = r;
        lowest = gInd;
        lowestVal = g;
      }
    }
    else if (g > r) {
      if (g > b) {
        highest = gInd;
        highestVal = g;
        if (b > r) {
          middle = bInd;
          middleVal = b;
          lowest = rInd;
          lowestVal = r;
        }
        else {
          middle = rInd;
          middleVal = r;
          lowest = bInd;
          lowestVal = b;
        }
      }
      else {
        highest = bInd;
        highestVal = b;
        middle = gInd;
        middleVal = g;
        lowest = rInd;
        lowestVal = r;
      }
    }

    if (lowestVal === highestVal) {
      continue;
    }

    const greyVal = getLightnessOfRGB(r, g, b) * 255;
    const saturationRange = Math.round(Math.min(255 - greyVal, greyVal));

    if (change == 1) {
      const maxChange = Math.min(255 - highestVal, lowestVal);
      const changeAmount = Math.min(saturationRange / 150, maxChange);
      const middleValueRatio = (greyVal - middleVal) / (greyVal - highestVal);

      highestVal = Math.round(highestVal + changeAmount) as i32;
      lowestVal = Math.round(lowestVal - changeAmount) as i32;
      middleVal = Math.round(greyVal + (highestVal - greyVal) * middleValueRatio) as i32;
    }
    else if (change == -1) {
      const maxChange = greyVal - lowestVal;
      const changeAmount = Math.min(saturationRange / 150, maxChange);
      const middleValueRatio = (greyVal - middleVal) / (greyVal - highestVal);

      highestVal = Math.round(highestVal - changeAmount) as i32;
      lowestVal = Math.round(lowestVal + changeAmount) as i32;
      middleVal = Math.round(greyVal + (highestVal - greyVal) * middleValueRatio) as i32;
    }

    store<u8>(highest, highestVal);
    store<u8>(middle, middleVal);
    store<u8>(lowest, lowestVal);
  }
}
