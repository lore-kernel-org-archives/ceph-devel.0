From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.4-rc4
Date: Fri, 18 Oct 2019 20:15:11 +0200
Message-ID: <20191018181511.8844-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc4

for you to fetch changes up to 25e6be21230d3208d687dad90b6e43419013c351:

  rbd: cancel lock_dwork if the wait is interrupted (2019-10-15 17:43:15 +0200)

----------------------------------------------------------------
A future-proofing decoding fix from Jeff intended for stable and
a patch for a mostly benign race from Dongsheng.

----------------------------------------------------------------
Dongsheng Yang (1):
      rbd: cancel lock_dwork if the wait is interrupted

Jeff Layton (1):
      ceph: just skip unrecognized info in ceph_reply_info_extra

 drivers/block/rbd.c  |  9 ++++++---
 fs/ceph/mds_client.c | 21 +++++++++++----------
 2 files changed, 17 insertions(+), 13 deletions(-)
