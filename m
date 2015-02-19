From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph changes for {3.20,4.0}-rc1
Date: Thu, 19 Feb 2015 10:25:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502191016340.3077@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

On the RBD side, there is a conversion to blk-mq from Christoph, several 
long-standing bug fixes from Ilya, and some cleanup from Rickard 
Strandqvist.  On the CephFS side there is a long list of fixes from Zheng, 
including improved session handling, a few IO path fixes, some dcache 
management correctness fixes, and several blocking while !TASK_RUNNING 
fixes.  The core code gets a few cleanups and Chaitanya has added support 
for TCP_NODELAY (which has been used on the server side for ages but we 
somehow missed on the kernel client).

There is also an update to MAINTAINERS to fix up some email addresses and 
reflect that Ilya and Zheng are doing most of the maintenance for RBD and 
CephFS these days.  Do not be surprised to see a pull request come from 
one of them in the future if I am unavailable for some reason.

Thanks!
sage

----------------------------------------------------------------
Chaitanya Huilgol (1):
      libceph: tcp_nodelay support

Christoph Hellwig (1):
      rbd: convert to blk-mq

Ilya Dryomov (7):
      libceph: nuke pool op infrastructure
      libceph: use mon_client.c/put_generic_request() more
      rbd: fix error paths in rbd_dev_refresh()
      rbd: do not treat standalone as flatten
      ceph: show nocephx_require_signatures and notcp_nodelay options
      libceph: fix double __remove_osd() problem
      libceph: kfree() in put_osd() shouldn't depend on authorizer

Rickard Strandqvist (2):
      rbd: nuke copy_token()
      ceph: acl: Remove unused function

Sage Weil (1):
      MAINTAINERS: update Ceph and RBD maintainers

Yan, Zheng (15):
      ceph: handle SESSION_FORCE_RO message
      ceph: properly zero data pages for file holes.
      ceph: improve reference tracking for snaprealm
      ceph: avoid block operation when !TASK_RUNNING (ceph_mdsc_sync)
      ceph: avoid block operation when !TASK_RUNNING (ceph_get_caps)
      ceph: avoid block operation when !TASK_RUNNING (ceph_mdsc_close_sessions)
      ceph: fix reading inline data when i_size > PAGE_SIZE
      ceph: fix request time stamp encoding
      ceph: provide seperate {inode,file}_operations for snapdir
      client: include kernel version in client metadata
      ceph: properly mark empty directory as complete
      ceph: fix atomic_open snapdir
      ceph: re-send requests when MDS enters reconnecting stage
      ceph: fix dentry leaks
      ceph: return error for traceless reply race

 MAINTAINERS                     |    7 +-
 drivers/block/rbd.c             |  193 +++++++++++++++++----------------------
 fs/ceph/acl.c                   |   14 ---
 fs/ceph/addr.c                  |   19 ++--
 fs/ceph/caps.c                  |  127 +++++++++++++++-----------
 fs/ceph/dir.c                   |   33 +++++--
 fs/ceph/file.c                  |   37 +++++---
 fs/ceph/inode.c                 |   41 +++++----
 fs/ceph/mds_client.c            |  127 +++++++++++++++++++-------
 fs/ceph/mds_client.h            |    2 +
 fs/ceph/snap.c                  |   54 +++++++----
 fs/ceph/super.c                 |    4 +
 fs/ceph/super.h                 |    5 +-
 include/linux/ceph/ceph_fs.h    |   37 +-------
 include/linux/ceph/libceph.h    |    3 +-
 include/linux/ceph/messenger.h  |    4 +-
 include/linux/ceph/mon_client.h |    9 +-
 net/ceph/ceph_common.c          |   16 +++-
 net/ceph/ceph_strings.c         |   14 ---
 net/ceph/debugfs.c              |    2 -
 net/ceph/messenger.c            |   14 ++-
 net/ceph/mon_client.c           |  139 +---------------------------
 net/ceph/osd_client.c           |   31 +++++--
 23 files changed, 444 insertions(+), 488 deletions(-)
