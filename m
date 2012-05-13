From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Sat, 12 May 2012 17:19:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205121719160.21796@cobra.newdream.net>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53001 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2EMATi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 May 2012 20:19:38 -0400
In-Reply-To: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>

Hey Noah,

This looks reasonable to me.  Greg?

sage

On Fri, 11 May 2012, Noah Watkins wrote:

> Return an error rather than a segfault if a client uses the interface
> when unmounted. The Java bindings were explicitly enforcing the
> mounted state, but this was overly complicated, uncommon, and better
> handled with a simple exception that can be checked at libcephfs level.
> 
> Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
> ---
>  src/libcephfs.cc |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 126 insertions(+), 3 deletions(-)
> 
> diff --git a/src/libcephfs.cc b/src/libcephfs.cc
> index e4fbf6a..4946daf 100644
> --- a/src/libcephfs.cc
> +++ b/src/libcephfs.cc
> @@ -127,6 +127,11 @@ public:
>      }
>    }
>  
> +  bool is_mounted()
> +  {
> +    return mounted;
> +  }
> +
>    int conf_read_file(const char *path_list)
>    {
>      std::deque<std::string> parse_errors;
> @@ -267,11 +272,15 @@ extern "C" int ceph_mount(struct ceph_mount_info *cmount, const char *root)
>  extern "C" int ceph_statfs(struct ceph_mount_info *cmount, const char *path,
>  			   struct statvfs *stbuf)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->statfs(path, stbuf);
>  }
>  
>  extern "C" int ceph_get_local_osd(struct ceph_mount_info *cmount)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->get_local_osd();
>  }
>  
> @@ -282,93 +291,130 @@ extern "C" const char* ceph_getcwd(struct ceph_mount_info *cmount)
>  
>  extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char *s)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->chdir(s);
>  }
>  
>  extern "C" int ceph_opendir(struct ceph_mount_info *cmount,
>  			    const char *name, struct ceph_dir_result **dirpp)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->opendir(name, (dir_result_t **)dirpp);
>  }
>  
>  extern "C" int ceph_closedir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->closedir((dir_result_t*)dirp);
>  }
>  
>  extern "C" struct dirent * ceph_readdir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp)
>  {
> +  if (!cmount->is_mounted()) {
> +    /* Client::readdir also sets errno to signal errors. */
> +    errno = -EDOM;
> +    return NULL;
> +  }
>    return cmount->get_client()->readdir((dir_result_t*)dirp);
>  }
>  
>  extern "C" int ceph_readdir_r(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp, struct dirent *de)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->readdir_r((dir_result_t*)dirp, de);
>  }
>  
>  extern "C" int ceph_readdirplus_r(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp,
>  				  struct dirent *de, struct stat *st, int *stmask)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->readdirplus_r((dir_result_t*)dirp, de, st, stmask);
>  }
>  
>  extern "C" int ceph_getdents(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp,
>  			     char *buf, int buflen)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->getdents((dir_result_t*)dirp, buf, buflen);
>  }
>  
>  extern "C" int ceph_getdnames(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp,
>  			      char *buf, int buflen)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->getdnames((dir_result_t*)dirp, buf, buflen);
>  }
>  
>  extern "C" void ceph_rewinddir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp)
>  {
> +  if (!cmount->is_mounted())
> +    return;
>    cmount->get_client()->rewinddir((dir_result_t*)dirp);
>  }
>  
>  extern "C" loff_t ceph_telldir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->telldir((dir_result_t*)dirp);
>  }
>  
>  extern "C" void ceph_seekdir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp, loff_t offset)
>  {
> +  if (!cmount->is_mounted())
> +    return;
>    cmount->get_client()->seekdir((dir_result_t*)dirp, offset);
>  }
>  
>  extern "C" int ceph_link (struct ceph_mount_info *cmount, const char *existing,
>  			  const char *newname)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->link(existing, newname);
>  }
>  
>  extern "C" int ceph_unlink(struct ceph_mount_info *cmount, const char *path)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->unlink(path);
>  }
>  
>  extern "C" int ceph_rename(struct ceph_mount_info *cmount, const char *from,
>  			   const char *to)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->rename(from, to);
>  }
>  
>  // dirs
>  extern "C" int ceph_mkdir(struct ceph_mount_info *cmount, const char *path, mode_t mode)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->mkdir(path, mode);
>  }
>  
>  extern "C" int ceph_mkdirs(struct ceph_mount_info *cmount, const char *path, mode_t mode)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->mkdirs(path, mode);
>  }
>  
>  extern "C" int ceph_rmdir(struct ceph_mount_info *cmount, const char *path)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->rmdir(path);
>  }
>  
> @@ -376,12 +422,16 @@ extern "C" int ceph_rmdir(struct ceph_mount_info *cmount, const char *path)
>  extern "C" int ceph_readlink(struct ceph_mount_info *cmount, const char *path,
>  			     char *buf, loff_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->readlink(path, buf, size);
>  }
>  
>  extern "C" int ceph_symlink(struct ceph_mount_info *cmount, const char *existing,
>  			    const char *newname)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->symlink(existing, newname);
>  }
>  
> @@ -389,76 +439,104 @@ extern "C" int ceph_symlink(struct ceph_mount_info *cmount, const char *existing
>  extern "C" int ceph_lstat(struct ceph_mount_info *cmount, const char *path,
>  			  struct stat *stbuf)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->lstat(path, stbuf);
>  }
>  
>  extern "C" int ceph_setattr(struct ceph_mount_info *cmount, const char *relpath,
>  			    struct stat *attr, int mask)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->setattr(relpath, attr, mask);
>  }
>  
>  // *xattr() calls supporting samba/vfs
>  extern "C" int ceph_getxattr(struct ceph_mount_info *cmount, const char *path, const char *name, void *value, size_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->getxattr(path, name, value, size);
>  }
>  
>  extern "C" int ceph_lgetxattr(struct ceph_mount_info *cmount, const char *path, const char *name, void *value, size_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->lgetxattr(path, name, value, size);
>  }
>  
>  extern "C" int ceph_listxattr(struct ceph_mount_info *cmount, const char *path, char *list, size_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->listxattr(path, list, size);
>  }
>  
>  extern "C" int ceph_llistxattr(struct ceph_mount_info *cmount, const char *path, char *list, size_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->llistxattr(path, list, size);
>  }
>  
>  extern "C" int ceph_removexattr(struct ceph_mount_info *cmount, const char *path, const char *name)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->removexattr(path, name);
>  }
>  
>  extern "C" int ceph_lremovexattr(struct ceph_mount_info *cmount, const char *path, const char *name)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->lremovexattr(path, name);
>  }
>  
>  extern "C" int ceph_setxattr(struct ceph_mount_info *cmount, const char *path, const char *name, const void *value, size_t size, int flags)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->setxattr(path, name, value, size, flags);
>  }
>  
>  extern "C" int ceph_lsetxattr(struct ceph_mount_info *cmount, const char *path, const char *name, const void *value, size_t size, int flags)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->lsetxattr(path, name, value, size, flags);
>  }
>  /* end xattr support */
>  
>  extern "C" int ceph_chmod(struct ceph_mount_info *cmount, const char *path, mode_t mode)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->chmod(path, mode);
>  }
>  extern "C" int ceph_chown(struct ceph_mount_info *cmount, const char *path,
>  			  uid_t uid, gid_t gid)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->chown(path, uid, gid);
>  }
>  
>  extern "C" int ceph_utime(struct ceph_mount_info *cmount, const char *path,
>  			  struct utimbuf *buf)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->utime(path, buf);
>  }
>  
>  extern "C" int ceph_truncate(struct ceph_mount_info *cmount, const char *path,
>  			     loff_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->truncate(path, size);
>  }
>  
> @@ -466,55 +544,75 @@ extern "C" int ceph_truncate(struct ceph_mount_info *cmount, const char *path,
>  extern "C" int ceph_mknod(struct ceph_mount_info *cmount, const char *path,
>  			  mode_t mode, dev_t rdev)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->mknod(path, mode, rdev);
>  }
>  
>  extern "C" int ceph_open(struct ceph_mount_info *cmount, const char *path,
>  			 int flags, mode_t mode)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->open(path, flags, mode);
>  }
>  
>  extern "C" int ceph_close(struct ceph_mount_info *cmount, int fd)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->close(fd);
>  }
>  
>  extern "C" loff_t ceph_lseek(struct ceph_mount_info *cmount, int fd,
>  			     loff_t offset, int whence)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->lseek(fd, offset, whence);
>  }
>  
>  extern "C" int ceph_read(struct ceph_mount_info *cmount, int fd, char *buf,
>  			 loff_t size, loff_t offset)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->read(fd, buf, size, offset);
>  }
>  
>  extern "C" int ceph_write(struct ceph_mount_info *cmount, int fd, const char *buf,
>  			  loff_t size, loff_t offset)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->write(fd, buf, size, offset);
>  }
>  
>  extern "C" int ceph_ftruncate(struct ceph_mount_info *cmount, int fd, loff_t size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->ftruncate(fd, size);
>  }
>  
>  extern "C" int ceph_fsync(struct ceph_mount_info *cmount, int fd, int syncdataonly)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->fsync(fd, syncdataonly);
>  }
>  
>  extern "C" int ceph_fstat(struct ceph_mount_info *cmount, int fd, struct stat *stbuf)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->fstat(fd, stbuf);
>  }
>  
>  extern "C" int ceph_sync_fs(struct ceph_mount_info *cmount)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    return cmount->get_client()->sync_fs();
>  }
>  
> @@ -522,7 +620,11 @@ extern "C" int ceph_sync_fs(struct ceph_mount_info *cmount)
>  extern "C" int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int fh)
>  {
>    struct ceph_file_layout l;
> -  int r = cmount->get_client()->describe_layout(fh, &l);
> +  int r;
> +
> +  if (!cmount->is_mounted())
> +    return -EDOM;
> +  r = cmount->get_client()->describe_layout(fh, &l);
>    if (r < 0)
>      return r;
>    return l.fl_stripe_unit;
> @@ -531,7 +633,11 @@ extern "C" int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int fh)
>  extern "C" int ceph_get_file_pool(struct ceph_mount_info *cmount, int fh)
>  {
>    struct ceph_file_layout l;
> -  int r = cmount->get_client()->describe_layout(fh, &l);
> +  int r;
> +
> +  if (!cmount->is_mounted())
> +    return -EDOM;
> +  r = cmount->get_client()->describe_layout(fh, &l);
>    if (r < 0)
>      return r;
>    return l.fl_pg_pool;
> @@ -540,7 +646,11 @@ extern "C" int ceph_get_file_pool(struct ceph_mount_info *cmount, int fh)
>  extern "C" int ceph_get_file_replication(struct ceph_mount_info *cmount, int fh)
>  {
>    struct ceph_file_layout l;
> -  int r = cmount->get_client()->describe_layout(fh, &l);
> +  int r;
> +
> +  if (!cmount->is_mounted())
> +    return -EDOM;
> +  r = cmount->get_client()->describe_layout(fh, &l);
>    if (r < 0)
>      return r;
>    int rep = cmount->get_client()->get_pool_replication(l.fl_pg_pool);
> @@ -550,6 +660,8 @@ extern "C" int ceph_get_file_replication(struct ceph_mount_info *cmount, int fh)
>  extern "C" int ceph_set_default_file_stripe_unit(struct ceph_mount_info *cmount,
>  						 int stripe)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    cmount->get_client()->set_default_file_stripe_unit(stripe);
>    return 0;
>  }
> @@ -557,12 +669,16 @@ extern "C" int ceph_set_default_file_stripe_unit(struct ceph_mount_info *cmount,
>  extern "C" int ceph_set_default_file_stripe_count(struct ceph_mount_info *cmount,
>  						  int count)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    cmount->get_client()->set_default_file_stripe_unit(count);
>    return 0;
>  }
>  
>  extern "C" int ceph_set_default_object_size(struct ceph_mount_info *cmount, int size)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    cmount->get_client()->set_default_object_size(size);
>    return 0;
>  }
> @@ -570,6 +686,8 @@ extern "C" int ceph_set_default_object_size(struct ceph_mount_info *cmount, int
>  extern "C" int ceph_set_default_file_replication(struct ceph_mount_info *cmount,
>  						 int replication)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    cmount->get_client()->set_default_file_replication(replication);
>    return 0;
>  }
> @@ -590,6 +708,9 @@ extern "C" int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int
>    if (naddr < 0)
>      return -EINVAL;
>  
> +  if (!cmount->is_mounted())
> +    return -EDOM;
> +
>    r = cmount->get_client()->get_file_stripe_address(fh, offset, address);
>    if (r < 0)
>      return r;
> @@ -606,6 +727,8 @@ extern "C" int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int
>  
>  extern "C" int ceph_localize_reads(struct ceph_mount_info *cmount, int val)
>  {
> +  if (!cmount->is_mounted())
> +    return -EDOM;
>    if (!val)
>      cmount->get_client()->clear_filer_flags(CEPH_OSD_FLAG_LOCALIZE_READS);
>    else
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
