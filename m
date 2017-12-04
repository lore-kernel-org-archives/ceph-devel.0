From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: drop negtive child dentries before try pruning
 inode's alias
Date: Mon, 04 Dec 2017 10:25:11 -0500
Message-ID: <1512401111.4042.14.camel@redhat.com>
References: <20171130141259.8577-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41756 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdLDPZO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Dec 2017 10:25:14 -0500
Received: by mail-ua0-f195.google.com with SMTP id q13so12669280uaq.8
        for <ceph-devel@vger.kernel.org>; Mon, 04 Dec 2017 07:25:14 -0800 (PST)
In-Reply-To: <20171130141259.8577-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Thu, 2017-11-30 at 22:12 +0800, Yan, Zheng wrote:
> negtive child dentry holds reference on inode's alias, it makes
> d_prune_aliases() do nothing.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/mds_client.c | 43 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index da181acd4a61..9e7bb5fa9295 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1440,6 +1440,30 @@ static int __close_session(struct ceph_mds_client *mdsc,
>  	return request_close_session(mdsc, session);
>  }
>  
> +static bool drop_negative_children(struct dentry *dentry)
> +{
> +	struct dentry *child;
> +	bool all_negtive = true;
> +
> +	if (!d_is_dir(dentry))
> +		goto out;
> +
> +	spin_lock(&dentry->d_lock);
> +	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
> +		if (d_really_is_positive(child)) {
> +			all_negtive = false;
> +			break;
> +		}
> +	}
> +	spin_unlock(&dentry->d_lock);
> +
> +	if (all_negtive)
> +		shrink_dcache_parent(dentry);
> +out:
> +	dput(dentry);

It's sort of nasty to drop the reference here. It makes it harder to
track how that gets done when you acquire and drop references across a
function boundary like this. There's also no reason for it since you
always do it last here anyway.

It'd be nicer to just move that into the caller.

> +	return all_negtive;
> +}
> +
>  /*
>   * Trim old(er) caps.
>   *
> @@ -1495,15 +1519,20 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
>  		__ceph_remove_cap(cap, true);
>  		session->s_trim_caps--;
>  	} else {
> -		int refs;
> +		struct dentry *dentry;
>  		/* try dropping referring dentries */
>  		spin_unlock(&ci->i_ceph_lock);
> -		d_prune_aliases(inode);
> -		refs = atomic_read(&inode->i_count);
> -		if (refs == 1)
> -			session->s_trim_caps--;
> -		dout("trim_caps_cb %p cap %p  pruned, count now %d\n",
> -		     inode, cap, refs);
> +		dentry = d_find_any_alias(inode);
> +		/* drop_negative_children() calls dput() */
> +		if (dentry && drop_negative_children(dentry)) {
> +			int refs;
> +			d_prune_aliases(inode);
> +			refs = atomic_read(&inode->i_count);
> +			if (refs == 1)
> +				session->s_trim_caps--;
> +			dout("trim_caps_cb %p cap %p pruned, count now %d\n",
> +			     inode, cap, refs);
> +		}
>  		return 0;
>  	}
>  

I think the rest looks fine though.

-- 
Jeff Layton <jlayton@redhat.com>
