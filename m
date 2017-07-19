From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.13-rc2
Date: Wed, 19 Jul 2017 17:04:45 +0200
Message-ID: <1500476685-4843-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.13-rc2

for you to fetch changes up to 7c40b22f6f84c98a1d36e6d0a4346e58f05e45d8:

  libceph: potential NULL dereference in ceph_msg_data_create() (2017-07-17 14:54:59 +0200)

----------------------------------------------------------------
A number of small fixes for -rc1 Luminous changes plus a readdir race
fix, marked for stable.

----------------------------------------------------------------
Arnd Bergmann (1):
      libceph: fix old style declaration warnings

Dan Carpenter (2):
      libceph: NULL deref on osdmap_apply_incremental() error path
      libceph: potential NULL dereference in ceph_msg_data_create()

Ilya Dryomov (3):
      libceph: set -EINVAL in one place in crush_decode()
      libceph: use alloc_pg_mapping() in __decode_pg_upmap_items()
      libceph: don't call encode_request_finish() on MOSDBackoff messages

Yan, Zheng (1):
      ceph: fix race in concurrent readdir

 fs/ceph/dir.c                      |  5 +++++
 include/linux/ceph/ceph_features.h |  8 ++++----
 net/ceph/messenger.c               |  6 ++++--
 net/ceph/osd_client.c              |  5 ++++-
 net/ceph/osdmap.c                  | 31 ++++++++++++++++---------------
 5 files changed, 33 insertions(+), 22 deletions(-)
