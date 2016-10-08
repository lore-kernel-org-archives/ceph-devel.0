From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.9-rc1
Date: Sat,  8 Oct 2016 16:26:15 +0200
Message-ID: <1475936775-14674-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36086 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbcJHO04 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2016 10:26:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.9-rc1

for you to fetch changes up to 64f77566e1c84990d6c448bb3960f899521c0b7d:

  crush: remove redundant local variable (2016-10-05 23:02:10 +0200)

----------------------------------------------------------------
The big ticket item here is support for rbd exclusive-lock feature,
with maintenance operations offloaded to userspace (Douglas Fuller,
Mike Christie and myself).  Another block device bullet is a series
fixing up layering error paths (myself).

On the filesystem side, we've got patches that improve our handling of
buffered vs dio write races (Neil Brown) and a few assorted fixes from
Zheng.  Also included a couple of random cleanups and a minor CRUSH
update.

----------------------------------------------------------------
Andreas Gerstmayr (1):
      ceph: fix description for rsize and rasize mount options

Douglas Fuller (5):
      libceph: support for CEPH_OSD_OP_LIST_WATCHERS
      libceph: add ceph_osdc_call() single-page helper
      libceph: support for advisory locking on RADOS objects
      libceph: support for lock.lock_info
      libceph: support for blacklisting clients

Ilya Dryomov (21):
      libceph: rename ceph_entity_name_encode() -> ceph_auth_entity_name_encode()
      libceph: rename ceph_client_id() -> ceph_client_gid()
      rbd: introduce a per-device ordered workqueue
      rbd: retry watch re-registration periodically
      rbd: support for exclusive-lock feature
      rbd: print capacity in decimal and features in hex
      rbd: add 'client_addr' sysfs rbd device attribute
      rbd: lock_on_read map option
      rbd: change rbd_obj_request_submit() signature
      rbd: clean up asserts in rbd_img_obj_request_submit() helpers
      rbd: mark the original request as done if stat request fails
      rbd: move bumping img_request refcount into rbd_obj_request_submit()
      rbd: don't crash or leak on errors in rbd_img_obj_parent_read_full_callback()
      rbd: rework rbd_img_obj_exists_submit() error paths
      rbd: don't call rbd_osd_req_format_read() for !img_data requests
      rbd: img_data requests don't own their page array
      rbd: add rbd_obj_request_error() helper
      libceph: use CEPH_AUTH_UNKNOWN in ceph_auth_build_hello()
      libceph: ceph_build_auth() doesn't need ceph_auth_build_hello()
      crush: don't normalize input of crush_ln iteratively
      crush: remove redundant local variable

Markus Elfring (1):
      rbd: use kmalloc_array() in rbd_header_from_disk()

Mike Christie (4):
      rbd: add 'cluster_fsid' sysfs rbd device attribute
      rbd: add 'snap_id' sysfs rbd device attribute
      rbd: add 'config_info' sysfs rbd device attribute
      rbd: add force close option

NeilBrown (2):
      ceph: ignore error from invalidate_inode_pages2_range() in direct write
      ceph: remove warning when ceph_releasepage() is called on dirty page

Wei Yongjun (1):
      ceph: use list_move instead of list_del/list_add

Yan, Zheng (4):
      ceph: fix error handling of start_read()
      ceph: fix mandatory flock check
      ceph: avoid accessing / when mounting a subpath
      ceph: handle CEPH_SESSION_REJECT message

 Documentation/ABI/testing/sysfs-bus-rbd |   29 +-
 Documentation/filesystems/ceph.txt      |    4 +
 drivers/block/rbd.c                     | 1562 ++++++++++++++++++++++++-------
 drivers/block/rbd_types.h               |   11 +
 fs/ceph/addr.c                          |   24 +-
 fs/ceph/file.c                          |    4 +-
 fs/ceph/locks.c                         |    4 +-
 fs/ceph/mds_client.c                    |   30 +-
 fs/ceph/mds_client.h                    |    1 +
 fs/ceph/strings.c                       |    2 +
 fs/ceph/super.c                         |   49 +-
 include/linux/ceph/auth.h               |    2 +-
 include/linux/ceph/ceph_fs.h            |   12 +
 include/linux/ceph/cls_lock_client.h    |   49 +
 include/linux/ceph/libceph.h            |    3 +-
 include/linux/ceph/mon_client.h         |    3 +
 include/linux/ceph/osd_client.h         |   23 +-
 net/ceph/Makefile                       |    1 +
 net/ceph/auth.c                         |   13 +-
 net/ceph/auth_none.c                    |    2 +-
 net/ceph/ceph_common.c                  |   13 +-
 net/ceph/ceph_strings.c                 |    1 +
 net/ceph/cls_lock_client.c              |  325 +++++++
 net/ceph/crush/mapper.c                 |   17 +-
 net/ceph/mon_client.c                   |   82 ++
 net/ceph/osd_client.c                   |  169 ++++
 26 files changed, 2031 insertions(+), 404 deletions(-)
 create mode 100644 include/linux/ceph/cls_lock_client.h
 create mode 100644 net/ceph/cls_lock_client.c
