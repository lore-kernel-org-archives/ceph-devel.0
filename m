From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH][TRIVIAL] ceph: Free mdsc if alloc mdsc->mdsmap failed.
Date: Tue, 25 Jun 2013 08:24:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306250824530.2998@cobra.newdream.net>
References: <201306251448154186071@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43446 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3FYPY6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 11:24:58 -0400
In-Reply-To: <201306251448154186071@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Applied, thanks!

sage


On Tue, 25 Jun 2013, majianpeng wrote:

> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/mds_client.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 4d29203..9fb58f6 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3040,8 +3040,10 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	fsc->mdsc = mdsc;
>  	mutex_init(&mdsc->mutex);
>  	mdsc->mdsmap = kzalloc(sizeof(*mdsc->mdsmap), GFP_NOFS);
> -	if (mdsc->mdsmap == NULL)
> +	if (mdsc->mdsmap == NULL) {
> +		kfree(mdsc);
>  		return -ENOMEM;
> +	}
>  
>  	init_completion(&mdsc->safe_umount_waiters);
>  	init_waitqueue_head(&mdsc->session_close_wq);
> -- 
> 1.8.1.2
> 
