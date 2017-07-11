From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.13-rc1
Date: Tue, 11 Jul 2017 19:21:38 +0200
Message-ID: <1499793698-8189-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c:

  Linux 4.12 (2017-07-02 16:07:02 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.13-rc1

for you to fetch changes up to 33e9c8dbfbcef8e4cda8e43a445e692ab7e0d8c0:

  libceph: advertise support for NEW_OSDOP_ENCODING and SERVER_LUMINOUS (2017-07-07 17:26:24 +0200)

----------------------------------------------------------------
The main item here is support for v12.y.z ("Luminous") clusters:
RESEND_ON_SPLIT, RADOS_BACKOFF, OSDMAP_PG_UPMAP and CRUSH_CHOOSE_ARGS
feature bits, and various other changes in the RADOS client protocol.
On top of that we have a new fsc mount option to allow supplying
fscache uniquifier (similar to NFS) and the usual pile of filesystem
fixes from Zheng.

----------------------------------------------------------------
Ilya Dryomov (33):
      libceph: remove ceph_sanitize_features() workaround
      libceph: new features macros
      libceph: handle non-empty dest in ceph_{oloc,oid}_copy()
      libceph: advertise support for OSD_POOLRESEND
      libceph: support SERVER_JEWEL feature bits
      libceph: fold [l]req->last_force_resend into ceph_osd_request_target
      libceph: new pi->last_force_request_resend
      libceph: introduce ceph_spg, ceph_pg_to_primary_shard()
      libceph: encode_{pgid,oloc}() helpers
      libceph: ceph_connection_operations::reencode_message() method
      libceph: MOSDOp v8 encoding (actual spgid + full hash)
      libceph: drop need_resend from calc_target()
      libceph: resend on PG splits if OSD has RESEND_ON_SPLIT
      libceph: delete from need_resend_linger before check_linger_pool_dne()
      libceph: make sure need_resend targets reflect latest map
      libceph: always populate t->target_{oid,oloc} in calc_target()
      libceph: use target pi for calc_target() calculations
      libceph: avoid unnecessary pi lookups in calc_target()
      libceph: make DEFINE_RB_* helpers more general
      libceph: respect RADOS_BACKOFF backoffs
      libceph: don't pass pgid by value
      libceph: introduce and switch to decode_pg_mapping()
      libceph: kill __{insert,lookup,remove}_pg_mapping()
      libceph: ceph_decode_skip_* helpers
      libceph: pg_upmap[_items] infrastructure
      libceph: compute actual pgid in ceph_pg_to_up_acting_osds()
      libceph: apply_upmap()
      crush: implement weight and id overrides for straw2
      libceph, crush: per-pool crush_choose_arg_map for crush_do_rule()
      crush: crush_init_workspace starts with struct crush_work
      crush: remove an obsolete comment
      libceph: osd_state is 32 bits wide in luminous
      libceph: advertise support for NEW_OSDOP_ENCODING and SERVER_LUMINOUS

Yan, Zheng (11):
      ceph: re-request max size after importing caps
      ceph: update the 'approaching max_size' code
      ceph: remove useless page->mapping check in writepage_nounlock()
      ceph: redirty page when writepage_nounlock() skips unwritable page
      ceph: cleanup writepage_nounlock()
      ceph: don't re-send interrupted flock request
      ceph: getattr before read on ceph.* xattrs
      ceph: avoid invalid memory dereference in the middle of umount
      ceph: avoid accessing freeing inode in ceph_check_delayed_caps()
      ceph: new mount option that specifies fscache uniquifier
      ceph: update ceph_dentry_info::lease_session when necessary

 fs/ceph/addr.c                     |  21 +-
 fs/ceph/cache.c                    |  92 +++-
 fs/ceph/caps.c                     |  40 +-
 fs/ceph/file.c                     |   2 +-
 fs/ceph/inode.c                    |  18 +-
 fs/ceph/locks.c                    |  25 +-
 fs/ceph/mds_client.c               |   4 +-
 fs/ceph/super.c                    |  47 +-
 fs/ceph/super.h                    |   4 +-
 fs/ceph/xattr.c                    |   3 +
 include/linux/ceph/ceph_features.h | 264 +++++++----
 include/linux/ceph/ceph_fs.h       |   1 +
 include/linux/ceph/decode.h        |  60 +++
 include/linux/ceph/libceph.h       |  49 +-
 include/linux/ceph/messenger.h     |   2 +
 include/linux/ceph/osd_client.h    |  70 ++-
 include/linux/ceph/osdmap.h        |  41 +-
 include/linux/ceph/rados.h         |   6 +
 include/linux/crush/crush.h        |  66 +++
 include/linux/crush/mapper.h       |   9 +-
 net/ceph/ceph_common.c             |   1 +
 net/ceph/crush/crush.c             |   3 +
 net/ceph/crush/mapper.c            |  81 +++-
 net/ceph/debugfs.c                 | 112 ++++-
 net/ceph/messenger.c               |  10 +-
 net/ceph/mon_client.c              |   8 +-
 net/ceph/osd_client.c              | 905 +++++++++++++++++++++++++++++++++----
 net/ceph/osdmap.c                  | 840 ++++++++++++++++++++++++++--------
 28 files changed, 2308 insertions(+), 476 deletions(-)
