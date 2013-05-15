From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH v2 0/3] ceph: fix might_sleep while atomic
Date: Wed, 15 May 2013 10:38:11 -0600
Message-ID: <1368635894-114707-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>
List-Id: ceph-devel.vger.kernel.org

This patch series fixes an issue where encode_caps_cb() ends up
calling kmap() while holding a spinlock.

The original patch (http://www.spinics.net/lists/ceph-devel/msg14573.html)
was expanded to fix some other outstanding issues noticed by Alex Elder
in his review.

Changes from the original version:

 - clean up a comment
 - add missing calls to cpu_to_le32()
 - eliminate unnecessary loop around calls to ceph_pagelist_append()
 - only loop on calls to ceph_count_locks() and ceph_encode_locks_to_buffer()
     if the number of locks changes; exit on other errors
 - return proper error code from encode_caps_cb() if kmalloc fails

In his review, Alex mentioned that he hadn't checked that num_fcntl_locks
and num_flock_locks were properly decoded on the server side, from a le32
over-the-wire type to a cpu type.  I checked, and AFAICS it is done; those
interested can consult Locker::_do_cap_update() in src/mds/Locker.cc and
src/include/encoding.h in the Ceph server code (git://github.com/ceph/ceph).

I also checked the server side for flock_len decoding, and I believe that
also happens correctly, by virtue of having been declared __le32 in
struct ceph_mds_cap_reconnect, in src/include/ceph_fs.h.

Jim Schutt (3):
  ceph: fix up comment for ceph_count_locks() as to which lock to hold
  ceph: add missing cpu_to_le32() calls when encoding a reconnect capability
  ceph: ceph_pagelist_append might sleep while atomic

 fs/ceph/locks.c      |   75 ++++++++++++++++++++++++++++++++------------------
 fs/ceph/mds_client.c |   65 +++++++++++++++++++++++--------------------
 fs/ceph/super.h      |    9 ++++-
 3 files changed, 90 insertions(+), 59 deletions(-)

-- 
1.7.8.2
