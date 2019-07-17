From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.3-rc1
Date: Wed, 17 Jul 2019 13:28:25 +0200
Message-ID: <20190717112825.23829-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 0ecfebd2b52404ae0c54a878c872bb93363ada36:

  Linux 5.2 (2019-07-07 15:41:56 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.3-rc1

for you to fetch changes up to d31d07b97a5e76f41e00eb81dcca740e84aa7782:

  ceph: fix end offset in truncate_inode_pages_range call (2019-07-08 14:01:45 +0200)

There is a trivial conflict caused by commit 9ffbe8ac05db
("locking/lockdep: Rename lockdep_assert_held_exclusive() ->
lockdep_assert_held_write()").  I included the resolution in
for-linus-merged.

----------------------------------------------------------------
Lots of exciting things this time!

- support for rbd object-map and fast-diff features (myself).  This
  will speed up reads, discards and things like snap diffs on sparse
  images.

- ceph.snap.btime vxattr to expose snapshot creation time (David
  Disseldorp).  This will be used to integrate with "Restore Previous
  Versions" feature added in Windows 7 for folks who reexport ceph
  through SMB.

- security xattrs for ceph (Zheng Yan).  Only selinux is supported
  for now due to the limitations of ->dentry_init_security().

- support for MSG_ADDR2, FS_BTIME and FS_CHANGE_ATTR features (Jeff
  Layton).  This is actually a single feature bit which was missing
  because of the filesystem pieces.  With this in, the kernel client
  will finally be reported as "luminous" by "ceph features" -- it is
  still being reported as "jewel" even though all required Luminous
  features were implemented in 4.13.

- stop NULL-terminating ceph vxattrs (Jeff Layton).  The convention
  with xattrs is to not terminate and this was causing inconsistencies
  with ceph-fuse.

- change filesystem time granularity from 1 us to 1 ns, again fixing
  an inconsistency with ceph-fuse (Luis Henriques).

On top of this there are some additional dentry name handling and cap
flushing fixes from Zheng.  Finally, Jeff is formally taking over for
Zheng as the filesystem maintainer.

----------------------------------------------------------------
Andrea Parri (1):
      ceph: fix improper use of smp_mb__before_atomic()

Christoph Hellwig (1):
      libceph: remove ceph_get_direct_page_vector()

Dan Carpenter (1):
      ceph: silence a checker warning in mdsc_show()

David Disseldorp (6):
      ceph: clean up ceph.dir.pin vxattr name sizeof()
      ceph: carry snapshot creation time with inodes
      ceph: add ceph.snap.btime vxattr
      ceph: fix listxattr vxattr buffer length calculation
      ceph: remove unused vxattr length helpers
      ceph: fix "ceph.dir.rctime" vxattr value

Hariprasad Kelam (1):
      ceph: fix warning PTR_ERR_OR_ZERO can be used

Ilya Dryomov (21):
      rbd: get rid of obj_req->xferred, obj_req->result and img_req->xferred
      rbd: replace obj_req->tried_parent with obj_req->read_state
      rbd: get rid of RBD_OBJ_WRITE_{FLAT,GUARD}
      rbd: move OSD request submission into object request state machines
      rbd: introduce image request state machine
      libceph: rename r_unsafe_item to r_private_item
      rbd: introduce obj_req->osd_reqs list
      rbd: factor out rbd_osd_setup_copyup()
      rbd: factor out __rbd_osd_setup_discard_ops()
      rbd: move OSD request allocation into object request state machines
      rbd: rename rbd_obj_setup_*() to rbd_obj_init_*()
      rbd: introduce copyup state machine
      rbd: lock should be quiesced on reacquire
      rbd: quiescing lock should wait for image requests
      rbd: new exclusive lock wait/wake code
      libceph: bump CEPH_MSG_MAX_DATA_LEN (again)
      libceph: change ceph_osdc_call() to take page vector for response
      libceph: export osd_req_op_data() macro
      rbd: call rbd_dev_mapping_set() from rbd_dev_image_probe()
      rbd: support for object-map and fast-diff
      rbd: setallochint only if object doesn't exist

Jeff Layton (22):
      libceph: fix sa_family just after reading address
      libceph: add ceph_decode_entity_addr
      libceph: ADDR2 support for monmap
      libceph: switch osdmap decoding to use ceph_decode_entity_addr
      libceph: fix watch_item_t decoding to use ceph_decode_entity_addr
      libceph: correctly decode ADDR2 addresses in incremental OSD maps
      ceph: have MDS map decoding use entity_addr_t decoder
      ceph: fix decode_locker to use ceph_decode_entity_addr
      libceph: use TYPE_LEGACY for entity addrs instead of TYPE_NONE
      libceph: rename ceph_encode_addr to ceph_encode_banner_addr
      ceph: add btime field to ceph_inode_info
      ceph: handle btime in cap messages
      libceph: turn on CEPH_FEATURE_MSG_ADDR2
      ceph: allow querying of STATX_BTIME in ceph_getattr
      iversion: add a routine to update a raw value with a larger one
      ceph: add change_attr field to ceph_inode_info
      ceph: handle change_attr in cap messages
      ceph: increment change_attribute on local changes
      ceph: make getxattr_cb return ssize_t
      ceph: return -ERANGE if virtual xattr value didn't fit in buffer
      ceph: don't NULL terminate virtual xattrs
      MAINTAINERS: take over for Zheng as CephFS kernel client maintainer

Luis Henriques (3):
      ceph: initialize superblock s_time_gran to 1
      ceph: use generic_delete_inode() for ->drop_inode
      ceph: fix end offset in truncate_inode_pages_range call

Yan, Zheng (15):
      ceph: close race between d_name_cmp() and update_dentry_lease()
      ceph: fix dir_lease_is_valid()
      ceph: use READ_ONCE to access d_parent in RCU critical section
      ceph: ensure d_name/d_parent stability in ceph_mdsc_lease_send_msg()
      ceph: hold i_ceph_lock when removing caps for freeing inode
      ceph: fix debug print format in __set_xattr()
      ceph: rename struct ceph_acls_info to ceph_acl_sec_ctx
      ceph: add selinux support
      ceph: fix infinite loop in get_quota_realm()
      ceph: don't blindly unregister session that is in opening state
      ceph: remove request from waiting list before unregister
      ceph: clear CEPH_I_KICK_FLUSH flag inside __kick_flushing_caps()
      ceph: kick flushing and flush snaps before sending normal cap message
      ceph: more precise CEPH_CLIENT_CAPS_PENDING_CAPSNAP
      ceph: use ceph_evict_inode to cleanup inode's resource

 MAINTAINERS                          |    4 +-
 drivers/block/rbd.c                  | 2442 ++++++++++++++++++++++++----------
 drivers/block/rbd_types.h            |   10 +
 fs/ceph/Kconfig                      |   12 +
 fs/ceph/acl.c                        |   22 +-
 fs/ceph/addr.c                       |    2 +
 fs/ceph/caps.c                       |  120 +-
 fs/ceph/debugfs.c                    |    2 +-
 fs/ceph/dir.c                        |   73 +-
 fs/ceph/export.c                     |    2 +-
 fs/ceph/file.c                       |   34 +-
 fs/ceph/inode.c                      |  208 +--
 fs/ceph/mds_client.c                 |  120 +-
 fs/ceph/mds_client.h                 |    4 +-
 fs/ceph/mdsmap.c                     |   12 +-
 fs/ceph/quota.c                      |   15 +-
 fs/ceph/snap.c                       |    3 +
 fs/ceph/super.c                      |   13 +-
 fs/ceph/super.h                      |   67 +-
 fs/ceph/xattr.c                      |  456 ++++---
 include/linux/ceph/ceph_features.h   |    1 +
 include/linux/ceph/ceph_fs.h         |    2 +-
 include/linux/ceph/cls_lock_client.h |    3 +
 include/linux/ceph/decode.h          |   13 +-
 include/linux/ceph/libceph.h         |   10 +-
 include/linux/ceph/mon_client.h      |    1 -
 include/linux/ceph/osd_client.h      |   12 +-
 include/linux/ceph/striper.h         |    2 +
 include/linux/iversion.h             |   24 +
 net/ceph/Makefile                    |    2 +-
 net/ceph/cls_lock_client.c           |   54 +-
 net/ceph/decode.c                    |   84 ++
 net/ceph/messenger.c                 |   14 +-
 net/ceph/mon_client.c                |   21 +-
 net/ceph/osd_client.c                |   42 +-
 net/ceph/osdmap.c                    |   31 +-
 net/ceph/pagevec.c                   |   33 -
 net/ceph/striper.c                   |   17 +
 38 files changed, 2733 insertions(+), 1254 deletions(-)
 create mode 100644 net/ceph/decode.c
