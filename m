From: Sage Weil <sage@newdream.net>
Subject: Re: [patch] ceph: cleanup: remove unused assignement
Date: Fri, 7 May 2010 14:42:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005071441550.18563@cobra.newdream.net>
References: <20100507082713.GQ27064@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49608 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0EGVjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 May 2010 17:39:35 -0400
In-Reply-To: <20100507082713.GQ27064@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org

On Fri, 7 May 2010, Dan Carpenter wrote:
> We don't ever use "dirty" so we can remove it.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 0c16818..a8db1a6 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1711,10 +1711,9 @@ out_unlocked:
>  static int caps_are_flushed(struct inode *inode, unsigned tid)
>  {
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> -	int dirty, i, ret = 1;
> +	int i, ret = 1;
>  
>  	spin_lock(&inode->i_lock);
> -	dirty = __ceph_caps_dirty(ci);
>  	for (i = 0; i < CEPH_CAP_BITS; i++)
>  		if ((ci->i_flushing_caps & (1 << i)) &&
>  		    ci->i_cap_flush_tid[i] <= tid) {

Queued up for the 2.6.35 window.

Thanks!
sage

