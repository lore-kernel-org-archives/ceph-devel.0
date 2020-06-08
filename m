From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.8-rc1
Date: Mon,  8 Jun 2020 18:36:26 +0200
Message-ID: <20200608163626.7339-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgFHQg2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jun 2020 12:36:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.8-rc1

for you to fetch changes up to dc1dad8e1a612650b1e786e992cb0c6e101e226a:

  rbd: compression_hint option (2020-06-01 23:32:35 +0200)

----------------------------------------------------------------
The highlights are:

- OSD/MDS latency and caps cache metrics infrastructure for the
  filesytem (Xiubo Li).  Currently available through debugfs and
  will be periodically sent to the MDS in the future.

- support for replica reads (balanced and localized reads) for
  rbd and the filesystem (myself).  The default remains to always
  read from primary, users can opt-in with the new crush_location
  and read_from_replica options.  Note that reading from replica
  is safe for general use only since Octopus.

- support for RADOS allocation hint flags (myself).  Currently
  used by rbd to propagate the compressible/incompressible hint
  given with the new compression_hint map option and ready for
  passing on more advanced hints, e.g. based on fadvise() from
  the filesystem.

- support for efficient cross-quota-realm renames (Luis Henriques)

- assorted cap handling improvements and cleanups, particularly
  untangling some of the locking (Jeff Layton)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      libceph, rbd: replace zero-length array with flexible-array

Ilya Dryomov (7):
      libceph: add non-asserting rbtree insertion helper
      libceph: decode CRUSH device/bucket types and names
      libceph: crush_location infrastructure
      libceph: support for balanced and localized reads
      libceph: read_from_replica option
      libceph: support for alloc hint flags
      rbd: compression_hint option

Jeff Layton (11):
      ceph: reorganize __send_cap for less spinlock abuse
      ceph: split up __finish_cap_flush
      ceph: add comments for handle_cap_flush_ack logic
      ceph: don't release i_ceph_lock in handle_cap_trunc
      ceph: don't take i_ceph_lock in handle_cap_import
      ceph: document what protects i_dirty_item and i_flushing_item
      ceph: fix potential race in ceph_check_caps
      ceph: throw a warning if we destroy session with mutex still locked
      ceph: convert mdsc->cap_dirty to a per-session list
      ceph: request expedited service on session's last cap flush
      ceph: ceph_kick_flushing_caps needs the s_mutex

Luis Henriques (3):
      ceph: normalize 'delta' parameter usage in check_quota_exceeded
      ceph: allow rename operation under different quota realms
      ceph: don't return -ESTALE if there's still an open file

Xiubo Li (6):
      ceph: add dentry lease metric support
      ceph: add caps perf metric for each superblock
      ceph: add read/write latency metric support
      ceph: add metadata perf metric support
      ceph: make sure mdsc->mutex is nested in s->s_mutex to fix dead lock
      ceph: skip checking caps when session reconnecting and releasing reqs

Yan, Zheng (1):
      ceph: reset i_requested_max_size if file write is not wanted

 drivers/block/rbd.c             |  44 ++++-
 drivers/block/rbd_types.h       |   2 +-
 fs/ceph/Makefile                |   2 +-
 fs/ceph/acl.c                   |   2 +-
 fs/ceph/addr.c                  |  20 ++
 fs/ceph/caps.c                  | 425 ++++++++++++++++++++++++++--------------
 fs/ceph/debugfs.c               | 100 +++++++++-
 fs/ceph/dir.c                   |  26 ++-
 fs/ceph/export.c                |   9 +-
 fs/ceph/file.c                  |  30 +++
 fs/ceph/inode.c                 |   4 +-
 fs/ceph/mds_client.c            |  48 ++++-
 fs/ceph/mds_client.h            |  15 +-
 fs/ceph/metric.c                | 148 ++++++++++++++
 fs/ceph/metric.h                |  62 ++++++
 fs/ceph/quota.c                 |  62 +++++-
 fs/ceph/super.h                 |  34 +++-
 fs/ceph/xattr.c                 |   4 +-
 include/linux/ceph/libceph.h    |  13 +-
 include/linux/ceph/mon_client.h |   2 +-
 include/linux/ceph/osd_client.h |   8 +-
 include/linux/ceph/osdmap.h     |  19 +-
 include/linux/ceph/rados.h      |  14 ++
 include/linux/crush/crush.h     |  14 +-
 net/ceph/ceph_common.c          |  75 +++++++
 net/ceph/crush/crush.c          |   3 +-
 net/ceph/debugfs.c              |   6 +-
 net/ceph/osd_client.c           | 103 +++++++++-
 net/ceph/osdmap.c               | 363 +++++++++++++++++++++++++++++-----
 29 files changed, 1405 insertions(+), 252 deletions(-)
 create mode 100644 fs/ceph/metric.c
 create mode 100644 fs/ceph/metric.h
