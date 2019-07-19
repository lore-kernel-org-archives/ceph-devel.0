From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/4] Sleeping functions in invalid context bug fixes
Date: Fri, 19 Jul 2019 15:32:18 +0100
Message-ID: <20190719143222.16058-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Hi,

I'm sending three "sleeping function called from invalid context" bug
fixes that I had on my TODO for a while.  All of them are ceph_buffer_put
related, and all the fixes follow the same pattern: delay the operation
until the ci->i_ceph_lock is released.

The first patch simply allows ceph_buffer_put to receive a NULL buffer so
that the NULL check doesn't need to be performed in all the other patches.
IOW, it's not really required, just convenient.

(Note: maybe these patches should all be tagged for stable.)

Luis Henriques (4):
  libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
  ceph: fix buffer free while holding i_ceph_lock in __ceph_setxattr()
  ceph: fix buffer free while holding i_ceph_lock in
    __ceph_build_xattrs_blob()
  ceph: fix buffer free while holding i_ceph_lock in fill_inode()

 fs/ceph/caps.c              |  5 ++++-
 fs/ceph/inode.c             |  7 ++++---
 fs/ceph/snap.c              |  4 +++-
 fs/ceph/super.h             |  2 +-
 fs/ceph/xattr.c             | 19 ++++++++++++++-----
 include/linux/ceph/buffer.h |  3 ++-
 6 files changed, 28 insertions(+), 12 deletions(-)
