From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
Date: Fri, 22 Mar 2019 15:41:39 +0100
Message-ID: <CAOi1vP_=5gBUFLCofhaCNbMkfdwYNSkJ06Rmw-bJkLXNC4v8fA@mail.gmail.com>
References: <20190322140819.300740-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322140819.300740-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 22, 2019 at 3:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang complains about assigning a variable to itself during the
> declaration:
>
> fs/ceph/ioctl.c:187:26: error: variable 'oid' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
>         CEPH_DEFINE_OID_ONSTACK(oid);
>                                 ^~~
> include/linux/ceph/osdmap.h:122:52: note: expanded from macro 'CEPH_DEFINE_OID_ONSTACK'
>         struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
>                               ~~~                         ^~~
> include/linux/ceph/osdmap.h:120:29: note: expanded from macro 'CEPH_OID_INIT_ONSTACK'
>     ({ ceph_oid_init(&oid); oid; })
>                             ^~~
>
> We use this trick in other places, but it is completely unnecessary
> here, as we can just use a regular struct initializer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/ceph/osdmap.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 5675b1f09bc5..82f957a7a0d6 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -116,10 +116,8 @@ static inline void ceph_oid_init(struct ceph_object_id *oid)
>         oid->name_len = 0;
>  }
>
> -#define CEPH_OID_INIT_ONSTACK(oid)                                     \
> -    ({ ceph_oid_init(&oid); oid; })
>  #define CEPH_DEFINE_OID_ONSTACK(oid)                                   \
> -       struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
> +       struct ceph_object_id oid = { .name = oid.inline_name }
>
>  static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
>  {

Hi Arnd,

I don't like this because the initialization is no longer contained to
ceph_oid_init().  Now there are two things to patch instead of one.

How is this going to be fixed in other places?

Thanks,

                Ilya
