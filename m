From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for -rc4
Date: Mon, 17 Feb 2014 12:50:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402171239030.20760@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

We have some patches fixing up ACL support issues from Zheng and 
Guangliang and a mount option to enable/disable this support.  (These 
fixes were somewhat delayed by the Chinese holiday.)  There is also a 
small fix for cached readdir handling when directories are fragmented.

Thanks!
sage

----------------------------------------------------------------
Guangliang Zhao (1):
      ceph: make ceph_forget_all_cached_acls() static inline

Sage Weil (1):
      ceph: add acl, noacl options for cephfs mount

Yan, Zheng (6):
      ceph: properly handle XATTR_CREATE and XATTR_REPLACE
      ceph: remove xattr when null value is given to setxattr()
      ceph: fix ceph_removexattr()
      ceph: fix ceph_set_acl()
      ceph: add missing init_acl() for mkdir() and atomic_open()
      ceph: fix __dcache_readdir()

 fs/ceph/acl.c                | 11 +--------
 fs/ceph/dir.c                | 23 ++++++++++++++-----
 fs/ceph/file.c               |  1 +
 fs/ceph/super.c              | 32 ++++++++++++++++++++++----
 fs/ceph/super.h              |  7 +++++-
 fs/ceph/xattr.c              | 54 ++++++++++++++++++++++++++++++++------------
 include/linux/ceph/ceph_fs.h |  5 ++--
 7 files changed, 96 insertions(+), 37 deletions(-)
