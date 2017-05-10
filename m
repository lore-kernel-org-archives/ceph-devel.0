From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.12-rc1
Date: Wed, 10 May 2017 12:12:46 +0200
Message-ID: <1494411166-20000-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit a351e9b9fc24e982ec2f0e76379a49826036da12:

  Linux 4.11 (2017-04-30 19:47:48 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.12-rc1

for you to fetch changes up to eeca958dce0a9231d1969f86196653eb50fcc9b3:

  ceph: fix memory leak in __ceph_setxattr() (2017-05-04 09:19:24 +0200)

----------------------------------------------------------------
The two main items are support for disabling automatic rbd exclusive
lock transfers from myself and the long awaited -ENOSPC handling series
from Jeff.  The former will allow rbd users to take advantage of
exclusive lock's built-in blacklist/break-lock functionality while
staying in control of who owns the lock.  With the latter in place, we
will abort filesystem writes on -ENOSPC instead of having them block
indefinitely.

Beyond that we've got the usual pile of filesystem fixes from Zheng,
some refcount_t conversion patches from Elena and a patch for an
ancient open() flags handling bug from Alexander.

----------------------------------------------------------------
Alexander Graf (1):
      ceph: fix file open flags on ppc64

Elena Reshetova (5):
      ceph: convert ceph_mds_session.s_ref from atomic_t to refcount_t
      ceph: convert ceph_cap_snap.nref from atomic_t to refcount_t
      libceph: convert ceph_snap_context.nref from atomic_t to refcount_t
      libceph: convert ceph_osd.o_ref from atomic_t to refcount_t
      libceph: convert ceph_pagelist.refcnt from atomic_t to refcount_t

Ilya Dryomov (11):
      libceph, ceph: always advertise all supported features
      libceph: supported_features module parameter
      rbd: move rbd_dev_destroy() call out of rbd_dev_image_release()
      rbd: move rbd_unregister_watch() call into rbd_dev_image_release()
      rbd: fix error handling around rbd_init_disk()
      rbd: ignore unlock errors
      rbd: store lock cookie
      rbd: support updating the lock cookie without releasing the lock
      rbd: kill rbd_is_lock_supported()
      rbd: return ResponseMessage result from rbd_handle_request_lock()
      rbd: exclusive map option

Jeff Layton (7):
      libceph: remove req->r_replay_version
      libceph: allow requests to return immediately on full conditions if caller wishes
      libceph: abort already submitted but abortable requests when map or pool goes full
      libceph: add an epoch_barrier field to struct ceph_osd_client
      ceph: handle epoch barriers in cap messages
      Revert "ceph: SetPageError() for writeback pages if writepages fails"
      ceph: when seeing write errors on an inode, switch to sync writes

Luis Henriques (1):
      ceph: fix memory leak in __ceph_setxattr()

Yan, Zheng (6):
      ceph: fix wrong check in ceph_renew_caps()
      ceph: allow connecting to mds whose rank >= mdsmap::m_max_mds
      ceph: fix potential use-after-free
      ceph: close stopped mds' session
      ceph: make seeky readdir more efficient
      ceph: choose readdir frag based on previous readdir reply

 drivers/block/rbd.c                  | 359 +++++++++++++++++++++--------------
 fs/ceph/addr.c                       |  10 +-
 fs/ceph/caps.c                       |  25 ++-
 fs/ceph/debugfs.c                    |  21 +-
 fs/ceph/dir.c                        |  23 ++-
 fs/ceph/file.c                       |  68 +++++--
 fs/ceph/inode.c                      |  17 +-
 fs/ceph/mds_client.c                 |  75 ++++++--
 fs/ceph/mds_client.h                 |  15 +-
 fs/ceph/mdsmap.c                     |  44 ++++-
 fs/ceph/snap.c                       |   2 +-
 fs/ceph/super.c                      |   7 +-
 fs/ceph/super.h                      |  31 ++-
 fs/ceph/xattr.c                      |   3 +
 include/linux/ceph/ceph_features.h   |   4 +
 include/linux/ceph/ceph_fs.h         |  14 ++
 include/linux/ceph/cls_lock_client.h |   5 +
 include/linux/ceph/libceph.h         |   8 +-
 include/linux/ceph/mdsmap.h          |   7 +-
 include/linux/ceph/osd_client.h      |   7 +-
 include/linux/ceph/pagelist.h        |   6 +-
 net/ceph/ceph_common.c               |  27 ++-
 net/ceph/cls_lock_client.c           |  51 +++++
 net/ceph/debugfs.c                   |   7 +-
 net/ceph/osd_client.c                | 139 ++++++++++++--
 net/ceph/pagelist.c                  |   2 +-
 net/ceph/snapshot.c                  |   6 +-
 27 files changed, 706 insertions(+), 277 deletions(-)
