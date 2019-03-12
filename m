From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.1-rc1
Date: Tue, 12 Mar 2019 18:50:17 +0100
Message-ID: <20190312175017.27764-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc1

for you to fetch changes up to d11ae8e0a76afc506071831854348f2ea1f3290e:

  Documentation: modern versions of ceph are not backed by btrfs (2019-03-05 18:55:18 +0100)

----------------------------------------------------------------
The highlights are:

- rbd will now ignore discards that aren't aligned and big enough to
  actually free up some space (myself).  This is controlled by the new
  alloc_size map option and can be disabled if needed.

- support for rbd deep-flatten feature (myself).  Deep-flatten allows
  "rbd flatten" to fully disconnect the clone image and its snapshots
  from the parent and make the parent snapshot removable.

- a new round of cap handling improvements (Zheng Yan).  The kernel
  client should now be much more prompt about releasing its caps and
  it is possible to put a limit on the number of caps held.

- support for getting ceph.dir.pin extended attribute (Zheng Yan)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      libceph: use struct_size() for kmalloc() in crush_decode()

Ilya Dryomov (11):
      rbd: get rid of obj_req->obj_request_count
      rbd: handle DISCARD and WRITE_ZEROES separately
      rbd: round off and ignore discards that are too small
      rbd: remove experimental designation from kernel layering
      rbd: clear ->xferred on error from rbd_obj_issue_copyup()
      rbd: factor out __rbd_osd_req_create()
      rbd: stop copying num_osd_ops in rbd_obj_issue_copyup()
      rbd: introduce rbd_obj_issue_copyup_ops()
      rbd: copyup with an empty snapshot context (aka deep-copyup)
      rbd: whole-object write and zeroout should copyup when snapshots exist
      rbd: advertise support for RBD_FEATURE_DEEP_FLATTEN

Jeff Layton (1):
      Documentation: modern versions of ceph are not backed by btrfs

Yan, Zheng (12):
      ceph: set special inode's blocksize to page size
      ceph: decode feature bits in session message
      ceph: split large reconnect into multiple messages
      ceph: map snapid to anonymous bdev ID
      ceph: support versioned reply
      ceph: support getting ceph.dir.pin vxattr
      ceph: send cap releases more aggressively
      ceph: touch existing cap when handling reply
      ceph: remove dentry_lru file from debugfs
      ceph: delete stale dentry when last reference is dropped
      ceph: periodically trim stale dentries
      ceph: add mount option to limit caps count

zhengbin (1):
      ceph: pass inclusive lend parameter to filemap_write_and_wait_range()

 Documentation/filesystems/ceph.txt |  14 +-
 drivers/block/rbd.c                | 400 +++++++++++++++------
 fs/ceph/caps.c                     |  72 ++--
 fs/ceph/debugfs.c                  |  27 --
 fs/ceph/dir.c                      | 455 +++++++++++++++++++-----
 fs/ceph/file.c                     |  13 +-
 fs/ceph/inode.c                    |  52 +--
 fs/ceph/mds_client.c               | 698 ++++++++++++++++++++++++++++++-------
 fs/ceph/mds_client.h               |  43 ++-
 fs/ceph/snap.c                     | 159 ++++++++-
 fs/ceph/super.c                    |  21 +-
 fs/ceph/super.h                    |  43 ++-
 fs/ceph/xattr.c                    |  20 +-
 include/linux/ceph/types.h         |   1 +
 net/ceph/osdmap.c                  |   5 +-
 15 files changed, 1597 insertions(+), 426 deletions(-)
