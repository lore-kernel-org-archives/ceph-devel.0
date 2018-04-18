From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.17-rc2
Date: Wed, 18 Apr 2018 16:52:20 +0200
Message-ID: <1524063140-28502-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.17-rc2

for you to fetch changes up to d93605407af34eb0b7eb8aff6b1eae2cde3cdd22:

  rbd: notrim map option (2018-04-16 09:38:40 +0200)

----------------------------------------------------------------
A couple of follow-up patches for -rc1 changes in rbd, support for
a timeout on waiting for the acquisition of exclusive lock and a fix
for uninitialized memory access in CephFS, marked for stable.

----------------------------------------------------------------
Arnd Bergmann (1):
      rbd: avoid Wreturn-type warnings

Dongsheng Yang (1):
      rbd: support timeout in rbd_wait_state_locked()

Ilya Dryomov (3):
      rbd: refactor rbd_wait_state_locked()
      rbd: adjust queue limits for "fancy" striping
      rbd: notrim map option

Yan, Zheng (1):
      ceph: always update atime/mtime/ctime for new inode

 drivers/block/rbd.c | 101 +++++++++++++++++++++++++++++++++++-----------------
 fs/ceph/inode.c     |  10 ++++--
 2 files changed, 76 insertions(+), 35 deletions(-)
