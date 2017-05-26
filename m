From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.12-rc3
Date: Fri, 26 May 2017 17:05:48 +0200
Message-ID: <1495811148-28223-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.12-rc3

for you to fetch changes up to 42c99fc4c7069371da7b04b9099319dd1c633ee2:

  ceph: check that the new inode size is within limits in ceph_fallocate() (2017-05-24 18:10:54 +0200)

----------------------------------------------------------------
A bunch of make W=1 and static checker fixups, a RECONNECT_SEQ
messenger patch from Zheng and Luis' fallocate fix.

----------------------------------------------------------------
Dan Carpenter (1):
      libceph: NULL deref on crush_decode() error path

Ilya Dryomov (5):
      libceph: use kbasename() and kill ceph_file_part()
      libceph: make ceph_msg_data_advance() return void
      libceph: drop version variable from ceph_monmap_decode()
      libceph: validate blob_struct_v in process_one_ticket()
      libceph: fix error handling in process_one_ticket()

Luis Henriques (1):
      ceph: check that the new inode size is within limits in ceph_fallocate()

Yan, Zheng (1):
      libceph: cleanup old messages according to reconnect seq

 fs/ceph/file.c                  |  6 +++++-
 include/linux/ceph/ceph_debug.h |  6 +++---
 net/ceph/auth_x.c               | 13 ++++++++-----
 net/ceph/ceph_common.c          | 13 -------------
 net/ceph/messenger.c            | 26 ++++++++++++++++----------
 net/ceph/mon_client.c           |  4 +---
 net/ceph/osdmap.c               |  1 +
 7 files changed, 34 insertions(+), 35 deletions(-)
