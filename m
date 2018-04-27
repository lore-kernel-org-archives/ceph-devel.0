From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.17-rc3
Date: Fri, 27 Apr 2018 16:51:32 +0200
Message-ID: <1524840692-30949-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.17-rc3

for you to fetch changes up to 9c55ad1c214d9f8c4594ac2c3fa392c1c32431a7:

  libceph: validate con->state at the top of try_write() (2018-04-26 17:39:08 +0200)

----------------------------------------------------------------
A CephFS quota follow-up and fixes for two older issues in the
messenger layer, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (3):
      libceph: un-backoff on tick when we have a authenticated session
      libceph: reschedule a tick in finish_hunting()
      libceph: validate con->state at the top of try_write()

Yan, Zheng (1):
      ceph: check if mds create snaprealm when setting quota

 fs/ceph/xattr.c       | 28 +++++++++++++++++++++++++---
 net/ceph/messenger.c  |  7 +++++++
 net/ceph/mon_client.c | 14 +++++++++++---
 3 files changed, 43 insertions(+), 6 deletions(-)
