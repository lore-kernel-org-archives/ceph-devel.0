From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.9-rc2
Date: Thu, 20 Oct 2016 18:50:03 +0200
Message-ID: <1476982203-24744-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.9-rc2

for you to fetch changes up to 5130ccea7cf4646a24c005be1309b7f86f1e91c9:

  ceph: fix non static symbol warning (2016-10-18 12:30:32 +0200)

----------------------------------------------------------------
rbd exclusive-lock edge case fix and several filesystem fixups.
Nikolay's error path patch is tagged for stable, everything else but
readdir vs frags race was introduced in 4.9-rc1.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ceph: fix uninitialized dentry pointer in ceph_real_mount()

Ilya Dryomov (2):
      rbd: don't wait for the lock forever if blacklisted
      rbd: don't retry watch reregistration if header object is gone

Nikolay Borisov (1):
      ceph: fix error handling in ceph_read_iter

Wei Yongjun (1):
      ceph: fix non static symbol warning

Yan, Zheng (1):
      ceph: fix readdir vs fragmentation race

 drivers/block/rbd.c | 50 +++++++++++++++++++++++++++++++++-----------------
 fs/ceph/file.c      |  3 ++-
 fs/ceph/inode.c     |  3 ++-
 fs/ceph/super.c     |  2 ++
 fs/ceph/xattr.c     |  4 ++--
 5 files changed, 41 insertions(+), 21 deletions(-)
