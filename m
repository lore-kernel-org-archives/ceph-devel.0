From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.19-rc3
Date: Fri,  7 Sep 2018 19:06:43 +0200
Message-ID: <20180907170643.18214-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.19-rc3

for you to fetch changes up to e92c0eaf754310f9f31e9229a3f7274a67478f82:

  rbd: support cloning across namespaces (2018-09-06 16:18:04 +0200)

----------------------------------------------------------------
Two rbd patches to complete support for images within namespaces that
went into -rc1 and a use-after-free fix.

The rbd changes have been sitting in a branch for quite a while but
couldn't be included into the -rc1 pull request because of a pending
wire protocol backwards compatibility fixup that only got committed
early this week.

Said fixup ended up being really trivial -- just an extra byte added,
so I decided to send these changes for -rc3.  If it's too late in the
cycle for this follow-up to be pulled, let me know and I'll send the
use-after-free fix separately; we will have the necessary stop gaps on
the server side to prevent the current 4.19 code from doing anything
unexpected.

----------------------------------------------------------------
Ilya Dryomov (3):
      ceph: avoid a use-after-free in ceph_destroy_options()
      rbd: factor out get_parent_info()
      rbd: support cloning across namespaces

 drivers/block/rbd.c | 235 +++++++++++++++++++++++++++++++++++++++-------------
 fs/ceph/super.c     |  16 ++--
 2 files changed, 189 insertions(+), 62 deletions(-)
