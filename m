From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: Fix warnings
Date: Wed, 25 Aug 2010 12:00:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008251200460.19762@cobra.newdream.net>
References: <20100825122610.17899.91326.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46224 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab0HYTAR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Aug 2010 15:00:17 -0400
In-Reply-To: <20100825122610.17899.91326.stgit@localhost.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Cox <alan@linux.intel.com>
Cc: ceph-devel@vger.kernel.org

Thanks, queuing this up.

sage

On Wed, 25 Aug 2010, Alan Cox wrote:

> Just scrubbing some warnings so I can see real problem ones in the build
> noise. For 32bit we need to coax gcc politely into believing we really
> honestly intend to the casts. Using (u64)(unsigned long) means we cast from
> a pointer to a type of the right size and then extend it. This stops the
> warning spew.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  fs/ceph/locks.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> 
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index ae85af0..4c7b090 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -82,7 +82,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  		length = fl->fl_end - fl->fl_start + 1;
>  
>  	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, file,
> -				(u64)fl->fl_pid, (u64)fl->fl_nspid,
> +				(u64)fl->fl_pid, 
> +				(u64)(unsigned long)fl->fl_nspid,
>  				lock_cmd, fl->fl_start,
>  				length, wait);
>  	if (!err) {
> @@ -92,7 +93,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  			/* undo! This should only happen if the kernel detects
>  			 * local deadlock. */
>  			ceph_lock_message(CEPH_LOCK_FCNTL, op, file,
> -					  (u64)fl->fl_pid, (u64)fl->fl_nspid,
> +					  (u64)fl->fl_pid,
> +					  (u64)(unsigned long)fl->fl_nspid,
>  					  CEPH_LOCK_UNLOCK, fl->fl_start,
>  					  length, 0);
>  			dout("got %d on posix_lock_file, undid lock", err);
> @@ -132,7 +134,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  		length = fl->fl_end - fl->fl_start + 1;
>  
>  	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
> -				file, (u64)fl->fl_pid, (u64)fl->fl_nspid,
> +				file, (u64)fl->fl_pid, 
> +				(u64)(unsigned long)fl->fl_nspid,
>  				lock_cmd, fl->fl_start,
>  				length, wait);
>  	if (!err) {
> @@ -141,7 +144,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  			ceph_lock_message(CEPH_LOCK_FLOCK,
>  					  CEPH_MDS_OP_SETFILELOCK,
>  					  file, (u64)fl->fl_pid,
> -					  (u64)fl->fl_nspid,
> +					  (u64)(unsigned long)fl->fl_nspid,
>  					  CEPH_LOCK_UNLOCK, fl->fl_start,
>  					  length, 0);
>  			dout("got %d on flock_lock_file_wait, undid lock", err);
> @@ -235,7 +238,8 @@ int lock_to_ceph_filelock(struct file_lock *lock,
>  	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
>  	cephlock->client = cpu_to_le64(0);
>  	cephlock->pid = cpu_to_le64(lock->fl_pid);
> -	cephlock->pid_namespace = cpu_to_le64((u64)lock->fl_nspid);
> +	cephlock->pid_namespace = 
> +	        cpu_to_le64((u64)(unsigned long)lock->fl_nspid);
>  
>  	switch (lock->fl_type) {
>  	case F_RDLCK:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
