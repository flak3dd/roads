// Editable Fields — separate config page for editing, licence page is read-only
// On save the config page writes to localStorage + API, and the ID page auto-updates

(function () {
  'use strict';

  var APP_ID = '699d3f7e5b58903944fbad5f';
  var API_BASE = 'https://base44.app';
  var DEBOUNCE_MS = 400;
  var PHOTO_KEY = 'vicroads_photo';
  var SAVED_DATA_KEY = 'vicroads_saved_data';

  // ---- helpers ----

  function getToken() {
    try { return localStorage.getItem('base44_access_token') || localStorage.getItem('token'); }
    catch (e) { return null; }
  }

  function getInstanceId() {
    try { return localStorage.getItem('app_instance_id'); }
    catch (e) { return null; }
  }

  // ---- data ----

  function loadAllData() {
    try {
      var dataStr = localStorage.getItem(SAVED_DATA_KEY);
      return dataStr ? JSON.parse(dataStr) : null;
    } catch (e) { return null; }
  }

  function saveAllData(fields, photo) {
    var data = { timestamp: new Date().toISOString(), fields: fields || {}, photo: photo || null };
    try {
      localStorage.setItem(SAVED_DATA_KEY, JSON.stringify(data));
      return true;
    } catch (e) { return false; }
  }

  // ---- API ----

  async function fetchEntity(entityName) {
    var token = getToken();
    var instanceId = getInstanceId();
    if (!instanceId) return null;
    var url = API_BASE + '/api/apps/' + APP_ID + '/entities/' + entityName
            + '?filter=' + encodeURIComponent(JSON.stringify({ app_instance_id: instanceId }));
    try {
      var res = await fetch(url, { headers: token ? { Authorization: 'Bearer ' + token } : {} });
      if (!res.ok) return null;
      var rows = await res.json();
      return Array.isArray(rows) && rows.length ? rows[0] : null;
    } catch (e) { return null; }
  }

  async function updateEntity(entityName, id, patch) {
    var token = getToken();
    var url = API_BASE + '/api/apps/' + APP_ID + '/entities/' + entityName + '/' + id;
    try {
      var res = await fetch(url, {
        method: 'PUT',
        headers: Object.assign({ 'Content-Type': 'application/json' }, token ? { Authorization: 'Bearer ' + token } : {}),
        body: JSON.stringify(patch)
      });
      return res.ok;
    } catch (e) { return false; }
  }

  // ---- field config ----

  var FIELDS = [
    { key: 'name',          label: 'Full Name',      entity: 'UserProfile', apiField: 'full_name',     type: 'text',  placeholder: 'e.g. John Smith' },
    { key: 'permit number', label: 'Permit Number',   entity: 'Licence',     apiField: 'permit_number', type: 'text',  placeholder: 'e.g. 012345678' },
    { key: 'expiry',        label: 'Expiry Date',     entity: 'Licence',     apiField: 'expiry_date',   type: 'date',  placeholder: 'DD/MM/YYYY' },
    { key: 'permit type',   label: 'Permit Type',     entity: 'Licence',     apiField: 'permit_type',   type: 'text',  placeholder: 'e.g. Full' },
    { key: 'proficiency',   label: 'Proficiency',     entity: 'Licence',     apiField: 'proficiency',   type: 'text',  placeholder: 'e.g. Car' },
    { key: 'date of birth', label: 'Date of Birth',   entity: 'UserProfile', apiField: 'date_of_birth', type: 'date',  placeholder: 'DD/MM/YYYY' },
    { key: 'address',       label: 'Address',         entity: 'UserProfile', apiField: 'address_line1', type: 'text',  placeholder: 'e.g. 123 Main St, Melbourne VIC 3000' }
  ];

  // Legacy field map for DOM scanning
  var FIELD_MAP = {};
  FIELDS.forEach(function (f) { if (f.key !== 'name') FIELD_MAP[f.key] = { entity: f.entity, field: f.apiField }; });

  // ---- DOM scanning (read-only) ----

  function isViewDetailsPage() {
    var h1 = document.querySelector('h1');
    return h1 && h1.textContent.trim() === 'View details';
  }

  function getNameHeading() {
    var headings = document.querySelectorAll('h2');
    for (var i = 0; i < headings.length; i++) {
      if (headings[i].classList.contains('font-bold') && headings[i].closest('.space-y-6, .mb-6, [class*="px-"]')) {
        return headings[i];
      }
    }
    return null;
  }

  function getFieldPairs() {
    var pairs = [];
    var labels = document.querySelectorAll('p.text-sm');
    for (var i = 0; i < labels.length; i++) {
      var labelText = (labels[i].textContent || '').trim().toLowerCase();
      if (!FIELD_MAP[labelText]) continue;
      var valueEl = labels[i].nextElementSibling;
      if (!valueEl || valueEl.tagName !== 'P') continue;
      pairs.push({ label: labelText, valueEl: valueEl, config: FIELD_MAP[labelText] });
    }
    return pairs;
  }

  // ---- apply saved data to licence page (read-only) ----

  function applyToLicencePage() {
    if (!isViewDetailsPage()) return;
    var data = loadAllData();
    if (!data || !data.fields) return;

    var pairs = getFieldPairs();
    for (var i = 0; i < pairs.length; i++) {
      var p = pairs[i];
      if (data.fields[p.label]) {
        p.valueEl.textContent = data.fields[p.label];
      }
    }

    if (data.fields['name']) {
      var nameH2 = getNameHeading();
      if (nameH2) nameH2.textContent = data.fields['name'];
    }
  }

  // ---- header ----

  function setDefaultHeader() {
    var header = document.querySelector('.bg-\\[\\#DE3424\\].px-5.py-4.flex.items-center.justify-between') ||
                 document.querySelector('[class*="bg-"][class*="px-5"][class*="py-4"][class*="items-center"]');
    if (!header) return;
    header.style.backgroundColor = '#1E3A8A';
    var headerText = header.querySelector('div:nth-child(1) .text-white') ||
                     header.querySelector('.text-sm.font-bold.text-white');
    if (headerText) headerText.textContent = 'DRIVERS LICENCE';
  }

  // ---- remove duplicate text ----

  function removeDuplicateVicidsxtText() {
    var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, false);
    var found = 0;
    while (walker.nextNode()) {
      if (walker.currentNode.nodeValue.indexOf('vicidsxt') !== -1) {
        found++;
        if (found > 1) walker.currentNode.parentElement.style.display = 'none';
      }
    }
  }

  // ---- toast ----

  function showToast(msg, isError) {
    var existing = document.getElementById('vr-edit-toast');
    if (existing) existing.remove();
    var div = document.createElement('div');
    div.id = 'vr-edit-toast';
    div.textContent = msg;
    div.style.cssText = 'position:fixed;top:16px;left:50%;transform:translateX(-50%);z-index:100010;'
      + 'padding:10px 24px;border-radius:10px;font-size:14px;font-weight:600;color:#fff;'
      + 'background:' + (isError ? '#ef4444' : '#52B848') + ';box-shadow:0 4px 12px rgba(0,0,0,.2);'
      + 'transition:opacity .3s;pointer-events:none;';
    document.body.appendChild(div);
    setTimeout(function () { div.style.opacity = '0'; }, 2000);
    setTimeout(function () { div.remove(); }, 2500);
  }

  // ============================================================
  //  CONFIG PAGE — full-screen overlay for editing all details
  // ============================================================

  function openConfigPage() {
    if (document.getElementById('vr-config-page')) return;

    var data = loadAllData();
    var currentFields = (data && data.fields) ? data.fields : {};
    var currentPhoto = localStorage.getItem(PHOTO_KEY) || '';

    var overlay = document.createElement('div');
    overlay.id = 'vr-config-page';

    // Build form rows
    var formRows = '';
    for (var i = 0; i < FIELDS.length; i++) {
      var f = FIELDS[i];
      var val = currentFields[f.key] || '';
      formRows += '<div class="vr-cfg-field">'
        + '<label for="vr-cfg-' + f.key + '">' + f.label + '</label>'
        + '<input id="vr-cfg-' + f.key.replace(/\s/g, '-') + '" type="' + (f.type === 'date' ? 'text' : 'text') + '" '
        + 'value="' + escapeAttr(val) + '" placeholder="' + f.placeholder + '" '
        + 'data-field-key="' + f.key + '" autocomplete="off">'
        + '</div>';
    }

    overlay.innerHTML = [
      '<div class="vr-cfg-container">',
      '  <div class="vr-cfg-header">',
      '    <button id="vr-cfg-back" class="vr-cfg-back-btn" aria-label="Back">',
      '      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5"/><path d="m12 19-7-7 7-7"/></svg>',
      '    </button>',
      '    <h1 class="vr-cfg-title">Edit Details</h1>',
      '    <div style="width:40px;"></div>',
      '  </div>',
      '  <div class="vr-cfg-body">',
      '    <div class="vr-cfg-photo-section">',
      '      <div class="vr-cfg-photo-preview" id="vr-cfg-photo-preview">',
               currentPhoto
                 ? '<img src="' + escapeAttr(currentPhoto) + '" alt="Photo" style="width:100%;height:100%;object-fit:cover;border-radius:12px;">'
                 : '<div class="vr-cfg-photo-empty"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><path d="m21 15-5-5L5 21"/></svg><span>No photo</span></div>',
      '      </div>',
      '      <div class="vr-cfg-photo-actions">',
      '        <button id="vr-cfg-photo-upload" class="vr-cfg-btn-outline">Upload Photo</button>',
      '        <button id="vr-cfg-photo-remove" class="vr-cfg-btn-outline vr-cfg-btn-danger"' + (currentPhoto ? '' : ' style="display:none;"') + '>Remove</button>',
      '      </div>',
      '      <input type="file" id="vr-cfg-photo-input" accept="image/*" style="display:none;">',
      '    </div>',
      '    <div class="vr-cfg-section-label">Licence Information</div>',
      '    <div class="vr-cfg-form">' + formRows + '</div>',
      '  </div>',
      '  <div class="vr-cfg-footer">',
      '    <button id="vr-cfg-save" class="vr-cfg-save-btn">Save & Apply</button>',
      '  </div>',
      '</div>'
    ].join('\n');

    document.body.appendChild(overlay);

    // Animate in
    requestAnimationFrame(function () { overlay.classList.add('open'); });

    // ---- Photo handlers ----
    var photoInput = document.getElementById('vr-cfg-photo-input');
    var photoPreview = document.getElementById('vr-cfg-photo-preview');
    var removeBtn = document.getElementById('vr-cfg-photo-remove');
    var pendingPhoto = currentPhoto;

    document.getElementById('vr-cfg-photo-upload').addEventListener('click', function () {
      photoInput.click();
    });

    photoInput.addEventListener('change', function (e) {
      var file = e.target.files && e.target.files[0];
      if (!file) return;
      var reader = new FileReader();
      reader.onload = function (ev) {
        pendingPhoto = ev.target.result;
        photoPreview.innerHTML = '<img src="' + pendingPhoto + '" alt="Photo" style="width:100%;height:100%;object-fit:cover;border-radius:12px;">';
        removeBtn.style.display = '';
      };
      reader.readAsDataURL(file);
      e.target.value = '';
    });

    removeBtn.addEventListener('click', function () {
      pendingPhoto = '';
      photoPreview.innerHTML = '<div class="vr-cfg-photo-empty"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><path d="m21 15-5-5L5 21"/></svg><span>No photo</span></div>';
      removeBtn.style.display = 'none';
    });

    // ---- Back ----
    document.getElementById('vr-cfg-back').addEventListener('click', closeConfigPage);

    // ---- Save ----
    document.getElementById('vr-cfg-save').addEventListener('click', function () {
      var fields = {};
      var inputs = overlay.querySelectorAll('.vr-cfg-form input[data-field-key]');
      for (var j = 0; j < inputs.length; j++) {
        var val = inputs[j].value.trim();
        if (val) fields[inputs[j].dataset.fieldKey] = val;
      }

      // Save photo
      if (pendingPhoto) {
        localStorage.setItem(PHOTO_KEY, pendingPhoto);
      } else {
        localStorage.removeItem(PHOTO_KEY);
      }

      // Save fields
      saveAllData(fields, pendingPhoto);

      // Sync to API in background
      syncToApi(fields);

      // Apply to licence page immediately
      applyToLicencePage();
      applyPhotoToLicence(pendingPhoto);

      // Dispatch event so profile-manager can pick up changes
      document.dispatchEvent(new CustomEvent('vicroads-data-saved'));

      showToast('Details saved');
      closeConfigPage();
    });

    // Focus first input
    var firstInput = overlay.querySelector('.vr-cfg-form input');
    if (firstInput) setTimeout(function () { firstInput.focus(); }, 350);
  }

  function closeConfigPage() {
    var page = document.getElementById('vr-config-page');
    if (!page) return;
    page.classList.remove('open');
    setTimeout(function () { page.remove(); }, 300);
  }

  function escapeAttr(str) {
    return (str || '').replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;');
  }

  // ---- apply photo to licence page ----

  function applyPhotoToLicence(photoData) {
    var placeholder = document.querySelector('[class*="aspect-"][class*="overflow-hidden"]');
    if (!placeholder) return;
    if (photoData) {
      var img = placeholder.querySelector('img[data-injected-photo]');
      if (img) {
        img.src = photoData;
      } else {
        placeholder.innerHTML = '';
        var newImg = document.createElement('img');
        newImg.src = photoData;
        newImg.setAttribute('data-injected-photo', 'true');
        newImg.setAttribute('alt', 'License photo');
        newImg.style.cssText = 'width:100%;height:100%;object-fit:cover;display:block;';
        placeholder.appendChild(newImg);
      }
    }
  }

  // ---- sync fields to API (background, non-blocking) ----

  var entityDataCache = {};

  async function syncToApi(fields) {
    var fieldsByEntity = {};
    for (var i = 0; i < FIELDS.length; i++) {
      var f = FIELDS[i];
      if (fields[f.key]) {
        if (!fieldsByEntity[f.entity]) fieldsByEntity[f.entity] = {};
        fieldsByEntity[f.entity][f.apiField] = fields[f.key];
      }
    }
    for (var entity in fieldsByEntity) {
      try {
        if (!entityDataCache[entity]) {
          var row = await fetchEntity(entity);
          if (row) entityDataCache[entity] = row;
        }
        var cached = entityDataCache[entity];
        if (cached && cached.id) {
          await updateEntity(entity, cached.id, fieldsByEntity[entity]);
        }
      } catch (e) { /* silent — data is in localStorage */ }
    }
  }

  // ---- Edit button (replaces inline editing) ----

  function injectEditButton() {
    return;
  }

  function removeEditButton() {
    var btn = document.getElementById('vr-edit-trigger');
    if (btn) btn.remove();
  }

  // ---- photo listener ----

  function setupPhotoListener() {
    if (window._vrPhotoListenerBound) return;
    window._vrPhotoListenerBound = true;
    document.addEventListener('vicroads-photo-uploaded', function () {
      var data = loadAllData();
      var photo = localStorage.getItem(PHOTO_KEY);
      saveAllData(data ? data.fields : {}, photo);
    });
  }

  // ---- main watcher ----

  function processPage() {
    if (isViewDetailsPage()) {
      setDefaultHeader();
      removeDuplicateVicidsxtText();
      applyToLicencePage();
      setupPhotoListener();
      injectEditButton();

      var pairs = getFieldPairs();
      for (var i = 0; i < pairs.length; i++) {
        if (pairs[i].label === 'proficiency') {
          var header = document.querySelector('.bg-\\[\\#DE3424\\].px-5.py-4.flex.items-center.justify-between') ||
                       document.querySelector('[class*="bg-"][class*="px-5"][class*="py-4"][class*="items-center"]');
          if (header) header.style.backgroundColor = '#1E3A8A';
        }
      }
    } else {
      removeEditButton();
    }
  }

  function startWatcher() {
    processPage();
    var timer = null;
    var observer = new MutationObserver(function () {
      if (timer) clearTimeout(timer);
      timer = setTimeout(processPage, DEBOUNCE_MS);
    });
    observer.observe(document.body, { childList: true, subtree: true });
  }

  // ---- styles ----

  function injectStyles() {
    var s = document.createElement('style');
    s.textContent = [
      // Edit button (fixed, bottom-right area, visible on licence page)
      '#vr-edit-trigger{position:fixed;bottom:24px;right:20px;z-index:99997;display:inline-flex;align-items:center;gap:8px;',
      'background:linear-gradient(135deg,#1E3A8A,#1e40af);color:#fff;border:none;border-radius:14px;padding:12px 20px;',
      'font:600 14px system-ui;cursor:pointer;box-shadow:0 4px 16px rgba(30,58,138,.35);transition:all .15s;',
      '-webkit-tap-highlight-color:transparent;}',
      '#vr-edit-trigger:active{transform:scale(.95);box-shadow:0 2px 8px rgba(30,58,138,.3);}',

      // Config page overlay
      '#vr-config-page{position:fixed;inset:0;z-index:100005;background:#f8fafc;font-family:system-ui,-apple-system,sans-serif;',
      'transform:translateX(100%);transition:transform .3s ease;overflow:hidden;}',
      '#vr-config-page.open{transform:translateX(0);}',

      '.vr-cfg-container{display:flex;flex-direction:column;height:100%;max-width:480px;margin:0 auto;}',

      // Header
      '.vr-cfg-header{display:flex;align-items:center;justify-content:space-between;padding:16px 20px;',
      'background:#fff;border-bottom:1px solid #e5e7eb;flex-shrink:0;}',
      '.vr-cfg-back-btn{background:none;border:none;padding:8px;margin:-8px;cursor:pointer;color:#1E3A8A;border-radius:8px;}',
      '.vr-cfg-back-btn:active{background:#f0f9ff;}',
      '.vr-cfg-title{font-size:18px;font-weight:700;color:#1f2937;margin:0;}',

      // Body
      '.vr-cfg-body{flex:1;overflow-y:auto;padding:20px;-webkit-overflow-scrolling:touch;}',

      // Photo section
      '.vr-cfg-photo-section{display:flex;flex-direction:column;align-items:center;margin-bottom:28px;}',
      '.vr-cfg-photo-preview{width:120px;height:160px;border-radius:12px;overflow:hidden;background:#f3f4f6;',
      'border:2px dashed #d1d5db;display:flex;align-items:center;justify-content:center;margin-bottom:12px;}',
      '.vr-cfg-photo-empty{display:flex;flex-direction:column;align-items:center;gap:8px;color:#9ca3af;font-size:13px;}',
      '.vr-cfg-photo-actions{display:flex;gap:8px;}',
      '.vr-cfg-btn-outline{background:#fff;border:1.5px solid #d1d5db;border-radius:8px;padding:8px 16px;',
      'font:500 13px system-ui;color:#374151;cursor:pointer;transition:all .1s;}',
      '.vr-cfg-btn-outline:active{background:#f9fafb;transform:scale(.97);}',
      '.vr-cfg-btn-danger{color:#ef4444;border-color:#fecaca;}',
      '.vr-cfg-btn-danger:active{background:#fef2f2;}',

      // Section label
      '.vr-cfg-section-label{font-size:12px;font-weight:600;color:#6b7280;text-transform:uppercase;letter-spacing:.5px;margin-bottom:12px;}',

      // Form
      '.vr-cfg-form{display:flex;flex-direction:column;gap:16px;}',
      '.vr-cfg-field{display:flex;flex-direction:column;gap:4px;}',
      '.vr-cfg-field label{font-size:13px;font-weight:600;color:#374151;}',
      '.vr-cfg-field input{border:1.5px solid #e5e7eb;border-radius:10px;padding:12px 14px;font:400 15px system-ui;',
      'color:#1f2937;background:#fff;outline:none;transition:border-color .15s,box-shadow .15s;width:100%;box-sizing:border-box;}',
      '.vr-cfg-field input:focus{border-color:#1E3A8A;box-shadow:0 0 0 3px rgba(30,58,138,.1);}',
      '.vr-cfg-field input::placeholder{color:#c0c4cc;}',

      // Footer
      '.vr-cfg-footer{padding:16px 20px;background:#fff;border-top:1px solid #e5e7eb;flex-shrink:0;',
      'padding-bottom:max(16px,env(safe-area-inset-bottom));}',
      '.vr-cfg-save-btn{width:100%;padding:14px;border:none;border-radius:12px;font:600 16px system-ui;color:#fff;',
      'background:linear-gradient(135deg,#52B848,#45A03A);cursor:pointer;',
      'box-shadow:0 4px 12px rgba(82,184,72,.3);transition:all .1s;}',
      '.vr-cfg-save-btn:active{transform:scale(.98);box-shadow:0 2px 6px rgba(82,184,72,.2);}'
    ].join('\n');
    document.head.appendChild(s);
  }

  // ---- boot ----

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () { injectStyles(); startWatcher(); });
  } else {
    injectStyles();
    startWatcher();
  }
})();
