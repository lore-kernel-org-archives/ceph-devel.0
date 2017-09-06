From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 0/3] ceph: kernel client cephfs quota support
Date: Wed,  6 Sep 2017 15:12:21 +0100
Message-ID: <20170906141224.11813-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932242AbdIFOMa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 6 Sep 2017 10:12:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Fajerski <jfajerski@suse.com>
Cc: ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>

A cephfs-specific quota implementation has been available in the
user-space fuse client for a while.  This quota implementation allows an
administrator to restrict the number of bytes and/or the number of files
in a filesystem subtree.  This quota implementation, however, is supported
at the client-level only, which means that cooperation is required between
different clients accessing the system.

This obviously assumes that all clients are trusted entities and will
respect the quotas, preventing users from exceeding the quota limits.
Since the kernel client doesn't support quotas, it has not been possible
to use it in a cluster where quotas are a requirement.

This patchset is an RFC that adds kernel client support for cephfs quotas
as it is currently implemented in the ceph fuse client.  Note however that
this patchset is not yet feature complete, as it only implements the
max_files quota (max_bytes is still missing).  I just wanted to have some
early review before continuing, specially in the reverse path walk code,
as this seems to be the perfect place to fail ;-)

I've obviously done some basic testing on this patchset but nothing really
complex -- single client on small (VMs) cluster.  Jan (thanks a lot!) has
pushed a branch that should enable testing using teuthology, but
unfortunately we haven't tried it:

  https://github.com/jan--f/ceph/tree/wip-quota-kernel-testing

[ Note that the goal is to simply use the existing workunit quota.sh once
  the kernel client has support for both max_files and max_bytes. ]

Luis Henriques (3):
  ceph: quota: add initial infrastructure to support cephfs quotas
  ceph: quotas: support for ceph.quota.max_files
  ceph: quota: don't allow cross-quota renames

 fs/ceph/Makefile                   |   2 +-
 fs/ceph/dir.c                      |  15 ++++
 fs/ceph/file.c                     |   4 +-
 fs/ceph/inode.c                    |   6 ++
 fs/ceph/mds_client.c               |  21 ++++++
 fs/ceph/mds_client.h               |   2 +
 fs/ceph/quota.c                    | 136 +++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h                    |  10 +++
 fs/ceph/xattr.c                    |  45 ++++++++++++
 include/linux/ceph/ceph_features.h |   3 +-
 include/linux/ceph/ceph_fs.h       |  17 +++++
 11 files changed, 258 insertions(+), 3 deletions(-)
 create mode 100644 fs/ceph/quota.c

