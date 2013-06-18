From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: silence GCC warnings
Date: Tue, 18 Jun 2013 08:10:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306180810380.23632@cobra.newdream.net>
References: <1371463963.26299.9.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371463963.26299.9.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This was already fixed up in teh testing branch; thanks!

On Mon, 17 Jun 2013, Paul Bolle wrote:

> Building rbd.o triggers two GCC warnings:
>     drivers/block/rbd.c: In function ?rbd_img_request_fill?:
>     drivers/block/rbd.c:1272:22: warning: ?bio_list? may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/block/rbd.c:2170:14: note: ?bio_list? was declared here
>     drivers/block/rbd.c:2231:10: warning: ?pages? may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Apparently GCC has trouble determining that "bio_list" is unused if "type"
> is "OBJ_REQUEST_PAGES" and, conversely, that "pages" will be unused if
> "type" is "OBJ_REQUEST_BIO". Add harmless initializations to NULL to
> help GCC.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Compile tested only.
> 
> 1) These warnings were introduced in v3.10-rc1, apparently through
> commit f1a4739f33 ("rbd: support page array image requests"). 
> 
> 2) Note that
>     rbd_assert(type == OBJ_REQUEST_PAGES);
> 
> seems redundant. I see no way that this assertion could ever be false. 
> 
>  drivers/block/rbd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3063452..b8a58178 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2185,9 +2185,11 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  	if (type == OBJ_REQUEST_BIO) {
>  		bio_list = data_desc;
>  		rbd_assert(img_offset == bio_list->bi_sector << SECTOR_SHIFT);
> +		pages = NULL;
>  	} else {
>  		rbd_assert(type == OBJ_REQUEST_PAGES);
>  		pages = data_desc;
> +		bio_list = NULL;
>  	}
>  
>  	while (resid) {
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
