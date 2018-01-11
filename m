From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.15-rc8
Date: Thu, 11 Jan 2018 18:10:27 +0100
Message-ID: <1515690627-4084-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:

  Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.15-rc8

for you to fetch changes up to 21acdf45f4958135940f0b4767185cf911d4b010:

  rbd: set max_segments to USHRT_MAX (2018-01-09 17:40:48 +0100)

----------------------------------------------------------------
Two rbd fixes for 4.12 and 4.2 issues respectively, marked for stable.

----------------------------------------------------------------
Florian Margaine (1):
      rbd: reacquire lock should update lock owner client id

Ilya Dryomov (1):
      rbd: set max_segments to USHRT_MAX

 drivers/block/rbd.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
