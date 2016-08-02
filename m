From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.8-rc1
Date: Tue,  2 Aug 2016 16:09:23 +0200
Message-ID: <1470146963-18367-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33865 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934884AbcHBOYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2016 10:24:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.8-rc1

for you to fetch changes up to a0f2b65275413b3438e9f55b1427273cd893c3b2:

  ceph: fix symbol versioning for ceph_monc_do_statfs (2016-07-28 15:32:53 +0200)

----------------------------------------------------------------
The highlights are:

 * RADOS namespace support in libceph and CephFS (Zheng Yan and myself).
   The stopgaps added in 4.5 to deny access to inodes in namespaces are
   removed and CEPH_FEATURE_FS_FILE_LAYOUT_V2 feature bit is now fully
   supported.

 * A large rework of the MDS cap flushing code (Zheng Yan).

 * Handle some of ->d_revalidate() in RCU mode (Jeff Layton).  We were
   overly pessimistic before, bailing at the first sight of LOOKUP_RCU.

On top of that we've got a few CephFS bug fixes, a couple of cleanups
and Arnd's workaround for a weird genksyms issue.

----------------------------------------------------------------
Arnd Bergmann (1):
      ceph: fix symbol versioning for ceph_monc_do_statfs

Colin Ian King (1):
      ceph: fix spelling mistake: "resgister" -> "register"

Ilya Dryomov (3):
      libceph: fix some missing includes
      libceph: add an ONSTACK initializer for oids
      libceph: add start en/decoding block helpers

Jeff Layton (4):
      ceph: remove ceph_mdsc_lease_release
      ceph: clear d_fsinfo pointer under d_lock
      ceph: allow dentry_lease_is_valid to work under RCU walk
      ceph: handle LOOKUP_RCU in ceph_d_revalidate

Miklos Szeredi (1):
      ceph: don't use ->d_time

Nikolay Borisov (1):
      ceph: Mark the file cache as unreclaimable

Phil Turnbull (1):
      ceph: Correctly return NXIO errors from ceph_llseek

Yan, Zheng (22):
      libceph: define new ceph_file_layout structure
      libceph: introduce reference counted string
      libceph: rados pool namespace support
      libceph: make sure redirect does not change namespace
      ceph: rados pool namespace support
      ceph: set user pages dirty after direct IO read
      ceph: reduce i_nr_by_mode array size
      ceph: fix use-after-free bug in ceph_direct_read_write()
      ceph: wait unsafe sync writes for evicting inode
      ceph: fix NULL dereference in ceph_queue_cap_snap()
      libceph: fsmap.user subscription support
      ceph: mount non-default filesystem by name
      ceph: update cap reconnect message to version 3
      ceph: include 'follows' of pending snapflush in cap reconnect message
      ceph: update types of some local varibles
      ceph: use list instead of rbtree to track cap flushes
      ceph: unify cap flush and snapcap flush
      ceph: avoid sending duplicated cap flush message
      ceph: introduce an inode flag to indicates if snapflush is needed
      ceph: kick cap flushes before sending other cap message
      ceph: cleanup ceph_flush_snaps()
      ceph: optimize cap flush waiting

 drivers/block/rbd.c               |  15 +-
 fs/ceph/addr.c                    |  77 +++-
 fs/ceph/cache.c                   |   2 +-
 fs/ceph/caps.c                    | 873 ++++++++++++++++++++------------------
 fs/ceph/dir.c                     |  73 ++--
 fs/ceph/file.c                    |  77 +++-
 fs/ceph/inode.c                   |  40 +-
 fs/ceph/ioctl.c                   |  30 +-
 fs/ceph/mds_client.c              | 358 ++++++++--------
 fs/ceph/mds_client.h              |  19 +-
 fs/ceph/snap.c                    |  10 +-
 fs/ceph/super.c                   |  43 +-
 fs/ceph/super.h                   |  48 +--
 fs/ceph/xattr.c                   | 101 +++--
 include/linux/ceph/ceph_fs.h      |  55 ++-
 include/linux/ceph/decode.h       |  55 +++
 include/linux/ceph/libceph.h      |   4 +-
 include/linux/ceph/mon_client.h   |   7 +-
 include/linux/ceph/msgpool.h      |   1 -
 include/linux/ceph/osd_client.h   |   1 +
 include/linux/ceph/osdmap.h       |  15 +-
 include/linux/ceph/string_table.h |  62 +++
 net/ceph/Makefile                 |   2 +-
 net/ceph/ceph_common.c            |   2 +
 net/ceph/ceph_fs.c                |  30 +-
 net/ceph/debugfs.c                |  12 +-
 net/ceph/mon_client.c             |   4 +-
 net/ceph/msgpool.c                |   1 +
 net/ceph/osd_client.c             |  49 ++-
 net/ceph/osdmap.c                 |  58 ++-
 net/ceph/string_table.c           | 111 +++++
 31 files changed, 1412 insertions(+), 823 deletions(-)
 create mode 100644 include/linux/ceph/string_table.h
 create mode 100644 net/ceph/string_table.c
