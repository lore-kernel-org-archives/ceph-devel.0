From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.20-rc1
Date: Wed, 31 Oct 2018 18:44:25 +0100
Message-ID: <20181031174425.27372-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc1

for you to fetch changes up to ea4cdc548e5e74a529cdd1aea885d74b4aa8f1b3:

  ceph: new mount option to disable usage of copy-from op (2018-10-22 10:28:24 +0200)

----------------------------------------------------------------
The highlights are:

- a series that fixes some old memory allocation issues in libceph
  (myself).  We no longer allocate memory in places where allocation
  failures cannot be handled and BUG when the allocation fails.

- support for copy_file_range() syscall (Luis Henriques).  If size and
  alignment conditions are met, it leverages RADOS copy-from operation.
  Otherwise, a local copy is performed.

- a patch that reduces memory requirement of ceph_sync_read() from the
  size of the entire read to the size of one object (Zheng Yan).

- fallocate() syscall is now restricted to FALLOC_FL_PUNCH_HOLE (Luis
  Henriques)

----------------------------------------------------------------
Chengguang Xu (3):
      ceph: reset cap hold timeout only for requeued inode
      rbd: add __init/__exit annotations
      ceph: check snap first in ceph_set_acl()

Ilya Dryomov (12):
      libceph: bump CEPH_MSG_MAX_DATA_LEN
      libceph: osd_req_op_cls_init() doesn't need to take opcode
      libceph: introduce ceph_pagelist_alloc()
      libceph: don't consume a ref on pagelist in ceph_msg_data_add_pagelist()
      libceph: no need to call osd_req_opcode_valid() in osd_req_encode_op()
      ceph: num_ops is off by one in ceph_aio_retry_work()
      libceph: enable fallback to ceph_msg_new() in ceph_msgpool_get()
      libceph: assign cookies in linger_submit()
      libceph: introduce alloc_watch_request()
      libceph, rbd, ceph: move ceph_osdc_alloc_messages() calls
      libceph: preallocate message data items
      libceph: check reply num_data_items in setup_request_data()

Luis Henriques (5):
      ceph: only allow punch hole mode in fallocate
      ceph: add non-blocking parameter to ceph_try_get_caps()
      libceph: support the RADOS copy-from operation
      ceph: support copy_file_range file operation
      ceph: new mount option to disable usage of copy-from op

Xuehan Xu (1):
      ceph: set timeout conditionally in __cap_delay_requeue

Yan, Zheng (4):
      Revert "ceph: fix dentry leak in splice_dentry()"
      ceph: fix dentry leak in ceph_readdir_prepopulate
      ceph: check if LOOKUPNAME request was aborted when filling trace
      ceph: refactor ceph_sync_read()

 Documentation/filesystems/ceph.txt |   5 +
 drivers/block/rbd.c                |  28 +-
 fs/ceph/acl.c                      |  13 +-
 fs/ceph/addr.c                     |   2 +-
 fs/ceph/caps.c                     |  21 +-
 fs/ceph/file.c                     | 573 +++++++++++++++++++++++++++----------
 fs/ceph/inode.c                    |  13 +-
 fs/ceph/mds_client.c               |   9 +-
 fs/ceph/super.c                    |  13 +
 fs/ceph/super.h                    |   3 +-
 fs/ceph/xattr.c                    |   3 +-
 include/linux/ceph/libceph.h       |   8 +-
 include/linux/ceph/messenger.h     |  24 +-
 include/linux/ceph/msgpool.h       |  11 +-
 include/linux/ceph/osd_client.h    |  22 +-
 include/linux/ceph/pagelist.h      |  11 +-
 include/linux/ceph/rados.h         |  28 ++
 net/ceph/messenger.c               | 107 +++----
 net/ceph/msgpool.c                 |  27 +-
 net/ceph/osd_client.c              | 363 +++++++++++++++++------
 net/ceph/pagelist.c                |  20 ++
 21 files changed, 900 insertions(+), 404 deletions(-)
