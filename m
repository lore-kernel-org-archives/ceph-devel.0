From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.14-rc7
Date: Thu, 26 Oct 2017 10:22:00 +0200
Message-ID: <1509006120-26925-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:

  Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.14-rc7

for you to fetch changes up to 6c2838fbdedb9b72a81c931d49e56b229b6cdbca:

  ceph: unlock dangling spinlock in try_flush_caps() (2017-10-25 08:31:15 +0200)

----------------------------------------------------------------
A small lock imbalance fix, marked for stable.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: unlock dangling spinlock in try_flush_caps()

 fs/ceph/caps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
