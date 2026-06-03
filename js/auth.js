// Auth gate — PIN-based login with session management
// Blocks app access until user authenticates. First visit = setup PIN, subsequent = enter PIN.

(function () {
  'use strict';

  var AUTH_PIN_KEY = 'vicroads_auth_pin';
  var AUTH_SESSION_KEY = 'vicroads_auth_session';
  var SESSION_DURATION = 30 * 60 * 1000; // 30 minutes

  function isAuthenticated() {
    try {
      var session = JSON.parse(localStorage.getItem(AUTH_SESSION_KEY));
      if (!session || !session.ts) return false;
      return (Date.now() - session.ts) < SESSION_DURATION;
    } catch (e) { return false; }
  }

  function hasPin() {
    return !!localStorage.getItem(AUTH_PIN_KEY);
  }

  function setSession() {
    localStorage.setItem(AUTH_SESSION_KEY, JSON.stringify({ ts: Date.now() }));
  }

  function hashPin(pin) {
    var h = 0;
    for (var i = 0; i < pin.length; i++) {
      h = ((h << 5) - h + pin.charCodeAt(i)) | 0;
    }
    return 'h_' + Math.abs(h).toString(36);
  }

  function verifyPin(pin) {
    return hashPin(pin) === localStorage.getItem(AUTH_PIN_KEY);
  }

  function savePin(pin) {
    localStorage.setItem(AUTH_PIN_KEY, hashPin(pin));
  }

  function logout() {
    localStorage.removeItem(AUTH_SESSION_KEY);
    location.reload();
  }

  // Expose logout globally for the profile manager
  window.vicraodsLogout = logout;

  function showLoginScreen() {
    var root = document.getElementById('root');
    if (root) root.style.display = 'none';

    var isSetup = !hasPin();

    var overlay = document.createElement('div');
    overlay.id = 'vr-auth-overlay';
    overlay.innerHTML = [
      '<div class="vr-auth-card">',
      '  <div class="vr-auth-logo">',
      '    <img src="images/68430efda_vicroads.webp" alt="VicRoads" style="width:64px;height:64px;border-radius:16px;">',
      '    <h1>Blitz ID</h1>',
      '    <p>' + (isSetup ? 'Create a PIN to secure your data' : 'Enter your PIN to continue') + '</p>',
      '  </div>',
      '  <div class="vr-auth-form">',
      '    <div class="vr-pin-dots" id="vr-pin-dots">',
      '      <span class="vr-dot"></span><span class="vr-dot"></span><span class="vr-dot"></span><span class="vr-dot"></span>',
      '    </div>',
      '    <input type="tel" id="vr-pin-input" maxlength="4" pattern="[0-9]*" inputmode="numeric" autocomplete="off" style="position:absolute;opacity:0;pointer-events:none;">',
      isSetup ? '    <input type="tel" id="vr-pin-confirm" maxlength="4" pattern="[0-9]*" inputmode="numeric" autocomplete="off" style="position:absolute;opacity:0;pointer-events:none;">' : '',
      isSetup ? '    <div class="vr-pin-dots vr-confirm-dots" id="vr-pin-confirm-dots" style="display:none;"><span class="vr-dot"></span><span class="vr-dot"></span><span class="vr-dot"></span><span class="vr-dot"></span></div>' : '',
      '    <div class="vr-keypad" id="vr-keypad">',
      '      <button data-key="1">1</button><button data-key="2">2</button><button data-key="3">3</button>',
      '      <button data-key="4">4</button><button data-key="5">5</button><button data-key="6">6</button>',
      '      <button data-key="7">7</button><button data-key="8">8</button><button data-key="9">9</button>',
      '      <button data-key="clear" class="vr-key-action">Clear</button><button data-key="0">0</button><button data-key="del" class="vr-key-action">&#9003;</button>',
      '    </div>',
      '    <p class="vr-auth-error" id="vr-auth-error"></p>',
      '    <p class="vr-auth-hint" id="vr-auth-hint">' + (isSetup ? 'Step 1: Enter a 4-digit PIN' : '') + '</p>',
      '  </div>',
      '</div>'
    ].join('\n');

    document.body.appendChild(overlay);

    var pinInput = document.getElementById('vr-pin-input');
    var dots = document.getElementById('vr-pin-dots');
    var errorEl = document.getElementById('vr-auth-error');
    var hintEl = document.getElementById('vr-auth-hint');
    var currentPin = '';
    var firstPin = '';
    var confirmPhase = false;

    function updateDots(targetDots, len) {
      var dotEls = targetDots.querySelectorAll('.vr-dot');
      for (var i = 0; i < dotEls.length; i++) {
        dotEls[i].classList.toggle('filled', i < len);
      }
    }

    function shakeCard() {
      var card = document.querySelector('.vr-auth-card');
      card.classList.add('vr-shake');
      setTimeout(function () { card.classList.remove('vr-shake'); }, 500);
    }

    function handleKey(key) {
      errorEl.textContent = '';

      if (key === 'clear') {
        currentPin = '';
        updateDots(confirmPhase ? document.getElementById('vr-pin-confirm-dots') : dots, 0);
        return;
      }
      if (key === 'del') {
        currentPin = currentPin.slice(0, -1);
        updateDots(confirmPhase ? document.getElementById('vr-pin-confirm-dots') : dots, currentPin.length);
        return;
      }

      if (currentPin.length >= 4) return;
      currentPin += key;
      updateDots(confirmPhase ? document.getElementById('vr-pin-confirm-dots') : dots, currentPin.length);

      if (currentPin.length === 4) {
        setTimeout(function () { processPin(currentPin); }, 200);
      }
    }

    function processPin(pin) {
      if (isSetup) {
        if (!confirmPhase) {
          firstPin = pin;
          confirmPhase = true;
          currentPin = '';
          dots.style.opacity = '0.4';
          var confirmDots = document.getElementById('vr-pin-confirm-dots');
          if (confirmDots) confirmDots.style.display = 'flex';
          hintEl.textContent = 'Step 2: Confirm your PIN';
          updateDots(confirmDots, 0);
        } else {
          if (pin === firstPin) {
            savePin(pin);
            setSession();
            grantAccess();
          } else {
            errorEl.textContent = 'PINs do not match. Try again.';
            shakeCard();
            confirmPhase = false;
            firstPin = '';
            currentPin = '';
            dots.style.opacity = '1';
            var cd = document.getElementById('vr-pin-confirm-dots');
            if (cd) cd.style.display = 'none';
            hintEl.textContent = 'Step 1: Enter a 4-digit PIN';
            updateDots(dots, 0);
          }
        }
      } else {
        if (verifyPin(pin)) {
          setSession();
          grantAccess();
        } else {
          errorEl.textContent = 'Incorrect PIN';
          shakeCard();
          currentPin = '';
          updateDots(dots, 0);
        }
      }
    }

    // Keypad click handler
    document.getElementById('vr-keypad').addEventListener('click', function (e) {
      var btn = e.target.closest('[data-key]');
      if (!btn) return;
      handleKey(btn.dataset.key);
    });

    // Physical keyboard support
    document.addEventListener('keydown', function (e) {
      if (!document.getElementById('vr-auth-overlay')) return;
      if (e.key >= '0' && e.key <= '9') handleKey(e.key);
      else if (e.key === 'Backspace') handleKey('del');
      else if (e.key === 'Escape') handleKey('clear');
    });
  }

  function grantAccess() {
    var overlay = document.getElementById('vr-auth-overlay');
    if (overlay) {
      overlay.style.opacity = '0';
      overlay.style.transition = 'opacity .3s';
      setTimeout(function () { overlay.remove(); }, 300);
    }
    var root = document.getElementById('root');
    if (root) root.style.display = '';
  }

  function injectAuthStyles() {
    var s = document.createElement('style');
    s.textContent = [
      '#vr-auth-overlay{position:fixed;inset:0;z-index:100000;display:flex;align-items:center;justify-content:center;',
      'background:linear-gradient(135deg,#1E3A8A 0%,#1e40af 50%,#1d4ed8 100%);font-family:system-ui,-apple-system,sans-serif;}',
      '.vr-auth-card{background:#fff;border-radius:24px;padding:40px 32px;width:min(340px,90vw);text-align:center;',
      'box-shadow:0 20px 60px rgba(0,0,0,.25);}',
      '.vr-auth-logo img{margin:0 auto 12px;}',
      '.vr-auth-logo h1{font-size:24px;font-weight:700;color:#1E3A8A;margin:0 0 4px;}',
      '.vr-auth-logo p{font-size:14px;color:#6b7280;margin:0 0 24px;}',
      '.vr-pin-dots{display:flex;justify-content:center;gap:16px;margin:0 0 24px;transition:opacity .2s;}',
      '.vr-dot{width:16px;height:16px;border-radius:50%;border:2px solid #d1d5db;background:transparent;display:block;transition:all .15s;}',
      '.vr-dot.filled{background:#1E3A8A;border-color:#1E3A8A;transform:scale(1.15);}',
      '.vr-keypad{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;max-width:260px;margin:0 auto;}',
      '.vr-keypad button{height:56px;border:none;border-radius:14px;font-size:22px;font-weight:600;color:#1f2937;',
      'background:#f3f4f6;cursor:pointer;transition:all .1s;-webkit-tap-highlight-color:transparent;user-select:none;}',
      '.vr-keypad button:active{background:#e5e7eb;transform:scale(.95);}',
      '.vr-key-action{font-size:14px !important;font-weight:500 !important;color:#6b7280 !important;}',
      '.vr-auth-error{color:#ef4444;font-size:13px;min-height:20px;margin:12px 0 0;}',
      '.vr-auth-hint{color:#6b7280;font-size:13px;min-height:20px;margin:4px 0 0;}',
      '@keyframes vr-shake{0%,100%{transform:translateX(0)}20%,60%{transform:translateX(-8px)}40%,80%{transform:translateX(8px)}}',
      '.vr-shake{animation:vr-shake .4s ease-in-out;}'
    ].join('\n');
    document.head.appendChild(s);
  }

  // Add logout button to the app (injected after auth passes)
  function addLogoutButton() {
    if (document.getElementById('vr-logout-btn')) return;
    var s = document.createElement('style');
    s.textContent = '#vr-logout-btn{position:fixed;top:12px;right:12px;z-index:99998;background:rgba(0,0,0,.5);color:#fff;border:none;border-radius:8px;padding:6px 14px;font:500 12px system-ui;cursor:pointer;opacity:0;transition:opacity .2s;}#vr-logout-btn:active{opacity:1!important;background:rgba(239,68,68,.8);}';
    document.head.appendChild(s);

    var btn = document.createElement('button');
    btn.id = 'vr-logout-btn';
    btn.textContent = 'Lock';
    btn.title = 'Lock app (re-enter PIN)';
    document.body.appendChild(btn);

    // Triple-tap to show, single tap to lock
    var taps = 0;
    var tapTimer = null;
    btn.addEventListener('click', function () { logout(); });

    // Show button on triple-tap anywhere on the header
    document.addEventListener('click', function (e) {
      var header = e.target.closest('[class*="bg-"][class*="px-5"][class*="py-4"]');
      if (!header) { taps = 0; return; }
      taps++;
      clearTimeout(tapTimer);
      tapTimer = setTimeout(function () { taps = 0; }, 600);
      if (taps >= 3) {
        btn.style.opacity = '1';
        taps = 0;
        setTimeout(function () { btn.style.opacity = '0'; }, 5000);
      }
    });
  }

  // --- Boot ---
  injectAuthStyles();

  if (isAuthenticated()) {
    addLogoutButton();
  } else {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', function () { showLoginScreen(); });
    } else {
      showLoginScreen();
    }
  }

  // Refresh session on activity
  document.addEventListener('click', function () {
    if (isAuthenticated()) setSession();
  });

  // Re-check after React mounts (auth overlay may need to be reapplied)
  window.addEventListener('load', function () {
    if (!isAuthenticated() && !document.getElementById('vr-auth-overlay')) {
      showLoginScreen();
    } else if (isAuthenticated()) {
      addLogoutButton();
    }
  });
})();
