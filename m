From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 0/7] Delete timespec64_trunc()
Date: Fri, 29 Nov 2019 21:30:23 -0800
Message-ID: <20191130053030.7868-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, arnd@arndb.de, hirofumi@mail.parknet.co.jp, jlayton@kernel.org, richard@nod.at, stfrench@microsoft.com, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, linux-mtd@lists.infradead.org
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

Deepa Dinamani (7):
  fs: fat: Eliminate timespec64_trunc() usage
  fs: cifs: Fix atime update check vs mtime
  fs: cifs: Delete usage of timespec64_trunc
  fs: ceph: Delete timespec64_trunc() usage
  fs: ubifs: Eliminate timespec64_trunc() usage
  fs: Delete timespec64_trunc()
  fs: Do not overload update_time

 fs/ceph/mds_client.c |  3 +--
 fs/cifs/inode.c      | 15 ++++++++-------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 30 +++---------------------------
 fs/ubifs/sb.c        | 11 ++++-------
 include/linux/fs.h   |  1 -
 6 files changed, 25 insertions(+), 45 deletions(-)

-- 
2.17.1

Cc: hirofumi@mail.parknet.co.jp
Cc: jlayton@kernel.org
Cc: richard@nod.at
Cc: stfrench@microsoft.com
Cc: ceph-devel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
