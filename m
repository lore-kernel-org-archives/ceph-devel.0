From: Alex Elder <elder@inktank.com>
Subject: Re: [TRIVIAL PATCH] bdi_register: Add __printf verification, fix
 arg mismatch
Date: Mon, 26 Nov 2012 21:05:28 -0600
Message-ID: <50B42DF8.8010407@inktank.com>
References: <1353613769.10902.8.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40260 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab2K0DFd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 22:05:33 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so8636089iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 19:05:30 -0800 (PST)
In-Reply-To: <1353613769.10902.8.camel@joe-AO722>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 11/22/2012 01:49 PM, Joe Perches wrote:
> __printf is useful to verify format and arguments.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Looks good.  I can take this into the ceph tree.  Thanks.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  fs/ceph/super.c             |    2 +-
>  include/linux/backing-dev.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 2eb43f2..e7dbb5c 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -849,7 +849,7 @@ static int ceph_register_bdi(struct super_block *sb,
>  		fsc->backing_dev_info.ra_pages =
>  			default_backing_dev_info.ra_pages;
>  
> -	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%d",
> +	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%ld",
>  			   atomic_long_inc_return(&bdi_seq));
>  	if (!err)
>  		sb->s_bdi = &fsc->backing_dev_info;
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 2a9a9ab..12731a1 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -114,6 +114,7 @@ struct backing_dev_info {
>  int bdi_init(struct backing_dev_info *bdi);
>  void bdi_destroy(struct backing_dev_info *bdi);
>  
> +__printf(3, 4)
>  int bdi_register(struct backing_dev_info *bdi, struct device *parent,
>  		const char *fmt, ...);
>  int bdi_register_dev(struct backing_dev_info *bdi, dev_t dev);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

