From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: add newline to end of debug message format
Date: Tue, 30 Jan 2018 17:24:34 +0800
Message-ID: <4DFCF103-B6DC-4EA9-8641-28DB0C59E9D5@redhat.com>
References: <1517300957-28459-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbeA3JYl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:24:41 -0500
In-Reply-To: <1517300957-28459-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org



> On 30 Jan 2018, at 16:29, Chengguang Xu <cgxu519@icloud.com> wrote:
> 
> Some of dout format do not include newline in the end,
> fix for the files which are in fs/ceph and net/ceph directories,
> and changing printk to dout for printing debug info in super.c
> 
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> fs/ceph/cache.c        |  2 +-
> fs/ceph/dir.c          |  2 +-
> fs/ceph/file.c         |  2 +-
> fs/ceph/locks.c        | 20 ++++++++++----------
> fs/ceph/mds_client.c   | 10 +++++-----
> fs/ceph/super.c        |  2 +-
> net/ceph/ceph_common.c |  2 +-
> 7 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index a3ab265..3781f72 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -190,7 +190,7 @@ static enum fscache_checkaux ceph_fscache_inode_check_aux(
> 	if (memcmp(data, &aux, sizeof(aux)) != 0)
> 		return FSCACHE_CHECKAUX_OBSOLETE;
> 
> -	dout("ceph inode 0x%p cached okay", ci);
> +	dout("ceph inode 0x%p cached okay\n", ci);
> 	return FSCACHE_CHECKAUX_OKAY;
> }
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 8a52666..e7c95be 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -444,7 +444,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
> 				fi->dir_ordered_count = req->r_dir_ordered_cnt;
> 			}
> 		} else {
> -			dout("readdir !did_prepopulate");
> +			dout("readdir !did_prepopulate\n");
> 			/* disable readdir cache */
> 			fi->readdir_cache_idx = -1;
> 			/* preclude from marking dir complete */
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5c17125..4795c7d 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -41,7 +41,7 @@ static __le32 ceph_flags_sys2wire(u32 flags)
> #undef ceph_sys2wire
> 
> 	if (flags)
> -		dout("unused open flags: %x", flags);
> +		dout("unused open flags: %x\n", flags);
> 
> 	return cpu_to_le32(wire_flags);
> }
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 9e66f69..9dae2ec 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -95,7 +95,7 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
> 	owner = secure_addr(fl->fl_owner);
> 
> 	dout("ceph_lock_message: rule: %d, op: %d, owner: %llx, pid: %llu, "
> -	     "start: %llu, length: %llu, wait: %d, type: %d", (int)lock_type,
> +	     "start: %llu, length: %llu, wait: %d, type: %d\n", (int)lock_type,
> 	     (int)operation, owner, (u64)fl->fl_pid, fl->fl_start, length,
> 	     wait, fl->fl_type);
> 
> @@ -132,7 +132,7 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
> 	}
> 	ceph_mdsc_put_request(req);
> 	dout("ceph_lock_message: rule: %d, op: %d, pid: %llu, start: %llu, "
> -	     "length: %llu, wait: %d, type: %d, err code %d", (int)lock_type,
> +	     "length: %llu, wait: %d, type: %d, err code %d\n", (int)lock_type,
> 	     (int)operation, (u64)fl->fl_pid, fl->fl_start,
> 	     length, wait, fl->fl_type, err);
> 	return err;
> @@ -226,7 +226,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
> 	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
> 		return -ENOLCK;
> 
> -	dout("ceph_lock, fl_owner: %p", fl->fl_owner);
> +	dout("ceph_lock, fl_owner: %p\n", fl->fl_owner);
> 
> 	/* set wait bit as appropriate, then make command as Ceph expects it*/
> 	if (IS_GETLK(cmd))
> @@ -264,7 +264,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
> 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
> 	if (!err) {
> 		if (op == CEPH_MDS_OP_SETFILELOCK) {
> -			dout("mds locked, locking locally");
> +			dout("mds locked, locking locally\n");
> 			err = posix_lock_file(file, fl, NULL);
> 			if (err) {
> 				/* undo! This should only happen if
> @@ -272,7 +272,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
> 				 * deadlock. */
> 				ceph_lock_message(CEPH_LOCK_FCNTL, op, inode,
> 						  CEPH_LOCK_UNLOCK, 0, fl);
> -				dout("got %d on posix_lock_file, undid lock",
> +				dout("got %d on posix_lock_file, undid lock\n",
> 				     err);
> 			}
> 		}
> @@ -294,7 +294,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
> 	if (fl->fl_type & LOCK_MAND)
> 		return -EOPNOTSUPP;
> 
> -	dout("ceph_flock, fl_file: %p", fl->fl_file);
> +	dout("ceph_flock, fl_file: %p\n", fl->fl_file);
> 
> 	spin_lock(&ci->i_ceph_lock);
> 	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> @@ -329,7 +329,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
> 			ceph_lock_message(CEPH_LOCK_FLOCK,
> 					  CEPH_MDS_OP_SETFILELOCK,
> 					  inode, CEPH_LOCK_UNLOCK, 0, fl);
> -			dout("got %d on locks_lock_file_wait, undid lock", err);
> +			dout("got %d on locks_lock_file_wait, undid lock\n", err);
> 		}
> 	}
> 	return err;
> @@ -356,7 +356,7 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
> 			++(*flock_count);
> 		spin_unlock(&ctx->flc_lock);
> 	}
> -	dout("counted %d flock locks and %d fcntl locks",
> +	dout("counted %d flock locks and %d fcntl locks\n",
> 	     *flock_count, *fcntl_count);
> }
> 
> @@ -384,7 +384,7 @@ static int lock_to_ceph_filelock(struct file_lock *lock,
> 		cephlock->type = CEPH_LOCK_UNLOCK;
> 		break;
> 	default:
> -		dout("Have unknown lock type %d", lock->fl_type);
> +		dout("Have unknown lock type %d\n", lock->fl_type);
> 		err = -EINVAL;
> 	}
> 
> @@ -407,7 +407,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
> 	int seen_flock = 0;
> 	int l = 0;
> 
> -	dout("encoding %d flock and %d fcntl locks", num_flock_locks,
> +	dout("encoding %d flock and %d fcntl locks\n", num_flock_locks,
> 	     num_fcntl_locks);
> 
> 	if (!ctx)
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 1b46825..731a856 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -384,7 +384,7 @@ static struct ceph_mds_session *get_session(struct ceph_mds_session *s)
> 		     refcount_read(&s->s_ref)-1, refcount_read(&s->s_ref));
> 		return s;
> 	} else {
> -		dout("mdsc get_session %p 0 -- FAIL", s);
> +		dout("mdsc get_session %p 0 -- FAIL\n", s);
> 		return NULL;
> 	}
> }
> @@ -2518,10 +2518,10 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
> 	 * Otherwise we just have to return an ESTALE
> 	 */
> 	if (result == -ESTALE) {
> -		dout("got ESTALE on request %llu", req->r_tid);
> +		dout("got ESTALE on request %llu\n", req->r_tid);
> 		req->r_resend_mds = -1;
> 		if (req->r_direct_mode != USE_AUTH_MDS) {
> -			dout("not using auth, setting for that now");
> +			dout("not using auth, setting for that now\n");
> 			req->r_direct_mode = USE_AUTH_MDS;
> 			__do_request(mdsc, req);
> 			mutex_unlock(&mdsc->mutex);
> @@ -2529,13 +2529,13 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
> 		} else  {
> 			int mds = __choose_mds(mdsc, req);
> 			if (mds >= 0 && mds != req->r_session->s_mds) {
> -				dout("but auth changed, so resending");
> +				dout("but auth changed, so resending\n");
> 				__do_request(mdsc, req);
> 				mutex_unlock(&mdsc->mutex);
> 				goto out;
> 			}
> 		}
> -		dout("have to return ESTALE on request %llu", req->r_tid);
> +		dout("have to return ESTALE on request %llu\n", req->r_tid);
> 	}
> 
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a62d2a9..5ec5eef 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -318,7 +318,7 @@ static int parse_fsopt_token(char *c, void *private)
> 		break;
> 	case Opt_poolperm:
> 		fsopt->flags &= ~CEPH_MOUNT_OPT_NOPOOLPERM;
> -		printk ("pool perm");
> +		dout("pool perm\n");
> 		break;
> 	case Opt_nopoolperm:
> 		fsopt->flags |= CEPH_MOUNT_OPT_NOPOOLPERM;
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 1e492ef..14ee3bf 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -217,7 +217,7 @@ static int parse_fsid(const char *str, struct ceph_fsid *fsid)
> 
> 	if (i == 16)
> 		err = 0;
> -	dout("parse_fsid ret %d got fsid %pU", err, fsid);
> +	dout("parse_fsid ret %d got fsid %pU\n", err, fsid);
> 	return err;
> }
> 
> -- 
> 1.8.3.1
> 

Applied, thanks

Yan, Zheng

