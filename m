From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 0/3] ceph: persistent caching with fscache
Date: Wed, 7 Aug 2013 19:15:07 -0400
Message-ID: <cover.1375645743.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:55919 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933734Ab3HGXPI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 19:15:08 -0400
Received: by mail-qc0-f182.google.com with SMTP id c11so1232732qcv.13
        for <ceph-devel@vger.kernel.org>; Wed, 07 Aug 2013 16:15:07 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, sage@inktank.com, zheng.z.yan@intel.com, dhowells@redhat.com, jiayisuse@gmail.com

This is a new and reworked patchset. I would greatly appreciate another review
of patch.

Since my last patchset I rethought how implement fscache in Ceph. Originally, I
started taking queues largely from the NFS and CIFS code. The code in those
filesystems as implemented is racy and I ended up wit the same kind of problems.
This was exasperated by how Ceph handles cache caps.

Previously I would create the fscache cookie every time we gained a cache cap
and remove it when we lost it.

The current approach is to create the cache cookie the first time we reference
the inode by a file. After that we don't get rid of the cookie till we dispose
of the inode. I like this approach a lot more then creating and destroying
fscache cookies every time we gain/loose a cache cap. And it avoids the need
for locking everywhere in the read, write, invalidate page code. It's not race
prone and simple. Finally, I don't have to worry about delaying a bunch of
work till later due to having the cap being in the inode spinlock.

The only piece of serialization now if taking out the i_mutex when creating the
cookie to prevent multiple open() race.

The cache is invalidated every time we open the file for write, size changes.
Every time we gain a cache cap we schedule a cookie re-validation to a work
queue (with the exception of the first one, as fscache already invokes
validation). The cache is ignored till the re-validation work runs and changes
the re-validation sequence number (sometimes invalidating it if needed).

In order to use this you need need kenel 3.11 rc3 or greater. 3.11 contains a 
big number of core fscache fixes. Otherwise you'll quickly run into oops on a 
high concurrent workload.

The first two patches I included were not written by me but were written by 
Hongyi Jia. He implemented the cookie re-validation scheme into fscache core.

Hongyi Jia (2):
  new cachefiles interface to check cache consistency
  new fscache interface to check cache consistency

Milosz Tanski (1):
  ceph: use fscache as a local presisent cache

 fs/cachefiles/interface.c     |  19 +++
 fs/cachefiles/internal.h      |   1 +
 fs/cachefiles/xattr.c         |  39 ++++++
 fs/ceph/Kconfig               |   9 ++
 fs/ceph/Makefile              |   2 +
 fs/ceph/addr.c                |  70 +++++++---
 fs/ceph/cache.c               | 306 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/cache.h               | 117 ++++++++++++++++
 fs/ceph/caps.c                |  19 ++-
 fs/ceph/file.c                |  17 +++
 fs/ceph/inode.c               |  69 +++++++++-
 fs/ceph/super.c               |  48 ++++++-
 fs/ceph/super.h               |  17 +++
 fs/fscache/cookie.c           |  22 +++
 include/linux/fscache-cache.h |   4 +
 include/linux/fscache.h       |  17 +++
 16 files changed, 748 insertions(+), 28 deletions(-)
 create mode 100644 fs/ceph/cache.c
 create mode 100644 fs/ceph/cache.h

-- 
1.8.1.2

