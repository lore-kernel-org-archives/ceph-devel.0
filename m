From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Ceph-fuse: Punch hole support
Date: Mon, 24 Jun 2013 21:46:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306242144180.8175@cobra.newdream.net>
References: <1371698253-5875-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37997 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3FYEq1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 00:46:27 -0400
In-Reply-To: <1371698253-5875-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Hi Li,

[Sorry, can't remember if I already replied to this, but:]

This patch looks ok, but the last step we need is to make sure it passes 
the fsx test with hole punching enabled.  I'm not sure if the versin of 
fsx run by ceph.git/qa/workunits/suites/fsx.sh tests hole punch or not.. 
if so, we just need to adjust the arguments in that script.  If not, we 
should pull the fsx.c file from our mirror of xfstests.git at ceph.com/git 
and use that version instead (by adjusting the fsx.sh script).

If this patch passes that test, we can merge it in and this code will get 
regularly tested.

Thanks!
sage


On Thu, 20 Jun 2013, Li Wang wrote:

> This patch implements punch hole support for ceph-fuse.
> 
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
>  src/client/Client.cc           |   85 ++++++++++++++++++++++++++++++++++++++++
>  src/client/Client.h            |    4 ++
>  src/client/fuse_ll.cc          |   23 +++++++++++
>  src/include/cephfs/libcephfs.h |   13 ++++++
>  src/libcephfs.cc               |    8 ++++
>  5 files changed, 133 insertions(+)
> 
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index 43cc83d..31d9c93 100644
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
> @@ -7647,6 +7648,90 @@ int Client::ll_fsync(Fh *fh, bool syncdataonly)
>    return _fsync(fh, syncdataonly);
>  }
>  
> +int Client::_punch_hole(Fh *fh, int64_t offset, int64_t length)
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
> +  in->mtime = ceph_clock_now(cct);
> +  mark_caps_dirty(in, CEPH_CAP_FILE_WR);
> +
> +done:
> +  put_cap_ref(in, CEPH_CAP_FILE_WR);
> +  return r;
> +}
> +
> +int Client::_fallocate(Fh *fh, int mode, loff_t offset, loff_t length)
> +{
> +  if (offset < 0 || length < 0)
> +    return -EINVAL;
> +
> +  if (!(mode & FALLOC_FL_KEEP_SIZE))
> +    return -EOPNOTSUPP;
> +
> +  if (!(mode & FALLOC_FL_PUNCH_HOLE))
> +    return 0; //No need to say EOPNOTSUPP;
> +
> +  return _punch_hole(fh, offset, length);
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
> index 22c6852..8ed7f23 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -553,6 +553,8 @@ private:
>    int _flush(Fh *fh);
>    int _fsync(Fh *fh, bool syncdataonly);
>    int _sync_fs();
> +  int _punch_hole(Fh *fh, int64_t offset, int64_t length);
> +  int _fallocate(Fh *fh, int mode, int64_t offset, int64_t length);
>  
>    int get_or_create(Inode *dir, const char* name,
>  		    Dentry **pdn, bool expect_null=false);
> @@ -651,6 +653,7 @@ public:
>    int ftruncate(int fd, loff_t size);
>    int fsync(int fd, bool syncdataonly);
>    int fstat(int fd, struct stat *stbuf);
> +  int fallocate(int fd, int mode, loff_t offset, loff_t length);
>  
>    // full path xattr ops
>    int getxattr(const char *path, const char *name, void *value, size_t size);
> @@ -720,6 +723,7 @@ public:
>    int ll_write(Fh *fh, loff_t off, loff_t len, const char *data);
>    int ll_flush(Fh *fh);
>    int ll_fsync(Fh *fh, bool syncdataonly);
> +  int ll_fallocate(Fh *fh, int mode, loff_t offset, loff_t length);
>    int ll_release(Fh *fh);
>    int ll_statfs(vinodeno_t vino, struct statvfs *stbuf);
>  
> diff --git a/src/client/fuse_ll.cc b/src/client/fuse_ll.cc
> index 46480e6..0a77001 100644
> --- a/src/client/fuse_ll.cc
> +++ b/src/client/fuse_ll.cc
> @@ -369,6 +369,20 @@ static void fuse_ll_flush(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info
>    fuse_reply_err(req, 0);
>  }
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
>  static void fuse_ll_ioctl(fuse_req_t req, fuse_ino_t ino, int cmd, void *arg, struct fuse_file_info *fi,
>                            unsigned flags, const void *in_buf, size_t in_bufsz, size_t out_bufsz)
>  {
> @@ -598,6 +612,15 @@ const static struct fuse_lowlevel_ops fuse_ll_oper = {
>   setlk: 0,
>   bmap: 0,
>   ioctl: fuse_ll_ioctl
> +#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
> + ,
> + poll: 0,
> + write_buf: 0,
> + retrieve_reply: 0,
> + forget_multi: 0,
> + flock: 0,
> + fallocate: fuse_ll_fallocate
> +#endif
>  };
>  
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
