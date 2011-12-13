From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Tue, 13 Dec 2011 12:36:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112131156460.25422@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38089 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab1LMUgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 15:36:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are two biggish things here, unfortunately.  One is a locking fix 
that replaces i_lock use with a ceph-private inode spinlock.  This is 
necessary to work around lock ordering issues which unfortunately we 
didn't notice until now (it's from the lock scalability stuff a couple of 
kernels back).  The diffstat is large, but it's a mechanical replacement 
and has been pretty well tested.  The other big one is removing rbd 
rollback functionality from the kernel entirely (we found a minor bug but 
it is better done from userspace anyway).

There are also a handful of other small bug fixes (missing spin_unlock, 
typo), some error reporting/handling on a corrupt image, a fix for the 
CRUSH mapping calculation, and a fix for a the seek() regression in 3.1.

There will probably be one more lock ordering patch coming shortly, but I 
want to do some more testing first.

Thanks!
sage


Josh Durgin (2):
      rbd: return an error when an invalid header is read
      rbd: remove buggy rollback functionality

Sage Weil (4):
      ceph: fix rasize reporting by ceph_show_options
      ceph: use i_ceph_lock instead of i_lock
      crush: fix mapping calculation when force argument doesn't exist
      ceph: fix SEEK_CUR, SEEK_SET regression

Yehuda Sadeh (1):
      ceph: add missing spin_unlock at ceph_mdsc_build_path()

 Documentation/ABI/testing/sysfs-bus-rbd |    7 -
 drivers/block/rbd.c                     |  101 ++---------------
 fs/ceph/addr.c                          |    8 +-
 fs/ceph/caps.c                          |  187 ++++++++++++++++---------------
 fs/ceph/dir.c                           |   24 ++--
 fs/ceph/file.c                          |   23 ++--
 fs/ceph/inode.c                         |   53 +++++----
 fs/ceph/ioctl.c                         |    4 +-
 fs/ceph/mds_client.c                    |   33 +++---
 fs/ceph/mds_client.h                    |    2 +-
 fs/ceph/snap.c                          |   16 ++--
 fs/ceph/super.c                         |    2 +-
 fs/ceph/super.h                         |   31 +++---
 fs/ceph/xattr.c                         |   42 ++++----
 net/ceph/crush/mapper.c                 |   35 ++----
 15 files changed, 239 insertions(+), 329 deletions(-)
