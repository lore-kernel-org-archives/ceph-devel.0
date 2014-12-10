From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: fix mksnap crash
Date: Wed, 10 Dec 2014 06:23:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412100623470.18213@cobra.newdream.net>
References: <1418212479-17714-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60668 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757688AbaLJOX4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 09:23:56 -0500
In-Reply-To: <1418212479-17714-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@redhat.com>

On Wed, 10 Dec 2014, Yan, Zheng wrote:

> mksnap reply only contain 'target', does not contain 'dentry'. So
> it's wrong to use req->r_reply_info.head->is_dentry to detect traceless
> reply.
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  fs/ceph/dir.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 6526199..fcfd0ab 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -812,7 +812,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  		acls.pagelist = NULL;
>  	}
>  	err = ceph_mdsc_do_request(mdsc, dir, req);
> -	if (!err && !req->r_reply_info.head->is_dentry)
> +	if (!err &&
> +	    !req->r_reply_info.head->is_target &&
> +	    !req->r_reply_info.head->is_dentry)
>  		err = ceph_handle_notrace_create(dir, dentry);
>  	ceph_mdsc_put_request(req);
>  out:
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
