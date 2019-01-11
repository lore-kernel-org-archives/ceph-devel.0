From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.0-rc2
Date: Fri, 11 Jan 2019 18:02:26 +0100
Message-ID: <20190111170226.19872-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc2

for you to fetch changes up to 85f5a4d666fd9be73856ed16bb36c5af5b406b29:

  rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set (2019-01-10 09:45:09 +0100)

----------------------------------------------------------------
A patch to allow setting abort_on_full and a fix for an old "rbd unmap"
edge case, marked for stable.

----------------------------------------------------------------
Dongsheng Yang (1):
      libceph: allow setting abort_on_full for rbd

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Souptick Joarder (1):
      ceph: use vmf_error() in ceph_filemap_fault()

 drivers/block/rbd.c             |  9 ++++-----
 fs/ceph/addr.c                  |  5 +----
 fs/ceph/super.c                 |  4 ++--
 include/linux/ceph/libceph.h    |  6 ++++--
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/ceph_common.c          | 11 ++++++++++-
 net/ceph/debugfs.c              |  2 +-
 net/ceph/osd_client.c           |  4 ++--
 8 files changed, 24 insertions(+), 18 deletions(-)
