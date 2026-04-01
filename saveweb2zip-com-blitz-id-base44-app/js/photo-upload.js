// Photo Upload - injects stored photo directly into the licence card placeholder
// Targets the exact div: class contains "aspect-[3/4]" (compiled: aspect-\[3\/4\])

(function () {
  'use strict';

  var PHOTO_KEY = 'vicroads_photo';

  // --- Get stored photo ---
  function getStoredPhoto() {
    return localStorage.getItem(PHOTO_KEY);
  }

  function getPhotoPlaceholder() {
    var slots = document.querySelectorAll('[class*="aspect-"][class*="overflow-hidden"]');
    for (var i = 0; i < slots.length; i++) {
      var text = (slots[i].textContent || '').trim().toLowerCase();
      if (text.indexOf('no photo') !== -1) return slots[i];
    }
    return slots.length ? slots[0] : null;
  }

  function updateButtonVisibility() {
    var btn = document.getElementById('vr-photo-btn');
    if (!btn) return;
    btn.style.display = getPhotoPlaceholder() ? 'inline-flex' : 'none';
  }

  // --- Inject photo into the grey placeholder ---
  function injectPhoto(photoData) {
    if (!photoData) return;
    var el = getPhotoPlaceholder();
    if (!el) return;

    var existing = el.querySelector('img[data-injected-photo], img[alt="License photo"]');
    if (existing) {
      existing.src = photoData;
      return;
    }

    el.innerHTML = '';
    var img = document.createElement('img');
    img.src = photoData;
    img.setAttribute('data-injected-photo', 'true');
    img.setAttribute('alt', 'License photo');
    img.style.cssText = 'width:100%;height:100%;object-fit:cover;display:block;';
    el.appendChild(img);
    console.log('Photo injected into licence card placeholder');
  }

  // --- Watch for the React component to render, then inject ---
  function startWatcher() {
    var photoData = getStoredPhoto();
    if (photoData) injectPhoto(photoData);
    updateButtonVisibility();

    // Keep watching in case React re-renders
    var observer = new MutationObserver(function () {
      var fresh = getStoredPhoto();
      if (fresh) injectPhoto(fresh);
      updateButtonVisibility();
    });
    observer.observe(document.body, { childList: true, subtree: true });
  }

  // --- Upload UI ---
  function setupUI() {
    var style = document.createElement('style');
    style.textContent = [
      '#vr-photo-btn{position:fixed;left:50%;bottom:18px;transform:translateX(-50%);z-index:10000;',
      'display:inline-flex;align-items:center;justify-content:center;gap:8px;',
      'background:linear-gradient(135deg,#52B848,#45A03A);color:#fff;border:none;',
      'border-radius:999px;min-width:170px;height:48px;padding:0 18px;font:600 16px system-ui;cursor:pointer;',
      'box-shadow:0 8px 22px rgba(82,184,72,.35);}',
      '#vr-photo-btn:active{transform:scale(.95);}',
      '#vr-toast{position:fixed;bottom:90px;right:20px;z-index:10001;',
      'background:#2D3E50;color:#fff;padding:10px 16px;border-radius:8px;',
      'font-size:13px;font-family:system-ui,sans-serif;display:none;',
      'box-shadow:0 4px 12px rgba(0,0,0,.2);}',
      '#vr-toast.show{display:block;}',
      '#vr-toast.ok{background:#52B848;}',
      '@supports(-webkit-touch-callout:none){',
      '#vr-photo-btn{bottom:max(18px,env(safe-area-inset-bottom));}',
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
    btn.innerHTML = '<span>Upload Photo</span>';
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

    document.addEventListener('change', function (e) {
      var target = e.target;
      if (!target || target.id !== 'photo-upload') return;
      var file = target.files && target.files[0];
      if (!file) return;
      var reader = new FileReader();
      reader.onload = function (ev) {
        var data = ev.target && ev.target.result;
        if (typeof data !== 'string') return;
        try {
          localStorage.setItem(PHOTO_KEY, data);
        } catch (err) {}
        injectPhoto(data);
        showToast('✅ Photo saved!', true);
      };
      reader.onerror = function () { showToast('❌ Could not read file'); };
      reader.readAsDataURL(file);
    }, true);
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
    updateButtonVisibility();
    if (photoData) {
      setTimeout(function () { injectPhoto(photoData); }, 500);
      setTimeout(function () { injectPhoto(photoData); }, 1500);
      setTimeout(function () { injectPhoto(photoData); }, 3000);
    }
  });

})();
