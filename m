From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.12-rc6
Date: Sat, 17 Jun 2017 15:43:33 +0200
Message-ID: <1497707013-13361-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.12-rc6

for you to fetch changes up to 4ca2fea6f8277ab381bd08b996d641255b6f7b00:

  ceph: unify inode i_ctime update (2017-06-14 19:37:23 +0200)

----------------------------------------------------------------
A fix for an old ceph ->fh_to_* bug from Luis and two timestamp
fixups from Zheng, prompted by the ongoing y2038 work.

----------------------------------------------------------------
Luis Henriques (1):
      ceph: check i_nlink while converting a file handle to dentry

Yan, Zheng (2):
      ceph: use current_kernel_time() to get request time stamp
      ceph: unify inode i_ctime update

 fs/ceph/acl.c        | 1 +
 fs/ceph/export.c     | 4 ++++
 fs/ceph/inode.c      | 5 ++---
 fs/ceph/mds_client.c | 4 +---
 4 files changed, 8 insertions(+), 6 deletions(-)
