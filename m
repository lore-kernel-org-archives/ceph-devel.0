From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/2] ceph: update ceph_dentry_info::lease_session when
 necessary
Date: Thu, 06 Jul 2017 09:21:06 -0400
Message-ID: <1499347266.4812.11.camel@redhat.com>
References: <20170706080212.28111-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34134 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbdGFNVJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 09:21:09 -0400
Received: by mail-qk0-f177.google.com with SMTP id d78so1773582qkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 06:21:09 -0700 (PDT)
In-Reply-To: <20170706080212.28111-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Thu, 2017-07-06 at 16:02 +0800, Yan, Zheng wrote:
> Current code does not update ceph_dentry_info::lease_session once
> it is set. If auth mds of corresponding dentry changes, dentry lease
> stays in invalid state.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/inode.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 53f23c9..220dfd8 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1016,6 +1016,7 @@ static void update_dentry_lease(struct dentry *dentry,
>  	long unsigned ttl = from_time + (duration * HZ) / 1000;
>  	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
>  	struct inode *dir;
> +	struct ceph_mds_session *old_lease_session = NULL;
>  
>  	/*
>  	 * Make sure dentry's inode matches tgt_vino. NULL tgt_vino means that
> @@ -1051,8 +1052,10 @@ static void update_dentry_lease(struct dentry *dentry,
>  	    time_before(ttl, di->time))
>  		goto out_unlock;  /* we already have a newer lease. */
>  
> -	if (di->lease_session && di->lease_session != session)
> -		goto out_unlock;
> +	if (di->lease_session && di->lease_session != session) {
> +		old_lease_session = di->lease_session;
> +		di->lease_session = NULL;
> +	}
>  
>  	ceph_dentry_lru_touch(dentry);
>  
> @@ -1065,6 +1068,8 @@ static void update_dentry_lease(struct dentry *dentry,
>  	di->time = ttl;
>  out_unlock:
>  	spin_unlock(&dentry->d_lock);
> +	if (old_lease_session)
> +		ceph_put_mds_session(old_lease_session);
>  	return;
>  }
>  

Reviewed-by: Jeff Layton <jlayton@redhat.com>
