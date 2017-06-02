From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.12-rc4
Date: Fri,  2 Jun 2017 17:41:54 +0200
Message-ID: <1496418114-26005-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.12-rc4

for you to fetch changes up to 6ac56951dc10232e24419f6972fc8131dd0166e0:

  rbd: implement REQ_OP_WRITE_ZEROES (2017-05-29 11:18:01 +0200)

----------------------------------------------------------------
A small fix for rbd FALLOC_FL_ZERO_RANGE/PUNCH_HOLE handling breakage
introduced in -rc1.

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: implement REQ_OP_WRITE_ZEROES

 drivers/block/rbd.c | 2 ++
 1 file changed, 2 insertions(+)
