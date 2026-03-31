/**
 * Photo Upload Enhancement for Blitz ID
 * Adds photo upload functionality to the app
 */

class PhotoUploadManager {
  constructor() {
    this.init();
  }

  init() {
    // Wait for React to mount
    this.waitForRoot(() => {
      this.setupPhotoUpload();
      this.injectPhotoUI();
    });

    // iOS-specific setup
    this.setupIOSSupport();
  }

  setupIOSSupport() {
    // Detect iOS
    const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
    
    if (isIOS) {
      // Add iOS viewport settings
      const meta = document.querySelector('meta[name="viewport"]');
      if (meta) {
        meta.setAttribute('content', 'width=device-width, initial-scale=1.0, viewport-fit=cover, user-scalable=yes');
      }

      // Ensure proper file input behavior on iOS
      document.addEventListener('touchstart', (e) => {
        if (e.target.type === 'file') {
          e.target.click();
        }
      });

      // Add status bar management for iOS
      this.setupIOSStatusBar();
    }
  }

  setupIOSStatusBar() {
    // Add iOS status bar color support
    const statusBarMeta = document.createElement('meta');
    statusBarMeta.name = 'apple-mobile-web-app-status-bar-style';
    statusBarMeta.content = 'black-translucent';
    document.head.appendChild(statusBarMeta);
  }

  waitForRoot(callback, maxAttempts = 50) {
    let attempts = 0;
    const checkRoot = setInterval(() => {
      attempts++;
      const root = document.getElementById('root');
      
      if (root && root.children.length > 0) {
        clearInterval(checkRoot);
        callback();
      } else if (attempts >= maxAttempts) {
        clearInterval(checkRoot);
        console.warn('Root element not ready, retrying...');
      }
    }, 100);
  }

  setupPhotoUpload() {
    // Create photo storage in localStorage
    if (!localStorage.getItem('vicroads_photos')) {
      localStorage.setItem('vicroads_photos', JSON.stringify({
        license_photo: null,
        vehicle_photo: null,
        timestamp: new Date().toISOString()
      }));
    }

    // Intercept file inputs
    document.addEventListener('change', (e) => {
      if (e.target.type === 'file' && e.target.accept?.includes('image')) {
        this.handlePhotoUpload(e);
      }
    }, true);
  }

  handlePhotoUpload(event) {
    const file = event.target.files[0];
    if (!file) return;

    // Validate file size (max 10MB for iOS compatibility)
    const maxSize = 10 * 1024 * 1024;
    if (file.size > maxSize) {
      alert('Photo size must be less than 10MB');
      event.target.value = '';
      return;
    }

    // Validate file type - be more lenient for iOS
    const validTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/heic', 'image/heif'];
    if (!validTypes.includes(file.type) && !file.type.startsWith('image/')) {
      alert('Only image files are allowed');
      event.target.value = '';
      return;
    }

    // Show loading indicator for iOS
    this.showNotification('Processing image...', 'info');

    // Convert to base64 and store
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const photoData = localStorage.getItem('vicroads_photos');
        const photos = JSON.parse(photoData);
        
        // Determine which photo type based on context
        const targetName = event.target.name || 'license_photo';
        photos[targetName] = {
          data: e.target.result,
          filename: file.name,
          type: file.type,
          size: file.size,
          uploaded: new Date().toISOString()
        };

        localStorage.setItem('vicroads_photos', JSON.stringify(photos));
        
        // Show success message
        this.showNotification(`Photo saved: ${file.name}`, 'success');
        
        // Dispatch custom event for React to listen to
        window.dispatchEvent(new CustomEvent('photoUploaded', {
          detail: { photoType: targetName, file: file.name }
        }));

        // Reset after a delay
        setTimeout(() => {
          event.target.value = '';
        }, 100);

      } catch (error) {
        this.showNotification('Error saving photo: ' + error.message, 'error');
        event.target.value = '';
      }
    };

    reader.onerror = () => {
      this.showNotification('Error reading file', 'error');
      event.target.value = '';
    };

    reader.readAsDataURL(file);
  }

  injectPhotoUI() {
    // Add CSS for photo upload UI
    const style = document.createElement('style');
    style.textContent = `
      .photo-upload-wrapper {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1000;
        display: none;
      }

      .photo-upload-wrapper.visible {
        display: block;
      }

      .photo-upload-btn {
        background: linear-gradient(135deg, #52B848 0%, #45A03A 100%);
        color: white;
        border: none;
        border-radius: 50%;
        width: 60px;
        height: 60px;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(82, 184, 72, 0.3);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .photo-upload-btn:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 16px rgba(82, 184, 72, 0.4);
      }

      .photo-upload-btn:active {
        transform: scale(0.95);
      }

      .photo-upload-menu {
        position: absolute;
        bottom: 70px;
        right: 0;
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        overflow: hidden;
        min-width: 200px;
        display: none;
      }

      .photo-upload-menu.active {
        display: block;
        animation: slideUp 0.3s ease;
      }

      @keyframes slideUp {
        from {
          opacity: 0;
          transform: translateY(10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .photo-upload-menu-item {
        padding: 12px 16px;
        cursor: pointer;
        border-bottom: 1px solid #f0f0f0;
        font-size: 14px;
        color: #333;
        transition: background-color 0.2s;
      }

      .photo-upload-menu-item:last-child {
        border-bottom: none;
      }

      .photo-upload-menu-item:hover {
        background-color: #f9f9f9;
        color: #52B848;
      }

      .photo-notification {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 16px 20px;
        border-radius: 8px;
        color: white;
        font-size: 14px;
        z-index: 2000;
        animation: slideInRight 0.3s ease;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        display: block;
      }

      .photo-notification.success {
        background-color: #52B848;
      }

      .photo-notification.error {
        background-color: #DE3424;
      }

      .photo-notification.info {
        background-color: #2D3E50;
      }

      @keyframes slideInRight {
        from {
          opacity: 0;
          transform: translateX(20px);
        }
        to {
          opacity: 1;
          transform: translateX(0);
        }
      }

      .photo-file-input {
        display: none;
      }

      /* iOS-specific optimizations */
      @supports (-webkit-touch-callout: none) {
        .photo-upload-btn {
          -webkit-user-select: none;
          -webkit-tap-highlight-color: transparent;
        }

        .photo-upload-menu-item {
          -webkit-user-select: none;
          -webkit-tap-highlight-color: transparent;
        }

        .photo-item-delete {
          -webkit-user-select: none;
          -webkit-tap-highlight-color: transparent;
        }

        /* Safe area support for notched devices */
        .photo-upload-wrapper {
          bottom: max(20px, env(safe-area-inset-bottom));
          right: max(20px, env(safe-area-inset-right));
        }

        .photo-list {
          top: max(20px, env(safe-area-inset-top));
          left: max(20px, env(safe-area-inset-left));
        }

        .photo-notification {
          top: max(20px, env(safe-area-inset-top));
          right: max(20px, env(safe-area-inset-right));
        }
      }

      .photo-list {
        position: fixed;
        top: 20px;
        left: 20px;
        background: white;
        border-radius: 8px;
        padding: 16px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        min-width: 250px;
        z-index: 999;
        display: none;
      }

      .photo-list.visible {
        display: block;
      }

      .photo-list h3 {
        margin: 0 0 12px 0;
        font-size: 14px;
        color: #2D3E50;
      }

      .photo-item {
        padding: 8px;
        background: #f9f9f9;
        border-radius: 4px;
        margin-bottom: 8px;
        font-size: 12px;
        color: #666;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .photo-item-name {
        flex: 1;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      .photo-item-delete {
        background: #DE3424;
        color: white;
        border: none;
        border-radius: 3px;
        padding: 2px 6px;
        font-size: 11px;
        cursor: pointer;
        margin-left: 8px;
      }

      .photo-item-delete:hover {
        background: #c9291d;
      }

      @media (max-width: 768px) {
        .photo-upload-wrapper {
          bottom: 15px;
          right: 15px;
        }

        .photo-upload-btn {
          width: 50px;
          height: 50px;
          font-size: 20px;
        }

        .photo-list {
          top: 10px;
          left: 10px;
          min-width: 220px;
        }

        .photo-notification {
          top: 10px;
          right: 10px;
          font-size: 12px;
        }

        /* iOS safe area for notched devices */
        @supports (-webkit-touch-callout: none) {
          .photo-upload-wrapper {
            bottom: max(10px, env(safe-area-inset-bottom));
            right: max(10px, env(safe-area-inset-right));
          }

          .photo-list {
            top: max(10px, env(safe-area-inset-top));
            left: max(10px, env(safe-area-inset-left));
          }

          .photo-notification {
            top: max(10px, env(safe-area-inset-top));
            right: max(10px, env(safe-area-inset-right));
          }
        }
      }
    `;
    document.head.appendChild(style);

    // Create upload button wrapper
    const wrapper = document.createElement('div');
    wrapper.className = 'photo-upload-wrapper';
    wrapper.innerHTML = `
      <button class="photo-upload-btn" title="Upload Photo" aria-label="Upload Photo">
        📷
      </button>
      <div class="photo-upload-menu">
        <div class="photo-upload-menu-item upload-license">Add License Photo</div>
        <div class="photo-upload-menu-item upload-vehicle">Add Vehicle Photo</div>
        <div class="photo-upload-menu-item clear-photos">Clear All Photos</div>
      </div>
      <input type="file" class="photo-file-input" accept="image/*">
    `;
    document.body.appendChild(wrapper);

    // Create photo list display
    const photoList = document.createElement('div');
    photoList.className = 'photo-list';
    photoList.innerHTML = `
      <h3>Uploaded Photos</h3>
      <div id="photo-list-items"></div>
    `;
    document.body.appendChild(photoList);

    // Setup event listeners
    const btn = wrapper.querySelector('.photo-upload-btn');
    const menu = wrapper.querySelector('.photo-upload-menu');
    const fileInput = wrapper.querySelector('.photo-file-input');
    const photoList = document.querySelector('.photo-list');

    // Hidden keyboard shortcut: Ctrl+Shift+P to show/hide photo manager
    document.addEventListener('keydown', (e) => {
      if (e.ctrlKey && e.shiftKey && e.code === 'KeyP') {
        e.preventDefault();
        this.togglePhotoUI(wrapper, photoList, menu);
      }
    });

    // iOS gesture: Double-tap on top-left corner to show/hide
    let tapCount = 0;
    let tapTimeout;
    const iOSGestureArea = document.createElement('div');
    iOSGestureArea.style.cssText = `
      position: fixed;
      top: 0;
      left: 0;
      width: 60px;
      height: 60px;
      z-index: 1;
      cursor: pointer;
      user-select: none;
    `;
    
    iOSGestureArea.addEventListener('touchstart', (e) => {
      tapCount++;
      
      if (tapTimeout) clearTimeout(tapTimeout);
      
      if (tapCount === 2) {
        e.preventDefault();
        this.togglePhotoUI(wrapper, photoList, menu);
        tapCount = 0;
      } else {
        tapTimeout = setTimeout(() => {
          tapCount = 0;
        }, 300);
      }
    });
    
    document.body.appendChild(iOSGestureArea);

    // Shake gesture detection for iOS (works on device with accelerometer)
    if (window.DeviceMotionEvent && typeof window.DeviceMotionEvent.requestPermission === 'function') {
      // iOS 13+ requires permission
      iOSGestureArea.addEventListener('touchend', () => {
        if (!window.motionPermissionRequested) {
          window.motionPermissionRequested = true;
          window.DeviceMotionEvent.requestPermission()
            .then(permissionState => {
              if (permissionState === 'granted') {
                window.addEventListener('devicemotion', this.handleShake.bind(this));
              }
            })
            .catch(console.error);
        }
      });
    } else if (window.DeviceMotionEvent) {
      // Older iOS versions
      window.addEventListener('devicemotion', this.handleShake.bind(this));
    }
    
    // Store reference for shake handling
    this.togglePhotoUIRef = () => this.togglePhotoUI(wrapper, photoList, menu);
  }

  togglePhotoUI(wrapper, photoList, menu) {
    wrapper.classList.toggle('visible');
    photoList.classList.toggle('visible');
    menu.classList.remove('active');
  }

  handleShake(event) {
    const acceleration = event.accelerationIncludingGravity;
    const x = acceleration.x || 0;
    const y = acceleration.y || 0;
    const z = acceleration.z || 0;

    // Calculate shake intensity
    const shakeIntensity = Math.sqrt(x * x + y * y + z * z);

    // Threshold for shake detection
    if (shakeIntensity > 30) {
      if (!this.lastShakeTime) {
        this.lastShakeTime = Date.now();
      }

      const timeSinceLastShake = Date.now() - this.lastShakeTime;
      
      if (timeSinceLastShake > 500) {
        this.lastShakeTime = Date.now();
        if (this.togglePhotoUIRef) {
          this.togglePhotoUIRef();
          this.showNotification('Photo Manager Toggled', 'info');
        }
      }
    }

    document.addEventListener('click', (e) => {
      if (!wrapper.contains(e.target)) {
        menu.classList.remove('active');
      }
    });

    btn.addEventListener('click', () => {
      menu.classList.toggle('active');
    });

    btn.addEventListener('touchend', (e) => {
      e.preventDefault();
      menu.classList.toggle('active');
    });

    const setupMenuListener = (selector, photoType) => {
      const element = wrapper.querySelector(selector);
      if (element) {
        element.addEventListener('click', () => {
          fileInput.name = photoType;
          fileInput.click();
          menu.classList.remove('active');
        });
        element.addEventListener('touchend', (e) => {
          e.preventDefault();
          fileInput.name = photoType;
          fileInput.click();
          menu.classList.remove('active');
        });
      }
    };

    setupMenuListener('.upload-license', 'license_photo');
    setupMenuListener('.upload-vehicle', 'vehicle_photo');

    wrapper.querySelector('.clear-photos').addEventListener('click', () => {
      if (confirm('Are you sure you want to delete all photos?')) {
        localStorage.setItem('vicroads_photos', JSON.stringify({
          license_photo: null,
          vehicle_photo: null,
          timestamp: new Date().toISOString()
        }));
        this.updatePhotoList();
        this.showNotification('All photos cleared', 'info');
        menu.classList.remove('active');
      }
    });

    wrapper.querySelector('.clear-photos').addEventListener('touchend', (e) => {
      e.preventDefault();
      if (confirm('Delete all photos?')) {
        localStorage.setItem('vicroads_photos', JSON.stringify({
          license_photo: null,
          vehicle_photo: null,
          timestamp: new Date().toISOString()
        }));
        this.updatePhotoList();
        this.showNotification('All photos cleared', 'info');
        menu.classList.remove('active');
      }
    });

    // Listen for photo upload events
    window.addEventListener('photoUploaded', () => {
      this.updatePhotoList();
    });

    // Initial photo list update
    this.updatePhotoList();
  }

  updatePhotoList() {
    try {
      const photoData = localStorage.getItem('vicroads_photos');
      const photos = JSON.parse(photoData);
      const listItems = document.getElementById('photo-list-items');

      if (!listItems) return;

      listItems.innerHTML = '';

      if (photos.license_photo) {
        const licenseEl = document.createElement('div');
        licenseEl.className = 'photo-item';
        licenseEl.innerHTML = `
          <span class="photo-item-name" title="${photos.license_photo.filename}">
            🪪 ${photos.license_photo.filename}
          </span>
          <button class="photo-item-delete" onclick="window.photoUploadManager.deletePhoto('license_photo')">✕</button>
        `;
        listItems.appendChild(licenseEl);
      }

      if (photos.vehicle_photo) {
        const vehicleEl = document.createElement('div');
        vehicleEl.className = 'photo-item';
        vehicleEl.innerHTML = `
          <span class="photo-item-name" title="${photos.vehicle_photo.filename}">
            🚗 ${photos.vehicle_photo.filename}
          </span>
          <button class="photo-item-delete" onclick="window.photoUploadManager.deletePhoto('vehicle_photo')">✕</button>
        `;
        listItems.appendChild(vehicleEl);
      }

      if (!photos.license_photo && !photos.vehicle_photo) {
        const noPhotoDiv = document.createElement('div');
        noPhotoDiv.style.cssText = 'color: #999; font-size: 12px; padding: 8px; cursor: pointer; user-select: none; transition: all 0.2s ease;';
        noPhotoDiv.textContent = 'No photos yet';
        noPhotoDiv.onmouseover = () => noPhotoDiv.style.opacity = '0.7';
        noPhotoDiv.onmouseout = () => noPhotoDiv.style.opacity = '1';
        noPhotoDiv.onclick = (e) => {
          e.stopPropagation();
          this.openDiscretePhotoUpload();
        };
        listItems.appendChild(noPhotoDiv);
      }
    } catch (error) {
      console.error('Error updating photo list:', error);
    }
  }

  deletePhoto(photoType) {
    try {
      const photoData = localStorage.getItem('vicroads_photos');
      const photos = JSON.parse(photoData);
      photos[photoType] = null;
      localStorage.setItem('vicroads_photos', JSON.stringify(photos));
      this.updatePhotoList();
      this.showNotification('Photo deleted', 'info');
    } catch (error) {
      this.showNotification('Error deleting photo', 'error');
    }
  }

  openDiscretePhotoUpload() {
    // Create hidden file input for discrete photo upload
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'image/*';
    fileInput.style.display = 'none';
    fileInput.name = 'license_photo';
    
    fileInput.onchange = (e) => {
      this.handlePhotoUpload(e);
      document.body.removeChild(fileInput);
    };
    
    document.body.appendChild(fileInput);
    fileInput.click();
  }

  showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `photo-notification ${type}`;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
      notification.style.animation = 'slideOutRight 0.3s ease forwards';
      setTimeout(() => notification.remove(), 300);
    }, 3000);
  }
}

// Initialize photo upload manager
window.photoUploadManager = new PhotoUploadManager();
