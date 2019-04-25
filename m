From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Thu, 25 Apr 2019 19:47:39 +0200
Message-ID: <20190425174739.27604-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc7

for you to fetch changes up to 37659182bff1eeaaeadcfc8f853c6d2b6dbc3f47:

  ceph: fix ci->i_head_snapc leak (2019-04-23 21:37:54 +0200)

----------------------------------------------------------------
dentry name handling fixes from Jeff and a memory leak fix from Zheng.
Both are old issues, marked for stable.

----------------------------------------------------------------
Jeff Layton (3):
      ceph: only use d_name directly when parent is locked
      ceph: ensure d_name stability in ceph_dentry_hash()
      ceph: handle the case where a dentry has been renamed on outstanding req

Yan, Zheng (1):
      ceph: fix ci->i_head_snapc leak

 fs/ceph/dir.c        |  6 ++++-
 fs/ceph/inode.c      | 16 +++++++++++-
 fs/ceph/mds_client.c | 70 +++++++++++++++++++++++++++++++++++++++++++---------
 fs/ceph/snap.c       |  7 +++++-
 4 files changed, 85 insertions(+), 14 deletions(-)
