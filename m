From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.1-rc3
Date: Fri, 29 Mar 2019 17:32:13 +0100
Message-ID: <20190329163213.17081-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc3

for you to fetch changes up to daf5cc27eed99afdea8d96e71b89ba41f5406ef6:

  ceph: fix use-after-free on symlink traversal (2019-03-27 19:00:37 +0100)

----------------------------------------------------------------
A patch to avoid choking on multipage bvecs in the messenger and
a small use-after-free fix.

----------------------------------------------------------------
Al Viro (1):
      ceph: fix use-after-free on symlink traversal

Ilya Dryomov (1):
      libceph: fix breakage caused by multipage bvecs

 fs/ceph/inode.c      | 2 +-
 net/ceph/messenger.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)
