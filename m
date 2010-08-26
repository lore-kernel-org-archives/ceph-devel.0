From: Sage Weil <sage@newdream.net>
Subject: Re: [patch] ceph: ceph_mdsc_build_path() returns an ERR_PTR
Date: Thu, 26 Aug 2010 09:30:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008260930060.22216@cobra.newdream.net>
References: <20100826090724.GA20072@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab0HZQ31 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Aug 2010 12:29:27 -0400
In-Reply-To: <20100826090724.GA20072@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

Applied, thanks!
sage

On Thu, 26 Aug 2010, Dan Carpenter wrote:

> ceph_mdsc_build_path() returns an ERR_PTR but this code is set up to
> handle NULL returns.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 360c4f2..6fd8b20 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -171,6 +171,8 @@ static int mdsc_show(struct seq_file *s, void *p)
>  		} else if (req->r_dentry) {
>  			path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
>  						    &pathbase, 0);
> +			if (IS_ERR(path))
> +				path = NULL;
>  			spin_lock(&req->r_dentry->d_lock);
>  			seq_printf(s, " #%llx/%.*s (%s)",
>  				   ceph_ino(req->r_dentry->d_parent->d_inode),
> @@ -187,6 +189,8 @@ static int mdsc_show(struct seq_file *s, void *p)
>  		if (req->r_old_dentry) {
>  			path = ceph_mdsc_build_path(req->r_old_dentry, &pathlen,
>  						    &pathbase, 0);
> +			if (IS_ERR(path))
> +				path = NULL;
>  			spin_lock(&req->r_old_dentry->d_lock);
>  			seq_printf(s, " #%llx/%.*s (%s)",
>  			   ceph_ino(req->r_old_dentry->d_parent->d_inode),
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
