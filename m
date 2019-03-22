From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.1-rc2
Date: Fri, 22 Mar 2019 17:19:47 +0100
Message-ID: <20190322161947.15053-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc2

for you to fetch changes up to 9d4a227f6ef189cf37eb22641f6ee788b7dc41bb:

  rbd: drop wait_for_latest_osdmap() (2019-03-20 16:27:40 +0100)

----------------------------------------------------------------
A follow up for the new alloc_size logic and a blacklisting fix, marked
for stable.

----------------------------------------------------------------
Ilya Dryomov (3):
      rbd: set io_min, io_opt and discard_granularity to alloc_size
      libceph: wait for latest osdmap in ceph_monc_blacklist_add()
      rbd: drop wait_for_latest_osdmap()

 drivers/block/rbd.c          | 28 ++++++----------------------
 include/linux/ceph/libceph.h |  2 ++
 net/ceph/ceph_common.c       | 18 +++++++++++++++++-
 net/ceph/mon_client.c        |  9 +++++++++
 4 files changed, 34 insertions(+), 23 deletions(-)
