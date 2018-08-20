From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.19-rc1
Date: Mon, 20 Aug 2018 17:23:22 +0200
Message-ID: <20180820152322.29372-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.19-rc1

for you to fetch changes up to 0fcf6c02b205f80f24eb548b236543ec151cb01c:

  ceph: don't drop message if it contains more data than expected (2018-08-13 17:55:44 +0200)

----------------------------------------------------------------
The main things are support for cephx v2 authentication protocol and
basic support for rbd images within namespaces (myself).  Also included
y2038 conversion patches from Arnd, a pile of miscellaneous fixes from
Chengguang and Zheng's feature bit infrastructure for the filesystem.

----------------------------------------------------------------
Arnd Bergmann (5):
      libceph: use timespec64 in for keepalive2 and ticket validity
      ceph: stop using current_kernel_time()
      ceph: use timespec64 for inode timestamp
      libceph: use timespec64 for r_mtime
      ceph: use timespec64 for r_stamp

Chengguang Xu (14):
      ceph: add retry logic for error -ERANGE in ceph_get_acl()
      ceph: restore ctime as well in the case of restoring old mode
      libceph: stop parsing when a bad int arg is detected
      ceph: return errors from posix_acl_equiv_mode() correctly
      ceph: add d_drop for some error cases in ceph_mknod()
      ceph: add d_drop for some error cases in ceph_symlink()
      ceph: add new field max_file_size in ceph_fs_client
      ceph: add additional range check in ceph_fallocate()
      ceph: add additional offset check in ceph_write_iter()
      ceph: add additional size check in ceph_setattr()
      ceph: compare fsc->max_file_size and inode->i_size for max file size limit
      ceph: change to void return type for __do_request()
      ceph: refactor ceph_unreserve_caps()
      ceph: refactor error handling code in ceph_reserve_caps()

Ilya Dryomov (14):
      libceph: make ceph_osdc_notify{,_ack}() payload_len u32
      libceph: change ceph_pagelist_encode_string() to take u32
      libceph: amend "bad option arg" error message
      rbd: pass rbd_spec into parse_rbd_opts_token()
      rbd: support for images within namespaces
      libceph: remove now unused ceph_{en,de}code_timespec()
      libceph: store ceph_auth_handshake pointer in ceph_connection
      libceph: factor out __prepare_write_connect()
      libceph: factor out __ceph_x_decrypt()
      libceph: factor out encrypt_authorizer()
      libceph: add authorizer challenge
      libceph: implement CEPHX_V2 calculation mode
      libceph: check authorizer reply/challenge length before reading
      libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()

Souptick Joarder (1):
      ceph: adding new return type vm_fault_t

Stephen Hemminger (1):
      ceph: fix whitespace

Yan, Zheng (3):
      ceph: fix incorrect use of strncpy
      ceph: support cephfs' own feature bits
      ceph: don't drop message if it contains more data than expected

YueHaibing (2):
      libceph: remove unnecessary non NULL check for request_key
      crush: fix using plain integer as NULL warning

 drivers/block/rbd.c                | 125 +++++++++++++------
 fs/ceph/acl.c                      |  30 +++--
 fs/ceph/addr.c                     |  74 ++++++------
 fs/ceph/cache.c                    |  11 +-
 fs/ceph/caps.c                     | 138 ++++++++++-----------
 fs/ceph/dir.c                      |  20 ++--
 fs/ceph/file.c                     |  34 ++++--
 fs/ceph/inode.c                    |  83 ++++++-------
 fs/ceph/mds_client.c               |  98 ++++++++++-----
 fs/ceph/mds_client.h               |  14 ++-
 fs/ceph/quota.c                    |   2 +-
 fs/ceph/snap.c                     |   6 +-
 fs/ceph/super.c                    |   6 +-
 fs/ceph/super.h                    |  12 +-
 fs/ceph/xattr.c                    |   4 +-
 include/linux/ceph/auth.h          |   8 ++
 include/linux/ceph/ceph_features.h |   7 +-
 include/linux/ceph/decode.h        |  18 ++-
 include/linux/ceph/messenger.h     |   8 +-
 include/linux/ceph/msgr.h          |   2 +-
 include/linux/ceph/osd_client.h    |  10 +-
 include/linux/ceph/pagelist.h      |   2 +-
 net/ceph/Kconfig                   |   1 -
 net/ceph/Makefile                  |   1 -
 net/ceph/auth.c                    |  16 +++
 net/ceph/auth_none.c               |   1 -
 net/ceph/auth_none.h               |   1 -
 net/ceph/auth_x.c                  | 239 +++++++++++++++++++++++++++++--------
 net/ceph/auth_x.h                  |   3 +-
 net/ceph/auth_x_protocol.h         |   7 ++
 net/ceph/ceph_common.c             |  13 +-
 net/ceph/cls_lock_client.c         |   4 +-
 net/ceph/crush/mapper.c            |   4 +-
 net/ceph/messenger.c               | 113 +++++++++++-------
 net/ceph/mon_client.c              |   2 +-
 net/ceph/osd_client.c              |  27 +++--
 net/ceph/pagevec.c                 |   1 -
 37 files changed, 737 insertions(+), 408 deletions(-)
