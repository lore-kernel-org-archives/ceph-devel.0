From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.10-rc5
Date: Fri, 20 Jan 2017 15:26:49 +0100
Message-ID: <1484922409-31183-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.10-rc5

for you to fetch changes up to 6df8c9d80a27cb587f61b4f06b57e248d8bc3f86:

  ceph: fix bad endianness handling in parse_reply_info_extra (2017-01-18 17:58:45 +0100)

----------------------------------------------------------------
Three filesystem endianness fixes (one goes back to the 2.6 era, all
marked for stable) and two fixups for this merge window's patches.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: make sure ceph_aes_crypt() IV is aligned

Jeff Layton (3):
      ceph: fix endianness of getattr mask in ceph_d_revalidate
      ceph: fix endianness bug in frag_tree_split_cmp
      ceph: fix bad endianness handling in parse_reply_info_extra

Yan, Zheng (1):
      ceph: fix ceph_get_caps() interruption

 fs/ceph/caps.c       | 7 ++++++-
 fs/ceph/dir.c        | 5 +++--
 fs/ceph/inode.c      | 3 ++-
 fs/ceph/mds_client.c | 9 +++++----
 net/ceph/crypto.c    | 2 +-
 5 files changed, 17 insertions(+), 9 deletions(-)
