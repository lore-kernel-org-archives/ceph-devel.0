From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH v3 0/3] ceph: kernel client cephfs quota support
Date: Wed, 20 Dec 2017 15:18:38 +0000
Message-ID: <20171220151841.22355-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755060AbdLTPSq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 20 Dec 2017 10:18:46 -0500
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

This patchset is an RFC that adds kernel client support for cephfs
quotas as it is currently implemented in the ceph fuse client.  Note
however that this patchset is not yet feature complete, as it only
implements the max_files quota (max_bytes is still missing).

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

Luis Henriques (3):
  ceph: quota: add initial infrastructure to support cephfs quotas
  ceph: quotas: support for ceph.quota.max_files
  ceph: quota: don't allow cross-quota renames

 fs/ceph/Makefile                   |   2 +-
 fs/ceph/dir.c                      |  16 ++++
 fs/ceph/file.c                     |   4 +-
 fs/ceph/inode.c                    |   6 ++
 fs/ceph/mds_client.c               |  23 +++++
 fs/ceph/mds_client.h               |   2 +
 fs/ceph/quota.c                    | 190 +++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h                    |  10 ++
 fs/ceph/xattr.c                    |  44 +++++++++
 include/linux/ceph/ceph_features.h |   3 +-
 include/linux/ceph/ceph_fs.h       |  17 ++++
 11 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100644 fs/ceph/quota.c

