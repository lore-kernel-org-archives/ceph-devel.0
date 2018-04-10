From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.17-rc1
Date: Tue, 10 Apr 2018 18:38:11 +0200
Message-ID: <1523378291-18095-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.17-rc1

for you to fetch changes up to 9122eed5281e89bdb02162a8ecb3cc13ffc8985e:

  ceph: quota: report root dir quota usage in statfs (2018-04-02 11:17:53 +0200)

----------------------------------------------------------------
The big ticket items are:

- support for rbd "fancy" striping (myself).  The striping feature bit
  is now fully implemented, allowing mapping v2 images with non-default
  striping patterns.  This completes support for --image-format 2.

- CephFS quota support (Luis Henriques and Zheng Yan).  This set is
  based on the new SnapRealm code in the upcoming v13.y.z ("Mimic")
  release.  Quota handling will be rejected on older filesystems.

- memory usage improvements in CephFS (Chengguang Xu).  Directory
  specific bits have been split out of ceph_file_info and some effort
  went into improving cap reservation code to avoid OOM crashes.

Also included a bunch of assorted fixes all over the place from
Chengguang and others.

----------------------------------------------------------------
Chengguang Xu (18):
      ceph: add newline to end of debug message format
      ceph: keep consistent semantic in fscache related option combination
      libceph, ceph: change permission for readonly debugfs entries
      libceph: fix misjudgement of maximum monitor number
      ceph: use seq_show_option for string type options
      libceph: adding missing message types to ceph_msg_type_name()
      ceph: adding protection for showing cap reservation info
      ceph: optimizing cap allocation
      ceph: release unreserved caps if having enough available caps
      ceph: optimizing cap reservation
      ceph: change variable name to follow common rule
      ceph: mark the cap cache as unreclaimable
      ceph: filter out used flags when printing unused open flags
      libceph, ceph: add __init attribution to init funcitons
      ceph: optimize mds session register
      ceph: optimize memory usage
      ceph: return proper bool type to caller instead of pointer
      ceph: fix invalid point dereference for error case in mdsc destroy

Colin Ian King (1):
      rbd: fix spelling mistake: "reregisteration" -> "reregistration"

Ilya Dryomov (34):
      rbd: set max_segment_size to UINT_MAX
      libceph: eliminate overflows in ceph_calc_file_object_mapping()
      libceph, ceph: change ceph_calc_file_object_mapping() signature
      rbd: start enums at 1 instead of 0
      libceph, rbd: new bio handling code (aka don't clone bios)
      rbd: remove bio cloning helpers
      rbd: don't (ab)use obj_req->pages for stat requests
      rbd: get rid of img_req->copyup_pages
      libceph: introduce BVECS data type
      rbd: move from raw pages to bvec data descriptors
      libceph: handle zero-length data items
      rbd: new request handling code
      rbd: remove old request handling code
      rbd: simplify rbd_osd_req_create()
      rbd: add img_req->op_type field
      rbd: update rbd_img_request_submit() signature
      rbd: new request completion code
      rbd: remove old request completion code
      rbd: remove obj_req->flags field
      rbd: store data_type in img_req instead of obj_req
      libceph: striping framework implementation
      libceph, ceph: move ceph_calc_file_object_mapping() to striper.c
      rbd: incorporate ceph_object_extent
      rbd: move to obj_req->img_extents
      rbd: create+truncate for whole-object layered discards
      rbd: switch to common striping framework
      rbd: remove rbd_img_request_fill() and helpers
      rbd: get rid of img_req->{offset,length}
      rbd: remove rbd_parent_request_{create,destroy}()
      rbd: introduce OWN_BVECS data type
      rbd: allow "fancy" striping
      rbd: remove redundant declaration of rbd_spec_put()
      rbd: move rbd_get_client() below rbd_put_client()
      rbd: get the latest osdmap when using an existing client

Kyle Spiers (1):
      rbd: remove VLA usage

Luis Henriques (8):
      ceph: quota: add initial infrastructure to support cephfs quotas
      ceph: quota: support for ceph.quota.max_files
      ceph: quota: don't allow cross-quota renames
      ceph: quota: support for ceph.quota.max_bytes
      ceph: quota: update MDS when max_bytes is approaching
      ceph: quota: cache inode pointer in ceph_snap_realm
      ceph: quota: add counter for snaprealms with quota
      ceph: quota: report root dir quota usage in statfs

Yan, Zheng (5):
      ceph: invalidate pages that beyond EOF in ceph_writepages_start()
      ceph: don't wait on writeback when there is no more dirty pages
      ceph: rename function drop_leases() to a more descriptive name
      ceph: don't check quota for snap inode
      ceph: fix root quota realm check

 Documentation/filesystems/ceph.txt |   16 +
 drivers/block/rbd.c                | 2452 ++++++++++++++----------------------
 fs/ceph/Makefile                   |    2 +-
 fs/ceph/addr.c                     |   63 +-
 fs/ceph/cache.c                    |    4 +-
 fs/ceph/caps.c                     |  128 +-
 fs/ceph/debugfs.c                  |    8 +-
 fs/ceph/dir.c                      |  204 +--
 fs/ceph/file.c                     |  117 +-
 fs/ceph/inode.c                    |   26 +-
 fs/ceph/ioctl.c                    |   13 +-
 fs/ceph/locks.c                    |   20 +-
 fs/ceph/mds_client.c               |   87 +-
 fs/ceph/mds_client.h               |    4 +
 fs/ceph/quota.c                    |  361 ++++++
 fs/ceph/snap.c                     |    2 +
 fs/ceph/super.c                    |   50 +-
 fs/ceph/super.h                    |   42 +
 fs/ceph/xattr.c                    |   44 +
 include/linux/ceph/ceph_features.h |    1 +
 include/linux/ceph/ceph_fs.h       |   17 +
 include/linux/ceph/libceph.h       |    1 +
 include/linux/ceph/messenger.h     |  101 +-
 include/linux/ceph/osd_client.h    |   19 +-
 include/linux/ceph/osdmap.h        |    6 -
 include/linux/ceph/striper.h       |   69 +
 net/ceph/Makefile                  |    1 +
 net/ceph/ceph_common.c             |    8 +-
 net/ceph/crypto.c                  |    6 +-
 net/ceph/debugfs.c                 |   17 +-
 net/ceph/messenger.c               |  188 ++-
 net/ceph/mon_client.c              |    2 +-
 net/ceph/osd_client.c              |   67 +-
 net/ceph/osdmap.c                  |   71 --
 net/ceph/striper.c                 |  261 ++++
 35 files changed, 2558 insertions(+), 1920 deletions(-)
 create mode 100644 fs/ceph/quota.c
 create mode 100644 include/linux/ceph/striper.h
 create mode 100644 net/ceph/striper.c
