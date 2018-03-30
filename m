From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.16-rc8
Date: Fri, 30 Mar 2018 15:48:59 +0200
Message-ID: <1522417739-26858-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.16-rc8

for you to fetch changes up to 85784f9395987a422fa04263e7c0fb13da11eb5c:

  ceph: only dirty ITER_IOVEC pages for direct read (2018-03-30 11:17:48 +0200)

----------------------------------------------------------------
A fix for a dio-enabled loop on ceph deadlock from Zheng, marked for
stable.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: only dirty ITER_IOVEC pages for direct read

 fs/ceph/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
