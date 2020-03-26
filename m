From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.6-rc8
Date: Thu, 26 Mar 2020 21:14:53 +0100
Message-ID: <20200326201453.7227-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.6-rc8

for you to fetch changes up to c8d6ee01449cd0d2f30410681cccb616a88f50b1:

  ceph: fix memory leak in ceph_cleanup_snapid_map() (2020-03-23 13:07:08 +0100)

----------------------------------------------------------------
A patch for a rather old regression in fullness handling and two memory
leak fixes, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (2):
      ceph: check POOL_FLAG_FULL/NEARFULL in addition to OSDMAP_FULL/NEARFULL
      libceph: fix alloc_msg_with_page_vector() memory leaks

Luis Henriques (1):
      ceph: fix memory leak in ceph_cleanup_snapid_map()

 fs/ceph/file.c                 | 14 +++++++++++---
 fs/ceph/snap.c                 |  1 +
 include/linux/ceph/messenger.h |  7 ++++---
 include/linux/ceph/osdmap.h    |  4 ++++
 include/linux/ceph/rados.h     |  6 ++++--
 net/ceph/messenger.c           |  9 +++++++--
 net/ceph/osd_client.c          | 14 +++-----------
 net/ceph/osdmap.c              |  9 +++++++++
 8 files changed, 43 insertions(+), 21 deletions(-)
