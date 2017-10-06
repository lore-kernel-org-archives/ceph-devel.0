From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.14-rc4
Date: Fri,  6 Oct 2017 16:31:06 +0200
Message-ID: <1507300266-2143-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.14-rc4

for you to fetch changes up to 38f340ccdf9ed5f1350505b46c5689d015967057:

  ceph: fix __choose_mds() for LSSNAP request (2017-10-02 16:18:16 +0200)

----------------------------------------------------------------
Two fixups for CephFS snapshot-handling patches in -rc1.

----------------------------------------------------------------
Yan, Zheng (2):
      ceph: properly queue cap snap for newly created snap realm
      ceph: fix __choose_mds() for LSSNAP request

 fs/ceph/mds_client.c | 11 ++++++-----
 fs/ceph/snap.c       |  8 +++-----
 2 files changed, 9 insertions(+), 10 deletions(-)
