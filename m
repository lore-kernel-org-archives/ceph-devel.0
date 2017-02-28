From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.11-rc1
Date: Tue, 28 Feb 2017 16:24:59 +0100
Message-ID: <1488295499-30426-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:

  Linux 4.10 (2017-02-19 14:34:00 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.11-rc1

for you to fetch changes up to 54ea0046b6fe36ec18e82d282a29a18da6cdea0f:

  libceph, rbd, ceph: WRITE | ONDISK -> WRITE (2017-02-24 19:04:57 +0100)

----------------------------------------------------------------
This time around we have:

- support for rbd data-pool feature, which enables rbd images on
  erasure-coded pools (myself).  CEPH_PG_MAX_SIZE has been bumped to
  allow erasure-coded profiles with k+m up to 32.

- a patch for ceph_d_revalidate() performance regression introduced in
  4.9, along with some cleanups in the area (Jeff Layton)

- a set of fixes for unsafe ->d_parent accesses in CephFS (Jeff Layton)

- buffered reads are now processed in rsize windows instead of rasize
  windows (Andreas Gerstmayr).  The new default for rsize mount option
  is 64M.

- ack vs commit distinction is gone, greatly simplifying ->fsync() and
  MOSDOpReply handling code (myself)

Also a few filesystem bug fixes from Zheng, a CRUSH sync up (CRUSH
computations are still serialized though) and several minor fixes and
cleanups all over.

----------------------------------------------------------------
Andreas Gerstmayr (1):
      ceph: set io_pages bdi hint

Arnd Bergmann (1):
      libceph: use BUG() instead of BUG_ON(1)

Bhumika Goyal (1):
      rbd: constify device_type structure

Colin Ian King (1):
      ceph: fix spelling mistake: "enabing" -> "enabling"

Dan Carpenter (1):
      ceph: tidy some white space in get_nonsnap_parent()

Ilya Dryomov (26):
      libceph: include linux/sched.h into crypto.c directly
      libceph: add osdmap_set_crush() helper
      crush: remove mutable part of CRUSH map
      crush: merge working data and scratch
      libceph: don't go through with the mapping if the PG is too wide
      libceph: bump CEPH_PG_MAX_SIZE to 32
      rbd: use kstrndup() in rbd_header_from_disk()
      rbd: kill rbd_image_header::{crypt_type,comp_type}
      rbd: initialize rbd_dev->header_oloc early
      rbd: do away with obj_request in rbd_obj_read_sync()
      libceph: pass reply buffer length through ceph_osdc_call()
      rbd: switch rbd_obj_method_sync() to ceph_osdc_call()
      rbd: remove now unused rbd_obj_request_wait() and helpers
      rbd: use rbd_obj_bytes() more
      rbd: introduce rbd_init_layout()
      rbd: support for data-pool feature
      rbd: set offset and length outside of rbd_obj_request_create()
      rbd: factor out __rbd_osd_req_create()
      rbd: RBD_V{1,2}_DATA_FORMAT macros
      rbd: store and use obj_request->object_no
      rbd: kill obj_request->object_name and rbd_segment_name_cache
      crush: do is_out test only if we do not collide
      crush: fix dprintk compilation
      ceph: remove special ack vs commit behavior
      libceph: get rid of ack vs commit
      libceph, rbd, ceph: WRITE | ONDISK -> WRITE

Jeff Layton (15):
      ceph: clean up unsafe d_parent access in __choose_mds
      ceph: clean up unsafe d_parent accesses in build_dentry_path
      ceph: pass parent dir ino info to build_dentry_path
      ceph: fix unsafe dcache access in ceph_encode_dentry_release
      ceph: pass parent inode info to ceph_encode_dentry_release if we have it
      ceph: fix bogus endianness change in ceph_ioctl_set_layout
      ceph: remove "Debugging hook" from ceph_fill_trace
      ceph: drop session argument to ceph_fill_trace
      ceph: convert bools in ceph_mds_request to a new r_req_flags field
      ceph: add a new flag to indicate whether parent is locked
      ceph: don't update_dentry_lease unless we actually got one
      ceph: vet the target and parent inodes before updating dentry lease
      ceph: call update_dentry_lease even when r_locked dir is not set
      ceph: do a LOOKUP in d_revalidate instead of GETATTR
      ceph: remove req from unsafe list when unregistering it

Seraphime Kirkovski (1):
      ceph: cleanup ACCESS_ONCE -> READ_ONCE

Stafford Horne (1):
      libceph: remove unneeded stddef.h include

Yan, Zheng (4):
      ceph: avoid updating mds_wanted too frequently
      ceph: update readpages osd request according to size of pages
      ceph: make sure flushing inode in proper session's cap_flushing list
      ceph: avoid calling ceph_renew_caps() infinitely

 Documentation/filesystems/ceph.txt |   5 +-
 drivers/block/rbd.c                | 601 ++++++++++++++-----------------------
 drivers/block/rbd_types.h          |  10 +-
 fs/ceph/addr.c                     |  19 +-
 fs/ceph/cache.c                    |   2 +-
 fs/ceph/caps.c                     |  40 ++-
 fs/ceph/debugfs.c                  |   2 +-
 fs/ceph/dir.c                      |  32 +-
 fs/ceph/export.c                   |   3 +-
 fs/ceph/file.c                     | 106 +------
 fs/ceph/inode.c                    | 172 +++++------
 fs/ceph/ioctl.c                    |   4 +-
 fs/ceph/mds_client.c               | 175 ++++++-----
 fs/ceph/mds_client.h               |  15 +-
 fs/ceph/super.c                    |   9 +-
 fs/ceph/super.h                    |  14 +-
 include/linux/ceph/osd_client.h    |   6 +-
 include/linux/ceph/osdmap.h        |  13 +-
 include/linux/ceph/rados.h         |   2 +-
 include/linux/crush/crush.h        |  41 ++-
 include/linux/crush/mapper.h       |  16 +-
 net/ceph/cls_lock_client.c         |  14 +-
 net/ceph/crush/crush.c             |   5 -
 net/ceph/crush/mapper.c            | 227 +++++++++-----
 net/ceph/crypto.c                  |   1 +
 net/ceph/osd_client.c              | 130 +++-----
 net/ceph/osdmap.c                  | 101 +++++--
 net/ceph/snapshot.c                |   2 -
 28 files changed, 835 insertions(+), 932 deletions(-)
