.class public Landroidx/webkit/internal/ProfileImpl;
.super Ljava/lang/Object;
.source "ProfileImpl.java"

# interfaces
.implements Landroidx/webkit/Profile;


# instance fields
.field private final mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    .line 43
    return-void
.end method

.method constructor <init>(Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;)V
    .locals 0
    .param p1, "profileImpl"    # Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    .line 38
    return-void
.end method


# virtual methods
.method public getCookieManager()Landroid/webkit/CookieManager;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .line 59
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 60
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 61
    iget-object v1, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;->getCookieManager()Landroid/webkit/CookieManager;

    move-result-object v1

    return-object v1

    .line 63
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getGeolocationPermissions()Landroid/webkit/GeolocationPermissions;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .line 81
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 82
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 83
    iget-object v1, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;->getGeoLocationPermissions()Landroid/webkit/GeolocationPermissions;

    move-result-object v1

    return-object v1

    .line 85
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getName()Ljava/lang/String;
    .locals 2

    .line 48
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 49
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 50
    iget-object v1, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;->getName()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 52
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getServiceWorkerController()Landroid/webkit/ServiceWorkerController;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .line 92
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 93
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 94
    iget-object v1, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;->getServiceWorkerController()Landroid/webkit/ServiceWorkerController;

    move-result-object v1

    return-object v1

    .line 96
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getWebStorage()Landroid/webkit/WebStorage;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .line 70
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 71
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 72
    iget-object v1, p0, Landroidx/webkit/internal/ProfileImpl;->mProfileImpl:Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;->getWebStorage()Landroid/webkit/WebStorage;

    move-result-object v1

    return-object v1

    .line 74
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method
