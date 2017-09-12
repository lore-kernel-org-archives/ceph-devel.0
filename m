From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/5] ceph: keep auth cap when inode has flocks or posix
 locks
Date: Tue, 12 Sep 2017 09:21:37 -0400
Message-ID: <1505222497.28831.12.camel@redhat.com>
References: <20170912025351.42147-1-zyan@redhat.com>
         <20170912025351.42147-2-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34458 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILNVl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 09:21:41 -0400
Received: by mail-yw0-f169.google.com with SMTP id r85so28143141ywg.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 06:21:40 -0700 (PDT)
In-Reply-To: <20170912025351.42147-2-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com

On Tue, 2017-09-12 at 10:53 +0800, Yan, Zheng wrote:
> file locks are tracked by inode's auth mds. releasing auth caps
> is equivalent to releasing all file locks.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/inode.c      |  1 +
>  fs/ceph/locks.c      | 62 ++++++++++++++++++++++++++++++++++++++++++++--------
>  fs/ceph/mds_client.c |  2 ++
>  fs/ceph/super.h      |  1 +
>  4 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 373dab5173ca..c70b26d2bf8a 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -492,6 +492,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>  	ci->i_wb_ref = 0;
>  	ci->i_wrbuffer_ref = 0;
>  	ci->i_wrbuffer_ref_head = 0;
> +	atomic_set(&ci->i_filelock_ref, 0);
>  	ci->i_shared_gen = 0;
>  	ci->i_rdcache_gen = 0;
>  	ci->i_rdcache_revoking = 0;
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 64ae74472046..69f731e75302 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -29,19 +29,46 @@ void __init ceph_flock_init(void)
>  	get_random_bytes(&lock_secret, sizeof(lock_secret));
>  }
>  
> +static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
> +{
> +	struct inode *inode = file_inode(src->fl_file);
> +	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
> +}
> +
> +static void ceph_fl_release_lock(struct file_lock *fl)
> +{
> +	struct inode *inode = file_inode(fl->fl_file);
> +	atomic_dec(&ceph_inode(inode)->i_filelock_ref);
> +}
> +
> +static const struct file_lock_operations ceph_fl_lock_ops = {
> +	.fl_copy_lock = ceph_fl_copy_lock,
> +	.fl_release_private = ceph_fl_release_lock,
> +};
> +
>  /**
>   * Implement fcntl and flock locking functions.
>   */
> -static int ceph_lock_message(u8 lock_type, u16 operation, struct file *file,
> +static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
>  			     int cmd, u8 wait, struct file_lock *fl)
>  {
> -	struct inode *inode = file_inode(file);
>  	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
>  	struct ceph_mds_request *req;
>  	int err;
>  	u64 length = 0;
>  	u64 owner;
>  
> +	if (operation == CEPH_MDS_OP_SETFILELOCK) {
> +		/*
> +		 * increasing i_filelock_ref closes race window between
> +		 * handling request reply and adding file_lock struct to
> +		 * inode. Otherwise, i_auth_cap may get trimmed in the
> +		 * window. Caller function will decrease the counter.
> +		 */
> +		fl->fl_ops = &ceph_fl_lock_ops;
> +		atomic_inc(&ceph_inode(inode)->i_filelock_ref);
> +	}
> +
>  	if (operation != CEPH_MDS_OP_SETFILELOCK || cmd == CEPH_LOCK_UNLOCK)
>  		wait = 0;
>  
> @@ -179,10 +206,11 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
>   */
>  int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  {
> -	u8 lock_cmd;
> +	struct inode *inode = file_inode(file);
>  	int err;
> -	u8 wait = 0;
>  	u16 op = CEPH_MDS_OP_SETFILELOCK;
> +	u8 lock_cmd;
> +	u8 wait = 0;
>  
>  	if (!(fl->fl_flags & FL_POSIX))
>  		return -ENOLCK;
> @@ -198,6 +226,17 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  	else if (IS_SETLKW(cmd))
>  		wait = 1;
>  
> +	if (op == CEPH_MDS_OP_SETFILELOCK) {
> +		/*
> +		 * increasing i_filelock_ref closes race window between
> +		 * handling request reply and adding file_lock struct to
> +		 * inode. Otherwise, i_auth_cap may get trimmed in the
> +		 * window. Caller function will decrease the counter.
> +		 */
> +		fl->fl_ops = &ceph_fl_lock_ops;
> +		atomic_inc(&ceph_inode(inode)->i_filelock_ref);
> +	}
> +
>  	if (F_RDLCK == fl->fl_type)
>  		lock_cmd = CEPH_LOCK_SHARED;
>  	else if (F_WRLCK == fl->fl_type)
> @@ -205,7 +244,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  	else
>  		lock_cmd = CEPH_LOCK_UNLOCK;
>  
> -	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, file, lock_cmd, wait, fl);
> +	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
>  	if (!err) {
>  		if (op != CEPH_MDS_OP_GETFILELOCK) {
>  			dout("mds locked, locking locally");
> @@ -214,7 +253,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  				/* undo! This should only happen if
>  				 * the kernel detects local
>  				 * deadlock. */
> -				ceph_lock_message(CEPH_LOCK_FCNTL, op, file,
> +				ceph_lock_message(CEPH_LOCK_FCNTL, op, inode,
>  						  CEPH_LOCK_UNLOCK, 0, fl);
>  				dout("got %d on posix_lock_file, undid lock",
>  				     err);
> @@ -226,8 +265,9 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
>  
>  int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  {
> -	u8 lock_cmd;
> +	struct inode *inode = file_inode(file);
>  	int err;
> +	u8 lock_cmd;
>  	u8 wait = 0;
>  
>  	if (!(fl->fl_flags & FL_FLOCK))
> @@ -238,6 +278,10 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  
>  	dout("ceph_flock, fl_file: %p", fl->fl_file);
>  
> +	/* see comment in ceph_lock */
> +	fl->fl_ops = &ceph_fl_lock_ops;
> +	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
> +
>  	if (IS_SETLKW(cmd))
>  		wait = 1;
>  
> @@ -249,13 +293,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  		lock_cmd = CEPH_LOCK_UNLOCK;
>  
>  	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
> -				file, lock_cmd, wait, fl);
> +				inode, lock_cmd, wait, fl);
>  	if (!err) {
>  		err = locks_lock_file_wait(file, fl);
>  		if (err) {
>  			ceph_lock_message(CEPH_LOCK_FLOCK,
>  					  CEPH_MDS_OP_SETFILELOCK,
> -					  file, CEPH_LOCK_UNLOCK, 0, fl);
> +					  inode, CEPH_LOCK_UNLOCK, 0, fl);
>  			dout("got %d on locks_lock_file_wait, undid lock", err);
>  		}
>  	}
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 9dd6b836ac9e..6146af4ed03c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1461,6 +1461,8 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
>  			goto out;
>  		if ((used | wanted) & CEPH_CAP_ANY_WR)
>  			goto out;
> +		if (atomic_read(&ci->i_filelock_ref) > 0)
> +			goto out;

Is there a potential race here? Could i_filelock_ref do a 0->1
transition just after you check it?

>  	}
>  	/* The inode has cached pages, but it's no longer used.
>  	 * we can safely drop it */
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 279a2f401cf5..9e0de8264257 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -351,6 +351,7 @@ struct ceph_inode_info {
>  	int i_pin_ref;
>  	int i_rd_ref, i_rdcache_ref, i_wr_ref, i_wb_ref;
>  	int i_wrbuffer_ref, i_wrbuffer_ref_head;
> +	atomic_t i_filelock_ref;
>  	u32 i_shared_gen;       /* increment each time we get FILE_SHARED */
>  	u32 i_rdcache_gen;      /* incremented each time we get FILE_CACHE. */
>  	u32 i_rdcache_revoking; /* RDCACHE gen to async invalidate, if any */

-- 
Jeff Layton <jlayton@redhat.com>
