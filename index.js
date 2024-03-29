// Handle new image uploading on canvas
function uploadImage(e) {
	const reader = new FileReader();
	reader.onload = event => {
		img.onload = () => original();
		img.src = event.target.result;
	}
	reader.readAsDataURL(e.target.files[0]);
}

// Add download button
function downloadCanvas() {
	// get canvas data  
	const image = canvas.toDataURL();

	// create temporary link  
	const tmpLink = document.createElement('a');
	tmpLink.download = 'edited-image.png'; // set name of downloaded file 
	tmpLink.href = image;

	// temporarily add link to body and initiate download  
	document.body.appendChild(tmpLink);
	tmpLink.click();
	document.body.removeChild(tmpLink);
}

// Revert to original loaded image...
function original() {
	[width, height] = [img.width, img.height];
	canvas.width = width;
	canvas.height = height;
	ctx.drawImage(img, 0, 0, width, height);
}

// ... or maniulate the image (apply filter)
async function manipulate(action, params = []) {
	const wasm = await loadWasm();

	const imageData = originalImageData();
	const bytes = new Uint8ClampedArray(wasm.memory.buffer);

	copyData(imageData.data, bytes);

	wasm[action](width, height, ...params);

	writeImageData(imageData, bytes);
}

async function loadWasm() {
	const arraySize = width * height * 4;
	const pageSize = 1 << 16;
	const nPages = Math.ceil(arraySize / pageSize);
	const memory = new WebAssembly.Memory({ initial: nPages });

	const wasm = await WebAssembly.instantiateStreaming(fetch('./build/untouched.wasm'), {
		env: {
			memory, // npm run asbuild:optimized -- --importMemory
			abort: (_msg, _file, line, column) => console.error(`Abort at ${line}:${column}`),
			seed: () => new Date().getTime()
		}
	});
	return wasm.instance.exports;
}

function originalImageData() {
	//original();
	return ctx.getImageData(0, 0, width, height);
}

function copyData(src, dest) {
	for (let i = 0; i < src.length; i++)
		dest[i] = src[i];
}

function writeImageData(imageData, bytes) {
	const data = imageData.data;
	for (let i = 0; i < data.length; i++)
		data[i] = bytes[i];

	ctx.putImageData(imageData, 0, 0);
}




// Load default image and canvas
let width, height;
const img = new Image();
img.crossOrigin = 'anonymous';
img.src = './default.jpg';

const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');

img.onload = () => original();

// Add image uploading handling
const imageLoader = document.getElementById('imageLoader');
imageLoader.addEventListener('change', uploadImage, false);

const imageDownloader = document.getElementById('imageDownloader');
imageDownloader.onclick = () => downloadCanvas();

// Filters
document.querySelector('.action.original').onclick = e => {
	e.preventDefault();
	original();
}
document.querySelector('.action.invertImg').onclick = e => {
	e.preventDefault();
	manipulate('invert');
}
document.querySelector('.action.grayscaleImg').onclick = e => {
	e.preventDefault();
	manipulate('grayscale');
}
document.querySelector('.action.basicMonochrome').onclick = e => {
	e.preventDefault();
	manipulate('basicMonochrome', [150]);
}
document.querySelector('.action.randomMonochrome').onclick = e => {
	e.preventDefault();
	manipulate('randomMonochrome', [80]);
}
document.querySelector('.action.mirror').onclick = e => {
	e.preventDefault();
	manipulate('mirror');
}

// Manipulations
document.querySelector('.action.incBrightness').onclick = e => {
	e.preventDefault();
	manipulate('incBrightness', [4]);
}
document.querySelector('.action.decBrightness').onclick = e => {
	e.preventDefault();
	manipulate('decBrightness', [4]);
}
document.querySelector('.action.incSaturation').onclick = e => {
	e.preventDefault();
	manipulate('saturation', [1]);
}
document.querySelector('.action.decSaturation').onclick = e => {
	e.preventDefault();
	manipulate('saturation', [-1]);
}