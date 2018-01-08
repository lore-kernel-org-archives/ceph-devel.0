From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4 0/6] ceph: kernel client cephfs quota support
Date: Mon, 8 Jan 2018 20:55:35 +0800
Message-ID: <CAAM7YAm7kON+OqrBMccyDSMi6Jkm3qSLN=O0KPCjOuO+jUQojg@mail.gmail.com>
References: <20180105104723.16202-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34316 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756068AbeAHMzg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 07:55:36 -0500
Received: by mail-ot0-f193.google.com with SMTP id p16so6482010otf.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jan 2018 04:55:36 -0800 (PST)
In-Reply-To: <20180105104723.16202-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

On Fri, Jan 5, 2018 at 6:47 PM, Luis Henriques <lhenriques@suse.com> wrote:
> A cephfs-specific quota implementation has been available in the
> user-space fuse client for a while.  This quota implementation allows an
> administrator to restrict the number of bytes and/or the number of files
> in a filesystem subtree.  This quota implementation, however, is
> supported at the client-level only, which means that cooperation is
> required between different clients accessing the system.
>
> This obviously assumes that all clients are trusted entities and will
> respect the quotas, preventing users from exceeding the quota limits.
> Since the kernel client doesn't support quotas, it has not been possible
> to use it in a cluster where quotas are a requirement.
>
> This patchset adds kernel client support for cephfs quotas as it is
> currently implemented in the ceph fuse client.  Note however that it
> relies on some still-to-be-merged changes to the MDS (see below,
> "Changes since v1" for details).
>
> For further details on CephFS quota, see [1].
>
> [1] http://docs.ceph.com/docs/master/cephfs/quota/
>
> ** Changes since v3 **
>
> - Rework after review from Yan, Zheng:
>   * ceph_handle_quota(): Always increment message sequence number, even
>     if inode isn't in cache
>   * renamed inode variables ino -> in
>   * get_quota_realm() now returns a ceph_snap_realm instead of
>     ceph_inode_info
>
> - Updated quota.c copyright and added SPDX identifier
>
> - Added max_bytes quota implementation
>
> - Updated Documentation/filesystems/ceph.txt to include reference to
>   quota; also documented added a few more comments to the code.
>
> ** Changes since v2 **
>
> Rework after review from Yan, Zheng:
>
> - Dropped patch 0001 ("ceph: add seqlock for snaprealm hierarchy change
>   detection") and use mdsc->snap_rwsem for walking the snaprealm
>   hierarchy instead of adding a seqlock.  This means that patches 0003
>   and 0004 needed to be reworked.
>
> - Added a NULL check in ceph_handle_quota() after the inode lookup with
>   ceph_find_inode().
>
> ** Changes since v1 **
>
> Instead of trying to do a reverse path walk to find the "quota realm"
> for a given directory, this patchset is now using snaprealms.  Thus, for
> testing it, a modified MDS is required:
>
>   https://github.com/ukernel/ceph/tree/wip-cephfs-quota-realm
>
> This modified MDS creates a snaprealm when a quota is set in a
> directory.  This means that a client needs only to walk up the snaprealm
> hierarchy to find a directory that has quotas instead of doing the full
> reverse path walking.
>
> Note however that this requires an extra patch that adds a seqlock (1st
> patch in series) to detect changes in the snaprealm hierarchy.
>
> Luis Henriques (6):
>   ceph: quota: add initial infrastructure to support cephfs quotas
>   ceph: quota: support for ceph.quota.max_files
>   ceph: quota: don't allow cross-quota renames
>   ceph: quota: support for ceph.quota.max_bytes
>   ceph: quota: update MDS when max_bytes is approaching
>   ceph: quota: add quotas to the in-tree cephfs documentation
>
>  Documentation/filesystems/ceph.txt |  12 ++
>  fs/ceph/Makefile                   |   2 +-
>  fs/ceph/dir.c                      |  16 +++
>  fs/ceph/file.c                     |  21 ++-
>  fs/ceph/inode.c                    |  10 ++
>  fs/ceph/mds_client.c               |  23 ++++
>  fs/ceph/mds_client.h               |   2 +
>  fs/ceph/quota.c                    | 276 +++++++++++++++++++++++++++++++++++++
>  fs/ceph/super.h                    |  14 ++
>  fs/ceph/xattr.c                    |  44 ++++++
>  include/linux/ceph/ceph_features.h |   3 +-
>  include/linux/ceph/ceph_fs.h       |  17 +++
>  12 files changed, 437 insertions(+), 3 deletions(-)
>  create mode 100644 fs/ceph/quota.c
>
Hi Luis.

This series looks good. I will add them to our testing branch if my
local test goes well.

I also wish to do some optimization (incremental patches) to the code

1. avoid quota check if there is no quota in the filesystem. we can
use a variable to tracker how many snaprealm have quota enabled.
2. save inode pointer  (not increase inode's reference count) in
ceph_snap_realm data structure. so we can avoid calling
ceph_find_inode() in check_quota_exceeded()

Regards
Yan, Zheng


> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
