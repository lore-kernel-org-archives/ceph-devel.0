From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.5-rc2
Date: Thu, 12 Dec 2019 19:43:56 +0100
Message-ID: <20191212184356.7143-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.5-rc2

for you to fetch changes up to da08e1e1d7c3f805f8771ad6a6fd3a7a30ba4fe2:

  ceph: add more debug info when decoding mdsmap (2019-12-09 20:55:10 +0100)

----------------------------------------------------------------
A fix to avoid a corner case when scheduling cap reclaim in batches
from Xiubo, a patch to add some observability into cap waiters from
Jeff and a couple of cleanups.

----------------------------------------------------------------
Jeff Layton (2):
      ceph: convert int fields in ceph_mount_options to unsigned int
      ceph: show tasks waiting on caps in debugfs caps file

Xiubo Li (3):
      ceph: trigger the reclaim work once there has enough pending caps
      ceph: switch to global cap helper
      ceph: add more debug info when decoding mdsmap

 fs/ceph/caps.c       | 41 +++++++++++++++++++++++++++--------------
 fs/ceph/debugfs.c    | 13 +++++++++++++
 fs/ceph/mds_client.c |  8 +++++---
 fs/ceph/mds_client.h |  9 +++++++++
 fs/ceph/mdsmap.c     | 12 ++++++++----
 fs/ceph/super.c      | 28 +++++++++++++++-------------
 fs/ceph/super.h      | 16 ++++++++--------
 7 files changed, 85 insertions(+), 42 deletions(-)
