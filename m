From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Replace zero-length array with flexible-array
Date: Fri, 8 May 2020 09:53:25 +0200
Message-ID: <CAOi1vP-w-doHK2zHJQixLneub5qwdnz8DC_9toDEvuPy7i72NA@mail.gmail.com>
References: <20200507185138.GA14076@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507185138.GA14076@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, May 7, 2020 at 8:47 PM Gustavo A. R. Silva
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
>  include/linux/ceph/mon_client.h |    2 +-
>  include/linux/crush/crush.h     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index dbb8a6959a73..ce4ffeb384d7 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -19,7 +19,7 @@ struct ceph_monmap {
>         struct ceph_fsid fsid;
>         u32 epoch;
>         u32 num_mon;
> -       struct ceph_entity_inst mon_inst[0];
> +       struct ceph_entity_inst mon_inst[];
>  };
>
>  struct ceph_mon_client;
> diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
> index 54741295c70b..38b0e4d50ed9 100644
> --- a/include/linux/crush/crush.h
> +++ b/include/linux/crush/crush.h
> @@ -87,7 +87,7 @@ struct crush_rule_mask {
>  struct crush_rule {
>         __u32 len;
>         struct crush_rule_mask mask;
> -       struct crush_rule_step steps[0];
> +       struct crush_rule_step steps[];
>  };
>
>  #define crush_rule_size(len) (sizeof(struct crush_rule) + \
>

Applied.

Thanks,

                Ilya
