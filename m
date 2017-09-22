From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.14-rc2
Date: Fri, 22 Sep 2017 15:35:05 +0200
Message-ID: <1506087305-29607-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.14-rc2

for you to fetch changes up to 717e6f2893eb35ce6728c3cacdc297b78d371b31:

  ceph: avoid panic in create_session_open_msg() if utsname() returns NULL (2017-09-19 21:04:52 +0200)

----------------------------------------------------------------
Two small but important fixes: RADOS semantic change in upcoming v12.2.1
release and a rare NULL dereference in create_session_open_msg().

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: don't allow bidirectional swap of pg-upmap-items

Yan, Zheng (1):
      ceph: avoid panic in create_session_open_msg() if utsname() returns NULL

 fs/ceph/mds_client.c |  7 ++++---
 fs/ceph/mds_client.h |  3 +++
 net/ceph/osdmap.c    | 35 +++++++++++++++++++++++++----------
 3 files changed, 32 insertions(+), 13 deletions(-)
