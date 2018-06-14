From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.18-rc1
Date: Thu, 14 Jun 2018 12:57:34 +0200
Message-ID: <1528973854-12563-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.18-rc1

for you to fetch changes up to 23edca864951250af845a11da86bb3ea63522ed2:

  rbd: flush rbd_dev->watch_dwork after watch is unregistered (2018-06-04 20:46:02 +0200)

----------------------------------------------------------------
The main piece is a set of libceph changes that revamps how OSD
requests are aborted, improving CephFS ENOSPC handling and making
"umount -f" actually work (Zheng and myself).  The rest is mostly
mount option handling cleanups from Chengguang and assorted fixes
from Zheng, Luis and Dongsheng.

----------------------------------------------------------------
Chengguang Xu (5):
      libceph, rbd: add error handling for osd_req_op_cls_init()
      ceph: fix alignment of rasize
      ceph: strengthen rsize/wsize/readdir_max_bytes validation
      ceph: show ino32 if the value is different with default
      ceph: update description of some mount options

Dongsheng Yang (1):
      rbd: flush rbd_dev->watch_dwork after watch is unregistered

Ilya Dryomov (13):
      libceph: get rid of more_kvec in try_write()
      libceph: use MSG_TRUNC for discarding received bytes
      ceph: show wsize only if non-default
      libceph: introduce ceph_osdc_abort_requests()
      libceph: no need to call flush_workqueue() before destruction
      libceph: move more code into __complete_request()
      libceph: defer __complete_request() to a workqueue
      libceph: use for_each_request() in ceph_osdc_abort_on_full()
      libceph: don't warn if req->r_abort_on_full is set
      libceph: avoid a use-after-free during map check
      libceph: don't abort reads in ceph_osdc_abort_on_full()
      libceph: make abort_on_full a per-osdc setting
      libceph: allocate the locator string with GFP_NOFAIL

Luis Henriques (2):
      ceph: fix st_nlink stat for directories
      ceph: fix use-after-free in ceph_statfs()

Yan, Zheng (10):
      ceph: use bit flags to define vxattr attributes
      ceph: always get rstat from auth mds
      ceph: update i_files/i_subdirs only when Fs cap is issued
      ceph: define argument structure for handle_cap_grant
      ceph: handle the new nfiles/nsubdirs fields in cap message
      ceph: support file lock on directory
      ceph: abort osd requests on force umount
      ceph: flush pending works before shutdown super
      ceph: fix wrong check for the case of updating link count
      ceph: prevent i_version from going back

 Documentation/filesystems/ceph.txt |   8 +-
 drivers/block/rbd.c                |  11 +-
 fs/ceph/addr.c                     |   1 -
 fs/ceph/caps.c                     | 160 ++++++++++++++++-----------
 fs/ceph/dir.c                      |   2 +
 fs/ceph/file.c                     |   1 -
 fs/ceph/inode.c                    |  67 +++++++-----
 fs/ceph/super.c                    |  35 ++++--
 fs/ceph/xattr.c                    |  60 ++++++-----
 include/linux/ceph/ceph_fs.h       |   1 +
 include/linux/ceph/osd_client.h    |   8 +-
 include/linux/ceph/osdmap.h        |   8 +-
 net/ceph/messenger.c               |  31 ++----
 net/ceph/osd_client.c              | 216 ++++++++++++++++++++++---------------
 net/ceph/osdmap.c                  |  19 ++--
 15 files changed, 372 insertions(+), 256 deletions(-)
