From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.0-rc8
Date: Thu, 21 Feb 2019 18:16:07 +0100
Message-ID: <20190221171607.2756-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc8

for you to fetch changes up to 04242ff3ac0abbaa4362f97781dac268e6c3541a:

  ceph: avoid repeatedly adding inode to mdsc->snap_flush_list (2019-02-18 18:08:29 +0100)

----------------------------------------------------------------
Two bug fixes for old issues, both marked for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

 fs/ceph/snap.c       |  3 ++-
 net/ceph/messenger.c | 15 +++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)
