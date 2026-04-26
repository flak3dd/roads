.class public Landroidx/webkit/internal/ApiHelperForLollipop;
.super Ljava/lang/Object;
.source "ApiHelperForLollipop.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    return-void
.end method

.method public static getUrl(Landroid/webkit/WebResourceRequest;)Landroid/net/Uri;
    .locals 1
    .param p0, "webResourceRequest"    # Landroid/webkit/WebResourceRequest;

    .line 51
    invoke-interface {p0}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    return-object v0
.end method

.method public static isForMainFrame(Landroid/webkit/WebResourceRequest;)Z
    .locals 1
    .param p0, "webResourceRequest"    # Landroid/webkit/WebResourceRequest;

    .line 42
    invoke-interface {p0}, Landroid/webkit/WebResourceRequest;->isForMainFrame()Z

    move-result v0

    return v0
.end method
