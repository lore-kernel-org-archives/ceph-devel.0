From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/2] ceph: quota: client optimizations
Date: Fri, 12 Jan 2018 17:19:27 +0000
Message-ID: <20180112171929.11791-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934098AbeALRTi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 12:19:38 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

Following this email I'm sending two patches that contain optimizations
for the quota implementation.  They were both suggested by Zheng Yan.

The first patch modifies the snaprealm structure to include an extra
field that will cache an inode pointer (but doesn't keep a ref to it).
This will remove the need for extra ceph_find_inode() calls while
walking through the snaprealm hierarchy.

The 2nd patch keeps a counter of inodes that have quota set.  By keeping
this counter, it is possible to short-circuit quota checks if we don't
have any inode with quotas on the filesystem.

NOTE: these 2 patches are based on the current ceph-client testing
branch, not on mainline kernel.

Luis Henriques (2):
  ceph: quota: cache inode pointer in ceph_snap_realm
  ceph: quota: add counter for snaprealms with quota

 fs/ceph/inode.c      |  3 +--
 fs/ceph/mds_client.c |  1 +
 fs/ceph/mds_client.h |  2 ++
 fs/ceph/quota.c      | 60 ++++++++++++++++++++++++++++++++++------------------
 fs/ceph/snap.c       |  9 ++++++++
 fs/ceph/super.h      |  4 ++++
 6 files changed, 57 insertions(+), 22 deletions(-)

