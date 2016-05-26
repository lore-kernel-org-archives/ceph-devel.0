From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 14:18:03 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This changeset has a few main parts:

 * Ilya has finished a huge refactoring effort to sync up the client-side 
logic in libceph with the user-space client code, which has evolved 
significantly over the last couple years, with lots of additional 
behaviors (e.g., how requests are handled when cluster is full and 
transitions from full to non-full).  This structure of the code is more 
closely aligned with userspace now such that it will be much easier to 
maintain going forward when behavior changes take place.  There are some 
locking improvements bundled in as well.

 * Zheng adds multi-filesystem support (multiple namespaces within the 
same Ceph cluster)

 * Zheng has changed the readdir offsets and directory enumeration so that 
dentry offsets are hash-based and therefore stable across directory 
fragmentation events on the MDS.

 * Zheng has a smorgasbord of bug fixes across fs/ceph.

Thanks!
sage



----------------------------------------------------------------
Ilya Dryomov (40):
      rbd: get/put img_request in rbd_img_request_submit()
      libceph: make ceph_osdc_put_request() accept NULL
      libceph: grab snapc in ceph_osdc_alloc_request()
      libceph: move message allocation out of ceph_osdc_alloc_request()
      libceph: change how osd_op_reply message size is calculated
      libceph: variable-sized ceph_object_id
      rbd: use header_oid instead of header_name
      libceph: nuke unused fields and functions
      libceph: open-code remove_{all,old}_osds()
      libceph: DEFINE_RB_FUNCS macro
      libceph: fix ceph_eversion encoding
      libceph: rename ceph_oloc_oid_to_pg()
      libceph: ceph_osds, ceph_pg_to_up_acting_osds()
      libceph: rename ceph_calc_pg_primary()
      libceph: make pgid_cmp() global
      libceph: pi->min_size, pi->last_force_request_resend
      libceph: introduce ceph_osd_request_target, calc_target()
      libceph: switch to calc_target(), part 1
      libceph: switch to calc_target(), part 2
      libceph: drop msg argument from ceph_osdc_callback_t
      libceph: redo callbacks and factor out MOSDOpReply decoding
      libceph: move schedule_delayed_work() in ceph_osdc_init()
      libceph: schedule tick from ceph_osdc_init()
      libceph: allocate dummy osdmap in ceph_osdc_init()
      libceph: handle_one_map()
      libceph: osd_init() and osd_cleanup()
      libceph: allocate ceph_osd with GFP_NOFAIL
      libceph: protect osdc->osd_lru list with a spinlock
      libceph: a major OSD client update
      libceph: request_init() and request_release_checks()
      libceph: wait_request_timeout()
      rbd: rbd_dev_header_unwatch_sync() variant
      libceph, rbd: ceph_osd_linger_request, watch/notify v2
      libceph: support for sending notifies
      libceph: support for checking on status of watch
      libceph: async MON client generic requests
      libceph: pool deletion detection
      libceph: take osdc->lock in osdmap_show() and dump flags in hex
      libceph: replace ceph_monc_request_next_osdmap()
      libceph: support for subscribing to "mdsmap.<id>" maps

Yan, Zheng (30):
      ceph: multiple filesystem support
      ceph: CEPH_FEATURE_MDSENC support
      ceph: renew caps for read/write if mds session got killed.
      ceph: don't call truncate_pagecache in ceph_writepages_start
      ceph: don't show symlink target in debugfs/mdsc
      ceph: report mount root in session metadata
      ceph: use CEPH_MDS_OP_RMXATTR request to remove xattr
      ceph: search cache postion for dcache readdir
      ceph: remove unnecessary checks in __dcache_readdir
      ceph: simplify 'offset in frag'
      ceph: define struct for dir entry in readdir reply
      ceph: define 'end/complete' in readdir reply as bit flags
      ceph: record 'offset' for each entry of readdir result
      ceph: don't forbid marking directory complete after forward seek
      ceph: using hash value to compose dentry offset
      ceph: fix inode reference leak
      ceph: don't assume frag tree splits in mds reply are sorted
      ceph: fix dir_auth check in ceph_fill_dirfrag()
      ceph: keep leaf frag when updating fragtree
      ceph: improve fragtree change detection
      ceph: tolerate bad i_size for symlink inode
      ceph: block non-fatal signals for fault/page_mkwrite
      ceph: make fault/page_mkwrite return VM_FAULT_OOM for -ENOMEM
      ceph: handle -EAGAIN returned by ceph_update_writeable_page()
      libceph: make ceph_osdc_wait_request() uninterruptible
      ceph: make ceph_update_writeable_page() uninterruptible
      ceph: handle interrupted ceph_writepage()
      ceph: SetPageError() for writeback pages if writepages fails
      ceph: don't use truncate_pagecache() to invalidate read cache
      ceph: fix wake_up_session_cb()

Zhang Zhuoyu (1):
      ceph: make logical calculation functions return bool

 drivers/block/rbd.c             |  305 +--
 fs/ceph/addr.c                  |  214 +-
 fs/ceph/cache.c                 |    2 +-
 fs/ceph/caps.c                  |   51 +-
 fs/ceph/debugfs.c               |    2 +-
 fs/ceph/dir.c                   |  376 ++--
 fs/ceph/file.c                  |   89 +-
 fs/ceph/inode.c                 |  159 +-
 fs/ceph/ioctl.c                 |   14 +-
 fs/ceph/mds_client.c            |  140 +-
 fs/ceph/mds_client.h            |   17 +-
 fs/ceph/mdsmap.c                |   43 +-
 fs/ceph/super.c                 |   47 +-
 fs/ceph/super.h                 |   12 +-
 fs/ceph/xattr.c                 |   25 +-
 include/linux/ceph/ceph_frag.h  |    4 +-
 include/linux/ceph/ceph_fs.h    |   20 +-
 include/linux/ceph/decode.h     |    2 +-
 include/linux/ceph/libceph.h    |   57 +
 include/linux/ceph/mon_client.h |   23 +-
 include/linux/ceph/osd_client.h |  231 ++-
 include/linux/ceph/osdmap.h     |  158 +-
 include/linux/ceph/rados.h      |   34 +-
 net/ceph/ceph_common.c          |    2 +-
 net/ceph/ceph_strings.c         |   16 +
 net/ceph/debugfs.c              |  147 +-
 net/ceph/mon_client.c           |  393 ++--
 net/ceph/osd_client.c           | 4074 +++++++++++++++++++++++++--------------
 net/ceph/osdmap.c               |  651 +++++--
 29 files changed, 4779 insertions(+), 2529 deletions(-)
