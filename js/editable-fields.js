// Editable Fields — inline editing on View Details (Permit & Identity tabs)
// Optimised: debounced auto-save, visual feedback, localStorage + API sync, profile integration

(function () {
  'use strict';

  var APP_ID = '699d3f7e5b58903944fbad5f';
  var API_BASE = 'https://base44.app';
  var DEBOUNCE_MS = 400;
  var AUTOSAVE_MS = 1500;
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

  // ---- save functionality ----

  var autoSaveTimer = null;

  function scheduleAutoSave() {
    if (autoSaveTimer) clearTimeout(autoSaveTimer);
    autoSaveTimer = setTimeout(function () { saveAllData(); }, AUTOSAVE_MS);
  }

  function saveAllData() {
    var data = { timestamp: new Date().toISOString(), fields: {}, photo: null };

    var pairs = getFieldPairs();
    for (var i = 0; i < pairs.length; i++) {
      var p = pairs[i];
      var val = p.valueEl.querySelector('input') ? p.valueEl.querySelector('input').value.trim() : p.valueEl.textContent.trim();
      if (val) data.fields[p.label] = val;
    }

    var nameH2 = getNameHeading();
    if (nameH2) {
      var nameVal = nameH2.querySelector('input') ? nameH2.querySelector('input').value.trim() : nameH2.textContent.trim();
      if (nameVal && nameVal !== 'NAME NOT SET') data.fields['name'] = nameVal;
    }

    var photo = localStorage.getItem(PHOTO_KEY);
    if (photo) data.photo = photo;

    try {
      localStorage.setItem(SAVED_DATA_KEY, JSON.stringify(data));
      return true;
    } catch (e) {
      return false;
    }
  }

  function loadAllData() {
    try {
      var dataStr = localStorage.getItem(SAVED_DATA_KEY);
      return dataStr ? JSON.parse(dataStr) : null;
    } catch (e) { return null; }
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

  var FIELD_MAP = {
    'permit number':  { entity: 'Licence',     field: 'permit_number' },
    'expiry':         { entity: 'Licence',     field: 'expiry_date' },
    'permit type':    { entity: 'Licence',     field: 'permit_type' },
    'proficiency':    { entity: 'Licence',     field: 'proficiency' },
    'date of birth':  { entity: 'UserProfile', field: 'date_of_birth' },
    'address':        { entity: 'UserProfile', field: 'address_line1' }
  };

  // ---- DOM scanning ----

  function isViewDetailsPage() {
    var h1 = document.querySelector('h1');
    return h1 && h1.textContent.trim() === 'View details';
  }

  function getNameHeading() {
    var headings = document.querySelectorAll('h2');
    for (var i = 0; i < headings.length; i++) {
      var t = headings[i].textContent.trim();
      if (t && headings[i].classList.contains('font-bold') && headings[i].closest('.space-y-6, .mb-6, [class*="px-"]')) {
        return headings[i];
      }
    }
    return null;
  }

  function getFieldPairs() {
    var pairs = [];
    var labels = document.querySelectorAll('p.text-sm');
    for (var i = 0; i < labels.length; i++) {
      var label = labels[i];
      var labelText = (label.textContent || '').trim().toLowerCase();
      if (!FIELD_MAP[labelText]) continue;
      var valueEl = label.nextElementSibling;
      if (!valueEl || valueEl.tagName !== 'P') continue;
      pairs.push({ label: labelText, valueEl: valueEl, config: FIELD_MAP[labelText] });
    }
    return pairs;
  }

  // ---- inline editing (optimised) ----

  function makeEditable(el, entityName, fieldName, entityCache, placeholder) {
    if (el.dataset.vrEditable === '1') return;
    el.dataset.vrEditable = '1';
    el.style.cursor = 'pointer';
    el.title = 'Tap to edit';

    el.addEventListener('click', function (e) {
      e.stopPropagation();
      if (el.querySelector('input')) return;

      var currentText = el.textContent.trim();
      if (currentText === 'NAME NOT SET' || currentText === 'Not set') currentText = '';

      var input = document.createElement('input');
      input.type = 'text';
      input.value = currentText;
      input.placeholder = placeholder || 'Enter value';
      input.style.cssText = 'width:100%;font:inherit;color:inherit;background:#f0f9ff;border:2px solid #1E3A8A;border-radius:8px;padding:6px 10px;outline:none;box-sizing:border-box;transition:border-color .15s;';

      el.textContent = '';
      el.appendChild(input);
      input.focus();
      input.select();

      // Live character count for address
      if (fieldName === 'address_line1') {
        var counter = document.createElement('span');
        counter.style.cssText = 'position:absolute;right:8px;bottom:-16px;font-size:10px;color:#9ca3af;';
        counter.textContent = input.value.length + '/100';
        el.style.position = 'relative';
        el.appendChild(counter);
        input.addEventListener('input', function () {
          counter.textContent = input.value.length + '/100';
        });
        input.maxLength = 100;
      }

      function commit() {
        var newVal = input.value.trim();
        el.textContent = newVal || placeholder || '';

        // Visual feedback
        el.style.transition = 'background .3s';
        el.style.background = '#f0fdf4';
        setTimeout(function () { el.style.background = ''; }, 800);

        saveField(entityName, fieldName, newVal, entityCache);
        scheduleAutoSave();
      }

      input.addEventListener('blur', commit);
      input.addEventListener('keydown', function (ev) {
        if (ev.key === 'Enter') { ev.preventDefault(); input.blur(); }
        if (ev.key === 'Escape') {
          el.textContent = currentText || placeholder || '';
        }
        if (ev.key === 'Tab') {
          ev.preventDefault();
          input.blur();
          // Focus next editable field
          var editables = document.querySelectorAll('[data-vr-editable="1"]');
          for (var idx = 0; idx < editables.length; idx++) {
            if (editables[idx] === el && editables[idx + 1]) {
              editables[idx + 1].click();
              break;
            }
          }
        }
      });
    });
  }

  var entityDataCache = {};

  async function ensureEntityCached(entityName) {
    if (entityDataCache[entityName]) return entityDataCache[entityName];
    var data = await fetchEntity(entityName);
    if (data) entityDataCache[entityName] = data;
    return data;
  }

  async function saveField(entityName, fieldName, value, cache) {
    var data = cache[entityName] || await ensureEntityCached(entityName);
    if (!data || !data.id) return;
    var patch = {};
    patch[fieldName] = value;
    var ok = await updateEntity(entityName, data.id, patch);
    if (ok) {
      data[fieldName] = value;
      showToast('Saved');
      if (fieldName === 'proficiency') updateHeaderColor(value);
    } else {
      showToast('Save failed — stored locally', true);
    }
  }

  // ---- header color ----

  function updateHeaderColor(proficiencyValue) {
    var header = document.querySelector('.bg-\\[\\#DE3424\\].px-5.py-4.flex.items-center.justify-between') ||
                 document.querySelector('[class*="bg-"][class*="px-5"][class*="py-4"][class*="items-center"]');
    if (!header) return;
    header.style.backgroundColor = '#1E3A8A';
    var headerText = header.querySelector('div:nth-child(1) .text-white') ||
                     header.querySelector('.text-sm.font-bold.text-white');
    if (headerText) headerText.textContent = 'DRIVERS LICENCE';
  }

  function setDefaultHeaderText() {
    var header = document.querySelector('.bg-\\[\\#DE3424\\].px-5.py-4.flex.items-center.justify-between') ||
                 document.querySelector('[class*="bg-"][class*="px-5"][class*="py-4"][class*="items-center"]');
    if (!header) return;
    header.style.backgroundColor = '#1E3A8A';
    var headerText = header.querySelector('div:nth-child(1) .text-white') ||
                     header.querySelector('.text-sm.font-bold.text-white');
    if (headerText) headerText.textContent = 'DRIVERS LICENCE';
  }

  // ---- restore saved data on page load ----

  function restoreSavedData() {
    var data = loadAllData();
    if (!data || !data.fields) return;

    var pairs = getFieldPairs();
    for (var i = 0; i < pairs.length; i++) {
      var p = pairs[i];
      if (data.fields[p.label] && !p.valueEl.querySelector('input')) {
        p.valueEl.textContent = data.fields[p.label];
      }
    }

    if (data.fields['name']) {
      var nameH2 = getNameHeading();
      if (nameH2 && !nameH2.querySelector('input')) {
        nameH2.textContent = data.fields['name'];
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
    div.style.cssText = 'position:fixed;top:16px;left:50%;transform:translateX(-50%);z-index:99999;'
      + 'padding:8px 20px;border-radius:8px;font-size:14px;font-weight:600;color:#fff;'
      + 'background:' + (isError ? '#ef4444' : '#52B848') + ';box-shadow:0 2px 8px rgba(0,0,0,.15);'
      + 'transition:opacity .3s;pointer-events:none;';
    document.body.appendChild(div);
    setTimeout(function () { div.style.opacity = '0'; }, 1800);
    setTimeout(function () { div.remove(); }, 2200);
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

  // ---- main watcher ----

  function processPage() {
    if (!isViewDetailsPage()) return;

    setDefaultHeaderText();
    removeDuplicateVicidsxtText();
    restoreSavedData();
    setupPhotoListener();

    var nameH2 = getNameHeading();
    if (nameH2) makeEditable(nameH2, 'UserProfile', 'full_name', entityDataCache, 'Enter full name');

    var pairs = getFieldPairs();
    for (var i = 0; i < pairs.length; i++) {
      var p = pairs[i];
      makeEditable(p.valueEl, p.config.entity, p.config.field, entityDataCache, 'Enter ' + p.label);
      if (p.label === 'proficiency') updateHeaderColor(p.valueEl.textContent.trim());
    }
  }

  function setupPhotoListener() {
    if (window._vrPhotoListenerBound) return;
    window._vrPhotoListenerBound = true;
    document.addEventListener('vicroads-photo-uploaded', function () { saveAllData(); });
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
    var style = document.createElement('style');
    style.textContent = [
      '[data-vr-editable="1"]{transition:background .2s,box-shadow .2s;border-radius:6px;padding:2px 4px;margin:-2px -4px;}',
      '[data-vr-editable="1"]:hover{background:#f0f9ff;box-shadow:inset 0 0 0 1px #bfdbfe;}',
      '[data-vr-editable="1"]::after{content:" \\270E";font-size:.7em;opacity:.35;vertical-align:super;}',
      '[data-vr-editable="1"]:focus-within{box-shadow:0 0 0 2px #1E3A8A;background:#fff;}'
    ].join('\n');
    document.head.appendChild(style);
  }

  // ---- boot ----

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () { injectStyles(); startWatcher(); });
  } else {
    injectStyles();
    startWatcher();
  }
})();
