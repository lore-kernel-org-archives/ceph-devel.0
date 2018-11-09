From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.20-rc2
Date: Fri,  9 Nov 2018 17:47:55 +0100
Message-ID: <20181109164755.13100-1-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc2

for you to fetch changes up to 23c625ce3065e40c933a4239efb9b11f1194a343:

  libceph: assume argonaut on the server side (2018-11-08 17:51:11 +0100)

----------------------------------------------------------------
Two CephFS fixes (copy_file_range and quota) and a small feature bit
cleanup.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: assume argonaut on the server side

Luis Henriques (2):
      ceph: add destination file data sync before doing any remote copy
      ceph: quota: fix null pointer dereference in quota check

 fs/ceph/file.c                     | 11 +++++++++--
 fs/ceph/mds_client.c               | 12 +++---------
 fs/ceph/quota.c                    |  3 ++-
 include/linux/ceph/ceph_features.h |  8 +-------
 4 files changed, 15 insertions(+), 19 deletions(-)
