From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v2] Ceph-fuse: Fallocate and hole punch support
Date: Tue, 16 Jul 2013 17:54:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307161748350.21178@cobra.newdream.net>
References: <1373965376-5451-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45958 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab3GQAyC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 20:54:02 -0400
In-Reply-To: <1373965376-5451-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

On Tue, 16 Jul 2013, Li Wang wrote:
> This patch implements fallocate and hole punch support for Ceph fuse client.
> 
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
> 
> Passed the fsx test.

Yay!  Is it the version that qa/workunits/suites/fsx.sh runs?  Does that 
script need to be modified to exercise the hole punching or does it detect 
when it is present on its own?

A few comments below... I think this can be simplified a bit more.

Thanks!
sage

> ---
>  src/client/Client.cc           |  114 ++++++++++++++++++++++++++++++++++++++++
>  src/client/Client.h            |    5 ++
>  src/client/fuse_ll.cc          |   26 +++++++++
>  src/include/cephfs/libcephfs.h |   13 +++++
>  src/libcephfs.cc               |    8 +++
>  5 files changed, 166 insertions(+)
> 
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index ae7ddf6..77fe6a2 100644
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
> @@ -7664,6 +7665,119 @@ int Client::ll_fsync(Fh *fh, bool syncdataonly)
>    return _fsync(fh, syncdataonly);
>  }
>  
> +int Client::_punch_hole(Fh *fh, int64_t offset, int64_t length)

We should pass the flag for whether to extend the file into this 
function...

> +{
> +  if (osdmap->test_flag(CEPH_OSDMAP_FULL))
> +    return -ENOSPC;
> +
> +  Inode *in = fh->inode;
> +
> +  assert(in->snapid == CEPH_NOSNAP);
> +
> +  if ((fh->mode & CEPH_FILE_MODE_WR) == 0)
> +    return -EBADF;
> +
> +  int have;
> +  int r = get_caps(in, CEPH_CAP_FILE_WR, CEPH_CAP_FILE_BUFFER, &have, -1);
> +  if (r < 0)
> +    return r;
> +
> +  Mutex flock("Client::_punch_hole flock");
> +  Cond cond;
> +  bool done = false;
> +  Context *onfinish = new C_SafeCond(&flock, &cond, &done);
> +  Context *onsafe = new C_Client_SyncCommit(this, in);
> +
> +  unsafe_sync_write++;
> +  get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
> +
> +  _invalidate_inode_cache(in, offset, length, true);
> +  r = filer->zero(in->ino, &in->layout,
> +                  in->snaprealm->get_snap_context(),
> +                  offset, length,
> +                  ceph_clock_now(cct),
> +                  0, onfinish, onsafe);
> +  if (r < 0)
> +    goto done;
> +
> +  client_lock.Unlock();
> +  flock.Lock();
> +  while (!done)
> +    cond.Wait(flock);
> +  flock.Unlock();
> +  client_lock.Lock();
> +

...and do the file size extension here, while we still old the FILE_WR 
cap ref.

> +  in->mtime = ceph_clock_now(cct);
> +  mark_caps_dirty(in, CEPH_CAP_FILE_WR);
> +
> +done:
> +  put_cap_ref(in, CEPH_CAP_FILE_WR);
> +  return r;
> +}
> +
> +int Client::_extend_size(Fh *fh, uint64_t length)
> +{
> +  Inode *in = fh->inode;
> +
> +  assert(in->snapid == CEPH_NOSNAP);
> +
> +  if ((fh->mode & CEPH_FILE_MODE_WR) == 0)
> +    return -EBADF;
> +
> +  int have;
> +  int r = get_caps(in, CEPH_CAP_FILE_WR, 0, &have, length);
> +  if (r < 0)
> +    return r;
> +
> +  if (length > in->size) {
> +    in->mtime = ceph_clock_now(cct);
> +    in->size = length;
> +    mark_caps_dirty(in, CEPH_CAP_FILE_WR);
> +
> +    if ((in->size << 1) >= in->max_size &&
> +	(in->reported_size << 1) < in->max_size)
> +      check_caps(in, false);
> +  }
> +
> +  put_cap_ref(in, CEPH_CAP_FILE_WR);
> +
> +  return 0;
> +}

Then we can drop this whole function, and don't have to think about 
situations where, say, we get caps and do the punch, but fail to get caps 
a second time change the file size.

> +
> +int Client::_fallocate(Fh *fh, int mode, int64_t offset, int64_t length)
> +{
> +  if (offset < 0 || length < 0)
> +    return -EINVAL;
> +
> +  if (mode & FALLOC_FL_PUNCH_HOLE)
> +    return _punch_hole(fh, offset, length);
> +
> +  if (!(mode & FALLOC_FL_KEEP_SIZE))
> +    return _extend_size(fh, offset + length);

this would go away too.

> +
> +  return 0;
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
> index 96e8937..e5dd310 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -555,6 +555,9 @@ private:
>    int _flush(Fh *fh);
>    int _fsync(Fh *fh, bool syncdataonly);
>    int _sync_fs();
> +  int _extend_size(Fh *fh, uint64_t length);
> +  int _punch_hole(Fh *fh, int64_t offset, int64_t length);
> +  int _fallocate(Fh *fh, int mode, int64_t offset, int64_t length);
>  
>    int get_or_create(Inode *dir, const char* name,
>  		    Dentry **pdn, bool expect_null=false);
> @@ -653,6 +656,7 @@ public:
>    int ftruncate(int fd, loff_t size);
>    int fsync(int fd, bool syncdataonly);
>    int fstat(int fd, struct stat *stbuf);
> +  int fallocate(int fd, int mode, loff_t offset, loff_t length);
>  
>    // full path xattr ops
>    int getxattr(const char *path, const char *name, void *value, size_t size);
> @@ -722,6 +726,7 @@ public:
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
> index 93e86e7..25a4861 100644
> --- a/src/include/cephfs/libcephfs.h
> +++ b/src/include/cephfs/libcephfs.h
> @@ -709,6 +709,19 @@ int ceph_ftruncate(struct ceph_mount_info *cmount, int fd, loff_t size);
>  int ceph_fsync(struct ceph_mount_info *cmount, int fd, int syncdataonly);
>  
>  /**
> + * Prefallocate or delete blocks in an open file.
> + *
> + * @param cmount the ceph mount handle to use for performing the fallocate.
> + * @param fd the file descriptor of the file to sync.
> + * @param mode a flags determines the operation to be performed on the given range.
> + * @param offset the offset of the file which the range begin.
> + * @param length the length of the range.
> + * @return 0 on success or a negative error code on failure.

If these args match the posix call (the flags, for instance), let's 
reference that in the comment.

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
> 
