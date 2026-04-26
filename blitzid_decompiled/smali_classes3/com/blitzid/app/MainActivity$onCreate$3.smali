.class public final Lcom/blitzid/app/MainActivity$onCreate$3;
.super Landroid/webkit/WebChromeClient;
.source "MainActivity.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blitzid/app/MainActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000+\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0011\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J2\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0014\u0010\u0006\u001a\u0010\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\t0\u0008\u0018\u00010\u00072\u0008\u0010\n\u001a\u0004\u0018\u00010\u000bH\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/blitzid/app/MainActivity$onCreate$3",
        "Landroid/webkit/WebChromeClient;",
        "onShowFileChooser",
        "",
        "webView",
        "Landroid/webkit/WebView;",
        "callback",
        "Landroid/webkit/ValueCallback;",
        "",
        "Landroid/net/Uri;",
        "params",
        "Landroid/webkit/WebChromeClient$FileChooserParams;",
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


# instance fields
.field final synthetic this$0:Lcom/blitzid/app/MainActivity;


# direct methods
.method constructor <init>(Lcom/blitzid/app/MainActivity;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/blitzid/app/MainActivity;

    iput-object p1, p0, Lcom/blitzid/app/MainActivity$onCreate$3;->this$0:Lcom/blitzid/app/MainActivity;

    .line 73
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    .locals 5
    .param p1, "webView"    # Landroid/webkit/WebView;
    .param p2, "callback"    # Landroid/webkit/ValueCallback;
    .param p3, "params"    # Landroid/webkit/WebChromeClient$FileChooserParams;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "Landroid/webkit/ValueCallback<",
            "[",
            "Landroid/net/Uri;",
            ">;",
            "Landroid/webkit/WebChromeClient$FileChooserParams;",
            ")Z"
        }
    .end annotation

    .line 79
    iget-object v0, p0, Lcom/blitzid/app/MainActivity$onCreate$3;->this$0:Lcom/blitzid/app/MainActivity;

    invoke-static {v0}, Lcom/blitzid/app/MainActivity;->access$getFileUploadCallback$p(Lcom/blitzid/app/MainActivity;)Landroid/webkit/ValueCallback;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0, v1}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 80
    :cond_0
    iget-object v0, p0, Lcom/blitzid/app/MainActivity$onCreate$3;->this$0:Lcom/blitzid/app/MainActivity;

    invoke-static {v0, p2}, Lcom/blitzid/app/MainActivity;->access$setFileUploadCallback$p(Lcom/blitzid/app/MainActivity;Landroid/webkit/ValueCallback;)V

    .line 81
    if-eqz p3, :cond_1

    invoke-virtual {p3}, Landroid/webkit/WebChromeClient$FileChooserParams;->createIntent()Landroid/content/Intent;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, v1

    :goto_0
    const/4 v2, 0x0

    if-nez v0, :cond_2

    return v2

    .line 82
    .local v0, "intent":Landroid/content/Intent;
    :cond_2
    nop

    .line 83
    :try_start_0
    iget-object v3, p0, Lcom/blitzid/app/MainActivity$onCreate$3;->this$0:Lcom/blitzid/app/MainActivity;

    const/16 v4, 0x3e9

    invoke-virtual {v3, v0, v4}, Lcom/blitzid/app/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    const/4 v1, 0x1

    return v1

    .line 84
    :catch_0
    move-exception v3

    .line 85
    .local v3, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/blitzid/app/MainActivity$onCreate$3;->this$0:Lcom/blitzid/app/MainActivity;

    invoke-static {v4, v1}, Lcom/blitzid/app/MainActivity;->access$setFileUploadCallback$p(Lcom/blitzid/app/MainActivity;Landroid/webkit/ValueCallback;)V

    .line 86
    return v2
.end method
