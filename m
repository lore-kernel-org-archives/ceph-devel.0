From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.16-rc1
Date: Thu,  8 Feb 2018 16:38:35 +0100
Message-ID: <1518104315-11462-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.16-rc1

for you to fetch changes up to 16515a6d54183349b858b9c05e483afc55fa7948:

  ceph: improving efficiency of syncfs (2018-01-30 21:10:15 +0100)

----------------------------------------------------------------
Things have been very quiet on the rbd side, as work continues on the
big ticket items slated for the next merge window.

On the CephFS side we have a large number of cap handling improvements,
a fix for our long-standing abuse of ->journal_info in ceph_readpages()
and yet another dentry pointer management patch.

----------------------------------------------------------------
Chengguang Xu (2):
      libceph: check kstrndup() return value
      ceph: improving efficiency of syncfs

Ilya Dryomov (4):
      rbd: obj_request->completion is unused
      rbd: use kmem_cache_zalloc() in rbd_img_request_create()
      rbd: don't NULL out ->obj_request in rbd_img_obj_parent_read_full()
      rbd: whitelist RBD_FEATURE_OPERATIONS feature bit

Yan, Zheng (13):
      ceph: voluntarily drop Ax cap for requests that create new inode
      ceph: voluntarily drop Lx cap for link/rename requests
      ceph: properly drop caps for setattr request
      ceph: voluntarily drop Fx cap for readdir request
      ceph: cleanup traceless reply handling for rename
      ceph: use atomic_t for ceph_inode_info::i_shared_gen
      ceph: avoid dereferencing invalid pointer during cached readdir
      ceph: track read contexts in ceph_file_info
      ceph: fix un-balanced fsc->writeback_count update
      ceph: fix incorrect snaprealm when adding caps
      ceph: limit rate of cap import/export error messages
      ceph: delete unreachable code in ceph_check_caps()
      ceph: fix race of queuing delayed caps

Zhi Zhang (1):
      ceph: try to allocate enough memory for reserved caps

 drivers/block/rbd.c    |  22 ++-----
 fs/ceph/addr.c         |  28 +++++---
 fs/ceph/caps.c         | 170 ++++++++++++++++++++++++++++++++++---------------
 fs/ceph/dir.c          |  79 +++++++++++++----------
 fs/ceph/file.c         |  12 +++-
 fs/ceph/inode.c        |  56 ++++++++++++----
 fs/ceph/mds_client.c   |  33 +++++++---
 fs/ceph/mds_client.h   |   3 +
 fs/ceph/snap.c         |   8 ++-
 fs/ceph/super.h        |  53 ++++++++++++++-
 net/ceph/ceph_common.c |   4 ++
 11 files changed, 323 insertions(+), 145 deletions(-)
