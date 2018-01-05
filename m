From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v4 0/6] ceph: kernel client cephfs quota support
Date: Fri,  5 Jan 2018 10:47:17 +0000
Message-ID: <20180105104723.16202-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36311 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeAEKre (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 05:47:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

A cephfs-specific quota implementation has been available in the
user-space fuse client for a while.  This quota implementation allows an
administrator to restrict the number of bytes and/or the number of files
in a filesystem subtree.  This quota implementation, however, is
supported at the client-level only, which means that cooperation is
required between different clients accessing the system.

This obviously assumes that all clients are trusted entities and will
respect the quotas, preventing users from exceeding the quota limits.
Since the kernel client doesn't support quotas, it has not been possible
to use it in a cluster where quotas are a requirement.

This patchset adds kernel client support for cephfs quotas as it is
currently implemented in the ceph fuse client.  Note however that it
relies on some still-to-be-merged changes to the MDS (see below,
"Changes since v1" for details).

For further details on CephFS quota, see [1].

[1] http://docs.ceph.com/docs/master/cephfs/quota/

** Changes since v3 **

- Rework after review from Yan, Zheng:
  * ceph_handle_quota(): Always increment message sequence number, even
    if inode isn't in cache
  * renamed inode variables ino -> in
  * get_quota_realm() now returns a ceph_snap_realm instead of
    ceph_inode_info

- Updated quota.c copyright and added SPDX identifier

- Added max_bytes quota implementation

- Updated Documentation/filesystems/ceph.txt to include reference to
  quota; also documented added a few more comments to the code.

** Changes since v2 **

Rework after review from Yan, Zheng:

- Dropped patch 0001 ("ceph: add seqlock for snaprealm hierarchy change
  detection") and use mdsc->snap_rwsem for walking the snaprealm
  hierarchy instead of adding a seqlock.  This means that patches 0003
  and 0004 needed to be reworked.

- Added a NULL check in ceph_handle_quota() after the inode lookup with
  ceph_find_inode().

** Changes since v1 **

Instead of trying to do a reverse path walk to find the "quota realm"
for a given directory, this patchset is now using snaprealms.  Thus, for
testing it, a modified MDS is required:

  https://github.com/ukernel/ceph/tree/wip-cephfs-quota-realm

This modified MDS creates a snaprealm when a quota is set in a
directory.  This means that a client needs only to walk up the snaprealm
hierarchy to find a directory that has quotas instead of doing the full
reverse path walking.

Note however that this requires an extra patch that adds a seqlock (1st
patch in series) to detect changes in the snaprealm hierarchy.

Luis Henriques (6):
  ceph: quota: add initial infrastructure to support cephfs quotas
  ceph: quota: support for ceph.quota.max_files
  ceph: quota: don't allow cross-quota renames
  ceph: quota: support for ceph.quota.max_bytes
  ceph: quota: update MDS when max_bytes is approaching
  ceph: quota: add quotas to the in-tree cephfs documentation

 Documentation/filesystems/ceph.txt |  12 ++
 fs/ceph/Makefile                   |   2 +-
 fs/ceph/dir.c                      |  16 +++
 fs/ceph/file.c                     |  21 ++-
 fs/ceph/inode.c                    |  10 ++
 fs/ceph/mds_client.c               |  23 ++++
 fs/ceph/mds_client.h               |   2 +
 fs/ceph/quota.c                    | 276 +++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h                    |  14 ++
 fs/ceph/xattr.c                    |  44 ++++++
 include/linux/ceph/ceph_features.h |   3 +-
 include/linux/ceph/ceph_fs.h       |  17 +++
 12 files changed, 437 insertions(+), 3 deletions(-)
 create mode 100644 fs/ceph/quota.c

