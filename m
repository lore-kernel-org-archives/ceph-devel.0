From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.0-rc4
Date: Thu, 24 Jan 2019 16:49:58 +0100
Message-ID: <20190124154958.8067-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc4

for you to fetch changes up to 74827ee29565f86e2a64495a5e3e58d3371d74ee:

  ceph: quota: cleanup license mess (2019-01-21 14:53:23 +0100)

----------------------------------------------------------------
A fix for a potential use-after-free, a patch to close a (mostly benign)
race in the messenger and a licence clarification for quota.c.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Thomas Gleixner (1):
      ceph: quota: cleanup license mess

Yan, Zheng (1):
      ceph: clear inode pointer when snap realm gets dropped by its inode

 fs/ceph/caps.c       |  2 ++
 fs/ceph/quota.c      | 13 -------------
 net/ceph/messenger.c |  5 +++--
 3 files changed, 5 insertions(+), 15 deletions(-)
