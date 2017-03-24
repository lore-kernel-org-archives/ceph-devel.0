From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.11-rc4
Date: Fri, 24 Mar 2017 15:10:00 +0100
Message-ID: <1490364600-7154-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.11-rc4

for you to fetch changes up to 633ee407b9d15a75ac9740ba9d3338815e1fcb95:

  libceph: force GFP_NOIO for socket allocations (2017-03-23 12:03:36 +0100)

----------------------------------------------------------------
A fix for a writeback deadlock caused by a GFP_KERNEL allocation on the
reclaim path, tagged for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: force GFP_NOIO for socket allocations

 net/ceph/messenger.c | 6 ++++++
 1 file changed, 6 insertions(+)
