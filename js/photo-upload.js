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

  // Swipe gesture handling for button visibility
  var buttonsVisible = false;
  var swipeStartY = 0;
  var swipeThreshold = 50;

  function initSwipeDetection() {
    // Touch events for mobile
    document.addEventListener('touchstart', function(e) {
      swipeStartY = e.touches[0].clientY;
    }, { passive: true });

    document.addEventListener('touchend', function(e) {
      var swipeEndY = e.changedTouches[0].clientY;
      var deltaY = swipeStartY - swipeEndY;
      handleSwipe(deltaY);
    }, { passive: true });

    // Mouse events for desktop testing
    var mouseStartY = 0;
    var isDragging = false;

    document.addEventListener('mousedown', function(e) {
      mouseStartY = e.clientY;
      isDragging = true;
    });

    document.addEventListener('mouseup', function(e) {
      if (!isDragging) return;
      isDragging = false;
      var deltaY = mouseStartY - e.clientY;
      handleSwipe(deltaY);
    });
  }

  function handleSwipe(deltaY) {
    if (Math.abs(deltaY) > swipeThreshold) {
      if (deltaY > 0) {
        // Swiped up - show buttons
        showButtons();
      } else {
        // Swiped down - hide buttons
        hideButtons();
      }
    }
  }

  function showButtons() {
    if (buttonsVisible) return;
    buttonsVisible = true;
    document.body.classList.add('vr-buttons-visible');
    document.body.classList.remove('vr-buttons-hidden');
  }

  function hideButtons() {
    if (!buttonsVisible) return;
    buttonsVisible = false;
    document.body.classList.remove('vr-buttons-visible');
    document.body.classList.add('vr-buttons-hidden');
  }

  // --- Upload UI ---
  function setupUI() {
    var style = document.createElement('style');
    style.textContent = [
      '#vr-photo-btn{position:fixed;left:50%;bottom:18px;transform:translateX(-50%) translateY(100px);z-index:10000;',
      'display:inline-flex;align-items:center;justify-content:center;gap:8px;',
      'background:linear-gradient(135deg,#52B848,#45A03A);color:#fff;border:none;',
      'border-radius:999px;min-width:170px;height:48px;padding:0 18px;font:600 16px system-ui;cursor:pointer;',
      'box-shadow:0 8px 22px rgba(82,184,72,.35);opacity:0;transition:transform .3s ease,opacity .3s ease;}',
      '#vr-save-ui{position:fixed;bottom:80px;left:50%;transform:translateX(-50%) translateY(100px);z-index:9999;',
      'opacity:0;transition:transform .3s ease,opacity .3s ease;}',
      '#vr-save-ui.visible{transform:translateX(-50%) translateY(0);opacity:1;}',
      '.vr-buttons-visible #vr-photo-btn{transform:translateX(-50%) translateY(0) !important;opacity:1 !important;}',
      '.vr-buttons-visible #vr-save-ui{transform:translateX(-50%) translateY(0) !important;opacity:1 !important;}',
      '.vr-buttons-hidden #vr-photo-btn{transform:translateX(-50%) translateY(100px) !important;opacity:0 !important;}',
      '.vr-buttons-hidden #vr-save-ui{transform:translateX(-50%) translateY(100px) !important;opacity:0 !important;}',
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

    initSwipeDetection();

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
    btn.title = 'Upload Licence Photo (swipe up to show buttons)';
    btn.type = 'button';
    btn.style.transform = 'translateX(-50%) translateY(100px)';
    btn.style.opacity = '0';
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
          // Dispatch event for editable-fields to save all data
          document.dispatchEvent(new CustomEvent('vicroads-photo-uploaded'));
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
        // Dispatch event for editable-fields to save all data
        document.dispatchEvent(new CustomEvent('vicroads-photo-uploaded'));
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
    showSwipeHint();
  }

  // Show hint toast on first load
  function showSwipeHint() {
    var hintShown = localStorage.getItem('vicroads_swipe_hint_shown');
    if (hintShown) return;

    setTimeout(function() {
      var toast = document.getElementById('vr-toast');
      if (toast) {
        toast.textContent = '👆 Swipe up to show buttons, down to hide';
        toast.className = 'show';
        setTimeout(function() { toast.className = ''; }, 4000);
      }
      localStorage.setItem('vicroads_swipe_hint_shown', 'true');
    }, 2000);
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
