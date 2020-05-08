From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: Replace zero-length array with flexible-array
Date: Fri, 8 May 2020 09:54:12 +0200
Message-ID: <CAOi1vP9GfENfy_D_iOeUrweUk2CTcz+2GXGg3M6y+bvQs_zqMw@mail.gmail.com>
References: <20200507191932.GA15991@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507191932.GA15991@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, May 7, 2020 at 9:15 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/block/rbd_types.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
> index ac98ab6ccd3b..a600e0eb6b6f 100644
> --- a/drivers/block/rbd_types.h
> +++ b/drivers/block/rbd_types.h
> @@ -93,7 +93,7 @@ struct rbd_image_header_ondisk {
>         __le32 snap_count;
>         __le32 reserved;
>         __le64 snap_names_len;
> -       struct rbd_image_snap_ondisk snaps[0];
> +       struct rbd_image_snap_ondisk snaps[];
>  } __attribute__((packed));
>
>
>

Applied (folded into libceph patch).

Thanks,

                Ilya
