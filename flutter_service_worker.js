'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"main.dart.js": "8b27809977344daf77596254dee6f643",
"assets/FontManifest.json": "ea489b15cb1e3312372838ae6ec740ef",
"assets/AssetManifest.bin": "ab2534c866b2dee0451ed912186d30df",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_soloud/web/worker.dart.js": "a9a8a75bd9576e5f591c34777699c71f",
"assets/packages/flutter_soloud/web/libflutter_soloud_plugin.js": "2b861682ebb616f46a449a61cf381f5c",
"assets/packages/flutter_soloud/web/libflutter_soloud_plugin.wasm": "7fa4227ad903974e4a77ffc2efddd0a9",
"assets/assets/fonts/Chewy-Regular.ttf": "53ee0977b5f9f3afc1d18b4419264c8b",
"assets/assets/images/pipe.png": "ccbadae55474e53cc16f5268f3a809d5",
"assets/assets/images/background/layer4-clouds.png": "39f85052dd79e18ff8c5f5229b0936de",
"assets/assets/images/background/layer3-clouds.png": "3db7a5a18357d9a99d77651f7212886c",
"assets/assets/images/background/layer5-huge-clouds.png": "1c8fc9133672d14d3fce14d608c4701c",
"assets/assets/images/background/layer7-bushes.png": "49cfa7c605a0f0a0faacab7f3e5cda6c",
"assets/assets/images/background/layer6-bushes.png": "5123c114769ed9dd086aaa50e9fa025f",
"assets/assets/images/background/layer1-sky.png": "eaca695464b3b8a9ce918075c26acd11",
"assets/assets/images/background/layer2-clouds.png": "2d298c3ccbc53cbefaaa0390900b6485",
"assets/assets/images/dash.png": "56931f95d9062ce735dc0d92f8e03428",
"assets/assets/images/multi_dash.svg": "0693839b246c67c0d389f525e2135a34",
"assets/assets/images/logo.png": "276a3da0529b5f057928cfa90ee5a753",
"assets/assets/images/blurred_background.png": "538676c07a0e09523778815af2f76e8a",
"assets/assets/images/portal.png": "f2f64637dda305f0f4a8eab4b3a1f52a",
"assets/assets/icons/ic_back.svg": "83e40138f06f8163af486505bc9188fc",
"assets/assets/icons/ic_share.svg": "cb5d32bf25018f759d6cdbc484eeb059",
"assets/assets/icons/ic_qr.svg": "0c949e7ec7cdc32137c784502b458066",
"assets/assets/icons/ic_home.svg": "83a4b484c2766ec3a052d3fa4ed4ada2",
"assets/assets/icons/ic_menu.svg": "ba05c07cf42de65584dfa04b9c6fe66f",
"assets/assets/icons/ic_close.svg": "63bda2f6191ad9b92d72e0d6e5fb2ce9",
"assets/assets/icons/ic_github.svg": "8dcc6b5262f3b6138b1566b357ba89a9",
"assets/assets/icons/ic_profile.svg": "db8773511fbb30df65dde72712699e62",
"assets/assets/icons/ic_trophy.svg": "70e00ec9619fef0830e74631b86005b2",
"assets/assets/icons/ic_youtube.svg": "81efb2f1086f3519e04833f5f0f95953",
"assets/assets/audio/score.mp3": "fd7f3ff3f2c802d1fd238a4378fcb8fb",
"assets/assets/audio/background.mp3": "3431c779f2b5ed847fde5e16c408fb69",
"assets/NOTICES": "f5a9c56d2e6c4afd8d18bdf3a1711df8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "a1124dbcafbe389ec6cc0488237bc92c",
"assets/AssetManifest.bin.json": "eff75f42316cf9a6734ed684f9264a51",
"index.html": "d3837d1d39f7aebadb062aff6a1b97ce",
"/": "d3837d1d39f7aebadb062aff6a1b97ce",
"manifest.json": "a036124569ebb87280196701e93df03f",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "88941b4c3688ff0aef3dc7ff41415f0a",
"flutter_bootstrap.js": "4d4d5e2d58870060cab9cf2ede25689c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
