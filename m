From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.2-rc1
Date: Thu, 16 May 2019 17:40:05 +0200
Message-ID: <20190516154005.22583-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.2-rc1

for you to fetch changes up to 00abf69dd24f4444d185982379c5cc3bb7b6d1fc:

  ceph: flush dirty inodes before proceeding with remount (2019-05-07 19:43:05 +0200)

----------------------------------------------------------------
On the filesystem side we have:

- a fix to enforce quotas set above the mount point (Luis Henriques)

- support for exporting snapshots through NFS (Zheng Yan)

- proper statx implementation (Jeff Layton).  statx flags are mapped
  to MDS caps, with AT_STATX_{DONT,FORCE}_SYNC taken into account.

- some follow-up dentry name handling fixes, in particular elimination
  of our hand-rolled helper and the switch to __getname() as suggested
  by Al (Jeff Layton)

- a set of MDS client cleanups in preparation for async MDS requests
  in the future (Jeff Layton)

- a fix to sync the filesystem before remounting (Jeff Layton)

On the rbd side, work is on-going on object-map and fast-diff image
features.

----------------------------------------------------------------
Arnd Bergmann (3):
      rbd: avoid clang -Wuninitialized warning
      rbd: convert all rbd_assert(0) to BUG()
      libceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK

Ilya Dryomov (2):
      rbd: client_mutex is never nested
      rbd: don't assert on writes to snapshots

Jeff Layton (20):
      ceph: remove superfluous inode_lock in ceph_fsync
      ceph: properly handle granular statx requests
      ceph: fix NULL pointer deref when debugging is enabled
      ceph: make iterate_session_caps a public symbol
      ceph: dump granular cap info in "caps" debugfs file
      ceph: fix potential use-after-free in ceph_mdsc_build_path
      ceph: use ceph_mdsc_build_path instead of clone_dentry_name
      ceph: use __getname/__putname in ceph_mdsc_build_path
      ceph: use pathlen values returned by set_request_path_attr
      ceph: after an MDS request, do callback and completions
      ceph: have ceph_mdsc_do_request call ceph_mdsc_submit_request
      ceph: move wait for mds request into helper function
      ceph: fix comment over ceph_drop_caps_for_unlink
      ceph: simplify arguments and return semantics of try_get_cap_refs
      ceph: just call get_session in __ceph_lookup_mds_session
      ceph: print inode number in __caps_issued_mask debugging messages
      libceph: fix unaligned accesses in ceph_entity_addr handling
      libceph: make ceph_pr_addr take an struct ceph_entity_addr pointer
      ceph: fix unaligned access in ceph_send_cap_releases
      ceph: flush dirty inodes before proceeding with remount

Luis Henriques (2):
      ceph: factor out ceph_lookup_inode()
      ceph: quota: fix quota subdir mounts

Yan, Zheng (1):
      ceph: snapshot nfs re-export

Zhi Zhang (1):
      ceph: remove duplicated filelock ref increase

 drivers/block/rbd.c            |  24 +--
 fs/ceph/caps.c                 |  93 +++++------
 fs/ceph/debugfs.c              |  40 ++++-
 fs/ceph/export.c               | 356 ++++++++++++++++++++++++++++++++++++++---
 fs/ceph/file.c                 |   2 +-
 fs/ceph/inode.c                |  85 ++++++----
 fs/ceph/locks.c                |  13 --
 fs/ceph/mds_client.c           | 205 ++++++++++--------------
 fs/ceph/mds_client.h           |  33 +++-
 fs/ceph/mdsmap.c               |   2 +-
 fs/ceph/quota.c                | 177 ++++++++++++++++++--
 fs/ceph/super.c                |   7 +
 fs/ceph/super.h                |   2 +
 include/linux/ceph/ceph_fs.h   |   6 +
 include/linux/ceph/messenger.h |   3 +-
 include/linux/ceph/osdmap.h    |  13 +-
 net/ceph/cls_lock_client.c     |   2 +-
 net/ceph/debugfs.c             |   4 +-
 net/ceph/messenger.c           | 121 +++++++-------
 net/ceph/mon_client.c          |   6 +-
 net/ceph/osd_client.c          |   2 +-
 21 files changed, 845 insertions(+), 351 deletions(-)
