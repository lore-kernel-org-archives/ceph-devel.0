From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.7-rc5
Date: Fri,  8 May 2020 19:16:13 +0200
Message-ID: <20200508171613.27097-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.7-rc5

for you to fetch changes up to 12ae44a40a1be891bdc6463f8c7072b4ede746ef:

  ceph: demote quotarealm lookup warning to a debug message (2020-05-08 18:44:40 +0200)

----------------------------------------------------------------
Fixes for an endianness handling bug that prevented mounts on
big-endian arches, a spammy log message and a couple error paths.
Also included a MAINTAINERS update.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: fix endianness bug when handling MDS session feature bits

Luis Henriques (1):
      ceph: demote quotarealm lookup warning to a debug message

Sage Weil (1):
      MAINTAINERS: remove myself as ceph co-maintainer

Wu Bo (2):
      ceph: fix special error code in ceph_try_get_caps()
      ceph: fix double unlock in handle_cap_export()

 MAINTAINERS          | 6 ------
 fs/ceph/caps.c       | 3 ++-
 fs/ceph/mds_client.c | 8 +++-----
 fs/ceph/quota.c      | 4 ++--
 4 files changed, 7 insertions(+), 14 deletions(-)
