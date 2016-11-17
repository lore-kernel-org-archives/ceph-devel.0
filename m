From: Jeremy Allison <jra@samba.org>
Subject: Re: [PATCH] VFS: convert to using ceph_statx structures and
 functions, when available
Date: Thu, 17 Nov 2016 11:50:25 -0800
Message-ID: <20161117195025.GD27181@jra3>
References: <1479406437-10409-1-git-send-email-jlayton@samba.org>
Reply-To: Jeremy Allison <jra@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:45762 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750813AbcKQTub (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Nov 2016 14:50:31 -0500
Content-Disposition: inline
In-Reply-To: <1479406437-10409-1-git-send-email-jlayton@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@samba.org>
Cc: samba-technical@lists.samba.org, ceph-devel@vger.kernel.org, ira@wakeful.net

On Thu, Nov 17, 2016 at 01:13:57PM -0500, Jeff Layton wrote:
> Add a configure test for the ceph_statx function, and use that to
> determine whether to compile in new functions that use it and its
> variants, or whether to use a the older code that fetches birthtimes
> from an xattr.
> 
> For cephwrap_lstat, we can use ceph_statx with the AT_SYMLINK_NOFOLLOW
> flag to get the right lookup semantics.
> 
> For setting the times via cephwrap_ntimes, We can just use ceph_setattrx
> and pass them all in at the same time.

Can you change the DEBUG(10,....)
calls to DBG_DEBUG(...) please ?

I'm trying to change all new code submissions
to the new:

/*
 * Debug levels matching RFC 3164
 */
#define DBGLVL_ERR       0      /* error conditions */
#define DBGLVL_WARNING   1      /* warning conditions */
#define DBGLVL_NOTICE    3      /* normal, but significant, condition */
#define DBGLVL_INFO      5      /* informational message */
#define DBGLVL_DEBUG    10      /* debug-level message */

#define DBG_ERR(...)            DBG_PREFIX(DBGLVL_ERR,          (__VA_ARGS__))
#define DBG_WARNING(...)        DBG_PREFIX(DBGLVL_WARNING,      (__VA_ARGS__))
#define DBG_NOTICE(...)         DBG_PREFIX(DBGLVL_NOTICE,       (__VA_ARGS__))
#define DBG_INFO(...)           DBG_PREFIX(DBGLVL_INFO,         (__VA_ARGS__))
#define DBG_DEBUG(...)          DBG_PREFIX(DBGLVL_DEBUG,        (__VA_ARGS__))

macros, and eventually retire DEBUG(x,..).

Cheers,

	Jeremy.

> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  source3/modules/vfs_ceph.c | 208 ++++++++++++++++++++++++++++++++++++++-------
>  source3/wscript            |   2 +
>  2 files changed, 177 insertions(+), 33 deletions(-)
> 
> diff --git a/source3/modules/vfs_ceph.c b/source3/modules/vfs_ceph.c
> index 8e0268378043..ab9c251c6074 100644
> --- a/source3/modules/vfs_ceph.c
> +++ b/source3/modules/vfs_ceph.c
> @@ -535,6 +535,147 @@ static int cephwrap_fsync(struct vfs_handle_struct *handle, files_struct *fsp)
>  	WRAP_RETURN(result);
>  }
>  
> +#ifdef HAVE_CEPH_STATX
> +#define SAMBA_STATX_ATTR_MASK	(CEPH_STATX_BASIC_STATS|CEPH_STATX_BTIME)
> +
> +static void init_stat_ex_from_ceph_statx(struct stat_ex *dst, const struct ceph_statx *stx)
> +{
> +	if ((stx->stx_mask & SAMBA_STATX_ATTR_MASK) != SAMBA_STATX_ATTR_MASK)
> +		DBG_WARNING("%s: stx->stx_mask is incorrect (wanted %x, got %x)",
> +				__func__, SAMBA_STATX_ATTR_MASK, stx->stx_mask);
> +
> +	dst->st_ex_dev = stx->stx_dev;
> +	dst->st_ex_rdev = stx->stx_rdev;
> +	dst->st_ex_ino = stx->stx_ino;
> +	dst->st_ex_mode = stx->stx_mode;
> +	dst->st_ex_uid = stx->stx_uid;
> +	dst->st_ex_gid = stx->stx_gid;
> +	dst->st_ex_size = stx->stx_size;
> +	dst->st_ex_nlink = stx->stx_nlink;
> +	dst->st_ex_atime = stx->stx_atime;
> +	dst->st_ex_btime = stx->stx_btime;
> +	dst->st_ex_ctime = stx->stx_ctime;
> +	dst->st_ex_mtime = stx->stx_mtime;
> +	dst->st_ex_calculated_birthtime = false;
> +	dst->st_ex_blksize = stx->stx_blksize;
> +	dst->st_ex_blocks = stx->stx_blocks;
> +}
> +
> +static int cephwrap_stat(struct vfs_handle_struct *handle,
> +			struct smb_filename *smb_fname)
> +{
> +	int result = -1;
> +	struct ceph_statx stx;
> +
> +	DEBUG(10, ("[CEPH] stat(%p, %s)\n", handle, smb_fname_str_dbg(smb_fname)));
> +
> +	if (smb_fname->stream_name) {
> +		errno = ENOENT;
> +		return result;
> +	}
> +
> +	result = ceph_statx(handle->data, smb_fname->base_name, &stx,
> +				SAMBA_STATX_ATTR_MASK, 0);
> +	DEBUG(10, ("[CEPH] statx(...) = %d\n", result));
> +	if (result < 0) {
> +		WRAP_RETURN(result);
> +	} else {
> +		DEBUG(10, ("[CEPH]\tstx = {dev = %llx, ino = %llu, mode = 0x%x, nlink = %llu, "
> +			   "uid = %d, gid = %d, rdev = %llx, size = %llu, blksize = %llu, "
> +			   "blocks = %llu, atime = %llu, mtime = %llu, ctime = %llu, btime = %llu}\n",
> +			   llu(stx.stx_dev), llu(stx.stx_ino), stx.stx_mode,
> +			   llu(stx.stx_nlink), stx.stx_uid, stx.stx_gid, llu(stx.stx_rdev),
> +			   llu(stx.stx_size), llu(stx.stx_blksize),
> +			   llu(stx.stx_blocks), llu(stx.stx_atime.tv_sec), llu(stx.stx_mtime.tv_sec),
> +			   llu(stx.stx_ctime.tv_sec), llu(stx.stx_btime.tv_sec)));
> +	}
> +	init_stat_ex_from_ceph_statx(&smb_fname->st, &stx);
> +	DEBUG(10, ("[CEPH] mode = 0x%x\n", smb_fname->st.st_ex_mode));
> +	return result;
> +}
> +
> +static int cephwrap_fstat(struct vfs_handle_struct *handle, files_struct *fsp, SMB_STRUCT_STAT *sbuf)
> +{
> +	int result = -1;
> +	struct ceph_statx stx;
> +
> +	DEBUG(10, ("[CEPH] fstat(%p, %d)\n", handle, fsp->fh->fd));
> +	result = ceph_fstatx(handle->data, fsp->fh->fd, &stx,
> +				SAMBA_STATX_ATTR_MASK, 0);
> +	DEBUG(10, ("[CEPH] fstat(...) = %d\n", result));
> +	if (result < 0) {
> +		WRAP_RETURN(result);
> +	} else {
> +		DEBUG(10, ("[CEPH]\tstx = {dev = %llx, ino = %llu, mode = 0x%x, nlink = %llu, "
> +			   "uid = %d, gid = %d, rdev = %llx, size = %llu, blksize = %llu, "
> +			   "blocks = %llu, atime = %llu, mtime = %llu, ctime = %llu, btime = %llu}\n",
> +			   llu(stx.stx_dev), llu(stx.stx_ino), stx.stx_mode,
> +			   llu(stx.stx_nlink), stx.stx_uid, stx.stx_gid, llu(stx.stx_rdev),
> +			   llu(stx.stx_size), llu(stx.stx_blksize),
> +			   llu(stx.stx_blocks), llu(stx.stx_atime.tv_sec), llu(stx.stx_mtime.tv_sec),
> +			   llu(stx.stx_ctime.tv_sec), llu(stx.stx_btime.tv_sec)));
> +	}
> +	init_stat_ex_from_ceph_statx(sbuf, &stx);
> +	DEBUG(10, ("[CEPH] mode = 0x%x\n", sbuf->st_ex_mode));
> +	return result;
> +}
> +
> +static int cephwrap_lstat(struct vfs_handle_struct *handle,
> +			 struct smb_filename *smb_fname)
> +{
> +	int result = -1;
> +	struct ceph_statx stx;
> +
> +	DEBUG(10, ("[CEPH] lstat(%p, %s)\n", handle, smb_fname_str_dbg(smb_fname)));
> +
> +	if (smb_fname->stream_name) {
> +		errno = ENOENT;
> +		return result;
> +	}
> +
> +	result = ceph_statx(handle->data, smb_fname->base_name, &stx,
> +				SAMBA_STATX_ATTR_MASK, AT_SYMLINK_NOFOLLOW);
> +	DEBUG(10, ("[CEPH] lstat(...) = %d\n", result));
> +	if (result < 0) {
> +		WRAP_RETURN(result);
> +	}
> +	init_stat_ex_from_ceph_statx(&smb_fname->st, &stx);
> +	return result;
> +}
> +
> +static int cephwrap_ntimes(struct vfs_handle_struct *handle,
> +			 const struct smb_filename *smb_fname,
> +			 struct smb_file_time *ft)
> +{
> +	struct ceph_statx stx = { 0 };
> +	int result;
> +	int mask = 0;
> +
> +	if (!null_timespec(ft->atime)) {
> +		stx.stx_atime = ft->atime;
> +		mask |= CEPH_SETATTR_ATIME;
> +	}
> +	if (!null_timespec(ft->mtime)) {
> +		stx.stx_mtime = ft->mtime;
> +		mask |= CEPH_SETATTR_MTIME;
> +	}
> +	if (!null_timespec(ft->create_time)) {
> +		stx.stx_btime = ft->create_time;
> +		mask |= CEPH_SETATTR_BTIME;
> +	}
> +
> +	if (!mask)
> +		return 0;
> +
> +	result = ceph_setattrx(handle->data, smb_fname->base_name, &stx, mask, 0);
> +	DEBUG(10, ("[CEPH] ntimes(%p, %s, {%ld, %ld, %ld, %ld}) = %d\n", handle, smb_fname_str_dbg(smb_fname),
> +				ft->mtime.tv_sec, ft->atime.tv_sec, ft->ctime.tv_sec,
> +				ft->create_time.tv_sec, result));
> +	return result;
> +}
> +
> +#else /* HAVE_CEPH_STATX */
> +
>  static int cephwrap_stat(struct vfs_handle_struct *handle,
>  			struct smb_filename *smb_fname)
>  {
> @@ -617,6 +758,40 @@ static int cephwrap_lstat(struct vfs_handle_struct *handle,
>  	return result;
>  }
>  
> +static int cephwrap_ntimes(struct vfs_handle_struct *handle,
> +			 const struct smb_filename *smb_fname,
> +			 struct smb_file_time *ft)
> +{
> +	struct utimbuf buf;
> +	int result;
> +
> +	if (null_timespec(ft->atime)) {
> +		buf.actime = smb_fname->st.st_ex_atime.tv_sec;
> +	} else {
> +		buf.actime = ft->atime.tv_sec;
> +	}
> +	if (null_timespec(ft->mtime)) {
> +		buf.modtime = smb_fname->st.st_ex_mtime.tv_sec;
> +	} else {
> +		buf.modtime = ft->mtime.tv_sec;
> +	}
> +	if (!null_timespec(ft->create_time)) {
> +		set_create_timespec_ea(handle->conn, smb_fname,
> +				       ft->create_time);
> +	}
> +	if (buf.actime == smb_fname->st.st_ex_atime.tv_sec &&
> +	    buf.modtime == smb_fname->st.st_ex_mtime.tv_sec) {
> +		return 0;
> +	}
> +
> +	result = ceph_utime(handle->data, smb_fname->base_name, &buf);
> +	DEBUG(10, ("[CEPH] ntimes(%p, %s, {%ld, %ld, %ld, %ld}) = %d\n", handle, smb_fname_str_dbg(smb_fname),
> +				ft->mtime.tv_sec, ft->atime.tv_sec, ft->ctime.tv_sec,
> +				ft->create_time.tv_sec, result));
> +	return result;
> +}
> +#endif /* HAVE_CEPH_STATX */
> +
>  static int cephwrap_unlink(struct vfs_handle_struct *handle,
>  			  const struct smb_filename *smb_fname)
>  {
> @@ -769,39 +944,6 @@ static char *cephwrap_getwd(struct vfs_handle_struct *handle)
>  	return SMB_STRDUP(cwd);
>  }
>  
> -static int cephwrap_ntimes(struct vfs_handle_struct *handle,
> -			 const struct smb_filename *smb_fname,
> -			 struct smb_file_time *ft)
> -{
> -	struct utimbuf buf;
> -	int result;
> -
> -	if (null_timespec(ft->atime)) {
> -		buf.actime = smb_fname->st.st_ex_atime.tv_sec;
> -	} else {
> -		buf.actime = ft->atime.tv_sec;
> -	}
> -	if (null_timespec(ft->mtime)) {
> -		buf.modtime = smb_fname->st.st_ex_mtime.tv_sec;
> -	} else {
> -		buf.modtime = ft->mtime.tv_sec;
> -	}
> -	if (!null_timespec(ft->create_time)) {
> -		set_create_timespec_ea(handle->conn, smb_fname,
> -				       ft->create_time);
> -	}
> -	if (buf.actime == smb_fname->st.st_ex_atime.tv_sec &&
> -	    buf.modtime == smb_fname->st.st_ex_mtime.tv_sec) {
> -		return 0;
> -	}
> -
> -	result = ceph_utime(handle->data, smb_fname->base_name, &buf);
> -	DEBUG(10, ("[CEPH] ntimes(%p, %s, {%ld, %ld, %ld, %ld}) = %d\n", handle, smb_fname_str_dbg(smb_fname),
> -				ft->mtime.tv_sec, ft->atime.tv_sec, ft->ctime.tv_sec,
> -				ft->create_time.tv_sec, result));
> -	return result;
> -}
> -
>  static int strict_allocate_ftruncate(struct vfs_handle_struct *handle, files_struct *fsp, off_t len)
>  {
>  	off_t space_to_write;
> diff --git a/source3/wscript b/source3/wscript
> index 5ce1b77e23b1..c6b2421c45b7 100644
> --- a/source3/wscript
> +++ b/source3/wscript
> @@ -1582,6 +1582,8 @@ main() {
>      if conf.CHECK_HEADERS('cephfs/libcephfs.h', False, False, 'cephfs') and conf.CHECK_LIB('cephfs', shlib=True) and Options.options.with_cephfs:
>          if Options.options.with_acl_support:
>              conf.DEFINE('HAVE_CEPH', '1')
> +            if conf.CHECK_FUNCS_IN('ceph_statx', 'cephfs', headers='cephfs/libcephfs.h'):
> +                conf.DEFINE('HAVE_CEPH_STATX', '1')
>          else:
>              Logs.warn("ceph support disabled due to --without-acl-support")
>              conf.undefine('HAVE_CEPH')
> -- 
> 2.7.4
> 
> 
