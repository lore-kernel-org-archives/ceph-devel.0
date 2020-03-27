From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re:
Date: Fri, 27 Mar 2020 09:59:57 +0100
Message-ID: <CAOi1vP_SyWiGdE084P5U-GLuRf1=CPh_+kTgAnqomuFjR6AR+g@mail.gmail.com>
References: <5e7dbb10.ulraq/ljeOm297+z%chenanqing@oppo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e7dbb10.ulraq/ljeOm297+z%chenanqing@oppo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chenanqing@oppo.com
Cc: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, kuba@kernel.org, Sage Weil <sage@redhat.com>, Jeff Layton <jlayton@kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 27, 2020 at 9:36 AM <chenanqing@oppo.com> wrote:
>
> From: Chen Anqing <chenanqing@oppo.com>
> To: Ilya Dryomov <idryomov@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>,
>         Sage Weil <sage@redhat.com>,
>         Jakub Kicinski <kuba@kernel.org>,
>         ceph-devel@vger.kernel.org,
>         netdev@vger.kernel.org,
>         linux-kernel@vger.kernel.org,
>         chenanqing@oppo.com
> Subject: [PATCH] libceph: we should take compound page into account also
> Date: Fri, 27 Mar 2020 04:36:30 -0400
> Message-Id: <20200327083630.36296-1-chenanqing@oppo.com>
> X-Mailer: git-send-email 2.18.2
>
> the patch is occur at a real crash,which slab is
> come from a compound page,so we need take the compound page
> into account also.
> fixed commit 7e241f647dc7 ("libceph: fall back to sendmsg for slab pages")'
>
> Signed-off-by: Chen Anqing <chenanqing@oppo.com>
> ---
>  net/ceph/messenger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f8ca5edc5f2c..e08c1c334cd9 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -582,7 +582,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
>          * coalescing neighboring slab objects into a single frag which
>          * triggers one of hardened usercopy checks.
>          */
> -       if (page_count(page) >= 1 && !PageSlab(page))
> +       if (page_count(page) >= 1 && !PageSlab(compound_head(page)))
>                 sendpage = sock->ops->sendpage;
>         else
>                 sendpage = sock_no_sendpage;

Hi Chen,

AFAICT compound pages should already be taken into account, because
PageSlab is defined as:

  __PAGEFLAG(Slab, slab, PF_NO_TAIL)

  #define __PAGEFLAG(uname, lname, policy)                       \
      TESTPAGEFLAG(uname, lname, policy)                         \
      __SETPAGEFLAG(uname, lname, policy)                        \
      __CLEARPAGEFLAG(uname, lname, policy)

  #define TESTPAGEFLAG(uname, lname, policy)                     \
  static __always_inline int Page##uname(struct page *page)      \
      { return test_bit(PG_##lname, &policy(page, 0)->flags); }

and PF_NO_TAIL policy is defined as:

  #define PF_NO_TAIL(page, enforce) ({                        \
      VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
      PF_POISONED_CHECK(compound_head(page)); })

So compound_head() is called behind the scenes.

Could you please explain what crash did you observe in more detail?
Perhaps you backported this patch to an older kernel?

Thanks,

                Ilya
