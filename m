From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.9-rc5
Date: Fri, 11 Nov 2016 16:43:40 +0100
Message-ID: <1478879020-20000-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.9-rc5

for you to fetch changes up to 264048afab27d7c27eedf5394714e0b396d787f7:

  libceph: initialize last_linger_id with a large integer (2016-11-10 20:13:08 +0100)

----------------------------------------------------------------
Ceph's ->read_iter() implementation is incompatible with the new
generic_file_splice_read() code that went into -rc1.  Switch to the
less efficient default_file_splice_read() for now; the proper fix is
being held for 4.10.

We also have a fix for a 4.8 regression and a trival libceph fixup.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: initialize last_linger_id with a large integer

Yan, Zheng (2):
      ceph: use default file splice read callback
      libceph: fix legacy layout decode with pool 0

 fs/ceph/file.c                  | 1 -
 include/linux/ceph/osd_client.h | 2 ++
 net/ceph/ceph_fs.c              | 3 ++-
 net/ceph/osd_client.c           | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)
