From: Sage Weil <sage@redhat.com>
Subject: [GIT PULL] Ceph updates for 4.6-rc1
Date: Fri, 25 Mar 2016 21:39:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603252132500.29038@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60782 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbcCZBjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 21:39:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is quite a bit here, including some overdue refactoring and cleanup 
on the mon_client and osd_client code from Ilya, scattered writeback 
support for CephFS and a pile of bug fixes from Zheng, and a few random 
cleanups and fixes from others.

This series is based on a recent merge of Al's tree to avoid conflicts 
with his splice_dentry changes.

Thanks!
sage

----------------------------------------------------------------
Anton Protopopov (1):
      ceph: fix a wrong comparison

Deepa Dinamani (1):
      ceph: replace CURRENT_TIME by current_fs_time()

Geliang Tang (3):
      rbd: use KMEM_CACHE macro
      ceph: use kmem_cache_zalloc
      libceph: use KMEM_CACHE macro

Ilya Dryomov (15):
      libceph: move debugfs initialization into __ceph_open_session()
      libceph: decouple hunting and subs management
      libceph: revamp subs code, switch to SUBSCRIBE2 protocol
      libceph: pick a different monitor when reconnecting
      libceph: monc ping rate is 10s
      libceph: monc hunt rate is 3s with backoff up to 30s
      libceph: introduce and switch to reopen_session()
      libceph: reschedule tick in mon_fault()
      libceph: behave in mon_fault() if cur_mon < 0
      libceph: rename ceph_osd_req_op::payload_len to indata_len
      libceph: make r_request msg_size calculation clearer
      libceph: osdc->req_mempool should be backed by a slab pool
      libceph: enable large, variable-sized OSD requests
      ceph: kill ceph_empty_snapc
      libceph: use sizeof_footer() more

Yan, Zheng (14):
      ceph: encode ctime in cap message
      ceph: don't enable rbytes mount option by default
      ceph: remove useless BUG_ON
      libceph: move r_reply_op_{len,result} into struct ceph_osd_req_op
      libceph: add helper that duplicates last extent operation
      ceph: scattered page writeback
      ceph: fix race during filling readdir cache
      ceph: avoid updating directory inode's i_size accidentally
      ceph: remove unnecessary NULL check
      ceph: fix mounting same fs multiple times
      ceph: don't request vxattrs from MDS
      ceph: fix security xattr deadlock
      ceph: kill ceph_get_dentry_parent_inode()
      ceph: use lookup request to revalidate dentry

 drivers/block/rbd.c                |  14 +-
 fs/ceph/addr.c                     | 324 ++++++++++++++++----------
 fs/ceph/caps.c                     |  11 +-
 fs/ceph/dir.c                      |  69 ++++--
 fs/ceph/export.c                   |  13 ++
 fs/ceph/file.c                     |  15 +-
 fs/ceph/inode.c                    |  34 ++-
 fs/ceph/mds_client.c               |   7 +-
 fs/ceph/snap.c                     |  16 --
 fs/ceph/super.c                    |  47 ++--
 fs/ceph/super.h                    |  23 +-
 fs/ceph/xattr.c                    |  78 ++++++-
 include/linux/ceph/ceph_features.h |   2 +
 include/linux/ceph/ceph_fs.h       |   7 +-
 include/linux/ceph/libceph.h       |   8 +-
 include/linux/ceph/mon_client.h    |  31 ++-
 include/linux/ceph/osd_client.h    |  15 +-
 net/ceph/ceph_common.c             |   4 +-
 net/ceph/debugfs.c                 |  17 +-
 net/ceph/messenger.c               |  29 +--
 net/ceph/mon_client.c              | 457 ++++++++++++++++++++-----------------
 net/ceph/osd_client.c              | 109 ++++++---
 22 files changed, 811 insertions(+), 519 deletions(-)
