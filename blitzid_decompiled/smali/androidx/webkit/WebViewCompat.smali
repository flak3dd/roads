.class public Landroidx/webkit/WebViewCompat;
.super Ljava/lang/Object;
.source "WebViewCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/webkit/WebViewCompat$VisualStateCallback;,
        Landroidx/webkit/WebViewCompat$WebMessageListener;
    }
.end annotation


# static fields
.field private static final EMPTY_URI:Landroid/net/Uri;

.field private static final WILDCARD_URI:Landroid/net/Uri;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 65
    const-string v0, "*"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Landroidx/webkit/WebViewCompat;->WILDCARD_URI:Landroid/net/Uri;

    .line 66
    const-string v0, ""

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Landroidx/webkit/WebViewCompat;->EMPTY_URI:Landroid/net/Uri;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addDocumentStartJavaScript(Landroid/webkit/WebView;Ljava/lang/String;Ljava/util/Set;)Landroidx/webkit/ScriptHandler;
    .locals 3
    .param p0, "webview"    # Landroid/webkit/WebView;
    .param p1, "script"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Landroidx/webkit/ScriptHandler;"
        }
    .end annotation

    .line 820
    .local p2, "allowedOriginRules":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->DOCUMENT_START_SCRIPT:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 821
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 822
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    .line 823
    invoke-interface {p2, v2}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    invoke-virtual {v1, p1, v2}, Landroidx/webkit/internal/WebViewProviderAdapter;->addDocumentStartJavaScript(Ljava/lang/String;[Ljava/lang/String;)Landroidx/webkit/internal/ScriptHandlerImpl;

    move-result-object v1

    .line 822
    return-object v1

    .line 825
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static addWebMessageListener(Landroid/webkit/WebView;Ljava/lang/String;Ljava/util/Set;Landroidx/webkit/WebViewCompat$WebMessageListener;)V
    .locals 3
    .param p0, "webView"    # Landroid/webkit/WebView;
    .param p1, "jsObjectName"    # Ljava/lang/String;
    .param p3, "listener"    # Landroidx/webkit/WebViewCompat$WebMessageListener;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;",
            "Landroidx/webkit/WebViewCompat$WebMessageListener;",
            ")V"
        }
    .end annotation

    .line 741
    .local p2, "allowedOriginRules":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_MESSAGE_LISTENER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 742
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 743
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    .line 744
    invoke-interface {p2, v2}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    .line 743
    invoke-virtual {v1, p1, v2, p3}, Landroidx/webkit/internal/WebViewProviderAdapter;->addWebMessageListener(Ljava/lang/String;[Ljava/lang/String;Landroidx/webkit/WebViewCompat$WebMessageListener;)V

    .line 748
    return-void

    .line 746
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method private static checkThread(Landroid/webkit/WebView;)V
    .locals 4
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 1143
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_1

    .line 1144
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForP;->getWebViewLooper(Landroid/webkit/WebView;)Landroid/os/Looper;

    move-result-object v0

    .line 1145
    .local v0, "webViewLooper":Landroid/os/Looper;
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_0

    .line 1153
    .end local v0    # "webViewLooper":Landroid/os/Looper;
    goto :goto_0

    .line 1146
    .restart local v0    # "webViewLooper":Landroid/os/Looper;
    :cond_0
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "A WebView method was called on thread \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1147
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'. All WebView methods must be called on the same thread. (Expected Looper "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " called on "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1150
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", FYI main Looper is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 1155
    .end local v0    # "webViewLooper":Landroid/os/Looper;
    :cond_1
    :try_start_0
    const-class v0, Landroid/webkit/WebView;

    const-string v1, "checkThread"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1156
    .local v0, "checkThreadMethod":Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 1159
    new-array v1, v2, [Ljava/lang/Object;

    invoke-virtual {v0, p0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1166
    nop

    .line 1168
    .end local v0    # "checkThreadMethod":Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1164
    :catch_0
    move-exception v0

    .line 1165
    .local v0, "e":Ljava/lang/reflect/InvocationTargetException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 1162
    .end local v0    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_1
    move-exception v0

    .line 1163
    .local v0, "e":Ljava/lang/IllegalAccessException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 1160
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v0

    .line 1161
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method private static createProvider(Landroid/webkit/WebView;)Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;
    .locals 1
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 1138
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v0

    invoke-interface {v0, p0}, Landroidx/webkit/internal/WebViewProviderFactory;->createWebView(Landroid/webkit/WebView;)Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    move-result-object v0

    return-object v0
.end method

.method public static createWebMessageChannel(Landroid/webkit/WebView;)[Landroidx/webkit/WebMessagePortCompat;
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 463
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->CREATE_WEB_MESSAGE_CHANNEL:Landroidx/webkit/internal/ApiFeature$M;

    .line 464
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$M;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$M;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 465
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForM;->createWebMessageChannel(Landroid/webkit/WebView;)[Landroid/webkit/WebMessagePort;

    move-result-object v1

    invoke-static {v1}, Landroidx/webkit/internal/WebMessagePortImpl;->portsToCompat([Landroid/webkit/WebMessagePort;)[Landroidx/webkit/WebMessagePortCompat;

    move-result-object v1

    return-object v1

    .line 466
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$M;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 467
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewProviderAdapter;->createWebMessageChannel()[Landroidx/webkit/WebMessagePortCompat;

    move-result-object v1

    return-object v1

    .line 469
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static getCurrentLoadedWebViewPackage()Landroid/content/pm/PackageInfo;
    .locals 2

    .line 371
    nop

    .line 375
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 376
    invoke-static {}, Landroidx/webkit/internal/ApiHelperForO;->getCurrentWebViewPackage()Landroid/content/pm/PackageInfo;

    move-result-object v0

    return-object v0

    .line 379
    :cond_0
    :try_start_0
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getLoadedWebViewPackageInfo()Landroid/content/pm/PackageInfo;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 380
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    .line 384
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getCurrentWebViewPackage(Landroid/content/Context;)Landroid/content/pm/PackageInfo;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .line 349
    nop

    .line 353
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getCurrentLoadedWebViewPackage()Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 354
    .local v0, "info":Landroid/content/pm/PackageInfo;
    if-eqz v0, :cond_0

    return-object v0

    .line 359
    :cond_0
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getNotYetLoadedWebViewPackageInfo(Landroid/content/Context;)Landroid/content/pm/PackageInfo;

    move-result-object v1

    return-object v1
.end method

.method private static getFactory()Landroidx/webkit/internal/WebViewProviderFactory;
    .locals 1

    .line 1134
    invoke-static {}, Landroidx/webkit/internal/WebViewGlueCommunicator;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v0

    return-object v0
.end method

.method private static getLoadedWebViewPackageInfo()Landroid/content/pm/PackageInfo;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;,
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/reflect/InvocationTargetException;,
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 395
    const-string v0, "android.webkit.WebViewFactory"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 396
    .local v0, "webViewFactoryClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Class;

    const-string v3, "getLoadedPackageInfo"

    invoke-virtual {v0, v3, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    .line 397
    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/pm/PackageInfo;

    .line 396
    return-object v1
.end method

.method private static getNotYetLoadedWebViewPackageInfo(Landroid/content/Context;)Landroid/content/pm/PackageInfo;
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .line 409
    nop

    .line 416
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "android.webkit.WebViewUpdateService"

    .line 417
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 418
    .local v1, "webviewUpdateServiceClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v2, "getCurrentWebViewPackageName"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v4, v3, [Ljava/lang/Object;

    .line 419
    invoke-virtual {v2, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1

    .line 429
    .end local v1    # "webviewUpdateServiceClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local v2, "webviewPackageName":Ljava/lang/String;
    nop

    .line 430
    if-nez v2, :cond_0

    return-object v0

    .line 431
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 433
    .local v1, "pm":Landroid/content/pm/PackageManager;
    :try_start_1
    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    .line 434
    :catch_0
    move-exception v3

    .line 435
    .local v3, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    return-object v0

    .line 427
    .end local v1    # "pm":Landroid/content/pm/PackageManager;
    .end local v2    # "webviewPackageName":Ljava/lang/String;
    .end local v3    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :catch_1
    move-exception v1

    .line 428
    .local v1, "e":Ljava/lang/NoSuchMethodException;
    return-object v0

    .line 425
    .end local v1    # "e":Ljava/lang/NoSuchMethodException;
    :catch_2
    move-exception v1

    .line 426
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    return-object v0

    .line 423
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_3
    move-exception v1

    .line 424
    .local v1, "e":Ljava/lang/IllegalAccessException;
    return-object v0

    .line 421
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_4
    move-exception v1

    .line 422
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    return-object v0
.end method

.method public static getProfile(Landroid/webkit/WebView;)Landroidx/webkit/Profile;
    .locals 2
    .param p0, "webView"    # Landroid/webkit/WebView;

    .line 1125
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 1126
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1127
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewProviderAdapter;->getProfile()Landroidx/webkit/Profile;

    move-result-object v1

    return-object v1

    .line 1129
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method private static getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 440
    new-instance v0, Landroidx/webkit/internal/WebViewProviderAdapter;

    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->createProvider(Landroid/webkit/WebView;)Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/webkit/internal/WebViewProviderAdapter;-><init>(Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;)V

    return-object v0
.end method

.method public static getSafeBrowsingPrivacyPolicyUrl()Landroid/net/Uri;
    .locals 2

    .line 321
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->SAFE_BROWSING_PRIVACY_POLICY_URL:Landroidx/webkit/internal/ApiFeature$O_MR1;

    .line 323
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$O_MR1;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 324
    invoke-static {}, Landroidx/webkit/internal/ApiHelperForOMR1;->getSafeBrowsingPrivacyPolicyUrl()Landroid/net/Uri;

    move-result-object v1

    return-object v1

    .line 325
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 326
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v1

    invoke-interface {v1}, Landroidx/webkit/internal/WebViewProviderFactory;->getStatics()Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;

    move-result-object v1

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;->getSafeBrowsingPrivacyPolicyUrl()Landroid/net/Uri;

    move-result-object v1

    return-object v1

    .line 328
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static getVariationsHeader()Ljava/lang/String;
    .locals 2

    .line 1067
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->GET_VARIATIONS_HEADER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 1068
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1069
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v1

    invoke-interface {v1}, Landroidx/webkit/internal/WebViewProviderFactory;->getStatics()Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;

    move-result-object v1

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;->getVariationsHeader()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 1071
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static getWebChromeClient(Landroid/webkit/WebView;)Landroid/webkit/WebChromeClient;
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 865
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->GET_WEB_CHROME_CLIENT:Landroidx/webkit/internal/ApiFeature$O;

    .line 866
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$O;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 867
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForO;->getWebChromeClient(Landroid/webkit/WebView;)Landroid/webkit/WebChromeClient;

    move-result-object v1

    return-object v1

    .line 868
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 869
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewProviderAdapter;->getWebChromeClient()Landroid/webkit/WebChromeClient;

    move-result-object v1

    return-object v1

    .line 871
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static getWebViewClient(Landroid/webkit/WebView;)Landroid/webkit/WebViewClient;
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 842
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->GET_WEB_VIEW_CLIENT:Landroidx/webkit/internal/ApiFeature$O;

    .line 843
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$O;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 844
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForO;->getWebViewClient(Landroid/webkit/WebView;)Landroid/webkit/WebViewClient;

    move-result-object v1

    return-object v1

    .line 845
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 846
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewProviderAdapter;->getWebViewClient()Landroid/webkit/WebViewClient;

    move-result-object v1

    return-object v1

    .line 848
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static getWebViewRenderProcess(Landroid/webkit/WebView;)Landroidx/webkit/WebViewRenderProcess;
    .locals 3
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 899
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->GET_WEB_VIEW_RENDERER:Landroidx/webkit/internal/ApiFeature$Q;

    .line 900
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$Q;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 901
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForQ;->getWebViewRenderProcess(Landroid/webkit/WebView;)Landroid/webkit/WebViewRenderProcess;

    move-result-object v1

    .line 903
    .local v1, "renderer":Landroid/webkit/WebViewRenderProcess;
    if-eqz v1, :cond_0

    invoke-static {v1}, Landroidx/webkit/internal/WebViewRenderProcessImpl;->forFrameworkObject(Landroid/webkit/WebViewRenderProcess;)Landroidx/webkit/internal/WebViewRenderProcessImpl;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return-object v2

    .line 904
    .end local v1    # "renderer":Landroid/webkit/WebViewRenderProcess;
    :cond_1
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 905
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewProviderAdapter;->getWebViewRenderProcess()Landroidx/webkit/WebViewRenderProcess;

    move-result-object v1

    return-object v1

    .line 907
    :cond_2
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static getWebViewRenderProcessClient(Landroid/webkit/WebView;)Landroidx/webkit/WebViewRenderProcessClient;
    .locals 3
    .param p0, "webview"    # Landroid/webkit/WebView;

    .line 1014
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE:Landroidx/webkit/internal/ApiFeature$Q;

    .line 1016
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$Q;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1017
    nop

    .line 1018
    invoke-static {p0}, Landroidx/webkit/internal/ApiHelperForQ;->getWebViewRenderProcessClient(Landroid/webkit/WebView;)Landroid/webkit/WebViewRenderProcessClient;

    move-result-object v1

    .line 1019
    .local v1, "renderer":Landroid/webkit/WebViewRenderProcessClient;
    if-eqz v1, :cond_1

    instance-of v2, v1, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;

    if-nez v2, :cond_0

    goto :goto_0

    .line 1023
    :cond_0
    move-object v2, v1

    check-cast v2, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;

    .line 1024
    invoke-virtual {v2}, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;->getFrameworkRenderProcessClient()Landroidx/webkit/WebViewRenderProcessClient;

    move-result-object v2

    .line 1023
    return-object v2

    .line 1021
    :cond_1
    :goto_0
    const/4 v2, 0x0

    return-object v2

    .line 1025
    .end local v1    # "renderer":Landroid/webkit/WebViewRenderProcessClient;
    :cond_2
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1026
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewProviderAdapter;->getWebViewRenderProcessClient()Landroidx/webkit/WebViewRenderProcessClient;

    move-result-object v1

    return-object v1

    .line 1028
    :cond_3
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static isMultiProcessEnabled()Z
    .locals 2

    .line 1044
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROCESS:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 1045
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1046
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v1

    invoke-interface {v1}, Landroidx/webkit/internal/WebViewProviderFactory;->getStatics()Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;

    move-result-object v1

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;->isMultiProcessEnabled()Z

    move-result v1

    return v1

    .line 1048
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static postVisualStateCallback(Landroid/webkit/WebView;JLandroidx/webkit/WebViewCompat$VisualStateCallback;)V
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;
    .param p1, "requestId"    # J
    .param p3, "callback"    # Landroidx/webkit/WebViewCompat$VisualStateCallback;

    .line 171
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->VISUAL_STATE_CALLBACK:Landroidx/webkit/internal/ApiFeature$M;

    .line 172
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$M;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$M;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 173
    invoke-static {p0, p1, p2, p3}, Landroidx/webkit/internal/ApiHelperForM;->postVisualStateCallback(Landroid/webkit/WebView;JLandroidx/webkit/WebViewCompat$VisualStateCallback;)V

    goto :goto_0

    .line 174
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$M;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 175
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->checkThread(Landroid/webkit/WebView;)V

    .line 176
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3}, Landroidx/webkit/internal/WebViewProviderAdapter;->insertVisualStateCallback(JLandroidx/webkit/WebViewCompat$VisualStateCallback;)V

    .line 180
    :goto_0
    return-void

    .line 178
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static postWebMessage(Landroid/webkit/WebView;Landroidx/webkit/WebMessageCompat;Landroid/net/Uri;)V
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;
    .param p1, "message"    # Landroidx/webkit/WebMessageCompat;
    .param p2, "targetOrigin"    # Landroid/net/Uri;

    .line 511
    sget-object v0, Landroidx/webkit/WebViewCompat;->WILDCARD_URI:Landroid/net/Uri;

    invoke-virtual {v0, p2}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 512
    sget-object p2, Landroidx/webkit/WebViewCompat;->EMPTY_URI:Landroid/net/Uri;

    .line 515
    :cond_0
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->POST_WEB_MESSAGE:Landroidx/webkit/internal/ApiFeature$M;

    .line 517
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$M;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$M;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Landroidx/webkit/WebMessageCompat;->getType()I

    move-result v1

    if-nez v1, :cond_1

    .line 518
    nop

    .line 519
    invoke-static {p1}, Landroidx/webkit/internal/WebMessagePortImpl;->compatToFrameworkMessage(Landroidx/webkit/WebMessageCompat;)Landroid/webkit/WebMessage;

    move-result-object v1

    .line 518
    invoke-static {p0, v1, p2}, Landroidx/webkit/internal/ApiHelperForM;->postWebMessage(Landroid/webkit/WebView;Landroid/webkit/WebMessage;Landroid/net/Uri;)V

    goto :goto_0

    .line 520
    :cond_1
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$M;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 521
    invoke-virtual {p1}, Landroidx/webkit/WebMessageCompat;->getType()I

    move-result v1

    invoke-static {v1}, Landroidx/webkit/internal/WebMessageAdapter;->isMessagePayloadTypeSupportedByWebView(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 522
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Landroidx/webkit/internal/WebViewProviderAdapter;->postWebMessage(Landroidx/webkit/WebMessageCompat;Landroid/net/Uri;)V

    .line 526
    :goto_0
    return-void

    .line 524
    :cond_2
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static removeWebMessageListener(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;
    .param p1, "jsObjectName"    # Ljava/lang/String;

    .line 772
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_MESSAGE_LISTENER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 773
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 774
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroidx/webkit/internal/WebViewProviderAdapter;->removeWebMessageListener(Ljava/lang/String;)V

    .line 778
    return-void

    .line 776
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static setProfile(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 2
    .param p0, "webView"    # Landroid/webkit/WebView;
    .param p1, "profileName"    # Ljava/lang/String;

    .line 1100
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->MULTI_PROFILE:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 1101
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$NoFramework;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1102
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroidx/webkit/internal/WebViewProviderAdapter;->setProfileWithName(Ljava/lang/String;)V

    .line 1106
    return-void

    .line 1104
    :cond_0
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static setSafeBrowsingAllowlist(Ljava/util/Set;Landroid/webkit/ValueCallback;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/webkit/ValueCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .line 251
    .local p0, "hosts":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .local p1, "callback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Boolean;>;"
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->SAFE_BROWSING_ALLOWLIST_PREFERRED_TO_PREFERRED:Landroidx/webkit/internal/ApiFeature$O_MR1;

    .line 253
    .local v0, "preferredFeature":Landroidx/webkit/internal/ApiFeature$O_MR1;
    sget-object v1, Landroidx/webkit/internal/WebViewFeatureInternal;->SAFE_BROWSING_ALLOWLIST_PREFERRED_TO_DEPRECATED:Landroidx/webkit/internal/ApiFeature$O_MR1;

    .line 255
    .local v1, "deprecatedFeature":Landroidx/webkit/internal/ApiFeature$O_MR1;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByWebView()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 256
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v2

    invoke-interface {v2}, Landroidx/webkit/internal/WebViewProviderFactory;->getStatics()Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;

    move-result-object v2

    invoke-interface {v2, p0, p1}, Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;->setSafeBrowsingAllowlist(Ljava/util/Set;Landroid/webkit/ValueCallback;)V

    .line 257
    return-void

    .line 259
    :cond_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, p0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 260
    .local v2, "hostsList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-virtual {v1}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByFramework()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 261
    invoke-static {v2, p1}, Landroidx/webkit/internal/ApiHelperForOMR1;->setSafeBrowsingWhitelist(Ljava/util/List;Landroid/webkit/ValueCallback;)V

    goto :goto_0

    .line 262
    :cond_1
    invoke-virtual {v1}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByWebView()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 263
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v3

    invoke-interface {v3}, Landroidx/webkit/internal/WebViewProviderFactory;->getStatics()Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;

    move-result-object v3

    invoke-interface {v3, v2, p1}, Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;->setSafeBrowsingWhitelist(Ljava/util/List;Landroid/webkit/ValueCallback;)V

    .line 267
    :goto_0
    return-void

    .line 265
    :cond_2
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v3

    throw v3
.end method

.method public static setSafeBrowsingWhitelist(Ljava/util/List;Landroid/webkit/ValueCallback;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/webkit/ValueCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 304
    .local p0, "hosts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p1, "callback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Boolean;>;"
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0, p0}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    invoke-static {v0, p1}, Landroidx/webkit/WebViewCompat;->setSafeBrowsingAllowlist(Ljava/util/Set;Landroid/webkit/ValueCallback;)V

    .line 305
    return-void
.end method

.method public static setWebViewRenderProcessClient(Landroid/webkit/WebView;Landroidx/webkit/WebViewRenderProcessClient;)V
    .locals 3
    .param p0, "webview"    # Landroid/webkit/WebView;
    .param p1, "webViewRenderProcessClient"    # Landroidx/webkit/WebViewRenderProcessClient;

    .line 987
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE:Landroidx/webkit/internal/ApiFeature$Q;

    .line 989
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$Q;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 990
    invoke-static {p0, p1}, Landroidx/webkit/internal/ApiHelperForQ;->setWebViewRenderProcessClient(Landroid/webkit/WebView;Landroidx/webkit/WebViewRenderProcessClient;)V

    goto :goto_0

    .line 991
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 992
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p1}, Landroidx/webkit/internal/WebViewProviderAdapter;->setWebViewRenderProcessClient(Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V

    .line 996
    :goto_0
    return-void

    .line 994
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static setWebViewRenderProcessClient(Landroid/webkit/WebView;Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V
    .locals 2
    .param p0, "webview"    # Landroid/webkit/WebView;
    .param p1, "executor"    # Ljava/util/concurrent/Executor;
    .param p2, "webViewRenderProcessClient"    # Landroidx/webkit/WebViewRenderProcessClient;

    .line 950
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE:Landroidx/webkit/internal/ApiFeature$Q;

    .line 952
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$Q;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 953
    invoke-static {p0, p1, p2}, Landroidx/webkit/internal/ApiHelperForQ;->setWebViewRenderProcessClient(Landroid/webkit/WebView;Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V

    goto :goto_0

    .line 955
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$Q;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 956
    invoke-static {p0}, Landroidx/webkit/WebViewCompat;->getProvider(Landroid/webkit/WebView;)Landroidx/webkit/internal/WebViewProviderAdapter;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Landroidx/webkit/internal/WebViewProviderAdapter;->setWebViewRenderProcessClient(Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V

    .line 961
    :goto_0
    return-void

    .line 959
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method

.method public static startSafeBrowsing(Landroid/content/Context;Landroid/webkit/ValueCallback;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/webkit/ValueCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .line 209
    .local p1, "callback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Boolean;>;"
    sget-object v0, Landroidx/webkit/internal/WebViewFeatureInternal;->START_SAFE_BROWSING:Landroidx/webkit/internal/ApiFeature$O_MR1;

    .line 210
    .local v0, "feature":Landroidx/webkit/internal/ApiFeature$O_MR1;
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByFramework()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 211
    invoke-static {p0, p1}, Landroidx/webkit/internal/ApiHelperForOMR1;->startSafeBrowsing(Landroid/content/Context;Landroid/webkit/ValueCallback;)V

    goto :goto_0

    .line 212
    :cond_0
    invoke-virtual {v0}, Landroidx/webkit/internal/ApiFeature$O_MR1;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 213
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getFactory()Landroidx/webkit/internal/WebViewProviderFactory;

    move-result-object v1

    invoke-interface {v1}, Landroidx/webkit/internal/WebViewProviderFactory;->getStatics()Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;

    move-result-object v1

    invoke-interface {v1, p0, p1}, Lorg/chromium/support_lib_boundary/StaticsBoundaryInterface;->initSafeBrowsing(Landroid/content/Context;Landroid/webkit/ValueCallback;)V

    .line 217
    :goto_0
    return-void

    .line 215
    :cond_1
    invoke-static {}, Landroidx/webkit/internal/WebViewFeatureInternal;->getUnsupportedOperationException()Ljava/lang/UnsupportedOperationException;

    move-result-object v1

    throw v1
.end method
