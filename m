From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.11-rc9
Date: Thu, 27 Apr 2017 17:57:19 +0200
Message-ID: <1493308639-10537-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 5a7ad1146caa895ad718a534399e38bd2ba721b7:

  Linux 4.11-rc8 (2017-04-23 16:53:00 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.11-rc9

for you to fetch changes up to 8179a101eb5f4ef0ac9a915fcea9a9d3109efa90:

  ceph: fix recursion between ceph_set_acl() and __ceph_setattr() (2017-04-25 21:08:26 +0200)

----------------------------------------------------------------
A fix for a kernel stack overflow bug in ceph setattr code, marked for
stable.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: fix recursion between ceph_set_acl() and __ceph_setattr()

 fs/ceph/inode.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)
