From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.16-rc4
Date: Fri,  2 Mar 2018 15:48:24 +0100
Message-ID: <1520002104-12128-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.16-rc4

for you to fetch changes up to 1c789249578895bb14ab62b4327306439b754857:

  ceph: fix potential memory leak in init_caches() (2018-03-01 16:39:47 +0100)

----------------------------------------------------------------
A cap handling fix from Zhi that ensures that metadata writeback isn't
delayed and three error path memory leak fixups from Chengguang.

----------------------------------------------------------------
Chengguang Xu (3):
      libceph, ceph: avoid memory leak when specifying same option several times
      ceph: fix dentry leak when failing to init debugfs
      ceph: fix potential memory leak in init_caches()

Zhi Zhang (1):
      ceph: flush dirty caps of unlinked inode ASAP

 fs/ceph/caps.c         | 26 ++++++++++++++++++++++++++
 fs/ceph/dir.c          | 28 +++++-----------------------
 fs/ceph/super.c        | 27 +++++++++++++--------------
 fs/ceph/super.h        |  2 +-
 net/ceph/ceph_common.c |  7 +++++++
 5 files changed, 52 insertions(+), 38 deletions(-)
