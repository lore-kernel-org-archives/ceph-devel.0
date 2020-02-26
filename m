From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH][next] block: Replace zero-length array with
 flexible-array member
Date: Wed, 26 Feb 2020 14:56:34 +0100
Message-ID: <CAOi1vP_2+G+0=-a0uqLMYisp+EtHhiVrkWFLFch5JygYVNWvdA@mail.gmail.com>
References: <20200225234836.GA31741@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200225234836.GA31741@embeddedor>
Sender: linux-block-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Richard Russon (FlatCap)" <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, Sage Weil <sage@redhat.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-ntfs-dev@lists.sourceforge.net, linux-block <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lars Ellenberg <drbd-dev@lists.linbit.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Feb 26, 2020 at 12:45 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
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
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  block/partitions/ldm.h             | 2 +-
>  drivers/block/drbd/drbd_int.h      | 2 +-
>  drivers/block/drbd/drbd_protocol.h | 8 ++++----

For rbd

>  drivers/block/rbd_types.h          | 2 +-

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
