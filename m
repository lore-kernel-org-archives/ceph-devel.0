From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.10-rc4
Date: Fri, 13 Jan 2017 18:37:55 +0100
Message-ID: <1484329075-18435-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.10-rc4

for you to fetch changes up to 84fcc2d2bd6cbf621e49e1d0f7eaef2e3c666b40:

  ceph: fix get_oldest_context() (2017-01-12 19:31:01 +0100)

----------------------------------------------------------------
Two small fixups for the filesystem changes that went into this merge
window.

----------------------------------------------------------------
Geng, Jichao (1):
      ceph: fix get_oldest_context()

Yan, Zheng (1):
      ceph: fix mds cluster availability check

 fs/ceph/addr.c       | 4 ++--
 fs/ceph/mds_client.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)
