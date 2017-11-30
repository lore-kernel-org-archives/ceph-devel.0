From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: drop negtive child dentries before try pruning
 inode's alias
Date: Thu, 30 Nov 2017 09:37:41 -0500
Message-ID: <1512052661.4132.4.camel@redhat.com>
References: <20171130141259.8577-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37457 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdK3Oho (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Nov 2017 09:37:44 -0500
Received: by mail-qk0-f195.google.com with SMTP id i130so9058736qke.4
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 06:37:44 -0800 (PST)
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

Would it be better to do this at the VFS layer? Dropping negative
children when we're going to prune dentries for an inode seems like it
ought to be done as a matter of course in d_prune_aliases.

-- 
Jeff Layton <jlayton@redhat.com>
