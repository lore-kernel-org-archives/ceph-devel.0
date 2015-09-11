From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph changes for 4.3-rc1
Date: Fri, 11 Sep 2015 11:14:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509111110400.7527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-787124152-1441995270=:7527"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-787124152-1441995270=:7527
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi Linus,

Please pull the following Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are a few fixes for snapshot behavior with CephFS and support for 
the new keepalive protocol from Zheng, a libceph fix that affects both RBD 
and CephFS, a few bug fixes and cleanups for RBD from Ilya, and several 
small fixes and cleanups from Jianpeng and others.

Thanks!
sage


----------------------------------------------------------------
Benoît Canet (1):
      libceph: Avoid holding the zero page on ceph_msgr_slab_init errors

Brad Hubbard (1):
      ceph: remove redundant test of head->safe and silence static analysis warnings

Ilya Dryomov (4):
      libceph: rename con_work() to ceph_con_workfn()
      rbd: fix double free on rbd_dev->header_name
      rbd: plug rbd_dev->header.object_prefix memory leak
      libceph: check data_len in ->alloc_msg()

Jianpeng Ma (3):
      ceph: remove the useless judgement
      ceph: no need to get parent inode in ceph_open
      ceph: cleanup use of ceph_msg_get

Nicholas Krause (1):
      libceph: remove the unused macro AES_KEY_SIZE

Yan, Zheng (7):
      ceph: EIO all operations after forced umount
      ceph: invalidate dirty pages after forced umount
      ceph: fix queuing inode to mdsdir's snaprealm
      libceph: set 'exists' flag for newly up osd
      libceph: use keepalive2 to verify the mon session is alive
      ceph: get inode size for each append write
      ceph: improve readahead for file holes

 drivers/block/rbd.c            |  6 ++--
 fs/ceph/addr.c                 |  6 ++--
 fs/ceph/caps.c                 |  8 +++++
 fs/ceph/file.c                 | 14 ++++----
 fs/ceph/mds_client.c           | 59 ++++++++++++++++++++++--------
 fs/ceph/mds_client.h           |  1 +
 fs/ceph/snap.c                 |  7 ----
 fs/ceph/super.c                |  1 +
 include/linux/ceph/libceph.h   |  2 ++
 include/linux/ceph/messenger.h |  4 +++
 include/linux/ceph/msgr.h      |  4 ++-
 net/ceph/ceph_common.c         |  1 +
 net/ceph/crypto.c              |  4 ---
 net/ceph/messenger.c           | 82 +++++++++++++++++++++++++++++++-----------
 net/ceph/mon_client.c          | 37 ++++++++++++++-----
 net/ceph/osd_client.c          | 51 ++++++++++----------------
 net/ceph/osdmap.c              |  2 +-
 17 files changed, 191 insertions(+), 98 deletions(-)
--557981400-787124152-1441995270=:7527--
