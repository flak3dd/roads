// Photo Upload - injects stored photo directly into the licence card placeholder
// Targets the exact div: class contains "aspect-[3/4]" (compiled: aspect-\[3\/4\])

(function () {
  'use strict';

  var PHOTO_KEY = 'vicroads_photo';

  // --- Get stored photo ---
  function getStoredPhoto() {
    return localStorage.getItem(PHOTO_KEY);
  }

  // --- Inject photo into the grey placeholder ---
  function injectPhoto(photoData) {
    // The photo placeholder is the div with class containing aspect-[3/4]
    // It sits next to the QR code inside the licence card
    var containers = document.querySelectorAll('[class*="aspect-"]');
    for (var i = 0; i < containers.length; i++) {
      var el = containers[i];
      var cls = el.className || '';
      // Match the portrait photo placeholder specifically
      if (cls.indexOf('aspect-') !== -1 && cls.indexOf('overflow-hidden') !== -1) {
        // Already has our photo
        if (el.querySelector('img[data-injected-photo]')) return;
        // Already has a real photo from the app
        if (el.querySelector('img[alt="License photo"]')) return;

        var img = document.createElement('img');
        img.src = photoData;
        img.setAttribute('data-injected-photo', 'true');
        img.setAttribute('alt', 'License photo');
        img.style.cssText = 'width:100%;height:100%;object-fit:cover;display:block;';
        el.appendChild(img);
        console.log('✅ Photo injected into licence card placeholder');
        return;
      }
    }
  }

  // --- Watch for the React component to render, then inject ---
  function startWatcher() {
    var photoData = getStoredPhoto();
    if (!photoData) return; // Nothing to inject yet

    // Try immediately
    injectPhoto(photoData);

    // Keep watching in case React re-renders
    var observer = new MutationObserver(function () {
      var fresh = getStoredPhoto();
      if (fresh) injectPhoto(fresh);
    });
    observer.observe(document.body, { childList: true, subtree: true });
  }

  // --- Upload UI ---
  function setupUI() {
    var style = document.createElement('style');
    style.textContent = [
      '#vr-photo-btn{position:fixed;bottom:20px;right:20px;z-index:10000;',
      'background:linear-gradient(135deg,#52B848,#45A03A);color:#fff;border:none;',
      'border-radius:50%;width:60px;height:60px;font-size:26px;cursor:pointer;',
      'box-shadow:0 4px 12px rgba(82,184,72,.4);}',
      '#vr-photo-btn:active{transform:scale(.95);}',
      '#vr-toast{position:fixed;bottom:90px;right:20px;z-index:10001;',
      'background:#2D3E50;color:#fff;padding:10px 16px;border-radius:8px;',
      'font-size:13px;font-family:system-ui,sans-serif;display:none;',
      'box-shadow:0 4px 12px rgba(0,0,0,.2);}',
      '#vr-toast.show{display:block;}',
      '#vr-toast.ok{background:#52B848;}',
      '@supports(-webkit-touch-callout:none){',
      '#vr-photo-btn{bottom:max(20px,env(safe-area-inset-bottom));right:max(20px,env(safe-area-inset-right));}',
      '#vr-toast{bottom:max(90px,calc(env(safe-area-inset-bottom) + 70px));}}'
    ].join('');
    document.head.appendChild(style);

    var input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';
    input.style.display = 'none';
    document.body.appendChild(input);

    var btn = document.createElement('button');
    btn.id = 'vr-photo-btn';
    btn.innerHTML = '📷';
    btn.title = 'Upload Licence Photo';
    btn.type = 'button';
    document.body.appendChild(btn);

    var toast = document.createElement('div');
    toast.id = 'vr-toast';
    document.body.appendChild(toast);

    function showToast(msg, ok) {
      toast.textContent = msg;
      toast.className = ok ? 'show ok' : 'show';
      setTimeout(function () { toast.className = ''; }, 3000);
    }

    btn.addEventListener('click', function (e) {
      e.preventDefault();
      e.stopPropagation();
      input.click();
    });

    input.addEventListener('change', function (e) {
      var file = e.target.files && e.target.files[0];
      if (!file) return;
      showToast('Reading photo...');
      var reader = new FileReader();
      reader.onload = function (ev) {
        var data = ev.target.result;
        try {
          localStorage.setItem(PHOTO_KEY, data);
          showToast('✅ Photo saved!', true);
          // Inject immediately - no reload needed
          injectPhoto(data);
        } catch (err) {
          showToast('❌ Error: ' + err.message);
        }
      };
      reader.onerror = function () { showToast('❌ Could not read file'); };
      reader.readAsDataURL(file);
    });
  }

  // --- Init ---
  function init() {
    setupUI();
    startWatcher();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // Re-run after React mounts
  window.addEventListener('load', function () {
    var photoData = getStoredPhoto();
    if (photoData) {
      setTimeout(function () { injectPhoto(photoData); }, 500);
      setTimeout(function () { injectPhoto(photoData); }, 1500);
      setTimeout(function () { injectPhoto(photoData); }, 3000);
    }
  });

})();
