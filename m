From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.15-rc1
Date: Mon, 20 Nov 2017 18:41:28 +0100
Message-ID: <1511199688-31244-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit bebc6082da0a9f5d47a1ea2edc099bf671058bd4:

  Linux 4.14 (2017-11-12 10:46:13 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.15-rc1

for you to fetch changes up to 3cfa3b16dd2f1787f9d19d6da2fe9652d806b387:

  rbd: default to single-major device number scheme (2017-11-13 16:33:08 +0100)

----------------------------------------------------------------
We have a set of file locking improvements from Zheng, rbd rw/ro
state handling code cleanup from myself and some assorted CephFS fixes
from Jeff.

rbd now defaults to single-major=Y, lifting the limit of ~240 rbd
images per host for everyone.

----------------------------------------------------------------
Colin Ian King (1):
      ceph: remove unused and redundant variable dropping

David Disseldorp (1):
      rbd: set discard_alignment to zero

Eric Biggers (1):
      libceph: don't WARN() if user tries to add invalid key

Gustavo A. R. Silva (1):
      ceph: mark expected switch fall-throughs

Ilya Dryomov (4):
      ceph: -EINVAL on decoding failure in ceph_mdsc_handle_fsmap()
      rbd: fix and simplify rbd_ioctl_set_ro()
      rbd: get rid of rbd_mapping::read_only
      rbd: default to single-major device number scheme

Jeff Layton (4):
      ceph: clean up spinlocking and list handling around cleanup_cap_releases()
      ceph: present consistent fsid, regardless of arch endianness
      ceph: remove the bump of i_version
      ceph: silence sparse endianness warning in encode_caps_cb

Thomas Meyer (1):
      ceph: fix bool initialization/comparison

Yan, Zheng (5):
      ceph: keep auth cap when inode has flocks or posix locks
      ceph: make lock_to_ceph_filelock() static
      ceph: optimize flock encoding during reconnect
      ceph: handle 'session get evicted while there are file locks'
      ceph: disable cached readdir after dropping positive dentry

 drivers/block/rbd.c   |  65 ++++--------------
 fs/ceph/caps.c        |   9 ++-
 fs/ceph/inode.c       |   9 ++-
 fs/ceph/locks.c       | 177 +++++++++++++++++++++++++++++++++++---------------
 fs/ceph/mds_client.c  |  96 +++++++++++++++++----------
 fs/ceph/super.c       |   5 +-
 fs/ceph/super.h       |   4 +-
 net/ceph/ceph_hash.c  |  12 +++-
 net/ceph/crypto.c     |   4 +-
 net/ceph/messenger.c  |   1 +
 net/ceph/mon_client.c |   5 +-
 11 files changed, 237 insertions(+), 150 deletions(-)
