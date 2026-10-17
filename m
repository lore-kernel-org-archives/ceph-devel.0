Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161638F658;
	Sat, 17 Oct 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254228; cv=none; b=Qf8e1cmgtbgZu3VZi3ac5pDOE6UA8SYsqqrQdifqOviu1ip+KieZZqXC8UxQqiw2Rlv6X5pEJauYzUU8Y75qvoHOEyMLN/xFct9QUX4Hqp+WD45XpKMFZ98W6e6o55GQZrUWKfqvPsUwJomU0kp43OWSe0Hf9y04kHjSgaNODw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254228; c=relaxed/simple;
	bh=uhz8DacrZJX7JmvD8DLaThwU8e3T3P8arpE1du6ujC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnExrjjd/5iTNt9H1ny1ZK07lyZ0QOh2oRjVUxctz+H6RoNnbQhPZhRn+4+FXDokKRWTQUKuBW3MOcD2se58xfmZZVFFFkf0V/UtJUPJOLmy+JDDlRY7jAqh3pzyxinBIEaoH1De3AgwkCMfOmQCTSxOXr4glE/ApPXnXrQX0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HkJUBeL/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HkJUBeL/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E3tgvS70v3cczKpKgH1TcPvtnsqOE0CiA1/VCGLtcTs=; b=HkJUBeL/vi+pAEMSPDntCFIlcj
	LLt3OwBi4t6po+su6VTIjWGKsI4F7lfKW0PQHuiJu0ZttK4uSQZvJ75+mSk4vukAwAfg+lRBEWysp
	QMY/sBjiVhAuHmPt2cQSH8EkxYfZnphuUexDQOCyrGaQtf6H5a4wUuxaA8aE0x72K6kekBHSlnz8U
	54xjoYUsNlQzR9lo4WJbvMD97t5GIfC1rj4EOIjaBd7b5Sw9o6CQ8L+eZW89LZV2JVBOdFzRYhzAD
	tTg8Tx7NFwR3VD030LmrqTaHC54DHZ4xzQpRLsE1Q/5/78T3TmJacNJ2x0wi2aFewOGi6ACirYqOB
	yLPoYozg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI7C8-00000008Y7e-2bFH;
	Sat, 17 Oct 2026 16:23:41 +0000
Date: Sat, 17 Oct 2026 17:23:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubo.li@clyso.com,
	slava@dubeyko.com, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ceph: fail quarantined subvolume access with
 EACCES
Message-ID: <20261017162340.GI989762@ZenIV>
References: <cover.1792074165.git.amarkuze@redhat.com>
 <cover.1792241577.git.amarkuze@redhat.com>
 <e0ed00e6d17dc8c6603c7de42d4e7b48d483274b.1792241577.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ed00e6d17dc8c6603c7de42d4e7b48d483274b.1792241577.git.amarkuze@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

> +/* A snapshot path must reach a head inode to encode its snapshot name. */
> +static bool ceph_snapshot_has_path(struct inode *inode)
> +{
> +	struct dentry *alias = d_find_alias(inode);
> +	struct dentry *cur;
> +	unsigned int seq, depth = 0;
> +	bool connected = false;
> +
> +	if (!alias)
> +		return false;
> +
> +	rcu_read_lock();
> +	seq = read_seqbegin(&rename_lock);
> +	cur = alias;
> +	while (cur && depth++ < 256) {
> +		struct inode *in = d_inode_rcu(cur);
> +		struct dentry *parent;
> +
> +		if (!in)
> +			break;
> +		if (!ceph_in_snap(in)) {
> +			connected = true;
> +			break;
> +		}
> +		if (d_unhashed(cur) ||
> +		    (READ_ONCE(cur->d_flags) & DCACHE_DISCONNECTED))
> +			break;
> +		parent = READ_ONCE(cur->d_parent);
> +		if (!parent || parent == cur)
                    ^^^^^^^
Please, explain how could that possibly happen.

> +			break;
> +		cur = parent;
> +	}
> +	if (read_seqretry(&rename_lock, seq))
> +		connected = false;
> +	rcu_read_unlock();
> +	dput(alias);
> +	return connected;
> +}
> +
> +static int ceph_snapshot_reply_error(struct inode *inode,
> +				     struct ceph_mds_request *req, int mask)
> +{
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	bool have_xattrs;
> +
> +	if (!req->r_target_inode ||
> +	    ceph_ino(req->r_target_inode) != ceph_ino(inode) ||
> +	    ceph_snap(req->r_target_inode) != ceph_snap(inode))
> +		return -EOPNOTSUPP;
> +
> +	/* LOOKUPINO can authorize access without returning the requested blob. */
> +	if ((mask & CEPH_CAP_XATTR_SHARED) &&
> +	    req->r_reply_info.targeti.xattr_len < 4) {
> +		spin_lock(&ci->i_ceph_lock);
> +		have_xattrs = ci->i_xattrs.version != 0;
> +		spin_unlock(&ci->i_ceph_lock);
> +		if (!have_xattrs)
> +			return -EOPNOTSUPP;
> +	}
> +	if ((mask & CEPH_CAP_FILE_RD) &&
> +	    req->r_reply_info.targeti.inline_version == 0 &&
> +	    ceph_has_inline_data(ci) && i_size_read(inode) > 0)
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static int ceph_snapshot_lookupino(struct inode *inode,
> +				   struct folio *locked_folio, int mask)
> +{
> +	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
> +	struct ceph_mds_request *req;
> +	int err;
> +
> +	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPINO, USE_ANY_MDS);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +	/* No r_inode: an NFS alias may not encode a snapshot pathname. */
> +	req->r_ino1 = ceph_vino(inode);
> +	req->r_args.lookupino.snapid = cpu_to_le64(ceph_snap(inode));
> +	req->r_args.lookupino.mask = cpu_to_le32(mask);
> +	req->r_num_caps = 1;
> +	req->r_locked_folio = locked_folio;
> +	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	if (!err)
> +		err = ceph_snapshot_reply_error(inode, req, mask);
> +	if (locked_folio && !err) {
> +		u64 version = req->r_reply_info.targeti.inline_version;
> +
> +		if (version == 0)
> +			err = -EINVAL;
> +		else if (version == CEPH_INLINE_NONE || version == 1)
> +			err = -ENODATA;
> +		else
> +			err = req->r_reply_info.targeti.inline_len;
> +	}
> +	ceph_mdsc_put_request(req);
> +	return err;
> +}
> +
> +int ceph_snapshot_read_auth(struct inode *inode)
> +{
> +	/*
> +	 * Preserve a connected snapshot path: its head inode may have been
> +	 * deleted and no longer be cached by the MDS. Disconnected handles
> +	 * fall back to LOOKUPINO, with the exact inode and snapshot ID.
> +	 * The authorization is scoped to this operation, never cached.
> +	 */
> +	return ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, true);
> +}
> +
>  /*
>   * Verify that we have a lease on the given mask.  If not,
>   * do a getattr against an mds.
> @@ -3582,20 +3863,43 @@ int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
>  	struct ceph_client *cl = fsc->client;
>  	struct ceph_mds_client *mdsc = fsc->mdsc;
>  	struct ceph_mds_request *req;
> +	u64 qepoch;
>  	int mode;
>  	int err;
>  
>  	if (ceph_snap(inode) == CEPH_SNAPDIR) {
> +		struct inode *parent;
> +
>  		boutc(cl, "inode %p %llx.%llx SNAPDIR\n", inode,
>  		      ceph_vinop(inode));
> -		return 0;
> +		/* The synthetic snapdir has the real directory's ino. */
> +		parent = ceph_lookup_inode(inode->i_sb, ceph_ino(inode));
> +		if (IS_ERR(parent))
> +			return PTR_ERR(parent);
> +		err = ceph_do_getattr(parent, mask, true);
> +		iput(parent);
> +		return err;
>  	}
> +	if (ceph_in_snap(inode) && !ceph_snapshot_has_path(inode))
> +		return ceph_snapshot_lookupino(inode, locked_folio, mask);
> +
> +	/*
> +	 * Cached caps would satisfy getattr after the MDS has revoked
> +	 * access, and a short walk has no ancestor to consult. Ask the
> +	 * MDS so a lost quarantine-disable can clear the mark, and so
> +	 * an uncached parent chain is not treated as clear. Immutable snapshot
> +	 * caps cannot receive revocations and always require an MDS check.
> +	 */
> +	if (ceph_in_snap(inode) ||
> +	    ceph_inode_quarantine_state(inode) != CEPH_Q_CLEAR)
> +		force = true;
>  
>  	boutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
>  	      ceph_vinop(inode), ceph_cap_string(mask), inode->i_mode);
>  	if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mask, 1))
>  			return 0;
>  
> +	qepoch = (u64)atomic64_read_acquire(&mdsc->quarantine_epoch);
>  	mode = ceph_try_to_choose_auth_mds(inode, mask);
>  	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, mode);
>  	if (IS_ERR(req))
> @@ -3606,6 +3910,15 @@ int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
>  	req->r_args.getattr.mask = cpu_to_le32(mask);
>  	req->r_locked_folio = locked_folio;
>  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	if (ceph_in_snap(inode)) {
> +		if (err == -EINVAL || err == -ESTALE ||
> +		    (!err && ceph_snapshot_reply_error(inode, req, mask))) {
> +			ceph_mdsc_put_request(req);
> +			return ceph_snapshot_lookupino(inode, locked_folio, mask);
> +		}
> +	}
> +	if (!err && !ceph_in_snap(inode))
> +		ceph_quarantine_remember_clear(inode, qepoch, req->r_cred);
>  	if (locked_folio && err == 0) {
>  		u64 inline_version = req->r_reply_info.targeti.inline_version;
>  		if (inline_version == 0) {
> @@ -3751,8 +4064,14 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		return -ESTALE;
>  	}
>  
> -	/* Skip the getattr altogether if we're asked not to sync */
> -	if ((flags & AT_STATX_SYNC_TYPE) != AT_STATX_DONT_SYNC) {
> +	/*
> +	 * AT_STATX_DONT_SYNC would return the cached attrs. A
> +	 * quarantined inode, or one whose parents are not cached,
> +	 * still has to ask the MDS. Snapshot caps cannot receive revocations.
> +	 */
> +	if (ceph_in_snap(inode) ||
> +	    ceph_inode_quarantine_state(inode) != CEPH_Q_CLEAR ||
> +	    (flags & AT_STATX_SYNC_TYPE) != AT_STATX_DONT_SYNC) {
>  		err = ceph_do_getattr(inode,
>  				statx_to_caps(request_mask, inode->i_mode),
>  				flags & AT_STATX_FORCE_SYNC);
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index 12cb50e0a166..d152cad10c23 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -201,6 +201,10 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
>  	if (copy_from_user(&dl, arg, sizeof(dl)))
>  		return -EFAULT;
>  
> +	r = ceph_do_getattr(inode, CEPH_STAT_CAP_LAYOUT, false);
> +	if (r)
> +		return r;
> +
>  	down_read(&osdc->lock);
>  	ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, 1,
>  				      &dl.object_no, &dl.object_offset, &xlen);
> @@ -401,12 +405,18 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	case FS_IOC_GET_ENCRYPTION_POLICY:
>  		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		ret = ceph_quarantine_revalidate(inode);
>  		if (ret)
>  			return ret;
>  		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
>  
>  	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
>  		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		ret = ceph_quarantine_revalidate(inode);
>  		if (ret)
>  			return ret;
>  		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
> @@ -429,6 +439,9 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	case FS_IOC_GET_ENCRYPTION_NONCE:
>  		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		ret = ceph_quarantine_revalidate(inode);
>  		if (ret)
>  			return ret;
>  		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 816f5f2d32cc..67d4c6279e00 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -39,7 +39,14 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
>  	CEPHFS_FEATURE_SUBVOLUME_METRICS,
>  
> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_SUBVOLUME_METRICS,
> +	/*
> +	 * Bit 23 is CEPHFS_FEATURE_BLOCKDIFF on the MDS and is not
> +	 * advertised here. Bit 24 is subvolume quarantine; it must stay
> +	 * aligned with the userspace client.
> +	 */
> +	CEPHFS_FEATURE_QUARANTINE = 24,
> +
> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_QUARANTINE,
>  };
>  
>  #define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
> @@ -57,6 +64,7 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_HAS_OWNER_UIDGID,	\
>  	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,	\
>  	CEPHFS_FEATURE_SUBVOLUME_METRICS,	\
> +	CEPHFS_FEATURE_QUARANTINE,		\
>  }
>  
>  /*
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 0264bd9d705f..540f31121f84 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1394,8 +1394,6 @@ int ceph_set_acl(struct mnt_idmap *idmap,
>  		 struct dentry *dentry, struct posix_acl *acl, int type);
>  int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>  		       struct ceph_acl_sec_ctx *as_ctx);
> -void ceph_init_inode_acls(struct inode *inode,
> -			  struct ceph_acl_sec_ctx *as_ctx);
>  
>  static inline void ceph_forget_all_cached_acls(struct inode *inode)
>  {
> @@ -1412,11 +1410,6 @@ static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>  {
>  	return 0;
>  }
> -static inline void ceph_init_inode_acls(struct inode *inode,
> -					struct ceph_acl_sec_ctx *as_ctx)
> -{
> -}
> -
>  static inline void ceph_forget_all_cached_acls(struct inode *inode)
>  {
>  }
> @@ -1578,7 +1571,7 @@ static inline bool ceph_has_inline_data(const struct ceph_inode_info *ci)
>  /* file.c */
>  extern const struct file_operations ceph_file_fops;
>  
> -extern int ceph_renew_caps(struct inode *inode, int fmode);
> +int ceph_renew_caps(struct inode *inode, int fmode, bool force);
>  extern int ceph_open(struct inode *inode, struct file *file);
>  extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>  			    struct file *file, unsigned flags, umode_t mode);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 4cba6e7bffd3..7fd307fcbe5a 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -997,6 +997,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
>  	struct ceph_vxattr *vxattr;
>  	int req_mask;
>  	ssize_t err;
> +	bool ask_mds = false;
>  
>  	if (strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN))
>  		goto handle_non_vxattrs;
> @@ -1034,7 +1035,19 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
>  	      ceph_vinop(inode), name, ci->i_xattrs.version,
>  	      ci->i_xattrs.index_version);
>  
> -	if (ci->i_xattrs.version == 0 ||
> +	/*
> +	 * A shared cap would answer from the cache. The state check may
> +	 * schedule, so drop i_ceph_lock first. A reply reading the blob
> +	 * it just installed must still use that cache.
> +	 */
> +	if (!ceph_current_fill_trace_request()) {
> +		spin_unlock(&ci->i_ceph_lock);
> +		ask_mds = ceph_in_snap(inode) ||
> +			  ceph_inode_quarantine_state(inode) != CEPH_Q_CLEAR;
> +		spin_lock(&ci->i_ceph_lock);
> +	}
> +
> +	if (ask_mds || ci->i_xattrs.version == 0 ||
>  	    !((req_mask & CEPH_CAP_XATTR_SHARED) ||
>  	      __ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1))) {
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -1089,6 +1102,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
>  	struct ceph_client *cl = ceph_inode_to_client(inode);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	bool len_only = (size == 0);
> +	bool ask_mds = false;
>  	u32 namelen;
>  	int err;
>  	struct ceph_journal_info __ji;
> @@ -1100,7 +1114,15 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
>  	      ceph_vinop(inode), ci->i_xattrs.version,
>  	      ci->i_xattrs.index_version);
>  
> -	if (ci->i_xattrs.version == 0 ||
> +	/* Same as __ceph_getxattr(): do not serve a shared cap hit. */
> +	if (!ceph_current_fill_trace_request()) {
> +		spin_unlock(&ci->i_ceph_lock);
> +		ask_mds = ceph_in_snap(inode) ||
> +			  ceph_inode_quarantine_state(inode) != CEPH_Q_CLEAR;
> +		spin_lock(&ci->i_ceph_lock);
> +	}
> +
> +	if (ask_mds || ci->i_xattrs.version == 0 ||
>  	    !__ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1)) {
>  		spin_unlock(&ci->i_ceph_lock);
>  		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
> @@ -1222,6 +1244,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>  	int required_blob_size;
>  	bool check_realm = false;
>  	bool lock_snap_rwsem = false;
> +	bool checked_quarantine = false;
>  
>  	if (ceph_in_snap(inode))
>  		return -EROFS;
> @@ -1319,6 +1342,33 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>  		goto retry;
>  	}
>  
> +	/*
> +	 * XATTR_EXCL applies the new blob with no MDS round trip.
> +	 * The state check may schedule, so drop i_ceph_lock first.
> +	 */
> +	if (!checked_quarantine) {
> +		enum ceph_qstate qstate;
> +
> +		spin_unlock(&ci->i_ceph_lock);
> +		qstate = ceph_inode_quarantine_write_state(inode);
> +		if (qstate == CEPH_Q_UNDER &&
> +		    ceph_inode_quarantine_direct(inode)) {
> +			ceph_buffer_put(old_blob);
> +			if (lock_snap_rwsem)
> +				up_read(&mdsc->snap_rwsem);
> +			err = -EACCES;
> +			goto out;
> +		}
> +		if (qstate != CEPH_Q_CLEAR) {
> +			ceph_buffer_put(old_blob);
> +			old_blob = NULL;
> +			goto do_sync_unlocked;
> +		}
> +		checked_quarantine = true;
> +		spin_lock(&ci->i_ceph_lock);
> +		goto retry;
> +	}
> +
>  	err = __set_xattr(ci, newname, name_len, newval, val_len,
>  			  flags, value ? 1 : -1, &xattr);
>  
> -- 
> 2.34.1
> 
> 
