From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 6/6] ceph: don't acquire i_mutex ceph_vmtruncate_work
Date: Sat, 5 Jan 2013 22:00:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301052156400.15430@cobra.newdream.net>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-7-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50571 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3AFGAz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:00:55 -0500
In-Reply-To: <1357299261-20591-7-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 4 Jan 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> In commit 22cddde104, ceph_get_caps() was moved into ceph_write_begin().
> So ceph_get_caps() can be called while i_mutex is locked. If there is
> pending vmtruncate, ceph_get_caps() will wait for it to complete, but
> ceph_vmtruncate_work() is blocked by the locked i_mutex.

Hmm... :/

> There are several places that call __ceph_do_pending_vmtruncate()
> without holding the i_mutex, I think it's OK to not acquire the i_mutex
> in ceph_vmtruncate_work()

The intention was that that function woudl only be called under i_mutex.  
I did a quick look through the callers and that appears to be the case 
(for things llseek and setattr, the vfs should be taking i_mutex).

IIRC, this is to serialize the page cache truncation with truncate 
operations; this work can only be sanely done under i_mutex, so we defer 
it to the work queue or next person who takes i_mutex and cares about the 
mapping and i_size being consistent.

What was the deadlock you observed?

sage


> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/inode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 81613bc..c895c7f 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1420,7 +1420,7 @@ out:
>  
>  
>  /*
> - * called by trunc_wq; take i_mutex ourselves
> + * called by trunc_wq;
>   *
>   * We also truncate in a separate thread as well.
>   */
> @@ -1431,9 +1431,7 @@ static void ceph_vmtruncate_work(struct work_struct *work)
>  	struct inode *inode = &ci->vfs_inode;
>  
>  	dout("vmtruncate_work %p\n", inode);
> -	mutex_lock(&inode->i_mutex);
>  	__ceph_do_pending_vmtruncate(inode);
> -	mutex_unlock(&inode->i_mutex);
>  	iput(inode);
>  }
>  
> -- 
> 1.7.11.7
> 
> 
