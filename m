From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 2/5] ceph: Propagate dentry down to inode_change_ok()
Date: Fri, 23 Sep 2016 15:45:27 +0800
Message-ID: <354FA312-0132-4C88-BCBB-05686037C234@redhat.com>
References: <1474299059-14806-1-git-send-email-jack@suse.cz>
 <1474299059-14806-3-git-send-email-jack@suse.cz>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1474299059-14806-3-git-send-email-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: ceph-devel.vger.kernel.org


> On 19 Sep 2016, at 23:30, Jan Kara <jack@suse.cz> wrote:
> 
> To avoid clearing of capabilities or security related extended
> attributes too early, inode_change_ok() will need to take dentry instead
> of inode. ceph_setattr() has the dentry easily available but
> __ceph_setattr() is also called from ceph_set_acl() where dentry is not
> easily available. Luckily that call path does not need inode_change_ok()
> to be called anyway. So reorganize functions a bit so that
> inode_change_ok() is called only from paths where dentry is available.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> fs/ceph/acl.c   |  5 +++++
> fs/ceph/inode.c | 19 +++++++++++--------
> 2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 013151d50069..a2cedfde75eb 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -127,6 +127,11 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> 			goto out_free;
> 	}
> 
> +	if (ceph_snap(inode) != CEPH_NOSNAP) {
> +		ret = -EROFS;
> +		goto out_free;
> +	}
> +
> 	if (new_mode != old_mode) {
> 		newattrs.ia_mode = new_mode;
> 		newattrs.ia_valid = ATTR_MODE;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index dd3a6dbf71eb..2aa3c0bcf3a5 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1905,13 +1905,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
> 	int inode_dirty_flags = 0;
> 	bool lock_snap_rwsem = false;
> 
> -	if (ceph_snap(inode) != CEPH_NOSNAP)
> -		return -EROFS;
> -
> -	err = inode_change_ok(inode, attr);
> -	if (err != 0)
> -		return err;
> -
> 	prealloc_cf = ceph_alloc_cap_flush();
> 	if (!prealloc_cf)
> 		return -ENOMEM;
> @@ -2124,7 +2117,17 @@ out_put:
>  */
> int ceph_setattr(struct dentry *dentry, struct iattr *attr)
> {
> -	return __ceph_setattr(d_inode(dentry), attr);
> +	struct inode *inode = d_inode(dentry);
> +	int err;
> +
> +	if (ceph_snap(inode) != CEPH_NOSNAP)
> +		return -EROFS;
> +
> +	err = inode_change_ok(inode, attr);
> +	if (err != 0)
> +		return err;
> +
> +	return __ceph_setattr(inode, attr);
> }

Acked-by: 'Yan, Zheng’ <zyan@redhat.com>
> 
> /*
> -- 
> 2.6.6
> 

