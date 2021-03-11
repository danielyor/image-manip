// Handle new image uploading on canvas
function uploadImage(e){
	var reader = new FileReader();
	reader.onload = function(event){
    	img.onload = function(){
			[width, height] = [img.width, img.height];
        	canvas.width = width;
        	canvas.height = height;
        	ctx.drawImage(img,0,0, width, height);        	
     	}
      	img.src = event.target.result;
	}
	reader.readAsDataURL(e.target.files[0]);     
}

// Add download button
function downloadCanvas(){  
    // get canvas data  
    var image = canvas.toDataURL();  
  
    // create temporary link  
    var tmpLink = document.createElement( 'a' );  
    tmpLink.download = 'image.png'; // set the name of the download file 
    tmpLink.href = image;  
  
    // temporarily add link to body and initiate the download  
    document.body.appendChild( tmpLink );  
    tmpLink.click();  
    document.body.removeChild( tmpLink );  
}

// Revert to original loaded image...
function original() {
	//canvas.height = img.height;
	//canvas.width = img.width;
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
	const arraySize = (width * height * 4) >>> 0;
	const nPages = ((arraySize + 0xffff) & ~0xffff) >>> 16;
	const memory = new WebAssembly.Memory({ initial: nPages });
  
	const wasm = await WebAssembly.instantiateStreaming(fetch('./build/optimized.wasm'), {
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
let img = new Image();
img.src = './default.jpg';
img.crossOrigin = 'anonymous';
let [width, height] = [img.width, img.height];

const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');
canvas.height = height;
canvas.width = width;

img.onload = () => original();

// Add image uploading handling
var imageLoader = document.getElementById('imageLoader');
imageLoader.addEventListener('change', uploadImage, false);


// Filters

document.querySelector('.action.original').onclick = e => {
  e.preventDefault();
  original();
}

document.querySelector('.action.invert').onclick = e => {
  e.preventDefault();
  manipulate('invert');
}

document.querySelector('.action.grayscale').onclick = e => {
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

// Manipulations

document.querySelector('.action.incBrightness').onclick = e => {
  e.preventDefault();
  manipulate('incBrightness', [4]);
}

document.querySelector('.action.decBrightness').onclick = e => {
  e.preventDefault();
  manipulate('decBrightness', [4]);
}