From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.2-rc4
Date: Sat,  8 Jun 2019 21:04:38 +0200
Message-ID: <20190608190438.7665-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.2-rc4

for you to fetch changes up to 7b2f936fc8282ab56d4d21247f2f9c21607c085c:

  ceph: fix error handling in ceph_get_caps() (2019-06-05 20:34:39 +0200)

----------------------------------------------------------------
A change to call iput() asynchronously to avoid a possible deadlock
when iput_final() needs to wait for in-flight I/O (e.g. readahead) and
a fixup for a cleanup that went into -rc1.

----------------------------------------------------------------
Yan, Zheng (3):
      ceph: single workqueue for inode related works
      ceph: avoid iput_final() while holding mutex or in dispatch thread
      ceph: fix error handling in ceph_get_caps()

 fs/ceph/caps.c       |  34 ++++++-----
 fs/ceph/file.c       |   2 +-
 fs/ceph/inode.c      | 155 +++++++++++++++++++++++++++------------------------
 fs/ceph/mds_client.c |  28 ++++++----
 fs/ceph/quota.c      |   9 ++-
 fs/ceph/snap.c       |  16 ++++--
 fs/ceph/super.c      |  28 +++-------
 fs/ceph/super.h      |  19 ++++---
 8 files changed, 156 insertions(+), 135 deletions(-)
