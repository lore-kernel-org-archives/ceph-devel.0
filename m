From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.14-rc1
Date: Tue, 12 Sep 2017 18:05:09 +0200
Message-ID: <1505232309-15208-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36802 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbdILQFc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 12:05:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 569dbb88e80deb68974ef6fdd6a13edb9d686261:

  Linux 4.13 (2017-09-03 13:56:17 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.14-rc1

for you to fetch changes up to 15b51bd6badbb373c723aa019cf530c8263efd7e:

  ceph: stop on-going cached readdir if mds revokes FILE_SHARED cap (2017-09-06 19:57:00 +0200)

----------------------------------------------------------------
The highlights include:

 * a large series of fixes and improvements to the snapshot-handling
   code (Zheng Yan)

 * individual read/write OSD requests passed down to libceph are now
   limited to 16M in size to avoid hitting OSD-side limits (Zheng Yan)

 * encode MStatfs v2 message to allow for more accurate space usage
   reporting (Douglas Fuller)

 * switch to the new writeback error tracking infrastructure (Jeff
   Layton)

----------------------------------------------------------------
Douglas Fuller (1):
      ceph: more accurate statfs

Jeff Layton (1):
      ceph: use errseq_t for writeback error reporting

Kefeng Wang (1):
      rbd: silence bogus uninitialized use warning in rbd_acquire_lock()

Luis Henriques (1):
      ceph: check negative offsets in ceph_llseek()

Markus Elfring (3):
      ceph: ENOMEM pr_err in __get_or_create_frag() is redundant
      ceph: delete an unnecessary return statement in update_dentry_lease()
      ceph: adjust 36 checks for NULL pointers

Yan, Zheng (27):
      ceph: remove unused cap_release_safety mount option
      ceph: limit osd read size to CEPH_MSG_MAX_DATA_LEN
      ceph: limit osd write size
      ceph: validate correctness of some mount options
      ceph: new cap message flags indicate if there is pending capsnap
      ceph: cleanup ceph_readdir_prepopulate()
      ceph: don't fill readdir cache for LSSNAP reply
      ceph: send LSSNAP request to auth mds of directory inode
      ceph: fix -EOLDSNAPC handling
      ceph: make sure flushsnap messages are sent in proper order
      ceph: include snapc in debug message of write
      ceph: don't use CEPH_OSD_FLAG_ORDERSNAP
      ceph: properly set snap follows for cap reconnect
      ceph: fix NULL pointer dereference in ceph_flush_snaps()
      ceph: fix message order check in handle_cap_export()
      ceph: handle race between vmtruncate and queuing cap snap
      ceph: queue cap snap only when snap realm's context changes
      ceph: remove stale check in ceph_invalidatepage()
      ceph: properly get capsnap's size in get_oldest_context()
      ceph: make writepage_nounlock() invalidate page that beyonds EOF
      ceph: optimize pagevec iterating in ceph_writepages_start()
      ceph: cleanup local variables in ceph_writepages_start()
      ceph: fix "range cyclic" mode writepages
      ceph: ignore wbc->range_{start,end} when write back snapshot data
      ceph: fix capsnap dirty pages accounting
      ceph: wait on writeback after writing snapshot data
      ceph: stop on-going cached readdir if mds revokes FILE_SHARED cap

Yanhu Cao (1):
      ceph: nuke startsync op

 drivers/block/rbd.c             |   2 +-
 fs/ceph/addr.c                  | 403 ++++++++++++++++++++++------------------
 fs/ceph/cache.c                 |   2 +-
 fs/ceph/caps.c                  |  40 ++--
 fs/ceph/debugfs.c               |   2 +-
 fs/ceph/dir.c                   |   6 +-
 fs/ceph/file.c                  |  50 ++---
 fs/ceph/inode.c                 |  53 +++---
 fs/ceph/mds_client.c            |  37 ++--
 fs/ceph/mdsmap.c                |   6 +-
 fs/ceph/snap.c                  |  37 ++--
 fs/ceph/super.c                 |  78 ++++----
 fs/ceph/super.h                 |  16 +-
 fs/ceph/xattr.c                 |   8 +-
 include/linux/ceph/ceph_fs.h    |   6 +-
 include/linux/ceph/libceph.h    |  11 --
 include/linux/ceph/mon_client.h |   4 +-
 include/linux/ceph/rados.h      |   1 -
 net/ceph/mon_client.c           |   6 +-
 net/ceph/osd_client.c           |   5 -
 20 files changed, 421 insertions(+), 352 deletions(-)
