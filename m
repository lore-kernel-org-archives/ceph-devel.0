From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for -rc5
Date: Mon, 5 May 2014 13:33:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405050656030.28288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linuxfoundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

First, there is a critical fix for the new primary-affinity function that 
went into -rc1.  The second batch of patches from Zheng fix a range of 
problems with directory fragmentation, readdir, and a few odds and ends 
for cephfs.

Thanks!
sage


----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: fix non-default values check in apply_primary_affinity()

Yan, Zheng (5):
      ceph: check directory's completeness before emitting directory entry
      ceph: use fpos_cmp() to compare dentry positions
      ceph: clear directory's completeness when creating file
      ceph: avoid releasing caps that are being used
      ceph: reserve caps for file layout/lock MDS requests

 fs/ceph/caps.c    |    2 +-
 fs/ceph/dir.c     |   33 ++++++++++++++-----------
 fs/ceph/inode.c   |   71 ++++++++++++-----------------------------------------
 fs/ceph/ioctl.c   |    3 +++
 fs/ceph/locks.c   |    1 +
 fs/ceph/super.h   |    1 -
 net/ceph/osdmap.c |    9 ++++---
 7 files changed, 44 insertions(+), 76 deletions(-)
