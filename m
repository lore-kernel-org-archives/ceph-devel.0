From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.13-rc4
Date: Fri,  4 Aug 2017 17:23:04 +0200
Message-ID: <1501860184-26226-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.13-rc4

for you to fetch changes up to ae78dd8139ce93a528beb7f3914531b7a7be9e30:

  libceph: make RECOVERY_DELETES feature create a new interval (2017-08-01 16:46:45 +0200)

----------------------------------------------------------------
A bunch of fixes and follow-ups for -rc1 Luminous patches: issues with
->reencode_message() and last minute RADOS semantic changes in v12.1.2.

----------------------------------------------------------------
Ilya Dryomov (6):
      libceph: make encode_request_*() work with r_mempool requests
      libceph: don't call ->reencode_message() more than once per message
      libceph: fallback for when there isn't a pool-specific choose_arg
      crush: assume weight_set != null imples weight_set_size > 0
      libceph: upmap semantic changes
      libceph: make RECOVERY_DELETES feature create a new interval

 include/linux/ceph/osd_client.h |  1 +
 include/linux/ceph/osdmap.h     |  2 ++
 include/linux/ceph/rados.h      |  4 +++
 include/linux/crush/crush.h     |  2 +-
 net/ceph/crush/mapper.c         |  2 +-
 net/ceph/messenger.c            |  6 ++---
 net/ceph/osd_client.c           | 14 +++++++---
 net/ceph/osdmap.c               | 60 ++++++++++++++++++++---------------------
 8 files changed, 53 insertions(+), 38 deletions(-)
