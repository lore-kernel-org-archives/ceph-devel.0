From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.3-rc6
Date: Fri, 23 Aug 2019 14:27:26 +0200
Message-ID: <20190823122726.15050-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.3-rc6

for you to fetch changes up to a561372405cf6bc6f14239b3a9e57bb39f2788b0:

  libceph: fix PG split vs OSD (re)connect race (2019-08-22 10:47:41 +0200)

----------------------------------------------------------------
Three important fixes tagged for stable (an indefinite hang, a crash on
an assert and a NULL pointer dereference) plus a small series from Luis
fixing instances of vfree() under spinlock.

----------------------------------------------------------------
Erqi Chen (1):
      ceph: clear page dirty before invalidate page

Ilya Dryomov (1):
      libceph: fix PG split vs OSD (re)connect race

Jeff Layton (1):
      ceph: don't try fill file_lock on unsuccessful GETFILELOCK reply

Luis Henriques (4):
      libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
      ceph: fix buffer free while holding i_ceph_lock in __ceph_setxattr()
      ceph: fix buffer free while holding i_ceph_lock in __ceph_build_xattrs_blob()
      ceph: fix buffer free while holding i_ceph_lock in fill_inode()

 fs/ceph/addr.c              |  5 +++--
 fs/ceph/caps.c              |  5 ++++-
 fs/ceph/inode.c             |  7 ++++---
 fs/ceph/locks.c             |  3 +--
 fs/ceph/snap.c              |  4 +++-
 fs/ceph/super.h             |  2 +-
 fs/ceph/xattr.c             | 19 ++++++++++++++-----
 include/linux/ceph/buffer.h |  3 ++-
 net/ceph/osd_client.c       |  9 ++++-----
 9 files changed, 36 insertions(+), 21 deletions(-)
