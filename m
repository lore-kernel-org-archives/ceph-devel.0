From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 1/2] ceph: increase i_release_count when clear
 I_COMPLETE flag
Date: Thu, 7 Mar 2013 13:03:39 -0800
Message-ID: <F994D6BB71B642259997BA453CFB0288@inktank.com>
References: <1362656170-4337-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50056 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847Ab3CGVDn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 16:03:43 -0500
Received: by mail-pa0-f44.google.com with SMTP id kp1so749468pab.17
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 13:03:43 -0800 (PST)
In-Reply-To: <1362656170-4337-1-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

I'm pulling this in for now to make sure this clears out that ENOENT bu=
g we hit =E2=80=94 but shouldn't we be fixing ceph_i_clear() to always =
bump the i_release_count? It doesn't seem like it would ever be correct=
 without it, and these are the only two callers. =20

The second one looks good to us and we'll test it but of course that ca=
n't go upstream through our tree.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thursday, March 7, 2013 at 3:36 AM, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.c=
om)>
> =20
> If some dentries were pruned or FILE_SHARED cap was revoked while
> readdir is in progress. make sure ceph_readdir() does not mark the
> directory as complete.
> =20
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@=
intel.com)>
> ---
> fs/ceph/caps.c | 1 +
> fs/ceph/dir.c | 13 +++++++++++--
> 2 files changed, 12 insertions(+), 2 deletions(-)
> =20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 76634f4..35cebf3 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -500,6 +500,7 @@ static void __check_cap_issue(struct ceph_inode_i=
nfo *ci, struct ceph_cap *cap,
> if (S_ISDIR(ci->vfs_inode.i_mode)) {
> dout(" marking %p NOT complete\n", &ci->vfs_inode);
> ci->i_ceph_flags &=3D ~CEPH_I_COMPLETE;
> + ci->i_release_count++;
> }
> }
> }
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 76821be..068304c 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -909,7 +909,11 @@ static int ceph_rename(struct inode *old_dir, st=
ruct dentry *old_dentry,
> */
> =20
> /* d_move screws up d_subdirs order */
> - ceph_i_clear(new_dir, CEPH_I_COMPLETE);
> + struct ceph_inode_info *ci =3D ceph_inode(new_dir);
> + spin_lock(&ci->i_ceph_lock);
> + ci->i_ceph_flags &=3D ~CEPH_I_COMPLETE;
> + ci->i_release_count++;
> + spin_unlock(&ci->i_ceph_lock);
> =20
> d_move(old_dentry, new_dentry);
> =20
> @@ -1073,6 +1077,7 @@ static int ceph_snapdir_d_revalidate(struct den=
try *dentry,
> */
> static void ceph_d_prune(struct dentry *dentry)
> {
> + struct ceph_inode_info *ci;
> dout("ceph_d_prune %p\n", dentry);
> =20
> /* do we have a valid parent? */
> @@ -1087,7 +1092,11 @@ static void ceph_d_prune(struct dentry *dentry=
)
> * we hold d_lock, so d_parent is stable, and d_fsdata is never
> * cleared until d_release
> */
> - ceph_i_clear(dentry->d_parent->d_inode, CEPH_I_COMPLETE);
> + ci =3D ceph_inode(dentry->d_parent->d_inode);
> + spin_lock(&ci->i_ceph_lock);
> + ci->i_ceph_flags &=3D ~CEPH_I_COMPLETE;
> + ci->i_release_count++;
> + spin_unlock(&ci->i_ceph_lock);
> }
> =20
> /*
> -- =20
> 1.7.11.7



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
