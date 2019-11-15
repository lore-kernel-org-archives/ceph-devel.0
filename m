From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.4-rc8
Date: Fri, 15 Nov 2019 18:03:09 +0100
Message-ID: <20191115170309.28988-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc8

for you to fetch changes up to 633739b2fedb6617d782ca252797b7a8ad754347:

  rbd: silence bogus uninitialized warning in rbd_object_map_update_finish() (2019-11-14 19:00:53 +0100)

----------------------------------------------------------------
Two fixes for the buffered reads and O_DIRECT writes serialization
patch that went into -rc1 and a fixup for a bogus warning on older
gcc versions.

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: silence bogus uninitialized warning in rbd_object_map_update_finish()

Jeff Layton (2):
      ceph: take the inode lock before acquiring cap refs
      ceph: increment/decrement dio counter on async requests

 drivers/block/rbd.c |  2 +-
 fs/ceph/file.c      | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 8 deletions(-)
