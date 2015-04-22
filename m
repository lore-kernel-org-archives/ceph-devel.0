From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph updates for 4.1-rc1
Date: Wed, 22 Apr 2015 09:36:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504220907230.11741@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linux,

Please pull the following Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This time around we have a collection of CephFS fixes from Zheng around 
MDS failure handling and snapshots, support for a new CRUSH straw2 
algorithm (to sync up with userspace) and several RBD cleanups and fixes 
from Ilya, an error path leak fix from Taesoo, and then an assorted 
collection of cleanups from others.

Thanks!
sage


----------------------------------------------------------------
Fabian Frederick (1):
      ceph: remove redundant declaration

Ilya Dryomov (12):
      rbd: be more informative on -ENOENT failures
      libceph: don't overwrite specific con error msgs
      rbd: mark block queue as non-rotational
      libceph, ceph: split ceph_show_options()
      libceph: expose client options through debugfs
      ceph: show non-default options only
      libceph: simplify our debugfs attr macro
      crush: drop unnecessary include from mapper.c
      crush: ensuring at most num-rep osds are selected
      crush: straw2 bucket type with an efficient 64-bit crush_ln()
      libceph: announce support for straw2 buckets
      rbd: rbd_wq comment is obsolete

Joe Perches (1):
      libceph: osdmap.h: Add missing format newlines

Nicholas Mc Guire (2):
      ceph: use msecs_to_jiffies for time conversion
      ceph: match wait_for_completion_timeout return type

Sanidhya Kashyap (1):
      ceph: kstrdup() memory handling

Taesoo Kim (1):
      ceph: properly release page upon error

Yan, Zheng (10):
      ceph: drop cap releases in requests composed before cap reconnect
      ceph: fix dcache/nocache mount option
      ceph: keep i_snap_realm while there are writers
      ceph: don't mark dirty caps when there is no auth cap
      ceph: don't zero i_wrbuffer_ref when reconnecting is denied
      ceph: cleanup unsafe requests when reconnecting is denied
      ceph: hold on to exclusive caps on complete directories
      ceph: fix null pointer dereference in send_mds_reconnect()
      ceph: rename snapshot support
      ceph: fix uninline data function

 drivers/block/rbd.c                |   26 ++++--
 fs/ceph/addr.c                     |   38 ++++++---
 fs/ceph/caps.c                     |   51 ++++++++---
 fs/ceph/dir.c                      |   48 ++++++++---
 fs/ceph/mds_client.c               |   61 +++++++++----
 fs/ceph/strings.c                  |    1 +
 fs/ceph/super.c                    |   56 ++++++------
 fs/ceph/super.h                    |    4 +-
 fs/ceph/xattr.c                    |   23 +++--
 include/linux/ceph/ceph_features.h |   16 +++-
 include/linux/ceph/ceph_fs.h       |    1 +
 include/linux/ceph/debugfs.h       |    8 +-
 include/linux/ceph/libceph.h       |    2 +
 include/linux/ceph/osdmap.h        |    5 +-
 include/linux/crush/crush.h        |   12 ++-
 net/ceph/ceph_common.c             |   37 ++++++++
 net/ceph/crush/crush.c             |   14 +++
 net/ceph/crush/crush_ln_table.h    |  166 ++++++++++++++++++++++++++++++++++++
 net/ceph/crush/mapper.c            |  118 +++++++++++++++++++++++--
 net/ceph/debugfs.c                 |   24 ++++++
 net/ceph/messenger.c               |   25 +++---
 net/ceph/osdmap.c                  |   25 ++++++
 22 files changed, 633 insertions(+), 128 deletions(-)
 create mode 100644 net/ceph/crush/crush_ln_table.h
