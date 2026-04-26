.class public Landroidx/webkit/WebMessageCompat;
.super Ljava/lang/Object;
.source "WebMessageCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/webkit/WebMessageCompat$Type;
    }
.end annotation


# static fields
.field public static final TYPE_ARRAY_BUFFER:I = 0x1

.field public static final TYPE_STRING:I


# instance fields
.field private final mArrayBuffer:[B

.field private final mPorts:[Landroidx/webkit/WebMessagePortCompat;

.field private final mString:Ljava/lang/String;

.field private final mType:I


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    .line 55
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/webkit/WebMessageCompat;-><init>(Ljava/lang/String;[Landroidx/webkit/WebMessagePortCompat;)V

    .line 56
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;[Landroidx/webkit/WebMessagePortCompat;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;
    .param p2, "ports"    # [Landroidx/webkit/WebMessagePortCompat;

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    iput-object p1, p0, Landroidx/webkit/WebMessageCompat;->mString:Ljava/lang/String;

    .line 66
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/webkit/WebMessageCompat;->mArrayBuffer:[B

    .line 67
    iput-object p2, p0, Landroidx/webkit/WebMessageCompat;->mPorts:[Landroidx/webkit/WebMessagePortCompat;

    .line 68
    const/4 v0, 0x0

    iput v0, p0, Landroidx/webkit/WebMessageCompat;->mType:I

    .line 69
    return-void
.end method

.method public constructor <init>([B)V
    .locals 1
    .param p1, "arrayBuffer"    # [B

    .line 79
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/webkit/WebMessageCompat;-><init>([B[Landroidx/webkit/WebMessagePortCompat;)V

    .line 80
    return-void
.end method

.method public constructor <init>([B[Landroidx/webkit/WebMessagePortCompat;)V
    .locals 1
    .param p1, "arrayBuffer"    # [B
    .param p2, "ports"    # [Landroidx/webkit/WebMessagePortCompat;

    .line 91
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 92
    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    iput-object p1, p0, Landroidx/webkit/WebMessageCompat;->mArrayBuffer:[B

    .line 94
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/webkit/WebMessageCompat;->mString:Ljava/lang/String;

    .line 95
    iput-object p2, p0, Landroidx/webkit/WebMessageCompat;->mPorts:[Landroidx/webkit/WebMessagePortCompat;

    .line 96
    const/4 v0, 0x1

    iput v0, p0, Landroidx/webkit/WebMessageCompat;->mType:I

    .line 97
    return-void
.end method

.method private checkType(I)V
    .locals 3
    .param p1, "typeForGetter"    # I

    .line 168
    iget v0, p0, Landroidx/webkit/WebMessageCompat;->mType:I

    if-ne p1, v0, :cond_0

    .line 172
    return-void

    .line 169
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Wrong data accessor type detected. "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Landroidx/webkit/WebMessageCompat;->mType:I

    .line 170
    invoke-direct {p0, v2}, Landroidx/webkit/WebMessageCompat;->typeToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " expected, but got "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p1}, Landroidx/webkit/WebMessageCompat;->typeToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private typeToString(I)Ljava/lang/String;
    .locals 1
    .param p1, "type"    # I

    .line 157
    packed-switch p1, :pswitch_data_0

    .line 163
    const-string v0, "Unknown"

    return-object v0

    .line 161
    :pswitch_0
    const-string v0, "ArrayBuffer"

    return-object v0

    .line 159
    :pswitch_1
    const-string v0, "String"

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public getArrayBuffer()[B
    .locals 1

    .line 123
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Landroidx/webkit/WebMessageCompat;->checkType(I)V

    .line 125
    iget-object v0, p0, Landroidx/webkit/WebMessageCompat;->mArrayBuffer:[B

    invoke-static {v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 126
    iget-object v0, p0, Landroidx/webkit/WebMessageCompat;->mArrayBuffer:[B

    return-object v0
.end method

.method public getData()Ljava/lang/String;
    .locals 1

    .line 143
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroidx/webkit/WebMessageCompat;->checkType(I)V

    .line 144
    iget-object v0, p0, Landroidx/webkit/WebMessageCompat;->mString:Ljava/lang/String;

    return-object v0
.end method

.method public getPorts()[Landroidx/webkit/WebMessagePortCompat;
    .locals 1

    .line 153
    iget-object v0, p0, Landroidx/webkit/WebMessageCompat;->mPorts:[Landroidx/webkit/WebMessagePortCompat;

    return-object v0
.end method

.method public getType()I
    .locals 1

    .line 105
    iget v0, p0, Landroidx/webkit/WebMessageCompat;->mType:I

    return v0
.end method
