From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph/super.c: quiet sparse noise
Date: Fri, 23 Sep 2011 12:06:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109231206390.26399@cobra.newdream.net>
References: <201109231153.30334.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33989 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab1IWTGp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 15:06:45 -0400
In-Reply-To: <201109231153.30334.hartleys@visionengravers.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org

Applied, thanks!

sage

On Fri, 23 Sep 2011, H Hartley Sweeten wrote:

> Quiet the sparse noise:
> 
> warning: symbol 'create_fs_client' was not declared. Should it be static?
> warning: symbol 'destroy_fs_client' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Sage Weil <sage@newdream.net>
> ceph-devel@vger.kernel.org
> 
> ---
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index e0a6a06..bbc1b78 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -426,7 +426,7 @@ static int extra_mon_dispatch(struct ceph_client *client, struct ceph_msg *msg)
>  /*
>   * create a new fs client
>   */
> -struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
> +static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
>  					struct ceph_options *opt)
>  {
>  	struct ceph_fs_client *fsc;
> @@ -502,7 +502,7 @@ fail:
>  	return ERR_PTR(err);
>  }
>  
> -void destroy_fs_client(struct ceph_fs_client *fsc)
> +static void destroy_fs_client(struct ceph_fs_client *fsc)
>  {
>  	dout("destroy_fs_client %p\n", fsc);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
