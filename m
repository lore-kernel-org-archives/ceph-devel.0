From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v2 0/6] Delete timespec64_trunc()
Date: Mon,  2 Dec 2019 21:19:39 -0800
Message-ID: <20191203051945.9440-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, arnd@arndb.de, ceph-devel@vger.kernel.org, hirofumi@mail.parknet.co.jp, jlayton@kernel.org, linux-cifs@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, stfrench@microsoft.com
List-Id: ceph-devel.vger.kernel.org

This series aims at deleting timespec64_trunc().
There is a new api: timestamp_truncate() that is the
replacement api. The api additionally does a limits
check on the filesystem timestamps.

The suggestion to open code some of the truncate logic
came from Al Viro. And, this does make the code in some
filesystems easy to follow.

The series also does some update_time() cleanup as
suggested by Al Viro.

Deepa Dinamani (6):
  fs: fat: Eliminate timespec64_trunc() usage
  fs: cifs: Delete usage of timespec64_trunc
  fs: ceph: Delete timespec64_trunc() usage
  fs: ubifs: Eliminate timespec64_trunc() usage
  fs: Delete timespec64_trunc()
  fs: Do not overload update_time

 fs/ceph/mds_client.c |  4 +---
 fs/cifs/inode.c      | 13 +++++++------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 33 +++------------------------------
 fs/ubifs/sb.c        | 11 ++++-------
 include/linux/fs.h   |  1 -
 6 files changed, 24 insertions(+), 48 deletions(-)

-- 
Changes since v1:
* Dropped the atime comparison (patch 2/7) taken through cifs tree.
* Refactored update_time according to review comments.
2.17.1

Cc: ceph-devel@vger.kernel.org
Cc: hirofumi@mail.parknet.co.jp
Cc: jlayton@kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: richard@nod.at
Cc: stfrench@microsoft.com
