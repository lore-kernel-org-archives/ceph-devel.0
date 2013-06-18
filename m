From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: remove RBD_DEBUG
Date: Tue, 18 Jun 2013 08:11:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306180811000.23632@cobra.newdream.net>
References: <1371464151.26299.12.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371464151.26299.12.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 17 Jun 2013, Paul Bolle wrote:
> The RBD_DEBUG macro is always defined, so it serves no purpose.
> Removing it has the benefit that readers of the code won't be tricked
> into thinking that rbd_assert() will compile away because they didn't
> define RBD_DEBUG themselves.

In the future we likely will disable the #define.  We may as well leave it 
there for now...


> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Compile tested only.
> 
>  drivers/block/rbd.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b8a58178..d3869b4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -44,8 +44,6 @@
>  
>  #include "rbd_types.h"
>  
> -#define RBD_DEBUG	/* Activate rbd_assert() calls */
> -
>  /*
>   * The basic unit of block I/O is a sector.  It is interpreted in a
>   * number of contexts in Linux (blk, bio, genhd), but the default is
> @@ -444,7 +442,6 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> -#ifdef RBD_DEBUG
>  #define rbd_assert(expr)						\
>  		if (unlikely(!(expr))) {				\
>  			printk(KERN_ERR "\nAssertion failure in %s() "	\
> @@ -453,9 +450,6 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
>  					__func__, __LINE__, #expr);	\
>  			BUG();						\
>  		}
> -#else /* !RBD_DEBUG */
> -#  define rbd_assert(expr)	((void) 0)
> -#endif /* !RBD_DEBUG */
>  
>  static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request);
>  static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
