From: Sage Weil <sage@inktank.com>
Subject: Ceph fixes for 3.10.y
Date: Tue, 31 Dec 2013 08:21:19 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312310819370.19234@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Greg,

This is a somewhat long overdue set of fixes for 3.10.y.  Since there 
are a lot of patches, they can be pulled from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-stable-3.10.24

If you prefer, I can send them as separate emails instead.  Note that this 
branch includes the 2 patches from the 3.12.y series you already picked 
up.

They are all reviewed, retested, and reference the original upstream 
commit (via git cherry-pick -x).

Thanks!
sage


----------------------------------------------------------------
Alex Elder (4):
      libceph: add lingering request reference when registered
      rbd: flush dcache after zeroing page data
      rbd: set removing flag while holding list lock
      rbd: protect against concurrent unmaps

Dan Carpenter (4):
      ceph: cleanup types in striped_read()
      libceph: fix error handling in handle_reply()
      libceph: potential NULL dereference in ceph_osdc_handle_map()
      libceph: create_singlethread_workqueue() doesn't return ERR_PTRs

Emil Goode (1):
      ceph: improve error handling in ceph_mdsmap_decode

Josh Durgin (8):
      rbd: fix buffer size for writes to images with snapshots
      rbd: fix null dereference in dout
      libceph: add function to ensure notifies are complete
      rbd: complete notifies before cleaning up osd_client and rbd_dev
      rbd: make rbd_obj_notify_ack() synchronous
      rbd: fix use-after free of rbd_dev->disk
      rbd: ignore unmapped snapshots that no longer exist
      rbd: fix error handling from rbd_snap_name()

Nathaniel Yazdani (1):
      ceph: fix null pointer dereference

Sage Weil (1):
      rbd: fix a couple warnings

Sasha Levin (1):
      ceph: avoid accessing invalid memory

Yan, Zheng (5):
      libceph: fix safe completion
      libceph: fix truncate size calculation
      libceph: call r_unsafe_callback when unsafe reply is received
      ceph: cleanup aborted requests when re-sending requests.
      ceph: wake up 'safe' waiters when unregistering request

majianpeng (4):
      ceph: Free mdsc if alloc mdsc->mdsmap failed.
      ceph: Add check returned value on func ceph_calc_ceph_pg.
      ceph: fix bugs about handling short-read for sync read mode.
      ceph: allow sync_read/write return partial successed size of read/write.

 drivers/block/rbd.c             | 158 +++++++++++++++++++++++++---------------
 fs/ceph/file.c                  |  47 ++++++------
 fs/ceph/ioctl.c                 |   8 +-
 fs/ceph/mds_client.c            |  15 +++-
 fs/ceph/mdsmap.c                |   4 +-
 fs/ceph/super.c                 |   2 +-
 include/linux/ceph/osd_client.h |   3 +-
 net/ceph/osd_client.c           |  82 ++++++++++++---------
 8 files changed, 189 insertions(+), 130 deletions(-)
