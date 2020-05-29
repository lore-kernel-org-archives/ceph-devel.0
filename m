From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.7-rc8
Date: Fri, 29 May 2020 17:52:57 +0200
Message-ID: <20200529155257.21043-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.7-rc8

for you to fetch changes up to fb33c114d3ed5bdac230716f5b0a93b56b92a90d:

  ceph: flush release queue when handling caps for unknown inode (2020-05-27 13:03:57 +0200)

----------------------------------------------------------------
Cache tiering and cap handling fixups, both marked for stable.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: flush release queue when handling caps for unknown inode

Jerry Lee (1):
      libceph: ignore pool overlay and cache logic on redirects

 fs/ceph/caps.c        | 2 +-
 net/ceph/osd_client.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
