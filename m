From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [RFC PATCH v3 3/3] ceph: quota: don't allow cross-quota renames
Date: Thu, 21 Dec 2017 16:10:16 +0800
Message-ID: <CAAM7YAmsFnTDk=4vJwih2UxCc_jfEpR4HzA+8F79Cg08804xEA@mail.gmail.com>
References: <20171220151841.22355-1-lhenriques@suse.com> <20171220151841.22355-4-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44836 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdLUIKR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Dec 2017 03:10:17 -0500
Received: by mail-ot0-f193.google.com with SMTP id d27so21811699ote.11
        for <ceph-devel@vger.kernel.org>; Thu, 21 Dec 2017 00:10:17 -0800 (PST)
In-Reply-To: <20171220151841.22355-4-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

On Wed, Dec 20, 2017 at 11:18 PM, Luis Henriques <lhenriques@suse.com> wrote:
> This patch changes ceph_rename so that -EXDEV is returned if an attempt is
> made to mv a file between two different dir trees with different quotas
> setup.
>
> Link: http://tracker.ceph.com/issues/22372
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/dir.c   |  5 +++++
>  fs/ceph/quota.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/super.h |  1 +
>  3 files changed, 64 insertions(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 66550d92b1ac..f6ac16caa1e9 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1090,6 +1090,11 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
>                 else
>                         return -EROFS;
>         }
> +       /* don't allow cross-quota renames */
> +       if ((old_dir != new_dir) &&
> +           (!ceph_quota_is_same_realm(old_dir, new_dir)))
> +               return -EXDEV;
> +
>         dout("rename dir %p dentry %p to dir %p dentry %p\n",
>              old_dir, old_dentry, new_dir, new_dentry);
>         req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 06b3268f8f7f..14e372deb633 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -20,6 +20,11 @@
>  #include "super.h"
>  #include "mds_client.h"
>
> +static inline bool ceph_has_quota(struct ceph_inode_info *ci)
> +{
> +       return (ci && (ci->i_max_files || ci->i_max_bytes));
> +}
> +
>  void ceph_handle_quota(struct ceph_mds_client *mdsc,
>                        struct ceph_mds_session *session,
>                        struct ceph_msg *msg)
> @@ -62,6 +67,59 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
>         iput(inode);
>  }
>
> +/*
> + * This function walks through the snaprealm for an inode and returns the
> + * ceph_inode_info for the first snaprealm that has quotas set (either max_files
> + * or max_bytes).  If the root is reached, return the root ceph_inode_info
> + * instead.
> + */
> +static struct ceph_inode_info *get_quota_realm(struct ceph_mds_client *mdsc,
> +                                              struct inode *inode)
> +{
> +       struct ceph_inode_info *ci = NULL;
> +       struct ceph_snap_realm *realm, *next;
> +       struct ceph_vino vino;
> +       struct inode *ino;

In ceph code,  'ino' is usually acronym for inode number. it's better
to use name 'in'

> +
> +       realm = ceph_inode(inode)->i_snap_realm;
> +       ceph_get_snap_realm(mdsc, realm);
> +       while (realm) {
> +               vino.ino = realm->ino;
> +               vino.snap = CEPH_NOSNAP;
> +               ino = ceph_find_inode(inode->i_sb, vino);
> +               if (!ino) {
> +                       pr_warn("Failed to find inode for %llu\n", vino.ino);
> +                       break;
> +               }
> +               ci = ceph_inode(ino);
> +               if (ceph_has_quota(ci) || (ci->i_vino.ino == CEPH_INO_ROOT)) {
> +                       iput(ino);
> +                       break;
> +               }
> +               iput(ino);
> +               next = realm->parent;
> +               ceph_get_snap_realm(mdsc, next);
> +               ceph_put_snap_realm(mdsc, realm);
> +               realm = next;
> +       }
> +       ceph_put_snap_realm(mdsc, realm);
> +
> +       return ci;

I think it's better to return realm, and let caller call ceph_put_snap_realm


> +}
> +
> +bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
> +{
> +       struct ceph_mds_client *mdsc = ceph_inode_to_client(old)->mdsc;
> +       struct ceph_inode_info *ci_old, *ci_new;
> +
> +       down_read(&mdsc->snap_rwsem);
> +       ci_old = get_quota_realm(mdsc, old);
> +       ci_new = get_quota_realm(mdsc, new);
> +       up_read(&mdsc->snap_rwsem);
> +
> +       return (ci_old == ci_new);
> +}
> +
>  enum quota_check_op {
>         QUOTA_CHECK_MAX_FILES_OP /* check quota max_files limit */
>  };
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 20197e29a7f0..a66e73338386 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1027,5 +1027,6 @@ extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
>                               struct ceph_mds_session *session,
>                               struct ceph_msg *msg);
>  extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
> +extern bool ceph_quota_is_same_realm(struct inode *old, struct inode *new);
>
>  #endif /* _FS_CEPH_SUPER_H */
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
