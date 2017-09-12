From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 2/5] ceph: make lock_to_ceph_filelock() 'static'
Date: Tue, 12 Sep 2017 08:48:31 -0400
Message-ID: <1505220511.28831.0.camel@redhat.com>
References: <20170912025351.42147-1-zyan@redhat.com>
         <20170912025351.42147-3-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36653 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILMse (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 08:48:34 -0400
Received: by mail-yw0-f180.google.com with SMTP id v72so25815674ywa.3
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 05:48:34 -0700 (PDT)
In-Reply-To: <20170912025351.42147-3-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com

On Tue, 2017-09-12 at 10:53 +0800, Yan, Zheng wrote:
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/locks.c | 62 ++++++++++++++++++++++++++++-----------------------------
>  fs/ceph/super.h |  1 -
>  2 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 69f731e75302..33e091e6e8d3 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -331,6 +331,37 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
>  	     *flock_count, *fcntl_count);
>  }
>  
> +/*
> + * Given a pointer to a lock, convert it to a ceph filelock
> + */
> +static int lock_to_ceph_filelock(struct file_lock *lock,
> +				 struct ceph_filelock *cephlock)
> +{
> +	int err = 0;
> +	cephlock->start = cpu_to_le64(lock->fl_start);
> +	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
> +	cephlock->client = cpu_to_le64(0);
> +	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
> +	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_owner));
> +
> +	switch (lock->fl_type) {
> +	case F_RDLCK:
> +		cephlock->type = CEPH_LOCK_SHARED;
> +		break;
> +	case F_WRLCK:
> +		cephlock->type = CEPH_LOCK_EXCL;
> +		break;
> +	case F_UNLCK:
> +		cephlock->type = CEPH_LOCK_UNLOCK;
> +		break;
> +	default:
> +		dout("Have unknown lock type %d", lock->fl_type);
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
>  /**
>   * Encode the flock and fcntl locks for the given inode into the ceph_filelock
>   * array. Must be called with inode->i_lock already held.
> @@ -415,34 +446,3 @@ int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
>  out_fail:
>  	return err;
>  }
> -
> -/*
> - * Given a pointer to a lock, convert it to a ceph filelock
> - */
> -int lock_to_ceph_filelock(struct file_lock *lock,
> -			  struct ceph_filelock *cephlock)
> -{
> -	int err = 0;
> -	cephlock->start = cpu_to_le64(lock->fl_start);
> -	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
> -	cephlock->client = cpu_to_le64(0);
> -	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
> -	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_owner));
> -
> -	switch (lock->fl_type) {
> -	case F_RDLCK:
> -		cephlock->type = CEPH_LOCK_SHARED;
> -		break;
> -	case F_WRLCK:
> -		cephlock->type = CEPH_LOCK_EXCL;
> -		break;
> -	case F_UNLCK:
> -		cephlock->type = CEPH_LOCK_UNLOCK;
> -		break;
> -	default:
> -		dout("Have unknown lock type %d", lock->fl_type);
> -		err = -EINVAL;
> -	}
> -
> -	return err;
> -}
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 9e0de8264257..88cbc0981c23 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1011,7 +1011,6 @@ extern int ceph_encode_locks_to_buffer(struct inode *inode,
>  extern int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
>  				  struct ceph_pagelist *pagelist,
>  				  int num_fcntl_locks, int num_flock_locks);
> -extern int lock_to_ceph_filelock(struct file_lock *fl, struct ceph_filelock *c);
>  
>  /* debugfs.c */
>  extern int ceph_fs_debugfs_init(struct ceph_fs_client *client);

Reviewed-by: Jeff Layton <jlayton@redhat.com>
