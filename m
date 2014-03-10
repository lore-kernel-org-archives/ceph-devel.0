From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: use fl->fl_file as owner identifier of flock and
 posix lock
Date: Sun, 9 Mar 2014 21:42:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403092138290.24219@cobra.newdream.net>
References: <1394421105-7215-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1403092114310.24219@cobra.newdream.net> <531D4157.6010507@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48474 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaCJEmr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 00:42:47 -0400
In-Reply-To: <531D4157.6010507@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 10 Mar 2014, Yan, Zheng wrote:
> On 03/10/2014 12:21 PM, Sage Weil wrote:
> > On Mon, 10 Mar 2014, Yan, Zheng wrote:
> >> flock and posix lock should use fl->fl_file instead of process ID
> >> as owner identifier. (posix lock uses fl->fl_owner, fl->fl_owner
> >> is usually equal to fl->fl_file in most cases). The process ID of
> >> who holds the lock is just for F_GETLK fcntl(2).
> >>
> >> The fix is rename the 'pid' fields of struct ceph_mds_request_args
> >> and struct ceph_filelock to 'owner', rename 'pid_namespace' fields
> >> to 'pid'. Assign fl->fl_file to the 'owner' field of lock messages.
> >>
> >> The MDS counterpart of this patch modifies the flock code to not
> >> take the 'pid_namespace' into consideration when checking conflict
> >> locks.
> > 
> > If I'm reading this right, it means the pid is purely informational now.  
> > and 'owner' is a raw pointer from the client?  That's unique, clearly, but 
> > I suspect its a bad idea to share kernel pointers with any remote system?  
> > Since this essentially boils down to a unique identifier for the thread 
> > group, I wonder if we should opt for a different unique identifier for 
> > that.
> 
> you mean XOR the pointer with a cipher ?

Or, if we just need to identify the thread group, use the tgid from the 
task, possibly in combination with the namespace.  Is the main bug here 
is that we aren't handling flock vs fcntl properly, or that the task 
may not be the actual owner?  Because we can always condition whether we 
fill this (or something else) into these fields based on whether fl_owner 
== NULL...

sage

> 
> > 
> > sage
> > 
> > 
> >>
> >> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> >> ---
> >>  fs/ceph/locks.c              | 44 ++++++++++++++++++++++++--------------------
> >>  include/linux/ceph/ceph_fs.h |  4 ++--
> >>  2 files changed, 26 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> >> index f91a569a..4857007 100644
> >> --- a/fs/ceph/locks.c
> >> +++ b/fs/ceph/locks.c
> >> @@ -14,9 +14,9 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct file *file,
> >>  			     int cmd, u8 wait, struct file_lock *fl)
> >>  {
> >>  	struct inode *inode = file_inode(file);
> >> -	struct ceph_mds_client *mdsc =
> >> -		ceph_sb_to_client(inode->i_sb)->mdsc;
> >> +	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
> >>  	struct ceph_mds_request *req;
> >> +	void *owner;
> >>  	int err;
> >>  	u64 length = 0;
> >>  
> >> @@ -32,25 +32,28 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct file *file,
> >>  	else
> >>  		length = fl->fl_end - fl->fl_start + 1;
> >>  
> >> -	dout("ceph_lock_message: rule: %d, op: %d, pid: %llu, start: %llu, "
> >> -	     "length: %llu, wait: %d, type: %d", (int)lock_type,
> >> -	     (int)operation, (u64)fl->fl_pid, fl->fl_start,
> >> -	     length, wait, fl->fl_type);
> >> +	if (lock_type == CEPH_LOCK_FCNTL)
> >> +		owner = fl->fl_owner;
> >> +	else
> >> +		owner = fl->fl_file;
> >> +
> >> +	dout("ceph_lock_message: rule: %d, op: %d, owner: %p, pid: %llu, "
> >> +	     "start: %llu, length: %llu, wait: %d, type: %d", (int)lock_type,
> >> +	     (int)operation, owner, (u64)fl->fl_pid, fl->fl_start, length,
> >> +	     wait, fl->fl_type);
> >>  
> >>  	req->r_args.filelock_change.rule = lock_type;
> >>  	req->r_args.filelock_change.type = cmd;
> >> +	req->r_args.filelock_change.owner =
> >> +		cpu_to_le64((u64)(unsigned long)owner);
> >>  	req->r_args.filelock_change.pid = cpu_to_le64((u64)fl->fl_pid);
> >> -	/* This should be adjusted, but I'm not sure if
> >> -	   namespaces actually get id numbers*/
> >> -	req->r_args.filelock_change.pid_namespace =
> >> -		cpu_to_le64((u64)(unsigned long)fl->fl_nspid);
> >>  	req->r_args.filelock_change.start = cpu_to_le64(fl->fl_start);
> >>  	req->r_args.filelock_change.length = cpu_to_le64(length);
> >>  	req->r_args.filelock_change.wait = wait;
> >>  
> >>  	err = ceph_mdsc_do_request(mdsc, inode, req);
> >>  
> >> -	if ( operation == CEPH_MDS_OP_GETFILELOCK){
> >> +	if (operation == CEPH_MDS_OP_GETFILELOCK) {
> >>  		fl->fl_pid = le64_to_cpu(req->r_reply_info.filelock_reply->pid);
> >>  		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
> >>  			fl->fl_type = F_RDLCK;
> >> @@ -93,8 +96,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
> >>  	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
> >>  		return -ENOLCK;
> >>  
> >> -	fl->fl_nspid = get_pid(task_tgid(current));
> >> -	dout("ceph_lock, fl_pid:%d", fl->fl_pid);
> >> +	dout("ceph_lock, fl_owner: %p", fl->fl_owner);
> >>  
> >>  	/* set wait bit as appropriate, then make command as Ceph expects it*/
> >>  	if (IS_GETLK(cmd))
> >> @@ -111,7 +113,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
> >>  
> >>  	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, file, lock_cmd, wait, fl);
> >>  	if (!err) {
> >> -		if ( op != CEPH_MDS_OP_GETFILELOCK ){
> >> +		if (op != CEPH_MDS_OP_GETFILELOCK) {
> >>  			dout("mds locked, locking locally");
> >>  			err = posix_lock_file(file, fl, NULL);
> >>  			if (err && (CEPH_MDS_OP_SETFILELOCK == op)) {
> >> @@ -145,8 +147,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
> >>  	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
> >>  		return -ENOLCK;
> >>  
> >> -	fl->fl_nspid = get_pid(task_tgid(current));
> >> -	dout("ceph_flock, fl_pid:%d", fl->fl_pid);
> >> +	dout("ceph_flock, fl_file: %p", fl->fl_file);
> >>  
> >>  	if (IS_SETLKW(cmd))
> >>  		wait = 1;
> >> @@ -289,13 +290,16 @@ int lock_to_ceph_filelock(struct file_lock *lock,
> >>  			  struct ceph_filelock *cephlock)
> >>  {
> >>  	int err = 0;
> >> -
> >>  	cephlock->start = cpu_to_le64(lock->fl_start);
> >>  	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
> >>  	cephlock->client = cpu_to_le64(0);
> >> -	cephlock->pid = cpu_to_le64(lock->fl_pid);
> >> -	cephlock->pid_namespace =
> >> -	        cpu_to_le64((u64)(unsigned long)lock->fl_nspid);
> >> +	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
> >> +	if (lock->fl_flags & FL_POSIX)
> >> +		cephlock->owner =
> >> +			cpu_to_le64((u64)(unsigned long)lock->fl_owner);
> >> +	else
> >> +		cephlock->owner =
> >> +			cpu_to_le64((u64)(unsigned long)lock->fl_file);
> >>  
> >>  	switch (lock->fl_type) {
> >>  	case F_RDLCK:
> >> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> >> index 35f345f..5f6db18 100644
> >> --- a/include/linux/ceph/ceph_fs.h
> >> +++ b/include/linux/ceph/ceph_fs.h
> >> @@ -421,8 +421,8 @@ union ceph_mds_request_args {
> >>  	struct {
> >>  		__u8 rule; /* currently fcntl or flock */
> >>  		__u8 type; /* shared, exclusive, remove*/
> >> +		__le64 owner; /* owner of the lock */
> >>  		__le64 pid; /* process id requesting the lock */
> >> -		__le64 pid_namespace;
> >>  		__le64 start; /* initial location to lock */
> >>  		__le64 length; /* num bytes to lock from start */
> >>  		__u8 wait; /* will caller wait for lock to become available? */
> >> @@ -533,8 +533,8 @@ struct ceph_filelock {
> >>  	__le64 start;/* file offset to start lock at */
> >>  	__le64 length; /* num bytes to lock; 0 for all following start */
> >>  	__le64 client; /* which client holds the lock */
> >> +	__le64 owner; /* owner the lock */
> >>  	__le64 pid; /* process id holding the lock on the client */
> >> -	__le64 pid_namespace;
> >>  	__u8 type; /* shared lock, exclusive lock, or unlock */
> >>  } __attribute__ ((packed));
> >>  
> >> -- 
> >> 1.8.5.3
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
