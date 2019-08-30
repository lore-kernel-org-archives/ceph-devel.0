From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.3-rc7
Date: Fri, 30 Aug 2019 16:11:15 +0200
Message-ID: <20190830141115.8049-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.3-rc7

for you to fetch changes up to d435c9a7b85be1e820668d2f3718c2d9f24d5548:

  rbd: restore zeroing past the overlap when reading from parent (2019-08-28 12:34:11 +0200)

----------------------------------------------------------------
A fix for a -rc1 regression in rbd and a trivial static checker fix.

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: restore zeroing past the overlap when reading from parent

Jia-Ju Bai (1):
      libceph: don't call crypto_free_sync_skcipher() on a NULL tfm

 drivers/block/rbd.c | 11 +++++++++++
 net/ceph/crypto.c   |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)
