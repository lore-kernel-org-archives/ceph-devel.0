From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.14-rc9
Date: Fri, 10 Nov 2017 15:11:41 +0100
Message-ID: <1510323101-4509-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 39dae59d66acd86d1de24294bd2f343fd5e7a625:

  Linux 4.14-rc8 (2017-11-05 13:05:14 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.14-rc9

for you to fetch changes up to 1e37f2f84680fa7f8394fd444b6928e334495ccc:

  rbd: use GFP_NOIO for parent stat and data requests (2017-11-09 09:32:53 +0100)

----------------------------------------------------------------
Memory allocation flags fix, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: use GFP_NOIO for parent stat and data requests

 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
