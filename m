From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [RFC PATCH 2/3] ceph: quotas: support for ceph.quota.max_files
Date: Thu, 7 Sep 2017 22:22:20 +0800
Message-ID: <B56DB47D-CFD8-49E5-8483-CF591488DD2D@redhat.com>
References: <20170906141224.11813-1-lhenriques@suse.com>
 <20170906141224.11813-3-lhenriques@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754862AbdIGOWe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 7 Sep 2017 10:22:34 -0400
In-Reply-To: <20170906141224.11813-3-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Fajerski <jfajerski@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>


> On 6 Sep 2017, at 22:12, Luis Henriques <lhenriques@suse.com> wrote:
> 
> This patch adds support for the max_files quota.  It hooks into all the
> ceph functions that add new filesystem objects that need to be checked
> against the quota limit.  -EDQUOT is returned when this limit is hit.
> 
> Note that we're not checking quotas on ceph_link().  ceph_link doesn't
> really create a new inode,  and since the MDS doesn't update the directory
> statistics when a new (hard) link is created (only with symlinks), they
> are not accounted as a new file.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> fs/ceph/dir.c   | 11 +++++++++++
> fs/ceph/file.c  |  4 +++-
> fs/ceph/quota.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> fs/ceph/super.h |  1 +
> 4 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index ef7240ace576..fb6adcf0ff51 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -815,6 +815,9 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
> 	if (ceph_snap(dir) != CEPH_NOSNAP)
> 		return -EROFS;
> 
> +	if (ceph_quota_is_quota_files_exceeded(dir))
> +		return -EDQUOT;
> +
> 	err = ceph_pre_init_acls(dir, &mode, &acls);
> 	if (err < 0)
> 		return err;
> @@ -868,6 +871,9 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> 	if (ceph_snap(dir) != CEPH_NOSNAP)
> 		return -EROFS;
> 
> +	if (ceph_quota_is_quota_files_exceeded(dir))
> +		return -EDQUOT;
> +
> 	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
> 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
> 	if (IS_ERR(req)) {
> @@ -917,6 +923,11 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
> 		goto out;
> 	}
> 
> +	if (ceph_quota_is_quota_files_exceeded(dir)) {
> +		err = -EDQUOT;
> +		goto out;
> +	}
> +
> 	mode |= S_IFDIR;
> 	err = ceph_pre_init_acls(dir, &mode, &acls);
> 	if (err < 0)
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3d48c415f3cb..708a9b841382 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -370,7 +370,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> 	struct ceph_mds_request *req;
> 	struct dentry *dn;
> 	struct ceph_acls_info acls = {};
> -       int mask;
> +	int mask;
> 	int err;
> 
> 	dout("atomic_open %p dentry %p '%pd' %s flags %d mode 0%o\n",
> @@ -381,6 +381,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> 		return -ENAMETOOLONG;
> 
> 	if (flags & O_CREAT) {
> +		if (ceph_quota_is_quota_files_exceeded(dir))
> +			return -EDQUOT;
> 		err = ceph_pre_init_acls(dir, &mode, &acls);
> 		if (err < 0)
> 			return err;
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index c02d73a8d167..1bd02658f16a 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -57,3 +57,45 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
> 
> 	iput(inode);
> }
> +
> +bool ceph_quota_is_quota_files_exceeded(struct inode *inode)
> +{
> +	struct ceph_inode_info *ci;
> +	struct dentry *next, *parent;
> +	u64 max_files;
> +	u64 rentries = 0;
> +	unsigned seq;
> +	bool result = false;
> +
> +	WARN_ON(!S_ISDIR(inode->i_mode));
> +
> +retry:
> +	seq = read_seqbegin(&rename_lock);
> +	ci = ceph_inode(inode);
> +	next = d_find_any_alias(inode);
> +
> +	while (true) {
> +		spin_lock(&ci->i_ceph_lock);
> +		max_files = ci->i_max_files;
> +		rentries = ci->i_rfiles + ci->i_rsubdirs;
> +		spin_unlock(&ci->i_ceph_lock);
> +
> +		if ((max_files && (rentries >= max_files)) || IS_ROOT(next))
> +			break;
> +
> +		parent = dget_parent(next);
> +		ci = ceph_inode(d_inode(parent));
> +		dput(next);
> +		next = parent;
> +	}
> +
> +	dput(next);
> +
> +	if (read_seqretry(&rename_lock, seq))
> +		goto retry;
> +
> +	if (max_files && (rentries >= max_files))
> +		result = true;

This bottom-up dentry traversal code worries me. I vaguely remember that bottom-up
dentry traversal in kernel is discouraged. Then there are multiples clients modifying
the filesystem at the same time, the rename_lock does not help. That's why user space
code Client::get_quota_root() checks dentry lease and does lookup parent. I’m not sure
if we can do the same operations in kernel, because locking is much more complex in
kernel.

For the long term, I prefer unifying quota and snapshot implementation. The inode
trace in MClientReply contains information about which quota realm the inode belongs
to. So client can find quota information easily. (This requires bigger change for both
mds and client)

Regards
Yan, Zheng



> +
> +	return result;
> +}
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 50c96ea7dc7c..ef131107dbf6 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1011,5 +1011,6 @@ extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
> extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
> 			      struct ceph_mds_session *session,
> 			      struct ceph_msg *msg);
> +extern bool ceph_quota_is_quota_files_exceeded(struct inode *inode);
> 
> #endif /* _FS_CEPH_SUPER_H */

