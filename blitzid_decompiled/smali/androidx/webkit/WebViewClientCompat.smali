.class public Landroidx/webkit/WebViewClientCompat;
.super Landroid/webkit/WebViewClient;
.source "WebViewClientCompat.java"

# interfaces
.implements Lorg/chromium/support_lib_boundary/WebViewClientBoundaryInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/webkit/WebViewClientCompat$SafeBrowsingThreat;
    }
.end annotation


# static fields
.field private static final sSupportedFeatures:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 54
    const-string v0, "SHOULD_OVERRIDE_WITH_REDIRECTS"

    const-string v1, "SAFE_BROWSING_HIT"

    const-string v2, "VISUAL_STATE_CALLBACK"

    const-string v3, "RECEIVE_WEB_RESOURCE_ERROR"

    const-string v4, "RECEIVE_HTTP_ERROR"

    filled-new-array {v2, v3, v4, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroidx/webkit/WebViewClientCompat;->sSupportedFeatures:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 53
    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public final getSupportedFeatures()[Ljava/lang/String;
    .locals 1

    .line 82
    sget-object v0, Landroidx/webkit/WebViewClientCompat;->sSupportedFeatures:[Ljava/lang/String;

    return-object v0
.end method

.method public onPageCommitVisible(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 0
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .line 119
    return-void
.end method

.method public final onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "error"    # Landroid/webkit/WebResourceError;

    .line 146
    nop

    .line 147
    new-instance v0, Landroidx/webkit/internal/WebResourceErrorImpl;

    invoke-direct {v0, p3}, Landroidx/webkit/internal/WebResourceErrorImpl;-><init>(Landroid/webkit/WebResourceError;)V

    invoke-virtual {p0, p1, p2, v0}, Landroidx/webkit/WebViewClientCompat;->onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroidx/webkit/WebResourceErrorCompat;)V

    .line 148
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroidx/webkit/WebResourceErrorCompat;)V
    .locals 3
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "error"    # Landroidx/webkit/WebResourceErrorCompat;

    .line 169
    nop

    .line 170
    const-string v0, "WEB_RESOURCE_ERROR_GET_CODE"

    invoke-static {v0}, Landroidx/webkit/WebViewFeature;->isFeatureSupported(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 171
    const-string v0, "WEB_RESOURCE_ERROR_GET_DESCRIPTION"

    invoke-static {v0}, Landroidx/webkit/WebViewFeature;->isFeatureSupported(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 176
    :cond_0
    invoke-static {p2}, Landroidx/webkit/internal/ApiHelperForLollipop;->isForMainFrame(Landroid/webkit/WebResourceRequest;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 177
    nop

    .line 178
    invoke-virtual {p3}, Landroidx/webkit/WebResourceErrorCompat;->getErrorCode()I

    move-result v0

    invoke-virtual {p3}, Landroidx/webkit/WebResourceErrorCompat;->getDescription()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 179
    invoke-static {p2}, Landroidx/webkit/internal/ApiHelperForLollipop;->getUrl(Landroid/webkit/WebResourceRequest;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    .line 177
    invoke-virtual {p0, p1, v0, v1, v2}, Landroidx/webkit/WebViewClientCompat;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    .line 181
    :cond_1
    return-void

    .line 174
    :cond_2
    :goto_0
    return-void
.end method

.method public final onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Ljava/lang/reflect/InvocationHandler;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "handler"    # Ljava/lang/reflect/InvocationHandler;

    .line 132
    new-instance v0, Landroidx/webkit/internal/WebResourceErrorImpl;

    invoke-direct {v0, p3}, Landroidx/webkit/internal/WebResourceErrorImpl;-><init>(Ljava/lang/reflect/InvocationHandler;)V

    invoke-virtual {p0, p1, p2, v0}, Landroidx/webkit/WebViewClientCompat;->onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroidx/webkit/WebResourceErrorCompat;)V

    .line 133
    return-void
.end method

.method public onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .locals 0
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "errorResponse"    # Landroid/webkit/WebResourceResponse;

    .line 202
    return-void
.end method

.method public final onSafeBrowsingHit(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;ILandroid/webkit/SafeBrowsingResponse;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "threatType"    # I
    .param p4, "response"    # Landroid/webkit/SafeBrowsingResponse;

    .line 229
    new-instance v0, Landroidx/webkit/internal/SafeBrowsingResponseImpl;

    invoke-direct {v0, p4}, Landroidx/webkit/internal/SafeBrowsingResponseImpl;-><init>(Landroid/webkit/SafeBrowsingResponse;)V

    invoke-virtual {p0, p1, p2, p3, v0}, Landroidx/webkit/WebViewClientCompat;->onSafeBrowsingHit(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;ILandroidx/webkit/SafeBrowsingResponseCompat;)V

    .line 230
    return-void
.end method

.method public onSafeBrowsingHit(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;ILandroidx/webkit/SafeBrowsingResponseCompat;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "threatType"    # I
    .param p4, "callback"    # Landroidx/webkit/SafeBrowsingResponseCompat;

    .line 251
    const-string v0, "SAFE_BROWSING_RESPONSE_SHOW_INTERSTITIAL"

    invoke-static {v0}, Landroidx/webkit/WebViewFeature;->isFeatureSupported(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 253
    const/4 v0, 0x1

    invoke-virtual {p4, v0}, Landroidx/webkit/SafeBrowsingResponseCompat;->showInterstitial(Z)V

    .line 260
    return-void

    .line 258
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v0

    throw v0
.end method

.method public final onSafeBrowsingHit(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;ILjava/lang/reflect/InvocationHandler;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "threatType"    # I
    .param p4, "handler"    # Ljava/lang/reflect/InvocationHandler;

    .line 215
    new-instance v0, Landroidx/webkit/internal/SafeBrowsingResponseImpl;

    invoke-direct {v0, p4}, Landroidx/webkit/internal/SafeBrowsingResponseImpl;-><init>(Ljava/lang/reflect/InvocationHandler;)V

    invoke-virtual {p0, p1, p2, p3, v0}, Landroidx/webkit/WebViewClientCompat;->onSafeBrowsingHit(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;ILandroidx/webkit/SafeBrowsingResponseCompat;)V

    .line 216
    return-void
.end method

.method public onWebAuthnIntent(Landroid/webkit/WebView;Landroid/app/PendingIntent;Ljava/lang/reflect/InvocationHandler;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "intent"    # Landroid/app/PendingIntent;
    .param p3, "callback"    # Ljava/lang/reflect/InvocationHandler;

    .line 307
    const/4 v0, 0x0

    return v0
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;

    .line 294
    nop

    .line 295
    invoke-static {p2}, Landroidx/webkit/internal/ApiHelperForLollipop;->getUrl(Landroid/webkit/WebResourceRequest;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Landroidx/webkit/WebViewClientCompat;->shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
