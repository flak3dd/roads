.class public Landroidx/webkit/internal/ApiHelperForN;
.super Ljava/lang/Object;
.source "ApiHelperForN.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    return-void
.end method

.method public static getAllowContentAccess(Landroid/webkit/ServiceWorkerWebSettings;)Z
    .locals 1
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;

    .line 138
    invoke-virtual {p0}, Landroid/webkit/ServiceWorkerWebSettings;->getAllowContentAccess()Z

    move-result v0

    return v0
.end method

.method public static getAllowFileAccess(Landroid/webkit/ServiceWorkerWebSettings;)Z
    .locals 1
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;

    .line 156
    invoke-virtual {p0}, Landroid/webkit/ServiceWorkerWebSettings;->getAllowFileAccess()Z

    move-result v0

    return v0
.end method

.method public static getBlockNetworkLoads(Landroid/webkit/ServiceWorkerWebSettings;)Z
    .locals 1
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;

    .line 174
    invoke-virtual {p0}, Landroid/webkit/ServiceWorkerWebSettings;->getBlockNetworkLoads()Z

    move-result v0

    return v0
.end method

.method public static getCacheMode(Landroid/webkit/ServiceWorkerWebSettings;)I
    .locals 1
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;

    .line 119
    invoke-virtual {p0}, Landroid/webkit/ServiceWorkerWebSettings;->getCacheMode()I

    move-result v0

    return v0
.end method

.method public static getDataDir(Landroid/content/Context;)Ljava/io/File;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 51
    invoke-virtual {p0}, Landroid/content/Context;->getDataDir()Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method public static getDisabledActionModeMenuItems(Landroid/webkit/WebSettings;)I
    .locals 1
    .param p0, "webSettings"    # Landroid/webkit/WebSettings;

    .line 198
    invoke-virtual {p0}, Landroid/webkit/WebSettings;->getDisabledActionModeMenuItems()I

    move-result v0

    return v0
.end method

.method public static getServiceWorkerControllerInstance()Landroid/webkit/ServiceWorkerController;
    .locals 1

    .line 60
    invoke-static {}, Landroid/webkit/ServiceWorkerController;->getInstance()Landroid/webkit/ServiceWorkerController;

    move-result-object v0

    return-object v0
.end method

.method public static getServiceWorkerWebSettings(Landroid/webkit/ServiceWorkerController;)Landroid/webkit/ServiceWorkerWebSettings;
    .locals 1
    .param p0, "serviceWorkerController"    # Landroid/webkit/ServiceWorkerController;

    .line 70
    invoke-virtual {p0}, Landroid/webkit/ServiceWorkerController;->getServiceWorkerWebSettings()Landroid/webkit/ServiceWorkerWebSettings;

    move-result-object v0

    return-object v0
.end method

.method public static getServiceWorkerWebSettingsImpl(Landroid/webkit/ServiceWorkerController;)Landroidx/webkit/internal/ServiceWorkerWebSettingsImpl;
    .locals 2
    .param p0, "serviceWorkerController"    # Landroid/webkit/ServiceWorkerController;

    .line 80
    new-instance v0, Landroidx/webkit/internal/ServiceWorkerWebSettingsImpl;

    .line 81
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForN;->getServiceWorkerWebSettings(Landroid/webkit/ServiceWorkerController;)Landroid/webkit/ServiceWorkerWebSettings;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/webkit/internal/ServiceWorkerWebSettingsImpl;-><init>(Landroid/webkit/ServiceWorkerWebSettings;)V

    .line 80
    return-object v0
.end method

.method public static isRedirect(Landroid/webkit/WebResourceRequest;)Z
    .locals 1
    .param p0, "webResourceRequest"    # Landroid/webkit/WebResourceRequest;

    .line 182
    invoke-interface {p0}, Landroid/webkit/WebResourceRequest;->isRedirect()Z

    move-result v0

    return v0
.end method

.method public static setAllowContentAccess(Landroid/webkit/ServiceWorkerWebSettings;Z)V
    .locals 0
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;
    .param p1, "allowContentAccess"    # Z

    .line 129
    invoke-virtual {p0, p1}, Landroid/webkit/ServiceWorkerWebSettings;->setAllowContentAccess(Z)V

    .line 130
    return-void
.end method

.method public static setAllowFileAccess(Landroid/webkit/ServiceWorkerWebSettings;Z)V
    .locals 0
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;
    .param p1, "allowFileAccess"    # Z

    .line 147
    invoke-virtual {p0, p1}, Landroid/webkit/ServiceWorkerWebSettings;->setAllowFileAccess(Z)V

    .line 148
    return-void
.end method

.method public static setBlockNetworkLoads(Landroid/webkit/ServiceWorkerWebSettings;Z)V
    .locals 0
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;
    .param p1, "blockNetworkLoads"    # Z

    .line 165
    invoke-virtual {p0, p1}, Landroid/webkit/ServiceWorkerWebSettings;->setBlockNetworkLoads(Z)V

    .line 166
    return-void
.end method

.method public static setCacheMode(Landroid/webkit/ServiceWorkerWebSettings;I)V
    .locals 0
    .param p0, "serviceWorkerWebSettings"    # Landroid/webkit/ServiceWorkerWebSettings;
    .param p1, "cacheMode"    # I

    .line 111
    invoke-virtual {p0, p1}, Landroid/webkit/ServiceWorkerWebSettings;->setCacheMode(I)V

    .line 112
    return-void
.end method

.method public static setDisabledActionModeMenuItems(Landroid/webkit/WebSettings;I)V
    .locals 0
    .param p0, "webSettings"    # Landroid/webkit/WebSettings;
    .param p1, "i"    # I

    .line 190
    invoke-virtual {p0, p1}, Landroid/webkit/WebSettings;->setDisabledActionModeMenuItems(I)V

    .line 191
    return-void
.end method

.method public static setServiceWorkerClient(Landroid/webkit/ServiceWorkerController;Landroid/webkit/ServiceWorkerClient;)V
    .locals 0
    .param p0, "serviceWorkerController"    # Landroid/webkit/ServiceWorkerController;
    .param p1, "serviceWorkerClient"    # Landroid/webkit/ServiceWorkerClient;

    .line 91
    invoke-virtual {p0, p1}, Landroid/webkit/ServiceWorkerController;->setServiceWorkerClient(Landroid/webkit/ServiceWorkerClient;)V

    .line 92
    return-void
.end method

.method public static setServiceWorkerClientCompat(Landroid/webkit/ServiceWorkerController;Landroidx/webkit/ServiceWorkerClientCompat;)V
    .locals 1
    .param p0, "serviceWorkerController"    # Landroid/webkit/ServiceWorkerController;
    .param p1, "serviceWorkerClientCompat"    # Landroidx/webkit/ServiceWorkerClientCompat;

    .line 101
    new-instance v0, Landroidx/webkit/internal/FrameworkServiceWorkerClient;

    invoke-direct {v0, p1}, Landroidx/webkit/internal/FrameworkServiceWorkerClient;-><init>(Landroidx/webkit/ServiceWorkerClientCompat;)V

    invoke-virtual {p0, v0}, Landroid/webkit/ServiceWorkerController;->setServiceWorkerClient(Landroid/webkit/ServiceWorkerClient;)V

    .line 103
    return-void
.end method
