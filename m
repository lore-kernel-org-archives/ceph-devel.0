From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] ceph: fix memory leak
Date: Mon, 22 Aug 2011 13:19:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108221317320.17780@cobra.newdream.net>
References: <CAB2gnbWqq4qDh0qmK8tC1-q5KY2H0rf_fNX_kVcFUEM6ZhYo5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47067 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab1HVUOU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2011 16:14:20 -0400
In-Reply-To: <CAB2gnbWqq4qDh0qmK8tC1-q5KY2H0rf_fNX_kVcFUEM6ZhYo5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Thanks, applied both of these!

sage

On Mon, 22 Aug 2011, Noah Watkins wrote:

> kfree does not clean up indirect allocations in
> ceph_fs_client and ceph_options (e.g. snapdir_name).
> 
> Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
> ---
>  fs/ceph/super.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 733674d..788f5ad 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -824,8 +824,8 @@ static struct dentry *ceph_mount(struct
> file_system_type *fs_type,
>  	fsc = create_fs_client(fsopt, opt);
>  	if (IS_ERR(fsc)) {
>  		res = ERR_CAST(fsc);
> -		kfree(fsopt);
> -		kfree(opt);
> +		destroy_mount_options(fsopt);
> +		ceph_destroy_options(opt);
>  		goto out_final;
>  	}
> 
> -- 
> 1.7.6
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
