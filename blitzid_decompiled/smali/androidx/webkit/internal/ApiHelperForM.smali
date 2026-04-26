.class public Landroidx/webkit/internal/ApiHelperForM;
.super Ljava/lang/Object;
.source "ApiHelperForM.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    return-void
.end method

.method public static close(Landroid/webkit/WebMessagePort;)V
    .locals 0
    .param p0, "webMessagePort"    # Landroid/webkit/WebMessagePort;

    .line 60
    invoke-virtual {p0}, Landroid/webkit/WebMessagePort;->close()V

    .line 61
    return-void
.end method

.method public static createWebMessage(Landroidx/webkit/WebMessageCompat;)Landroid/webkit/WebMessage;
    .locals 3
    .param p0, "message"    # Landroidx/webkit/WebMessageCompat;

    .line 103
    new-instance v0, Landroid/webkit/WebMessage;

    invoke-virtual {p0}, Landroidx/webkit/WebMessageCompat;->getData()Ljava/lang/String;

    move-result-object v1

    .line 104
    invoke-virtual {p0}, Landroidx/webkit/WebMessageCompat;->getPorts()[Landroidx/webkit/WebMessagePortCompat;

    move-result-object v2

    invoke-static {v2}, Landroidx/webkit/internal/WebMessagePortImpl;->compatToPorts([Landroidx/webkit/WebMessagePortCompat;)[Landroid/webkit/WebMessagePort;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Landroid/webkit/WebMessage;-><init>(Ljava/lang/String;[Landroid/webkit/WebMessagePort;)V

    .line 103
    return-object v0
.end method

.method public static createWebMessageChannel(Landroid/webkit/WebView;)[Landroid/webkit/WebMessagePort;
    .locals 1
    .param p0, "webView"    # Landroid/webkit/WebView;

    .line 181
    invoke-virtual {p0}, Landroid/webkit/WebView;->createWebMessageChannel()[Landroid/webkit/WebMessagePort;

    move-result-object v0

    return-object v0
.end method

.method public static createWebMessageCompat(Landroid/webkit/WebMessage;)Landroidx/webkit/WebMessageCompat;
    .locals 3
    .param p0, "webMessage"    # Landroid/webkit/WebMessage;

    .line 113
    new-instance v0, Landroidx/webkit/WebMessageCompat;

    invoke-virtual {p0}, Landroid/webkit/WebMessage;->getData()Ljava/lang/String;

    move-result-object v1

    .line 114
    invoke-virtual {p0}, Landroid/webkit/WebMessage;->getPorts()[Landroid/webkit/WebMessagePort;

    move-result-object v2

    invoke-static {v2}, Landroidx/webkit/internal/WebMessagePortImpl;->portsToCompat([Landroid/webkit/WebMessagePort;)[Landroidx/webkit/WebMessagePortCompat;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Landroidx/webkit/WebMessageCompat;-><init>(Ljava/lang/String;[Landroidx/webkit/WebMessagePortCompat;)V

    .line 113
    return-object v0
.end method

.method public static getDescription(Landroid/webkit/WebResourceError;)Ljava/lang/CharSequence;
    .locals 1
    .param p0, "webResourceError"    # Landroid/webkit/WebResourceError;

    .line 132
    invoke-virtual {p0}, Landroid/webkit/WebResourceError;->getDescription()Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method public static getErrorCode(Landroid/webkit/WebResourceError;)I
    .locals 1
    .param p0, "webResourceError"    # Landroid/webkit/WebResourceError;

    .line 122
    invoke-virtual {p0}, Landroid/webkit/WebResourceError;->getErrorCode()I

    move-result v0

    return v0
.end method

.method public static getOffscreenPreRaster(Landroid/webkit/WebSettings;)Z
    .locals 1
    .param p0, "webSettings"    # Landroid/webkit/WebSettings;

    .line 148
    invoke-virtual {p0}, Landroid/webkit/WebSettings;->getOffscreenPreRaster()Z

    move-result v0

    return v0
.end method

.method public static postMessage(Landroid/webkit/WebMessagePort;Landroid/webkit/WebMessage;)V
    .locals 0
    .param p0, "webMessagePort"    # Landroid/webkit/WebMessagePort;
    .param p1, "webMessage"    # Landroid/webkit/WebMessage;

    .line 52
    invoke-virtual {p0, p1}, Landroid/webkit/WebMessagePort;->postMessage(Landroid/webkit/WebMessage;)V

    .line 53
    return-void
.end method

.method public static postVisualStateCallback(Landroid/webkit/WebView;JLandroidx/webkit/WebViewCompat$VisualStateCallback;)V
    .locals 1
    .param p0, "webView"    # Landroid/webkit/WebView;
    .param p1, "requestId"    # J
    .param p3, "callback"    # Landroidx/webkit/WebViewCompat$VisualStateCallback;

    .line 158
    new-instance v0, Landroidx/webkit/internal/ApiHelperForM$3;

    invoke-direct {v0, p3}, Landroidx/webkit/internal/ApiHelperForM$3;-><init>(Landroidx/webkit/WebViewCompat$VisualStateCallback;)V

    invoke-virtual {p0, p1, p2, v0}, Landroid/webkit/WebView;->postVisualStateCallback(JLandroid/webkit/WebView$VisualStateCallback;)V

    .line 164
    return-void
.end method

.method public static postWebMessage(Landroid/webkit/WebView;Landroid/webkit/WebMessage;Landroid/net/Uri;)V
    .locals 0
    .param p0, "webView"    # Landroid/webkit/WebView;
    .param p1, "message"    # Landroid/webkit/WebMessage;
    .param p2, "targetOrigin"    # Landroid/net/Uri;

    .line 172
    invoke-virtual {p0, p1, p2}, Landroid/webkit/WebView;->postWebMessage(Landroid/webkit/WebMessage;Landroid/net/Uri;)V

    .line 173
    return-void
.end method

.method public static setOffscreenPreRaster(Landroid/webkit/WebSettings;Z)V
    .locals 0
    .param p0, "webSettings"    # Landroid/webkit/WebSettings;
    .param p1, "b"    # Z

    .line 140
    invoke-virtual {p0, p1}, Landroid/webkit/WebSettings;->setOffscreenPreRaster(Z)V

    .line 141
    return-void
.end method

.method public static setWebMessageCallback(Landroid/webkit/WebMessagePort;Landroidx/webkit/WebMessagePortCompat$WebMessageCallbackCompat;)V
    .locals 1
    .param p0, "frameworksImpl"    # Landroid/webkit/WebMessagePort;
    .param p1, "callback"    # Landroidx/webkit/WebMessagePortCompat$WebMessageCallbackCompat;

    .line 70
    new-instance v0, Landroidx/webkit/internal/ApiHelperForM$1;

    invoke-direct {v0, p1}, Landroidx/webkit/internal/ApiHelperForM$1;-><init>(Landroidx/webkit/WebMessagePortCompat$WebMessageCallbackCompat;)V

    invoke-virtual {p0, v0}, Landroid/webkit/WebMessagePort;->setWebMessageCallback(Landroid/webkit/WebMessagePort$WebMessageCallback;)V

    .line 77
    return-void
.end method

.method public static setWebMessageCallback(Landroid/webkit/WebMessagePort;Landroidx/webkit/WebMessagePortCompat$WebMessageCallbackCompat;Landroid/os/Handler;)V
    .locals 1
    .param p0, "frameworksImpl"    # Landroid/webkit/WebMessagePort;
    .param p1, "callback"    # Landroidx/webkit/WebMessagePortCompat$WebMessageCallbackCompat;
    .param p2, "handler"    # Landroid/os/Handler;

    .line 88
    new-instance v0, Landroidx/webkit/internal/ApiHelperForM$2;

    invoke-direct {v0, p1}, Landroidx/webkit/internal/ApiHelperForM$2;-><init>(Landroidx/webkit/WebMessagePortCompat$WebMessageCallbackCompat;)V

    invoke-virtual {p0, v0, p2}, Landroid/webkit/WebMessagePort;->setWebMessageCallback(Landroid/webkit/WebMessagePort$WebMessageCallback;Landroid/os/Handler;)V

    .line 95
    return-void
.end method
