From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.20-rc4
Date: Fri, 23 Nov 2018 19:49:19 +0100
Message-ID: <20181123184919.10675-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc4

for you to fetch changes up to 7e241f647dc7087a0401418a187f3f5b527cc690:

  libceph: fall back to sendmsg for slab pages (2018-11-19 17:59:47 +0100)

----------------------------------------------------------------
A messenger fix, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: fall back to sendmsg for slab pages

 net/ceph/messenger.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
