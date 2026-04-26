.class public Landroidx/webkit/internal/ProfileStoreImpl;
.super Ljava/lang/Object;
.source "ProfileStoreImpl.java"

# interfaces
.implements Landroidx/webkit/ProfileStore;


# static fields
.field private static sInstance:Landroidx/webkit/ProfileStore;


# instance fields
.field private final mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/webkit/internal/ProfileStoreImpl;->mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    .line 45
    return-void
.end method

.method private constructor <init>(Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;)V
    .locals 0
    .param p1, "profileStoreImpl"    # Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    iput-object p1, p0, Landroidx/webkit/internal/ProfileStoreImpl;->mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    .line 41
    return-void
.end method

.method public static getInstance()Landroidx/webkit/ProfileStore;
    .locals 2

    .line 54
    sget-object v0, Landroidx/webkit/internal/ProfileStoreImpl;->sInstance:Landroidx/webkit/ProfileStore;

    if-nez v0, :cond_0

    .line 55
    new-instance v0, Landroidx/webkit/internal/ProfileStoreImpl;

    .line 56
    invoke-static {}, Landroidx/webkit/internal/WebViewGlueCommunicator;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v1

    invoke-interface {v1}, Landroidx/webkit/internal/WebViewProviderFactory;->getProfileStore()Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/webkit/internal/ProfileStoreImpl;-><init>(Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;)V

    sput-object v0, Landroidx/webkit/internal/ProfileStoreImpl;->sInstance:Landroidx/webkit/ProfileStore;

    .line 58
    :cond_0
    sget-object v0, Landroidx/webkit/internal/ProfileStoreImpl;->sInstance:Landroidx/webkit/ProfileStore;

    return-object v0
.end method


# virtual methods
.method public deleteProfile(Ljava/lang/String;)Z
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .line 103
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 104
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 105
    iget-object v1, p0, Landroidx/webkit/internal/ProfileStoreImpl;->mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    invoke-interface {v1, p1}, Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;->deleteProfile(Ljava/lang/String;)Z

    move-result v1

    return v1

    .line 107
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getAllProfileNames()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 93
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 94
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 95
    iget-object v1, p0, Landroidx/webkit/internal/ProfileStoreImpl;->mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;->getAllProfileNames()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 97
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getOrCreateProfile(Ljava/lang/String;)Landroidx/webkit/Profile;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .line 64
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 65
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 66
    new-instance v1, Landroidx/webkit/internal/ProfileImpl;

    const-class v2, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    iget-object v3, p0, Landroidx/webkit/internal/ProfileStoreImpl;->mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    .line 67
    invoke-interface {v3, p1}, Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;->getOrCreateProfile(Ljava/lang/String;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v3

    .line 66
    invoke-static {v2, v3}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-direct {v1, v2}, Landroidx/webkit/internal/ProfileImpl;-><init>(Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;)V

    return-object v1

    .line 69
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public getProfile(Ljava/lang/String;)Landroidx/webkit/Profile;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .line 76
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 77
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 78
    iget-object v1, p0, Landroidx/webkit/internal/ProfileStoreImpl;->mProfileStoreImpl:Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;

    invoke-interface {v1, p1}, Lorg/chromium/support_lib_boundary/ProfileStoreBoundaryInterface;->getProfile(Ljava/lang/String;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    .line 79
    .local v1, "profileBoundaryInterface":Ljava/lang/reflect/InvocationHandler;
    if-eqz v1, :cond_0

    .line 80
    new-instance v2, Landroidx/webkit/internal/ProfileImpl;

    const-class v3, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-static {v3, v1}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    invoke-direct {v2, v3}, Landroidx/webkit/internal/ProfileImpl;-><init>(Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;)V

    return-object v2

    .line 83
    :cond_0
    const/4 v2, 0x0

    return-object v2

    .line 86
    .end local v1    # "profileBoundaryInterface":Ljava/lang/reflect/InvocationHandler;
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method
