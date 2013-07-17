From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v3] Ceph-fuse: Fallocate and punch hole support
Date: Wed, 17 Jul 2013 09:01:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307170853340.767@cobra.newdream.net>
References: <1374045960-2807-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab3GQQBQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jul 2013 12:01:16 -0400
In-Reply-To: <1374045960-2807-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

On Wed, 17 Jul 2013, Li Wang wrote:
> This patch implements fallocate and punch hole support for Ceph fuse client.
> 
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
> The version of fsx.c at ceph.com/qa refered by qa/workunits/suites/fsx.sh 
> does not support hole punching.
> Instead, we are using the one from git://ceph.newdream.net/git/xfstests.git.
> Except that, the fsx.sh works well.

Would you mind submitting a patch for fsx.sh that pulls the better fsx.c 
out of xfstests.git?

This looks pretty good!  One small nit below, and a suggestion for 
optimizing callers to punch beyond EOF.

The dumpling feature freeze passed a week and a half ago, so this will go 
in in another week or two after the first couple of -rc's are out.

Thanks!
sage


> ---
>  src/client/Client.cc           |   92 ++++++++++++++++++++++++++++++++++++++++
>  src/client/Client.h            |    3 ++
>  src/client/fuse_ll.cc          |   26 ++++++++++++
>  src/include/cephfs/libcephfs.h |   18 ++++++++
>  src/libcephfs.cc               |    8 ++++
>  5 files changed, 147 insertions(+)
> 
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index ae7ddf6..3119add 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -22,6 +22,7 @@
>  #include <sys/stat.h>
>  #include <sys/param.h>
>  #include <fcntl.h>
> +#include <linux/falloc.h>
>  
>  #include <sys/statvfs.h>
>  
> @@ -7664,6 +7665,97 @@ int Client::ll_fsync(Fh *fh, bool syncdataonly)
>    return _fsync(fh, syncdataonly);
>  }
>  
> +int Client::_fallocate(Fh *fh, int mode, int64_t offset, int64_t length)
> +{
> +  if (offset < 0 || length <= 0)
> +    return -EINVAL;
> +
> +  if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> +    return -EOPNOTSUPP;
> +
> +  if ((mode & FALLOC_FL_PUNCH_HOLE) && !(mode & FALLOC_FL_KEEP_SIZE))
> +    return -EOPNOTSUPP;
> +
> +  if (osdmap->test_flag(CEPH_OSDMAP_FULL))
> +    return -ENOSPC;
> +
> +  Inode *in = fh->inode;
> +
> +  assert(in->snapid == CEPH_NOSNAP);

or return -EROFS?

> +
> +  if ((fh->mode & CEPH_FILE_MODE_WR) == 0)
> +    return -EBADF;
> +
> +  int have;
> +  int r = get_caps(in, CEPH_CAP_FILE_WR, CEPH_CAP_FILE_BUFFER, &have, -1);
> +  if (r < 0)
> +    return r;
> +
> +  if (mode & FALLOC_FL_PUNCH_HOLE) {
> +    Mutex flock("Client::_punch_hole flock");
> +    Cond cond;
> +    bool done = false;
> +    Context *onfinish = new C_SafeCond(&flock, &cond, &done);
> +    Context *onsafe = new C_Client_SyncCommit(this, in);
> +
> +    unsafe_sync_write++;
> +    get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
> +
> +    _invalidate_inode_cache(in, offset, length, true);
> +    r = filer->zero(in->ino, &in->layout,
> +                    in->snaprealm->get_snap_context(),
> +                    offset, length,
> +                    ceph_clock_now(cct),
> +                    0, onfinish, onsafe);
> +    if (r < 0)
> +      goto done;

It might be worth a check there for the case where offset/length extend 
past EOF.  Although note that we can only safely trust i_size if we have 
the Fs cap.

> +
> +    client_lock.Unlock();
> +    flock.Lock();
> +    while (!done)
> +      cond.Wait(flock);
> +    flock.Unlock();
> +    client_lock.Lock();
> +  } else if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> +    uint64_t size = offset + length;
> +    if (size > in->size) {
> +      in->size = size;
> +      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
> +
> +      if ((in->size << 1) >= in->max_size &&
> +          (in->reported_size << 1) < in->max_size)
> +        check_caps(in, false);
> +    }
> +  }
> +
> +  in->mtime = ceph_clock_now(cct);
> +  mark_caps_dirty(in, CEPH_CAP_FILE_WR);
> +
> +done:
> +  put_cap_ref(in, CEPH_CAP_FILE_WR);
> +  return r;
> +}
> +
> +int Client::ll_fallocate(Fh *fh, int mode, loff_t offset, loff_t length)
> +{
> +  Mutex::Locker lock(client_lock);
> +  ldout(cct, 3) << "ll_fallocate " << fh << " " << fh->inode->ino << " " << dendl;
> +  tout(cct) << "ll_fallocate " << mode << " " << offset << " " << length << std::endl;
> +  tout(cct) << (unsigned long)fh << std::endl;
> +
> +  return _fallocate(fh, mode, offset, length);
> +}
> +
> +int Client::fallocate(int fd, int mode, loff_t offset, loff_t length)
> +{
> +  Mutex::Locker lock(client_lock);
> +  tout(cct) << "fallocate " << " " << fd << mode << " " << offset << " " << length << std::endl;
> +
> +  Fh *fh = get_filehandle(fd);
> +  if (!fh)
> +    return -EBADF;
> +  return _fallocate(fh, mode, offset, length);
> +}
>  
>  int Client::ll_release(Fh *fh)
>  {
> diff --git a/src/client/Client.h b/src/client/Client.h
> index 96e8937..218fe10 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -555,6 +555,7 @@ private:
>    int _flush(Fh *fh);
>    int _fsync(Fh *fh, bool syncdataonly);
>    int _sync_fs();
> +  int _fallocate(Fh *fh, int mode, int64_t offset, int64_t length);
>  
>    int get_or_create(Inode *dir, const char* name,
>  		    Dentry **pdn, bool expect_null=false);
> @@ -653,6 +654,7 @@ public:
>    int ftruncate(int fd, loff_t size);
>    int fsync(int fd, bool syncdataonly);
>    int fstat(int fd, struct stat *stbuf);
> +  int fallocate(int fd, int mode, loff_t offset, loff_t length);
>  
>    // full path xattr ops
>    int getxattr(const char *path, const char *name, void *value, size_t size);
> @@ -722,6 +724,7 @@ public:
>    int ll_write(Fh *fh, loff_t off, loff_t len, const char *data);
>    int ll_flush(Fh *fh);
>    int ll_fsync(Fh *fh, bool syncdataonly);
> +  int ll_fallocate(Fh *fh, int mode, loff_t offset, loff_t length);
>    int ll_release(Fh *fh);
>    int ll_statfs(vinodeno_t vino, struct statvfs *stbuf);
>  
> diff --git a/src/client/fuse_ll.cc b/src/client/fuse_ll.cc
> index 8339553..836b5b2 100644
> --- a/src/client/fuse_ll.cc
> +++ b/src/client/fuse_ll.cc
> @@ -399,6 +399,20 @@ static void fuse_ll_ioctl(fuse_req_t req, fuse_ino_t ino, int cmd, void *arg, st
>  }
>  #endif
>  
> +#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
> +
> +static void fuse_ll_fallocate(fuse_req_t req, fuse_ino_t ino, int mode,
> +                              off_t offset, off_t length,
> +                              struct fuse_file_info *fi)
> +{
> +  CephFuse::Handle *cfuse = (CephFuse::Handle *)fuse_req_userdata(req);
> +  Fh *fh = (Fh*)fi->fh;
> +  int r = cfuse->client->ll_fallocate(fh, mode, offset, length);
> +  fuse_reply_err(req, -r);
> +}
> +
> +#endif
> +
>  static void fuse_ll_release(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>  {
>    CephFuse::Handle *cfuse = (CephFuse::Handle *)fuse_req_userdata(req);
> @@ -599,8 +613,20 @@ const static struct fuse_lowlevel_ops fuse_ll_oper = {
>   getlk: 0,
>   setlk: 0,
>   bmap: 0,
> +#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
>  #ifdef FUSE_IOCTL_COMPAT
>   ioctl: fuse_ll_ioctl,
> +#else
> + ioctl: 0,
> +#endif
> + poll: 0, 
> +#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
> + write_buf: 0,
> + retrieve_reply: 0,
> + forget_multi: 0,
> + flock: 0,
> + fallocate: fuse_ll_fallocate
> +#endif
>  #endif
>  };
>  
> diff --git a/src/include/cephfs/libcephfs.h b/src/include/cephfs/libcephfs.h
> index 93e86e7..9b74f63 100644
> --- a/src/include/cephfs/libcephfs.h
> +++ b/src/include/cephfs/libcephfs.h
> @@ -709,6 +709,24 @@ int ceph_ftruncate(struct ceph_mount_info *cmount, int fd, loff_t size);
>  int ceph_fsync(struct ceph_mount_info *cmount, int fd, int syncdataonly);
>  
>  /**
> + * Preallocate or release disk space for the file for the byte range.
> + *
> + * @param cmount the ceph mount handle to use for performing the fallocate.
> + * @param fd the file descriptor of the file to fallocate.
> + * @param mode the flags determines the operation to be performed on the given range.
> + *        default operation (0) allocate and initialize to zero the file in the byte range,
> + *        and the file size will be changed if offset + length is greater than
> + *        the file size. if the FALLOC_FL_KEEP_SIZE flag is specified in the mode,
> + *        the file size will not be changed. if the FALLOC_FL_PUNCH_HOLE flag is
> + *        specified in the mode, the operation is deallocate space and zero the byte range.
> + * @param offset the byte range starting.
> + * @param length the length of the range.
> + * @return 0 on success or a negative error code on failure.
> + */
> +int ceph_fallocate(struct ceph_mount_info *cmount, int fd, int mode,
> +	                      loff_t offset, loff_t length);
> +
> +/**
>   * Get the open file's statistics.
>   *
>   * @param cmount the ceph mount handle to use for performing the fstat.
> diff --git a/src/libcephfs.cc b/src/libcephfs.cc
> index 16b130a..306c4ba 100644
> --- a/src/libcephfs.cc
> +++ b/src/libcephfs.cc
> @@ -700,6 +700,14 @@ extern "C" int ceph_fsync(struct ceph_mount_info *cmount, int fd, int syncdataon
>    return cmount->get_client()->fsync(fd, syncdataonly);
>  }
>  
> +extern "C" int ceph_fallocate(struct ceph_mount_info *cmount, int fd, int mode,
> +	                      loff_t offset, loff_t length)
> +{
> +  if (!cmount->is_mounted())
> +    return -ENOTCONN;
> +  return cmount->get_client()->fallocate(fd, mode, offset, length);
> +}
> +
>  extern "C" int ceph_fstat(struct ceph_mount_info *cmount, int fd, struct stat *stbuf)
>  {
>    if (!cmount->is_mounted())
> -- 
> 1.7.9.5
> 
> 
