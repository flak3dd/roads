// Photo Upload - injects stored photo directly into the licence card placeholder
// Targets the exact div: class contains "aspect-[3/4]" (compiled: aspect-\[3\/4\])

(function () {
  'use strict';

  var PHOTO_KEY = 'vicroads_photo';
  var LONG_PRESS_MS = 650;

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

  function clearPhoto(placeholder, showToast) {
    if (!placeholder) return;
    try {
      localStorage.removeItem(PHOTO_KEY);
    } catch (err) {}

    var original = placeholder.dataset.vrOriginalHtml;
    if (original) {
      placeholder.innerHTML = original;
    } else {
      placeholder.innerHTML = '<span style="color:#9ca3af;">No photo</span>';
    }
    if (showToast) showToast('Photo removed', true);
  }

  function bindPlaceholderGestures(input, showToast) {
    var placeholder = getPhotoPlaceholder();
    if (!placeholder || placeholder.dataset.vrPhotoBound === '1') return;

    placeholder.dataset.vrPhotoBound = '1';
    if (!placeholder.dataset.vrOriginalHtml) {
      placeholder.dataset.vrOriginalHtml = placeholder.innerHTML;
    }
    placeholder.style.cursor = 'pointer';
    placeholder.title = 'Tap to add photo, long press to remove';

    var timer = null;
    var longPressTriggered = false;
    var suppressClickUntil = 0;

    function startPress(e) {
      if (e && e.type === 'mousedown' && e.button !== 0) return;
      longPressTriggered = false;
      timer = setTimeout(function () {
        longPressTriggered = true;
        suppressClickUntil = Date.now() + 500;
        clearPhoto(placeholder, showToast);
      }, LONG_PRESS_MS);
    }

    function endPress() {
      if (timer) {
        clearTimeout(timer);
        timer = null;
      }
    }

    placeholder.addEventListener('click', function (e) {
      if (Date.now() < suppressClickUntil || longPressTriggered) {
        e.preventDefault();
        e.stopPropagation();
        return;
      }
      e.preventDefault();
      e.stopPropagation();
      input.click();
    });

    placeholder.addEventListener('touchstart', startPress, { passive: true });
    placeholder.addEventListener('touchend', endPress);
    placeholder.addEventListener('touchcancel', endPress);
    placeholder.addEventListener('touchmove', endPress);
    placeholder.addEventListener('mousedown', startPress);
    placeholder.addEventListener('mouseup', endPress);
    placeholder.addEventListener('mouseleave', endPress);
    placeholder.addEventListener('contextmenu', function (e) {
      e.preventDefault();
      clearPhoto(placeholder, showToast);
    });
  }

  // --- Inject photo into the grey placeholder ---
  function injectPhoto(photoData) {
    if (!photoData) return;
    var el = getPhotoPlaceholder();
    if (!el) return;
    if (!el.dataset.vrOriginalHtml) {
      el.dataset.vrOriginalHtml = el.innerHTML;
    }

    var existing = el.querySelector('img[data-injected-photo], img[alt="License photo"]');
    if (existing) {
      existing.src = photoData;
      existing.setAttribute('data-injected-photo', 'true');
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
    var input = document.getElementById('vr-photo-input');
    if (input) bindPlaceholderGestures(input);

    // Keep watching in case React re-renders
    var observer = new MutationObserver(function () {
      var fresh = getStoredPhoto();
      if (fresh) injectPhoto(fresh);
      updateButtonVisibility();
      var liveInput = document.getElementById('vr-photo-input');
      if (liveInput) bindPlaceholderGestures(liveInput);
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
    input.id = 'vr-photo-input';
    input.type = 'file';
    input.accept = 'image/*';
    input.setAttribute('capture', 'environment');
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
      e.target.value = '';
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

    bindPlaceholderGestures(input, showToast);
    updateButtonVisibility();
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
    var input = document.getElementById('vr-photo-input');
    if (input) bindPlaceholderGestures(input);
    if (photoData) {
      setTimeout(function () { injectPhoto(photoData); }, 500);
      setTimeout(function () { injectPhoto(photoData); }, 1500);
      setTimeout(function () { injectPhoto(photoData); }, 3000);
    }
  });

})();
