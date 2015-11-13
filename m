From: Sage Weil <sage@redhat.com>
Subject: [GIT PULL] Ceph changes for -rc1
Date: Fri, 13 Nov 2015 07:54:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511130750020.13621@cobra.newdream.net>
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

There are several patches from Ilya fixing RBD allocation lifecycle 
issues, a series adding a nocephx_sign_messages option (and associated bug 
fixes/cleanups), several patches from Zheng improving the (directory) 
fsync behavior, a big improvement in IO for direct-io requests when 
striping is enabled from Caifeng, and several other small fixes and 
cleanups.

Thanks!
sage

----------------------------------------------------------------
Arnd Bergmann (1):
      ceph: fix message length computation

Geliang Tang (1):
      ceph: fix a comment typo

Ilya Dryomov (10):
      rbd: return -ENOMEM instead of pool id if rbd_dev_create() fails
      rbd: don't free rbd_dev outside of the release callback
      rbd: set device_type::release instead of device::release
      rbd: remove duplicate calls to rbd_dev_mapping_clear()
      libceph: introduce ceph_x_authorizer_cleanup()
      libceph: msg signing callouts don't need con argument
      libceph: drop authorizer check from cephx msg signing routines
      libceph: stop duplicating client fields in messenger
      libceph: add nocephx_sign_messages option
      libceph: clear msg->con in ceph_msg_release() only

Ioana Ciornei (1):
      libceph: evaluate osd_req_op_data() arguments only once

Julia Lawall (1):
      rbd: drop null test before destroy functions

Shraddha Barke (2):
      libceph: remove con argument in handle_reply()
      libceph: use local variable cursor instead of &msg->cursor

Yan, Zheng (3):
      ceph: don't invalidate page cache when inode is no longer used
      ceph: add request to i_unsafe_dirops when getting unsafe reply
      ceph: make fsync() wait unsafe requests that created/modified inode

Zhu, Caifeng (1):
      ceph: combine as many iovec as possile into one OSD request

 drivers/block/rbd.c            | 109 ++++++++++++++++++++---------------------
 fs/ceph/cache.c                |   2 +-
 fs/ceph/caps.c                 |  76 ++++++++++++++--------------
 fs/ceph/file.c                 |  87 ++++++++++++++++++++++++++++----
 fs/ceph/inode.c                |   1 +
 fs/ceph/mds_client.c           |  57 +++++++++++++++------
 fs/ceph/mds_client.h           |   3 ++
 fs/ceph/super.h                |   1 +
 include/linux/ceph/libceph.h   |   4 +-
 include/linux/ceph/messenger.h |  16 ++----
 net/ceph/auth_x.c              |  36 +++++++++-----
 net/ceph/ceph_common.c         |  18 +++++--
 net/ceph/crypto.h              |   4 +-
 net/ceph/messenger.c           |  88 ++++++++++++++-------------------
 net/ceph/osd_client.c          |  34 ++++++-------
 15 files changed, 314 insertions(+), 222 deletions(-)
