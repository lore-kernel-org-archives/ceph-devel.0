From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 0/2] fix quota subdir mounts
Date: Fri,  1 Mar 2019 17:57:50 +0000
Message-ID: <20190301175752.17808-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Hi!

As reported recently in the ceph-users mailing-list[1], the kernel client
behaves differently from the fuse client regarding mounting subdirs where
quotas are in effect.  I've also created a bug to track this issue[2].

The following patches are a possible way of fixing this issue.  The
performance impact should be close to zero if the mount is done in the
CephFS root inode.  When we're mounting subdirs, we may have extra
queries to the MDSs, depending on how many extra realms we'll need to
loop through.

Warning: this is just an RFC, and the patches are only lightly tested!

[1] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-February/033357.html
[2] https://tracker.ceph.com/issues/38482

Luis Henriques (2):
  ceph: factor out ceph_lookup_inode()
  ceph: quota: fix quota subdir mounts

 fs/ceph/caps.c   |  2 +-
 fs/ceph/export.c | 14 +++++++++++++-
 fs/ceph/quota.c  | 30 +++++++++++++++++++++++++++---
 fs/ceph/snap.c   |  3 +++
 fs/ceph/super.h  |  3 +++
 5 files changed, 47 insertions(+), 5 deletions(-)
