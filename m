From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.18-rc3
Date: Fri, 29 Jun 2018 16:49:57 +0200
Message-ID: <20180629144957.32584-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.18-rc3

for you to fetch changes up to 8b8f53af1ed9df88a4c0fbfdf3db58f62060edf3:

  ceph: fix dentry leak in splice_dentry() (2018-06-26 18:42:44 +0200)

----------------------------------------------------------------
A trivial dentry leak fix from Zheng.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: fix dentry leak in splice_dentry()

 fs/ceph/inode.c | 1 +
 1 file changed, 1 insertion(+)
