// Editable Fields - allows inline editing on View Details (Permit & Identity tabs)
// Targets field values and the name heading, saving changes back to Base44 API.

(function () {
  'use strict';

  var APP_ID = '699d3f7e5b58903944fbad5f';
  var API_BASE = 'https://base44.app';
  var DEBOUNCE_MS = 400;

  // ---- helpers ----

  function getToken() {
    try { return localStorage.getItem('base44_access_token') || localStorage.getItem('token'); }
    catch (e) { return null; }
  }

  function getInstanceId() {
    try { return localStorage.getItem('app_instance_id'); }
    catch (e) { return null; }
  }

  // Fetch entity rows filtered by app_instance_id
  async function fetchEntity(entityName) {
    var token = getToken();
    var instanceId = getInstanceId();
    if (!instanceId) return null;
    var url = API_BASE + '/api/apps/' + APP_ID + '/entities/' + entityName
            + '?filter=' + encodeURIComponent(JSON.stringify({ app_instance_id: instanceId }));
    var res = await fetch(url, {
      headers: token ? { Authorization: 'Bearer ' + token } : {}
    });
    if (!res.ok) return null;
    var rows = await res.json();
    return Array.isArray(rows) && rows.length ? rows[0] : null;
  }

  // Update an entity row by id
  async function updateEntity(entityName, id, patch) {
    var token = getToken();
    var url = API_BASE + '/api/apps/' + APP_ID + '/entities/' + entityName + '/' + id;
    var res = await fetch(url, {
      method: 'PUT',
      headers: Object.assign({ 'Content-Type': 'application/json' }, token ? { Authorization: 'Bearer ' + token } : {}),
      body: JSON.stringify(patch)
    });
    return res.ok;
  }

  // ---- field config ----

  // Map from label text (lowercase) shown in the UI  -->  { entity, field }
  var FIELD_MAP = {
    'permit number':  { entity: 'Licence',     field: 'permit_number' },
    'expiry':         { entity: 'Licence',     field: 'expiry_date' },
    'permit type':    { entity: 'Licence',     field: 'permit_type' },
    'date of birth':  { entity: 'UserProfile', field: 'date_of_birth' },
    'address':        { entity: 'UserProfile', field: 'address_line1' }
  };

  // ---- DOM scanning ----

  function isViewDetailsPage() {
    var h1 = document.querySelector('h1');
    return h1 && h1.textContent.trim() === 'View details';
  }

  // Find the NAME heading (h2 with bold text like "NAME NOT SET" or the user's name)
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

  // Find label -> value pairs. Labels are <p class="text-sm text-gray-500 ..."> and values
  // are the next sibling <p class="font-semibold text-gray-900 ...">
  function getFieldPairs() {
    var pairs = [];
    var labels = document.querySelectorAll('p.text-sm');
    for (var i = 0; i < labels.length; i++) {
      var label = labels[i];
      var labelText = (label.textContent || '').trim().toLowerCase();
      if (!FIELD_MAP[labelText]) continue;
      // value element is the next sibling <p>
      var valueEl = label.nextElementSibling;
      if (!valueEl || valueEl.tagName !== 'P') continue;
      pairs.push({ label: labelText, valueEl: valueEl, config: FIELD_MAP[labelText] });
    }
    return pairs;
  }

  // ---- inline editing ----

  function makeEditable(el, entityName, fieldName, entityCache, placeholder) {
    if (el.dataset.vrEditable === '1') return;
    el.dataset.vrEditable = '1';
    el.style.cursor = 'pointer';
    el.title = 'Tap to edit';

    // subtle edit icon hint
    el.style.position = 'relative';

    el.addEventListener('click', function (e) {
      e.stopPropagation();
      if (el.querySelector('input')) return; // already editing

      var currentText = el.textContent.trim();
      if (currentText === 'NAME NOT SET' || currentText === '') currentText = '';

      var input = document.createElement('input');
      input.type = 'text';
      input.value = currentText;
      input.placeholder = placeholder || 'Enter value';
      input.style.cssText = 'width:100%;font:inherit;color:inherit;background:#f9fafb;border:1.5px solid #52B848;border-radius:6px;padding:4px 8px;outline:none;box-sizing:border-box;';

      el.textContent = '';
      el.appendChild(input);
      input.focus();
      input.select();

      function commit() {
        var newVal = input.value.trim();
        el.textContent = newVal || placeholder || '';
        saveField(entityName, fieldName, newVal, entityCache);
      }

      input.addEventListener('blur', commit);
      input.addEventListener('keydown', function (ev) {
        if (ev.key === 'Enter') { ev.preventDefault(); input.blur(); }
        if (ev.key === 'Escape') { el.textContent = currentText || placeholder || ''; }
      });
    });
  }

  // Shared entity cache so we don't refetch per field
  var entityDataCache = {};

  async function ensureEntityCached(entityName) {
    if (entityDataCache[entityName]) return entityDataCache[entityName];
    var data = await fetchEntity(entityName);
    if (data) entityDataCache[entityName] = data;
    return data;
  }

  async function saveField(entityName, fieldName, value, cache) {
    var data = cache[entityName] || await ensureEntityCached(entityName);
    if (!data || !data.id) {
      console.warn('[editable-fields] No entity row for', entityName);
      return;
    }
    var patch = {};
    patch[fieldName] = value;
    var ok = await updateEntity(entityName, data.id, patch);
    if (ok) {
      data[fieldName] = value;
      showToast('Saved');
    } else {
      showToast('Save failed', true);
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
      + 'background:' + (isError ? '#DE3424' : '#52B848') + ';box-shadow:0 2px 8px rgba(0,0,0,.15);'
      + 'transition:opacity .3s;pointer-events:none;';
    document.body.appendChild(div);
    setTimeout(function () { div.style.opacity = '0'; }, 1800);
    setTimeout(function () { div.remove(); }, 2200);
  }

  // ---- main watcher ----

  function processPage() {
    if (!isViewDetailsPage()) return;

    // 1. Name heading (shared between Permit and Identity tabs)
    var nameH2 = getNameHeading();
    if (nameH2) {
      makeEditable(nameH2, 'UserProfile', 'full_name', entityDataCache, 'Enter full name');
    }

    // 2. Labelled field pairs
    var pairs = getFieldPairs();
    for (var i = 0; i < pairs.length; i++) {
      var p = pairs[i];
      makeEditable(p.valueEl, p.config.entity, p.config.field, entityDataCache, 'Enter ' + p.label);
    }
  }

  // Observe DOM changes (React re-renders)
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
      '[data-vr-editable="1"]:hover { background: #f0fdf4; border-radius: 4px; }',
      '[data-vr-editable="1"]::after { content: " \\270E"; font-size: 0.75em; opacity: 0.4; }',
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
