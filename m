From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.5-rc1
Date: Wed,  4 Dec 2019 21:03:07 +0100
Message-ID: <20191204200307.21047-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 219d54332a09e8d8741c1e1982f5eae56099de85:

  Linux 5.4 (2019-11-24 16:32:01 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.5-rc1

for you to fetch changes up to 82995cc6c5ae4bf4d72edef381a085e52d5b5905:

  libceph, rbd, ceph: convert to use the new mount API (2019-11-27 22:28:37 +0100)

----------------------------------------------------------------
The two highlights are a set of improvements to how rbd read-only
mappings are handled and a conversion to the new mount API (slightly
complicated by the fact that we had a common option parsing framework
that called out into rbd and the filesystem instead of them calling
into it).  Also included a few scattered fixes and a MAINTAINERS update
for rbd, adding Dongsheng as a reviewer.

----------------------------------------------------------------
Colin Ian King (1):
      rbd: fix spelling mistake "requeueing" -> "requeuing"

David Howells (1):
      libceph, rbd, ceph: convert to use the new mount API

Ilya Dryomov (11):
      libceph: drop unnecessary check from dispatch() in mon_client.c
      rbd: update MAINTAINERS info
      rbd: introduce rbd_is_snap()
      rbd: introduce RBD_DEV_FLAG_READONLY
      rbd: treat images mapped read-only seriously
      rbd: disallow read-write partitions on images mapped read-only
      rbd: don't acquire exclusive lock for read-only mappings
      rbd: don't establish watch for read-only mappings
      rbd: remove snapshot existence validation code
      rbd: don't query snapshot features
      rbd: ask for a weaker incompat mask for read-only mappings

Jeff Layton (3):
      ceph: make several helper accessors take const pointers
      ceph: tone down loglevel on ceph_mdsc_build_path warning
      ceph: don't leave ino field in ceph_mds_request_head uninitialized

Xiubo Li (1):
      ceph: fix geting random mds from mdsmap

 MAINTAINERS                  |   2 +-
 drivers/block/rbd.c          | 467 ++++++++++++++++---------------
 fs/ceph/cache.c              |   9 +-
 fs/ceph/cache.h              |   5 +-
 fs/ceph/mds_client.c         |  19 +-
 fs/ceph/mdsmap.c             |  11 +-
 fs/ceph/super.c              | 646 ++++++++++++++++++++++---------------------
 fs/ceph/super.h              |  13 +-
 include/linux/ceph/libceph.h |  10 +-
 net/ceph/ceph_common.c       | 419 +++++++++++++---------------
 net/ceph/messenger.c         |   2 -
 net/ceph/mon_client.c        |   3 -
 12 files changed, 803 insertions(+), 803 deletions(-)
