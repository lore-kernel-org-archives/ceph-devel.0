From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.15-rc4
Date: Fri, 15 Dec 2017 17:25:06 +0100
Message-ID: <1513355106-9906-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.15-rc4

for you to fetch changes up to 040d786032bf59002d374b86d75b04d97624005c:

  ceph: drop negative child dentries before try pruning inode's alias (2017-12-08 11:07:12 +0100)

----------------------------------------------------------------
CephFS inode trimming fix from Zheng, marked for stable.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: drop negative child dentries before try pruning inode's alias

 fs/ceph/mds_client.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)
