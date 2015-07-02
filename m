From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph updates for -rc1
Date: Thu, 2 Jul 2015 09:29:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507020923540.13991@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1594059033-1435854560=:13991"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbbGBQ3V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Jul 2015 12:29:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1594059033-1435854560=:13991
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi Linus,

Please pull the following Ceph updates from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

We have a pile of bug fixes from Ilya, including a few patches that sync 
up the CRUSH code with the latest from userspace.  There is also a long 
series from Zheng that fixes various issues with snapshots, inline data, 
and directory fsync, some simplification and improvement in the cap 
release code, and a rework of the caching of directory contents.  To top 
it off there are a few small fixes and cleanups from Benoit and Hong.

Thanks!
sage


----------------------------------------------------------------
Benoît Canet (2):
      libceph: Remove spurious kunmap() of the zero page
      libceph: Fix ceph_tcp_sendpage()'s more boolean usage

Hong Zhiguo (1):
      libceph: fix wrong name "Ceph filesystem for Linux"

Ilya Dryomov (14):
      libceph: use kvfree() instead of open-coding it
      libceph: nuke time_sub()
      libceph: store timeouts in jiffies, verify user input
      libceph: a couple tweaks for wait loops
      ceph: simplify two mount_timeout sites
      rbd: timeout watch teardown on unmap with mount_timeout
      crush: fix crash from invalid 'take' argument
      crush: sync up with userspace
      rbd: bump queue_max_segments
      rbd: terminate rbd_opts_tokens with Opt_err
      rbd: store rbd_options in rbd_device
      rbd: queue_depth map option
      crush: fix a bug in tree bucket decode
      rbd: use GFP_NOIO in rbd_obj_request_create()

Yan, Zheng (23):
      libceph: properly release STAT request's raw_data_in
      libceph: allow setting osd_req_op's flags
      ceph: check OSD caps before read/write
      ceph: use empty snap context for uninline_data and get_pool_perm
      ceph: set i_head_snapc when getting CEPH_CAP_FILE_WR reference
      ceph: avoid sending unnessesary FLUSHSNAP message
      ceph: take snap_rwsem when accessing snap realm's cached_context
      ceph: don't trim auth cap when there are cap snaps
      ceph: make sure syncfs flushes all cap snaps
      ceph: don't pre-allocate space for cap release messages
      ceph: exclude setfilelock requests when calculating oldest tid
      ceph: ratelimit warn messages for MDS closes session
      ceph: don't include used caps in cap_wanted
      ceph: fix flushing caps
      ceph: fix directory fsync
      ceph: track pending caps flushing accurately
      ceph: track pending caps flushing globally
      ceph: send TID of the oldest pending caps flush to MDS
      ceph: re-send flushing caps (which are revoked) in reconnect stage
      ceph: pre-allocate data structure that tracks caps flushing
      ceph: switch some GFP_NOFS memory allocation to GFP_KERNEL
      ceph: rework dcache readdir
      ceph: fix ceph_writepages_start()

 drivers/block/rbd.c             | 111 ++++--
 fs/ceph/acl.c                   |   4 +-
 fs/ceph/addr.c                  | 308 ++++++++++++---
 fs/ceph/caps.c                  | 836 +++++++++++++++++++++++++++-------------
 fs/ceph/dir.c                   | 383 ++++++++----------
 fs/ceph/file.c                  |  61 ++-
 fs/ceph/inode.c                 | 155 ++++++--
 fs/ceph/mds_client.c            | 425 +++++++++++---------
 fs/ceph/mds_client.h            |  23 +-
 fs/ceph/snap.c                  | 173 +++++----
 fs/ceph/super.c                 |  25 +-
 fs/ceph/super.h                 | 125 +++---
 fs/ceph/xattr.c                 |  65 +++-
 include/linux/ceph/libceph.h    |  21 +-
 include/linux/ceph/osd_client.h |   2 +-
 include/linux/crush/crush.h     |  40 +-
 include/linux/crush/hash.h      |   6 +
 include/linux/crush/mapper.h    |   2 +-
 net/ceph/ceph_common.c          |  50 ++-
 net/ceph/crush/crush.c          |  13 +-
 net/ceph/crush/crush_ln_table.h |  32 +-
 net/ceph/crush/hash.c           |   8 +-
 net/ceph/crush/mapper.c         | 148 ++++---
 net/ceph/messenger.c            |   3 +-
 net/ceph/mon_client.c           |  13 +-
 net/ceph/osd_client.c           |  42 +-
 net/ceph/osdmap.c               |   2 +-
 net/ceph/pagevec.c              |   5 +-
 28 files changed, 2010 insertions(+), 1071 deletions(-)
--557981400-1594059033-1435854560=:13991--
