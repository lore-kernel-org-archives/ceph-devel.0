From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc2
Date: Fri, 3 Jun 2016 08:48:57 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606030835310.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

We have a few follow-up fixes for the libceph refactor from Ilya, and then 
some cephfs + fscache fixes from Zheng.  The first two FS-Cache patches 
are acked by David Howells and deemed trivial enough to go through our 
tree.  The rest fix some issues with the ceph fscache handling (disable 
cache for inodes opened for write, and simplify the revalidation logic 
accordingly, dropping the now-unnecessary work queue).

Thanks!
sage


----------------------------------------------------------------
Ilya Dryomov (3):
      libceph: change ceph_osdmap_flag() to take osdc
      libceph: put request only if it's done in handle_reply()
      libceph: use %s instead of %pE in dout()s

Yan, Zheng (7):
      FS-Cache: wake write waiter after invalidating writes
      FS-Cache: make check_consistency callback return int
      ceph: call __fscache_uncache_page() if readpages fails
      ceph: avoid unnecessary fscache invalidation/revlidation
      ceph: disable fscache when inode is opened for write
      ceph: improve fscache revalidation
      ceph: use i_version to check validity of fscache

 fs/cachefiles/interface.c       |   2 +-
 fs/ceph/addr.c                  |   6 +-
 fs/ceph/cache.c                 | 141 +++++++++++++++++-----------------------
 fs/ceph/cache.h                 |  44 ++++++++-----
 fs/ceph/caps.c                  |  23 +++----
 fs/ceph/file.c                  |  27 ++------
 fs/ceph/super.h                 |   4 +-
 fs/fscache/page.c               |   2 +
 include/linux/ceph/osd_client.h |   5 ++
 include/linux/ceph/osdmap.h     |   5 --
 include/linux/fscache-cache.h   |   2 +-
 net/ceph/osd_client.c           |  51 +++++++--------
 net/ceph/osdmap.c               |   4 +-
 13 files changed, 138 insertions(+), 178 deletions(-)
