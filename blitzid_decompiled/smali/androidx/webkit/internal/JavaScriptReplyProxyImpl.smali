.class public Landroidx/webkit/internal/JavaScriptReplyProxyImpl;
.super Landroidx/webkit/JavaScriptReplyProxy;
.source "JavaScriptReplyProxyImpl.java"


# instance fields
.field private mBoundaryInterface:Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;


# direct methods
.method public constructor <init>(Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;)V
    .locals 0
    .param p1, "boundaryInterface"    # Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;

    .line 35
    invoke-direct {p0}, Landroidx/webkit/JavaScriptReplyProxy;-><init>()V

    .line 36
    iput-object p1, p0, Landroidx/webkit/internal/JavaScriptReplyProxyImpl;->mBoundaryInterface:Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;

    .line 37
    return-void
.end method

.method public static forInvocationHandler(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/internal/JavaScriptReplyProxyImpl;
    .locals 2
    .param p0, "invocationHandler"    # Ljava/lang/reflect/InvocationHandler;

    .line 45
    const-class v0, Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;

    .line 46
    invoke-static {v0, p0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;

    .line 48
    .local v0, "boundaryInterface":Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;
    new-instance v1, Landroidx/webkit/internal/JavaScriptReplyProxyImpl$1;

    invoke-direct {v1, v0}, Landroidx/webkit/internal/JavaScriptReplyProxyImpl$1;-><init>(Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;)V

    invoke-interface {v0, v1}, Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;->getOrCreatePeer(Ljava/util/concurrent/Callable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/webkit/internal/JavaScriptReplyProxyImpl;

    return-object v1
.end method


# virtual methods
.method public postMessage(Ljava/lang/String;)V
    .locals 2
    .param p1, "message"    # Ljava/lang/String;

    .line 59
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_MESSAGE_LISTENER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 60
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 61
    iget-object v1, p0, Landroidx/webkit/internal/JavaScriptReplyProxyImpl;->mBoundaryInterface:Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;

    invoke-interface {v1, p1}, Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;->postMessage(Ljava/lang/String;)V

    .line 65
    return-void

    .line 63
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public postMessage([B)V
    .locals 3
    .param p1, "arrayBuffer"    # [B

    .line 70
    const-string v0, "ArrayBuffer must be non-null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 71
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_MESSAGE_ARRAY_BUFFER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 72
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 73
    iget-object v1, p0, Landroidx/webkit/internal/JavaScriptReplyProxyImpl;->mBoundaryInterface:Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;

    new-instance v2, Landroidx/webkit/internal/WebMessagePayloadAdapter;

    invoke-direct {v2, p1}, Landroidx/webkit/internal/WebMessagePayloadAdapter;-><init>([B)V

    .line 74
    invoke-static {v2}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v2

    .line 73
    invoke-interface {v1, v2}, Lorg/chromium/support_lib_boundary/JsReplyProxyBoundaryInterface;->postMessageWithPayload(Ljava/lang/reflect/InvocationHandler;)V

    .line 78
    return-void

    .line 76
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method
