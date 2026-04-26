.class public final Lcom/blitzid/app/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blitzid/app/MainActivity$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMainActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MainActivity.kt\ncom/blitzid/app/MainActivity\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,115:1\n1#2:116\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000>\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0011\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0018\u0000 \u00142\u00020\u0001:\u0001\u0014B\u0005\u00a2\u0006\u0002\u0010\u0002J\"\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000c2\u0008\u0010\u000e\u001a\u0004\u0018\u00010\u000fH\u0014J\u0008\u0010\u0010\u001a\u00020\nH\u0016J\u0012\u0010\u0011\u001a\u00020\n2\u0008\u0010\u0012\u001a\u0004\u0018\u00010\u0013H\u0015R\u001c\u0010\u0003\u001a\u0010\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00060\u0005\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082.\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/blitzid/app/MainActivity;",
        "Landroidx/appcompat/app/AppCompatActivity;",
        "()V",
        "fileUploadCallback",
        "Landroid/webkit/ValueCallback;",
        "",
        "Landroid/net/Uri;",
        "webView",
        "Landroid/webkit/WebView;",
        "onActivityResult",
        "",
        "requestCode",
        "",
        "resultCode",
        "data",
        "Landroid/content/Intent;",
        "onBackPressed",
        "onCreate",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "Companion",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final Companion:Lcom/blitzid/app/MainActivity$Companion;

.field private static final FILE_CHOOSER_REQUEST:I = 0x3e9


# instance fields
.field private fileUploadCallback:Landroid/webkit/ValueCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/webkit/ValueCallback<",
            "[",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation
.end field

.field private webView:Landroid/webkit/WebView;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/blitzid/app/MainActivity$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/blitzid/app/MainActivity$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/blitzid/app/MainActivity;->Companion:Lcom/blitzid/app/MainActivity$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method public static final synthetic access$getFileUploadCallback$p(Lcom/blitzid/app/MainActivity;)Landroid/webkit/ValueCallback;
    .locals 1
    .param p0, "$this"    # Lcom/blitzid/app/MainActivity;

    .line 18
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->fileUploadCallback:Landroid/webkit/ValueCallback;

    return-object v0
.end method

.method public static final synthetic access$setFileUploadCallback$p(Lcom/blitzid/app/MainActivity;Landroid/webkit/ValueCallback;)V
    .locals 0
    .param p0, "$this"    # Lcom/blitzid/app/MainActivity;
    .param p1, "<set-?>"    # Landroid/webkit/ValueCallback;

    .line 18
    iput-object p1, p0, Lcom/blitzid/app/MainActivity;->fileUploadCallback:Landroid/webkit/ValueCallback;

    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 5
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .line 97
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 98
    const/16 v0, 0x3e9

    if-ne p1, v0, :cond_3

    .line 99
    const/4 v0, -0x1

    const/4 v1, 0x0

    if-ne p2, v0, :cond_1

    .line 100
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 116
    .local v0, "it":Landroid/net/Uri;
    const/4 v2, 0x0

    .line 100
    .local v2, "$i$a$-let-MainActivity$onActivityResult$result$1":I
    const/4 v3, 0x1

    new-array v3, v3, [Landroid/net/Uri;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    .end local v0    # "it":Landroid/net/Uri;
    .end local v2    # "$i$a$-let-MainActivity$onActivityResult$result$1":I
    goto :goto_0

    :cond_0
    move-object v3, v1

    goto :goto_0

    .line 101
    :cond_1
    move-object v3, v1

    .line 99
    :goto_0
    move-object v0, v3

    .line 102
    .local v0, "result":[Landroid/net/Uri;
    iget-object v2, p0, Lcom/blitzid/app/MainActivity;->fileUploadCallback:Landroid/webkit/ValueCallback;

    if-eqz v2, :cond_2

    invoke-interface {v2, v0}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 103
    :cond_2
    iput-object v1, p0, Lcom/blitzid/app/MainActivity;->fileUploadCallback:Landroid/webkit/ValueCallback;

    .line 105
    .end local v0    # "result":[Landroid/net/Uri;
    :cond_3
    return-void
.end method

.method public onBackPressed()V
    .locals 3

    .line 108
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    const/4 v1, 0x0

    const-string v2, "webView"

    if-nez v0, :cond_0

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 109
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_1

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    move-object v1, v0

    :goto_0
    invoke-virtual {v1}, Landroid/webkit/WebView;->goBack()V

    goto :goto_1

    .line 111
    :cond_2
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onBackPressed()V

    .line 113
    :goto_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 7
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 29
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 32
    invoke-virtual {p0}, Lcom/blitzid/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 33
    nop

    .line 32
    const/16 v1, 0x500

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 36
    invoke-virtual {p0}, Lcom/blitzid/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 38
    new-instance v0, Landroid/webkit/WebView;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    .line 39
    check-cast v0, Landroid/view/View;

    invoke-virtual {p0, v0}, Lcom/blitzid/app/MainActivity;->setContentView(Landroid/view/View;)V

    .line 41
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    const/4 v2, 0x0

    const-string v3, "webView"

    if-nez v0, :cond_0

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_0
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    .local v0, "$this$onCreate_u24lambda_u240":Landroid/webkit/WebSettings;
    const/4 v4, 0x0

    .line 42
    .local v4, "$i$a$-apply-MainActivity$onCreate$1":I
    const/4 v5, 0x1

    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 43
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 44
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 45
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 46
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    .line 47
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V

    .line 48
    const/4 v6, -0x1

    invoke-virtual {v0, v6}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 49
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V

    .line 50
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 51
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 52
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V

    .line 53
    invoke-virtual {v0, v5}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V

    .line 54
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    .line 55
    nop

    .line 41
    .end local v0    # "$this$onCreate_u24lambda_u240":Landroid/webkit/WebSettings;
    .end local v4    # "$i$a$-apply-MainActivity$onCreate$1":I
    nop

    .line 57
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_1

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_1
    new-instance v1, Lcom/blitzid/app/MainActivity$onCreate$2;

    invoke-direct {v1, p0}, Lcom/blitzid/app/MainActivity$onCreate$2;-><init>(Lcom/blitzid/app/MainActivity;)V

    check-cast v1, Landroid/webkit/WebViewClient;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 73
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_2

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_2
    new-instance v1, Lcom/blitzid/app/MainActivity$onCreate$3;

    invoke-direct {v1, p0}, Lcom/blitzid/app/MainActivity$onCreate$3;-><init>(Lcom/blitzid/app/MainActivity;)V

    check-cast v1, Landroid/webkit/WebChromeClient;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 93
    iget-object v0, p0, Lcom/blitzid/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_3

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    move-object v2, v0

    :goto_0
    const-string v0, "file:///android_asset/web/index.html"

    invoke-virtual {v2, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 94
    return-void
.end method
