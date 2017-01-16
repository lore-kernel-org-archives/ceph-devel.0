From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: use BUG() instead of BUG_ON(1)
Date: Mon, 16 Jan 2017 14:33:59 +0100
Message-ID: <CAOi1vP_+fABpNS+NCNDcHqsRPB11_Qm2AY0_9+BJ5+aPzrh45Q@mail.gmail.com>
References: <20170116110622.3870494-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116110622.3870494-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Jan 16, 2017 at 12:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I ran into this compile warning, which is the result of BUG_ON(1)
> not always leading to the compiler treating the code path as
> unreachable:
>
> include/linux/ceph/osdmap.h: In function 'ceph_can_shift_osds':
> include/linux/ceph/osdmap.h:62:1: error: control reaches end of non-void function [-Werror=return-type]
>
> Using BUG() here avoids the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/ceph/osdmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 9a9041784dcf..412906609954 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -57,7 +57,7 @@ static inline bool ceph_can_shift_osds(struct ceph_pg_pool_info *pool)
>         case CEPH_POOL_TYPE_EC:
>                 return false;
>         default:
> -               BUG_ON(1);
> +               BUG();
>         }
>  }

Applied.

Thanks,

                Ilya
