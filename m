From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.10-rc1
Date: Fri, 16 Dec 2016 19:14:05 +0100
Message-ID: <1481912045-19365-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.10-rc1

for you to fetch changes up to 45ee2c1d66185e5bd27702c60cce3c43fa3370d2:

  libceph: remove now unused finish_request() wrapper (2016-12-14 22:39:08 +0100)

----------------------------------------------------------------
A varied set of changes:

- a large rework of cephx auth code to cope with CONFIG_VMAP_STACK
  (myself).  Also fixed a deadlock caused by a bogus allocation on the
  writeback path and authorize reply verification.

- a fix for long stalls during fsync (Jeff Layton).  The client now
  has a way to force the MDS log flush, leading to ~100x speedups in
  some synthetic tests.

- a new [no]require_active_mds mount option (Zheng Yan).  On mount, we
  will now check whether any of the MDSes are available and bail rather
  than block if none are.  This check can be avoided by specifying the
  "no" option.

- a couple of MDS cap handling fixes and a few assorted patches
  throughout.

----------------------------------------------------------------
Ilya Dryomov (18):
      libceph: ceph_x_encrypt_buflen() takes in_len
      libceph: old_key in process_one_ticket() is redundant
      libceph: introduce ceph_x_encrypt_offset()
      libceph: introduce ceph_crypt() for in-place en/decryption
      libceph: rename and align ceph_x_authorizer::reply_buf
      libceph: tweak calcu_signature() a little
      libceph: switch ceph_x_encrypt() to ceph_crypt()
      libceph: switch ceph_x_decrypt() to ceph_crypt()
      libceph: remove now unused ceph_*{en,de}crypt*() functions
      libceph: uninline ceph_crypto_key_destroy()
      libceph: stop allocating a new cipher on every crypto request
      libceph: no need for GFP_NOFS in ceph_monc_init()
      libceph: verify authorize reply on connect
      libceph: drop len argument of *verify_authorizer_reply()
      libceph: no need to drop con->mutex for ->get_authorizer()
      rbd: silence bogus -Wmaybe-uninitialized warning
      libceph: always signal completion when done
      libceph: remove now unused finish_request() wrapper

Jeff Layton (5):
      ceph: fix minor typo in unsafe_request_wait
      ceph: move xattr initialzation before the encoding past the ceph_mds_caps
      ceph: define new argument structure for send_cap_msg
      ceph: update cap message struct version to 10
      ceph: add flags parameter to send_cap_msg

Nikolay Borisov (1):
      ceph: fix scheduler warning due to nested blocking

Tobias Klauser (1):
      crush: include mapper.h in mapper.c

Yan, Zheng (6):
      ceph: try getting buffer capability for readahead/fadvise
      ceph: fix splice read for no Fc capability case
      ceph: check availability of mds cluster on mount
      ceph: record truncate size/seq for snap data writeback
      ceph: properly set issue_seq for cap release
      ceph: avoid creating orphan object when checking pool permission

Zhi Zhang (1):
      ceph: fix printing wrong return variable in ceph_direct_read_write()

 drivers/block/rbd.c             |   2 +-
 fs/ceph/addr.c                  |  98 +++++++--
 fs/ceph/caps.c                  | 323 ++++++++++++++++++----------
 fs/ceph/file.c                  | 127 ++++++-----
 fs/ceph/mds_client.c            |  23 +-
 fs/ceph/mdsmap.c                | 163 +++++++++++++-
 fs/ceph/snap.c                  |   2 +
 fs/ceph/super.c                 |  10 +
 fs/ceph/super.h                 |   5 +
 include/linux/ceph/auth.h       |   5 +-
 include/linux/ceph/ceph_fs.h    |   3 +
 include/linux/ceph/mdsmap.h     |   5 +
 include/linux/ceph/messenger.h  |   2 +-
 include/linux/ceph/osd_client.h |   2 +-
 net/ceph/auth.c                 |   4 +-
 net/ceph/auth_x.c               | 197 ++++++++---------
 net/ceph/auth_x.h               |   3 +-
 net/ceph/crush/mapper.c         |   2 +
 net/ceph/crypto.c               | 461 ++++++++++------------------------------
 net/ceph/crypto.h               |  26 +--
 net/ceph/messenger.c            |  19 +-
 net/ceph/mon_client.c           |  12 +-
 net/ceph/osd_client.c           |  39 ++--
 23 files changed, 809 insertions(+), 724 deletions(-)
