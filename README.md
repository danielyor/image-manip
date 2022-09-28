# WASM Image Manipulation experiments with AssemblyScript
## How to run
Install dependencies. Then build untouched, optimized, or both WASM files:
```
npm i
npm run asbuild
```
Run a localhost webserver: http://localhost:1234
```
npx ws -p 1234
```

Rebuild the WASM files after every change in index.ts

You can choose between optimized and untouched WASM in index.js, during the WASM instantiation process. See also asconfig.json for [compiler](https://www.assemblyscript.org/compiler.html) options.

---

Default photo taken from [Unsplash](https://unsplash.com/photos/zRZAnttNo7o).
