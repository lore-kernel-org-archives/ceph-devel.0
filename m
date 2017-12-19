From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [RFC v2 PATCH 2/4] ceph: quota: add initial infrastructure to
 support cephfs quotas
Date: Tue, 19 Dec 2017 17:24:38 +0800
Message-ID: <CAAM7YA=kDH==QbPX0_OeQwX8e4=t4WzsgGw3wV_=zziYVg-Q1Q@mail.gmail.com>
References: <20171218153902.7455-1-lhenriques@suse.com> <20171218153902.7455-3-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37083 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933739AbdLSJYj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Dec 2017 04:24:39 -0500
Received: by mail-oi0-f68.google.com with SMTP id y75so11966671oie.4
        for <ceph-devel@vger.kernel.org>; Tue, 19 Dec 2017 01:24:39 -0800 (PST)
In-Reply-To: <20171218153902.7455-3-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

On Mon, Dec 18, 2017 at 11:39 PM, Luis Henriques <lhenriques@suse.com> wrote:
> This patch adds the infrastructure required to support cephfs quotas as it
> is currently implemented in the ceph fuse client.  Cephfs quotas can be
> set on any directory, and can restrict the number of bytes or the number
> of files stored beneath that point in the directory hierarchy.
>
> Quotas are set using the extended attributes 'ceph.quota.max_files' and
> 'ceph.quota.max_bytes', and can be removed by setting these attributes to
> '0'.
>
> Link: http://tracker.ceph.com/issues/22372
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/Makefile                   |  2 +-
>  fs/ceph/inode.c                    |  6 ++++
>  fs/ceph/mds_client.c               | 23 +++++++++++++++
>  fs/ceph/mds_client.h               |  2 ++
>  fs/ceph/quota.c                    | 59 ++++++++++++++++++++++++++++++++++++++
>  fs/ceph/super.h                    |  8 ++++++
>  fs/ceph/xattr.c                    | 44 ++++++++++++++++++++++++++++
>  include/linux/ceph/ceph_features.h |  3 +-
>  include/linux/ceph/ceph_fs.h       | 17 +++++++++++
>  9 files changed, 162 insertions(+), 2 deletions(-)
>  create mode 100644 fs/ceph/quota.c
>
> diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
> index 174f5709e508..a699e320393f 100644
> --- a/fs/ceph/Makefile
> +++ b/fs/ceph/Makefile
> @@ -6,7 +6,7 @@
>  obj-$(CONFIG_CEPH_FS) += ceph.o
>
>  ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
> -       export.o caps.o snap.o xattr.o \
> +       export.o caps.o snap.o xattr.o quota.o \
>         mds_client.o mdsmap.o strings.o ceph_frag.o \
>         debugfs.o
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index ab81652198c4..8a0ba96e105d 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -441,6 +441,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>         atomic64_set(&ci->i_complete_seq[1], 0);
>         ci->i_symlink = NULL;
>
> +       ci->i_max_bytes = 0;
> +       ci->i_max_files = 0;
> +
>         memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
>         RCU_INIT_POINTER(ci->i_layout.pool_ns, NULL);
>
> @@ -790,6 +793,9 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
>         inode->i_rdev = le32_to_cpu(info->rdev);
>         inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
>
> +       ci->i_max_bytes = iinfo->max_bytes;
> +       ci->i_max_files = iinfo->max_files;
> +
>         if ((new_version || (new_issued & CEPH_CAP_AUTH_SHARED)) &&
>             (issued & CEPH_CAP_AUTH_EXCL) == 0) {
>                 inode->i_mode = le32_to_cpu(info->mode);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 1b468250e947..2290056d13fc 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -100,6 +100,26 @@ static int parse_reply_info_in(void **p, void *end,
>         } else
>                 info->inline_version = CEPH_INLINE_NONE;
>
> +       if (features & CEPH_FEATURE_MDS_QUOTA) {
> +               u8 struct_v, struct_compat;
> +               u32 struct_len;
> +
> +               /*
> +                * both struct_v and struct_compat are expected to be >= 1
> +                */
> +               ceph_decode_8_safe(p, end, struct_v, bad);
> +               ceph_decode_8_safe(p, end, struct_compat, bad);
> +               if (!struct_v || !struct_compat)
> +                       goto bad;
> +               ceph_decode_32_safe(p, end, struct_len, bad);
> +               ceph_decode_need(p, end, struct_len, bad);
> +               ceph_decode_64_safe(p, end, info->max_bytes, bad);
> +               ceph_decode_64_safe(p, end, info->max_files, bad);
> +       } else {
> +               info->max_bytes = 0;
> +               info->max_files = 0;
> +       }
> +
>         info->pool_ns_len = 0;
>         info->pool_ns_data = NULL;
>         if (features & CEPH_FEATURE_FS_FILE_LAYOUT_V2) {
> @@ -4064,6 +4084,9 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
>         case CEPH_MSG_CLIENT_LEASE:
>                 handle_lease(mdsc, s, msg);
>                 break;
> +       case CEPH_MSG_CLIENT_QUOTA:
> +               ceph_handle_quota(mdsc, s, msg);
> +               break;
>
>         default:
>                 pr_err("received unknown message type %d %s\n", type,
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 837ac4b087a0..7af576733948 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -49,6 +49,8 @@ struct ceph_mds_reply_info_in {
>         char *inline_data;
>         u32 pool_ns_len;
>         char *pool_ns_data;
> +       u64 max_bytes;
> +       u64 max_files;
>  };
>
>  struct ceph_mds_reply_dir_entry {
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> new file mode 100644
> index 000000000000..69d74d7b73ad
> --- /dev/null
> +++ b/fs/ceph/quota.c
> @@ -0,0 +1,59 @@
> +/*
> + * quota.c - CephFS quota
> + *
> + * Copyright (C) 2017 SUSE
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "super.h"
> +#include "mds_client.h"
> +
> +void ceph_handle_quota(struct ceph_mds_client *mdsc,
> +                      struct ceph_mds_session *session,
> +                      struct ceph_msg *msg)
> +{
> +       struct super_block *sb = mdsc->fsc->sb;
> +       struct ceph_mds_quota *h = msg->front.iov_base;
> +       struct ceph_vino vino;
> +       struct inode *inode;
> +       struct ceph_inode_info *ci;
> +
> +       if (msg->front.iov_len != sizeof(*h)) {
> +               pr_err("ceph_handle_quota corrupt message mds%d len %d\n",
> +                      session->s_mds, (int)msg->front.iov_len);
> +               ceph_msg_dump(msg);
> +               return;
> +       }
> +
> +       /* lookup inode */
> +       vino.ino = le64_to_cpu(h->ino);
> +       vino.snap = CEPH_NOSNAP;
> +       inode = ceph_find_inode(sb, vino);

check null

> +       ci = ceph_inode(inode);
> +
> +       mutex_lock(&session->s_mutex);
> +       session->s_seq++;
> +       mutex_unlock(&session->s_mutex);
> +
> +       spin_lock(&ci->i_ceph_lock);
> +       ci->i_rbytes = le64_to_cpu(h->rbytes);
> +       ci->i_rfiles = le64_to_cpu(h->rfiles);
> +       ci->i_rsubdirs = le64_to_cpu(h->rsubdirs);
> +       ci->i_max_bytes = le64_to_cpu(h->max_bytes);
> +       ci->i_max_files = le64_to_cpu(h->max_files);
> +       spin_unlock(&ci->i_ceph_lock);
> +
> +       iput(inode);
> +}
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6474e8d875b7..e3e68448f55c 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -309,6 +309,9 @@ struct ceph_inode_info {
>         u64 i_rbytes, i_rfiles, i_rsubdirs;
>         u64 i_files, i_subdirs;
>
> +       /* quotas */
> +       u64 i_max_bytes, i_max_files;
> +
>         struct rb_root i_fragtree;
>         int i_fragtree_nsplits;
>         struct mutex i_fragtree_mutex;
> @@ -1021,4 +1024,9 @@ extern int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
>  extern int ceph_fs_debugfs_init(struct ceph_fs_client *client);
>  extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
>
> +/* quota.c */
> +extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
> +                             struct ceph_mds_session *session,
> +                             struct ceph_msg *msg);
> +
>  #endif /* _FS_CEPH_SUPER_H */
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index e1c4e0b12b4c..cfc3028be0fa 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -224,6 +224,31 @@ static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
>                         (long)ci->i_rctime.tv_nsec);
>  }
>
> +/* quotas */
> +
> +static bool ceph_vxattrcb_quota_exists(struct ceph_inode_info *ci)
> +{
> +       return (ci->i_max_files || ci->i_max_bytes);
> +}
> +
> +static size_t ceph_vxattrcb_quota(struct ceph_inode_info *ci, char *val,
> +                                 size_t size)
> +{
> +       return snprintf(val, size, "max_bytes=%llu max_files=%llu",
> +                       ci->i_max_bytes, ci->i_max_files);
> +}
> +
> +static size_t ceph_vxattrcb_quota_max_bytes(struct ceph_inode_info *ci,
> +                                           char *val, size_t size)
> +{
> +       return snprintf(val, size, "%llu", ci->i_max_bytes);
> +}
> +
> +static size_t ceph_vxattrcb_quota_max_files(struct ceph_inode_info *ci,
> +                                           char *val, size_t size)
> +{
> +       return snprintf(val, size, "%llu", ci->i_max_files);
> +}
>
>  #define CEPH_XATTR_NAME(_type, _name)  XATTR_CEPH_PREFIX #_type "." #_name
>  #define CEPH_XATTR_NAME2(_type, _name, _name2) \
> @@ -247,6 +272,15 @@ static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
>                 .hidden = true,                 \
>                 .exists_cb = ceph_vxattrcb_layout_exists,       \
>         }
> +#define XATTR_QUOTA_FIELD(_type, _name)                                        \
> +       {                                                               \
> +               .name = CEPH_XATTR_NAME(_type, _name),                  \
> +               .name_size = sizeof (CEPH_XATTR_NAME(_type, _name)),    \
> +               .getxattr_cb = ceph_vxattrcb_ ## _type ## _ ## _name,   \
> +               .readonly = false,                                      \
> +               .hidden = true,                                         \
> +               .exists_cb = ceph_vxattrcb_quota_exists,                \
> +       }
>
>  static struct ceph_vxattr ceph_dir_vxattrs[] = {
>         {
> @@ -270,6 +304,16 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
>         XATTR_NAME_CEPH(dir, rsubdirs),
>         XATTR_NAME_CEPH(dir, rbytes),
>         XATTR_NAME_CEPH(dir, rctime),
> +       {
> +               .name = "ceph.quota",
> +               .name_size = sizeof("ceph.quota"),
> +               .getxattr_cb = ceph_vxattrcb_quota,
> +               .readonly = false,
> +               .hidden = true,
> +               .exists_cb = ceph_vxattrcb_quota_exists,
> +       },
> +       XATTR_QUOTA_FIELD(quota, max_bytes),
> +       XATTR_QUOTA_FIELD(quota, max_files),
>         { .name = NULL, 0 }     /* Required table terminator */
>  };
>  static size_t ceph_dir_vxattrs_name_size;      /* total size of all names */
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 59042d5ac520..6acd46c36271 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -209,7 +209,8 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facin
>          CEPH_FEATURE_SERVER_JEWEL |            \
>          CEPH_FEATURE_MON_STATEFUL_SUB |        \
>          CEPH_FEATURE_CRUSH_TUNABLES5 |         \
> -        CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING)
> +        CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING | \
> +        CEPH_FEATURE_MDS_QUOTA)
>
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
>         (CEPH_FEATURE_NOSRCADDR |        \
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index 88dd51381aaf..98bdcc0eda3f 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -134,6 +134,7 @@ struct ceph_dir_layout {
>  #define CEPH_MSG_CLIENT_LEASE           0x311
>  #define CEPH_MSG_CLIENT_SNAP            0x312
>  #define CEPH_MSG_CLIENT_CAPRELEASE      0x313
> +#define CEPH_MSG_CLIENT_QUOTA          0x314
>
>  /* pool ops */
>  #define CEPH_MSG_POOLOP_REPLY           48
> @@ -807,4 +808,20 @@ struct ceph_mds_snap_realm {
>  } __attribute__ ((packed));
>  /* followed by my snap list, then prior parent snap list */
>
> +/*
> + * quotas
> + */
> +struct ceph_mds_quota {
> +       __le64 ino;             /* ino */
> +       struct ceph_timespec rctime;
> +       __le64 rbytes;          /* dir stats */
> +       __le64 rfiles;
> +       __le64 rsubdirs;
> +       __u8 struct_v;          /* compat */
> +       __u8 struct_compat;
> +       __le32 struct_len;
> +       __le64 max_bytes;       /* quota max. bytes */
> +       __le64 max_files;       /* quota max. files */
> +} __attribute__ ((packed));
> +
>  #endif
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
