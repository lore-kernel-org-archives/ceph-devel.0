From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.4-rc1
Date: Wed, 25 Sep 2019 19:20:21 +0200
Message-ID: <20190925172021.23334-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc1

for you to fetch changes up to 3ee5a7015c8b7cb4de21f7345f8381946f2fce55:

  ceph: call ceph_mdsc_destroy from destroy_fs_client (2019-09-16 12:06:25 +0200)

----------------------------------------------------------------
The highlights are:

- automatic recovery of a blacklisted filesystem session (Zheng Yan).
  This is disabled by default and can be enabled by mounting with the
  new "recover_session=clean" option.

- serialize buffered reads and O_DIRECT writes (Jeff Layton).  Care is
  taken to avoid serializing O_DIRECT reads and writes with each other,
  this is based on the exclusion scheme from NFS.

- handle large osdmaps better in the face of fragmented memory (myself)

- don't limit what security.* xattrs can be get or set (Jeff Layton).
  We were overly restrictive here, unnecessarily preventing things like
  file capability sets stored in security.capability from working.

- allow copy_file_range() within the same inode and across different
  filesystems within the same cluster (Luis Henriques)

----------------------------------------------------------------
David Disseldorp (1):
      libceph: handle OSD op ceph_pagelist_append() errors

Dongsheng Yang (1):
      rbd: fix response length parameter for encoded strings

Erqi Chen (1):
      ceph: reconnect connection if session hang in opening state

Ilya Dryomov (6):
      ceph: fix indentation in __get_snap_name()
      libceph: drop unused con parameter of calc_target()
      rbd: pull rbd_img_request_create() dout out into the callers
      ceph: include ceph_debug.h in cache.c
      libceph: avoid a __vmalloc() deadlock in ceph_kvmalloc()
      libceph: use ceph_kvmalloc() for osdmap arrays

Jeff Layton (18):
      ceph: allow copy_file_range when src and dst inode are same
      ceph: don't list vxattrs in listxattr()
      ceph: don't SetPageError on writepage errors
      ceph: remove ceph_get_cap_mds and __ceph_get_cap_mds
      ceph: fetch cap_gen under spinlock in ceph_add_cap
      ceph: eliminate session->s_trim_caps
      ceph: fix comments over ceph_add_cap
      ceph: have __mark_caps_flushing return flush_tid
      ceph: remove unneeded test in try_flush_caps
      ceph: remove CEPH_I_NOFLUSH
      ceph: remove incorrect comment above __send_cap
      ceph: update the mtime when truncating up
      ceph: don't freeze during write page faults
      ceph: add buffered/direct exclusionary locking for reads and writes
      ceph: turn ceph_security_invalidate_secctx into static inline
      ceph: only set CEPH_I_SEC_INITED if we got a MAC label
      ceph: allow arbitrary security.* xattrs
      ceph: call ceph_mdsc_destroy from destroy_fs_client

John Hubbard (2):
      ceph: don't return a value from void function
      ceph: use release_pages() directly

Krzysztof Wilczynski (1):
      ceph: move static keyword to the front of declarations

Luis Henriques (2):
      ceph: fix directories inode i_blkbits initialization
      ceph: allow object copies across different filesystems in the same cluster

Yan, Zheng (9):
      libceph: add function that reset client's entity addr
      libceph: add function that clears osd client's abort_err
      ceph: allow closing session in restarting/reconnect state
      ceph: track and report error of async metadata operation
      ceph: pass filp to ceph_get_caps()
      ceph: add helper function that forcibly reconnects to ceph cluster.
      ceph: return -EIO if read/write against filp that lost file locks
      ceph: invalidate all write mode filp after reconnect
      ceph: auto reconnect after blacklisted

 Documentation/filesystems/ceph.txt |  14 +++
 drivers/block/rbd.c                |  18 ++--
 fs/ceph/Makefile                   |   2 +-
 fs/ceph/addr.c                     |  61 +++++++------
 fs/ceph/cache.c                    |   2 +
 fs/ceph/caps.c                     | 173 +++++++++++++++++++------------------
 fs/ceph/debugfs.c                  |   1 -
 fs/ceph/export.c                   |  60 ++++++-------
 fs/ceph/file.c                     | 104 +++++++++++++---------
 fs/ceph/inode.c                    |  50 ++++++-----
 fs/ceph/io.c                       | 163 ++++++++++++++++++++++++++++++++++
 fs/ceph/io.h                       |  12 +++
 fs/ceph/locks.c                    |   8 +-
 fs/ceph/mds_client.c               | 110 +++++++++++++++++------
 fs/ceph/mds_client.h               |   8 +-
 fs/ceph/super.c                    |  52 +++++++++--
 fs/ceph/super.h                    |  49 +++++++----
 fs/ceph/xattr.c                    |  76 ++--------------
 include/linux/ceph/libceph.h       |   1 +
 include/linux/ceph/messenger.h     |   1 +
 include/linux/ceph/mon_client.h    |   1 +
 include/linux/ceph/osd_client.h    |   2 +
 net/ceph/ceph_common.c             |  37 ++++++--
 net/ceph/messenger.c               |   6 ++
 net/ceph/mon_client.c              |   7 ++
 net/ceph/osd_client.c              |  65 +++++++++++---
 net/ceph/osdmap.c                  |  69 +++++++++------
 27 files changed, 767 insertions(+), 385 deletions(-)
 create mode 100644 fs/ceph/io.c
 create mode 100644 fs/ceph/io.h
