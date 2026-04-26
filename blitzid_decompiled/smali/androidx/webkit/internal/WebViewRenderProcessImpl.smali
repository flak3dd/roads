.class public Landroidx/webkit/internal/WebViewRenderProcessImpl;
.super Landroidx/webkit/WebViewRenderProcess;
.source "WebViewRenderProcessImpl.java"


# static fields
.field private static final sFrameworkMap:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/webkit/WebViewRenderProcess;",
            "Landroidx/webkit/internal/WebViewRenderProcessImpl;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mBoundaryInterface:Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;

.field private mFrameworkObject:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/webkit/WebViewRenderProcess;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 39
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Landroidx/webkit/internal/WebViewRenderProcessImpl;->sFrameworkMap:Ljava/util/WeakHashMap;

    return-void
.end method

.method public constructor <init>(Landroid/webkit/WebViewRenderProcess;)V
    .locals 1
    .param p1, "frameworkRenderer"    # Landroid/webkit/WebViewRenderProcess;

    .line 46
    invoke-direct {p0}, Landroidx/webkit/WebViewRenderProcess;-><init>()V

    .line 47
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Landroidx/webkit/internal/WebViewRenderProcessImpl;->mFrameworkObject:Ljava/lang/ref/WeakReference;

    .line 48
    return-void
.end method

.method public constructor <init>(Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;)V
    .locals 0
    .param p1, "boundaryInterface"    # Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;

    .line 41
    invoke-direct {p0}, Landroidx/webkit/WebViewRenderProcess;-><init>()V

    .line 42
    iput-object p1, p0, Landroidx/webkit/internal/WebViewRenderProcessImpl;->mBoundaryInterface:Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;

    .line 43
    return-void
.end method

.method public static forFrameworkObject(Landroid/webkit/WebViewRenderProcess;)Landroidx/webkit/internal/WebViewRenderProcessImpl;
    .locals 3
    .param p0, "frameworkRenderer"    # Landroid/webkit/WebViewRenderProcess;

    .line 77
    sget-object v0, Landroidx/webkit/internal/WebViewRenderProcessImpl;->sFrameworkMap:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/webkit/internal/WebViewRenderProcessImpl;

    .line 78
    .local v1, "renderer":Landroidx/webkit/internal/WebViewRenderProcessImpl;
    if-eqz v1, :cond_0

    .line 79
    return-object v1

    .line 81
    :cond_0
    new-instance v2, Landroidx/webkit/internal/WebViewRenderProcessImpl;

    invoke-direct {v2, p0}, Landroidx/webkit/internal/WebViewRenderProcessImpl;-><init>(Landroid/webkit/WebViewRenderProcess;)V

    move-object v1, v2

    .line 82
    invoke-virtual {v0, p0, v1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 83
    return-object v1
.end method

.method public static forInvocationHandler(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/internal/WebViewRenderProcessImpl;
    .locals 2
    .param p0, "invocationHandler"    # Ljava/lang/reflect/InvocationHandler;

    .line 56
    const-class v0, Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;

    .line 57
    invoke-static {v0, p0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;

    .line 63
    .local v0, "boundaryInterface":Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;
    new-instance v1, Landroidx/webkit/internal/WebViewRenderProcessImpl$1;

    invoke-direct {v1, v0}, Landroidx/webkit/internal/WebViewRenderProcessImpl$1;-><init>(Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;)V

    invoke-interface {v0, v1}, Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;->getOrCreatePeer(Ljava/util/concurrent/Callable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/webkit/internal/WebViewRenderProcessImpl;

    return-object v1
.end method


# virtual methods
.method public terminate()Z
    .locals 3

    .line 88
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_VIEW_RENDERER_TERMINATE:Landroidx/webkit/internal/ApiFeature$Q;

    .line 89
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$Q;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 90
    iget-object v1, p0, Landroidx/webkit/internal/WebViewRenderProcessImpl;->mFrameworkObject:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/webkit/WebViewRenderProcess;

    .line 91
    .local v1, "renderer":Landroid/webkit/WebViewRenderProcess;
    if-eqz v1, :cond_0

    invoke-static {v1}, Landroidx/webkit/internal/ApiHelperForQ;->terminate(Landroid/webkit/WebViewRenderProcess;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return v2

    .line 92
    .end local v1    # "renderer":Landroid/webkit/WebViewRenderProcess;
    :cond_1
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 93
    iget-object v1, p0, Landroidx/webkit/internal/WebViewRenderProcessImpl;->mBoundaryInterface:Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/WebViewRendererBoundaryInterface;->terminate()Z

    move-result v1

    return v1

    .line 95
    :cond_2
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method
