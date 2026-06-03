// Profile Manager — save, load, switch, and delete named profiles
// Each profile stores all editable field values + photo data

(function () {
  'use strict';

  var PROFILES_KEY = 'vicroads_profiles';
  var ACTIVE_PROFILE_KEY = 'vicroads_active_profile';
  var SAVED_DATA_KEY = 'vicroads_saved_data';
  var PHOTO_KEY = 'vicroads_photo';

  function getProfiles() {
    try {
      var data = localStorage.getItem(PROFILES_KEY);
      return data ? JSON.parse(data) : {};
    } catch (e) { return {}; }
  }

  function setProfiles(profiles) {
    localStorage.setItem(PROFILES_KEY, JSON.stringify(profiles));
  }

  function getActiveProfileId() {
    return localStorage.getItem(ACTIVE_PROFILE_KEY) || null;
  }

  function setActiveProfileId(id) {
    if (id) localStorage.setItem(ACTIVE_PROFILE_KEY, id);
    else localStorage.removeItem(ACTIVE_PROFILE_KEY);
  }

  function generateId() {
    return 'p_' + Date.now().toString(36) + '_' + Math.random().toString(36).substr(2, 5);
  }

  // Capture current app state from localStorage (config page saves here)
  function captureCurrentState() {
    var state = { fields: {}, photo: null, timestamp: new Date().toISOString() };

    try {
      var saved = JSON.parse(localStorage.getItem(SAVED_DATA_KEY));
      if (saved && saved.fields) state.fields = saved.fields;
    } catch (e) {}

    var photo = localStorage.getItem(PHOTO_KEY);
    if (photo) state.photo = photo;

    return state;
  }

  // Apply a profile's data to the app
  function applyProfile(profileData) {
    if (!profileData) return;

    // Save to standard data keys so editable-fields picks it up
    var saveData = { fields: profileData.fields || {}, photo: profileData.photo || null, timestamp: new Date().toISOString() };
    localStorage.setItem(SAVED_DATA_KEY, JSON.stringify(saveData));

    if (profileData.photo) {
      localStorage.setItem(PHOTO_KEY, profileData.photo);
    } else {
      localStorage.removeItem(PHOTO_KEY);
    }

    // Apply fields to DOM
    var pairs = document.querySelectorAll('p.text-sm');
    for (var i = 0; i < pairs.length; i++) {
      var labelText = (pairs[i].textContent || '').trim().toLowerCase();
      var valueEl = pairs[i].nextElementSibling;
      if (valueEl && valueEl.tagName === 'P' && profileData.fields[labelText]) {
        valueEl.textContent = profileData.fields[labelText];
      }
    }

    // Apply name
    if (profileData.fields['name']) {
      var headings = document.querySelectorAll('h2');
      for (var j = 0; j < headings.length; j++) {
        if (headings[j].classList.contains('font-bold')) {
          headings[j].textContent = profileData.fields['name'];
          break;
        }
      }
    }

    // Apply photo
    if (profileData.photo) {
      var placeholder = document.querySelector('[class*="aspect-"][class*="overflow-hidden"]');
      if (placeholder) {
        var img = placeholder.querySelector('img[data-injected-photo]');
        if (img) {
          img.src = profileData.photo;
        } else {
          placeholder.innerHTML = '';
          var newImg = document.createElement('img');
          newImg.src = profileData.photo;
          newImg.setAttribute('data-injected-photo', 'true');
          newImg.setAttribute('alt', 'License photo');
          newImg.style.cssText = 'width:100%;height:100%;object-fit:cover;display:block;';
          placeholder.appendChild(newImg);
        }
      }
    }
  }

  // Save current state as a new or existing profile
  function saveProfile(name, existingId) {
    var profiles = getProfiles();
    var id = existingId || generateId();
    var state = captureCurrentState();
    state.name = name;
    state.updatedAt = new Date().toISOString();
    if (!existingId) state.createdAt = state.updatedAt;
    else state.createdAt = (profiles[id] && profiles[id].createdAt) || state.updatedAt;

    profiles[id] = state;
    setProfiles(profiles);
    setActiveProfileId(id);
    return id;
  }

  function deleteProfile(id) {
    var profiles = getProfiles();
    delete profiles[id];
    setProfiles(profiles);
    if (getActiveProfileId() === id) setActiveProfileId(null);
  }

  function loadProfile(id) {
    var profiles = getProfiles();
    var p = profiles[id];
    if (!p) return false;
    setActiveProfileId(id);
    applyProfile(p);
    return true;
  }

  // --- UI ---

  function showToast(msg, isError) {
    var existing = document.getElementById('vr-profile-toast');
    if (existing) existing.remove();
    var div = document.createElement('div');
    div.id = 'vr-profile-toast';
    div.textContent = msg;
    div.style.cssText = 'position:fixed;top:16px;left:50%;transform:translateX(-50%);z-index:100001;padding:8px 20px;border-radius:8px;font-size:14px;font-weight:600;color:#fff;background:' + (isError ? '#ef4444' : '#1E3A8A') + ';box-shadow:0 2px 8px rgba(0,0,0,.15);transition:opacity .3s;pointer-events:none;';
    document.body.appendChild(div);
    setTimeout(function () { div.style.opacity = '0'; }, 2000);
    setTimeout(function () { div.remove(); }, 2500);
  }

  function showProfilePanel() {
    var existing = document.getElementById('vr-profile-panel');
    if (existing) { existing.remove(); return; }

    var profiles = getProfiles();
    var activeId = getActiveProfileId();
    var keys = Object.keys(profiles);

    var panel = document.createElement('div');
    panel.id = 'vr-profile-panel';

    var listHtml = '';
    if (keys.length === 0) {
      listHtml = '<p style="color:#9ca3af;text-align:center;padding:16px;font-size:13px;">No saved profiles yet</p>';
    } else {
      for (var i = 0; i < keys.length; i++) {
        var id = keys[i];
        var p = profiles[id];
        var isActive = id === activeId;
        var nameDisplay = p.name || 'Unnamed';
        var dateDisplay = p.updatedAt ? new Date(p.updatedAt).toLocaleDateString() : '';
        var fieldCount = Object.keys(p.fields || {}).length;
        var hasPhoto = !!p.photo;

        listHtml += '<div class="vr-profile-item' + (isActive ? ' active' : '') + '" data-id="' + id + '">'
          + '<div class="vr-profile-info">'
          + '<div class="vr-profile-name">' + escapeHtml(nameDisplay) + (isActive ? ' <span class="vr-active-badge">Active</span>' : '') + '</div>'
          + '<div class="vr-profile-meta">' + fieldCount + ' fields' + (hasPhoto ? ' + photo' : '') + ' · ' + dateDisplay + '</div>'
          + '</div>'
          + '<div class="vr-profile-actions">'
          + '<button class="vr-prof-load" data-id="' + id + '" title="Load">Load</button>'
          + '<button class="vr-prof-update" data-id="' + id + '" title="Update with current data">Update</button>'
          + '<button class="vr-prof-del" data-id="' + id + '" title="Delete">Del</button>'
          + '</div>'
          + '</div>';
      }
    }

    panel.innerHTML = [
      '<div class="vr-profile-backdrop" id="vr-profile-backdrop"></div>',
      '<div class="vr-profile-sheet">',
      '  <div class="vr-profile-header">',
      '    <h3>Profiles</h3>',
      '    <button id="vr-profile-close" class="vr-profile-close-btn">&times;</button>',
      '  </div>',
      '  <div class="vr-profile-list">' + listHtml + '</div>',
      '  <div class="vr-profile-new">',
      '    <input type="text" id="vr-profile-name-input" placeholder="Profile name" maxlength="30">',
      '    <button id="vr-profile-save-btn">Save Current</button>',
      '  </div>',
      '  <div class="vr-profile-footer">',
      '    <button id="vr-profile-logout-btn" class="vr-profile-logout">Lock App</button>',
      '  </div>',
      '</div>'
    ].join('\n');

    document.body.appendChild(panel);

    // Event handlers
    document.getElementById('vr-profile-close').addEventListener('click', closePanel);
    document.getElementById('vr-profile-backdrop').addEventListener('click', closePanel);

    document.getElementById('vr-profile-save-btn').addEventListener('click', function () {
      var nameInput = document.getElementById('vr-profile-name-input');
      var name = (nameInput.value || '').trim();
      if (!name) { nameInput.style.borderColor = '#ef4444'; nameInput.focus(); return; }
      saveProfile(name);
      showToast('Profile "' + name + '" saved');
      closePanel();
    });

    document.getElementById('vr-profile-logout-btn').addEventListener('click', function () {
      if (window.vicraodsLogout) window.vicraodsLogout();
    });

    panel.addEventListener('click', function (e) {
      var loadBtn = e.target.closest('.vr-prof-load');
      if (loadBtn) {
        var id = loadBtn.dataset.id;
        if (loadProfile(id)) {
          showToast('Profile loaded');
          closePanel();
          setTimeout(function () { location.reload(); }, 400);
        }
        return;
      }

      var updateBtn = e.target.closest('.vr-prof-update');
      if (updateBtn) {
        var uid = updateBtn.dataset.id;
        var profs = getProfiles();
        if (profs[uid]) {
          saveProfile(profs[uid].name, uid);
          showToast('Profile updated');
          closePanel();
        }
        return;
      }

      var delBtn = e.target.closest('.vr-prof-del');
      if (delBtn) {
        var did = delBtn.dataset.id;
        var dp = getProfiles();
        var dname = dp[did] ? dp[did].name : 'this profile';
        if (confirm('Delete profile "' + dname + '"?')) {
          deleteProfile(did);
          showToast('Profile deleted', true);
          closePanel();
          showProfilePanel();
        }
      }
    });

    // Enter key on input
    document.getElementById('vr-profile-name-input').addEventListener('keydown', function (e) {
      if (e.key === 'Enter') document.getElementById('vr-profile-save-btn').click();
    });

    // Animate in
    requestAnimationFrame(function () {
      panel.classList.add('open');
    });
  }

  function closePanel() {
    var panel = document.getElementById('vr-profile-panel');
    if (panel) {
      panel.classList.remove('open');
      setTimeout(function () { panel.remove(); }, 300);
    }
  }

  function escapeHtml(str) {
    var div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  // --- Profile button (replaces old save UI) ---
  function injectProfileButton() {
    return;
  }

  function injectStyles() {
    var s = document.createElement('style');
    s.textContent = [
      '#vr-profile-trigger{position:fixed;top:12px;left:12px;z-index:99998;display:inline-flex;align-items:center;gap:6px;',
      'background:rgba(30,58,138,.85);backdrop-filter:blur(8px);color:#fff;border:none;border-radius:10px;padding:8px 14px;',
      'font:600 13px system-ui;cursor:pointer;box-shadow:0 2px 8px rgba(0,0,0,.15);transition:all .2s;opacity:0.6;}',
      '#vr-profile-trigger:active{transform:scale(.95);opacity:1;}',

      '#vr-profile-panel{position:fixed;inset:0;z-index:100002;font-family:system-ui,-apple-system,sans-serif;}',
      '.vr-profile-backdrop{position:absolute;inset:0;background:rgba(0,0,0,.4);opacity:0;transition:opacity .3s;}',
      '#vr-profile-panel.open .vr-profile-backdrop{opacity:1;}',

      '.vr-profile-sheet{position:absolute;bottom:0;left:0;right:0;background:#fff;border-radius:20px 20px 0 0;',
      'max-height:85vh;overflow-y:auto;transform:translateY(100%);transition:transform .3s ease;',
      'box-shadow:0 -4px 20px rgba(0,0,0,.1);padding-bottom:env(safe-area-inset-bottom,0);}',
      '#vr-profile-panel.open .vr-profile-sheet{transform:translateY(0);}',

      '.vr-profile-header{display:flex;align-items:center;justify-content:space-between;padding:20px 20px 12px;border-bottom:1px solid #f3f4f6;}',
      '.vr-profile-header h3{font-size:18px;font-weight:700;color:#1f2937;margin:0;}',
      '.vr-profile-close-btn{background:none;border:none;font-size:28px;color:#9ca3af;cursor:pointer;padding:0 4px;line-height:1;}',

      '.vr-profile-list{max-height:40vh;overflow-y:auto;padding:8px 12px;}',
      '.vr-profile-item{display:flex;align-items:center;justify-content:space-between;padding:12px;border-radius:12px;margin:4px 0;background:#f9fafb;transition:background .15s;}',
      '.vr-profile-item.active{background:#eff6ff;border:1px solid #bfdbfe;}',
      '.vr-profile-info{flex:1;min-width:0;}',
      '.vr-profile-name{font-size:15px;font-weight:600;color:#1f2937;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}',
      '.vr-active-badge{font-size:10px;background:#1E3A8A;color:#fff;padding:2px 6px;border-radius:4px;vertical-align:middle;font-weight:500;}',
      '.vr-profile-meta{font-size:12px;color:#9ca3af;margin-top:2px;}',
      '.vr-profile-actions{display:flex;gap:6px;flex-shrink:0;margin-left:8px;}',
      '.vr-profile-actions button{border:none;border-radius:8px;padding:6px 10px;font:500 12px system-ui;cursor:pointer;transition:all .1s;}',
      '.vr-prof-load{background:#1E3A8A;color:#fff;}',
      '.vr-prof-load:active{background:#1e40af;}',
      '.vr-prof-update{background:#f3f4f6;color:#374151;}',
      '.vr-prof-update:active{background:#e5e7eb;}',
      '.vr-prof-del{background:#fef2f2;color:#ef4444;}',
      '.vr-prof-del:active{background:#fee2e2;}',

      '.vr-profile-new{display:flex;gap:8px;padding:16px 20px;border-top:1px solid #f3f4f6;}',
      '.vr-profile-new input{flex:1;border:1.5px solid #e5e7eb;border-radius:10px;padding:10px 14px;font:400 14px system-ui;outline:none;transition:border-color .15s;}',
      '.vr-profile-new input:focus{border-color:#1E3A8A;}',
      '.vr-profile-new button{background:linear-gradient(135deg,#1E3A8A,#1e40af);color:#fff;border:none;border-radius:10px;padding:10px 18px;font:600 14px system-ui;cursor:pointer;white-space:nowrap;}',
      '.vr-profile-new button:active{transform:scale(.97);}',

      '.vr-profile-footer{padding:12px 20px 20px;border-top:1px solid #f3f4f6;text-align:center;}',
      '.vr-profile-logout{background:none;border:1px solid #e5e7eb;border-radius:10px;padding:10px 24px;font:500 13px system-ui;color:#6b7280;cursor:pointer;width:100%;}',
      '.vr-profile-logout:active{background:#f9fafb;}'
    ].join('\n');
    document.head.appendChild(s);
  }

  // --- Auto-load active profile on page load ---
  function autoLoadProfile() {
    var activeId = getActiveProfileId();
    if (!activeId) return;
    var profiles = getProfiles();
    var p = profiles[activeId];
    if (p) applyProfile(p);
  }

  // --- Boot ---
  function init() {
    injectStyles();
    injectProfileButton();
    autoLoadProfile();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.addEventListener('load', function () {
    injectProfileButton();
    autoLoadProfile();
  });
})();
