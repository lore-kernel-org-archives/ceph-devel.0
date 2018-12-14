From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.20-rc7
Date: Fri, 14 Dec 2018 16:48:58 +0100
Message-ID: <20181214154858.1155-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc7

for you to fetch changes up to 6f9718fe41c3a47e4362bddf145e2db6ad7d8e87:

  ceph: make 'nocopyfrom' a default mount option (2018-12-11 18:22:17 +0100)

----------------------------------------------------------------
Luis discovered a problem with the new copyfrom offload on the server
side.  Disable it for now.

----------------------------------------------------------------
Luis Henriques (1):
      ceph: make 'nocopyfrom' a default mount option

 fs/ceph/super.c | 4 ++--
 fs/ceph/super.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)
