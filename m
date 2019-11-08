From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.4-rc7
Date: Fri,  8 Nov 2019 16:58:53 +0100
Message-ID: <20191108155853.23314-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc7

for you to fetch changes up to ff29fde84d1fc82f233c7da0daa3574a3942bec7:

  ceph: return -EINVAL if given fsc mount option on kernel w/o support (2019-11-07 18:03:23 +0100)

----------------------------------------------------------------
Some late-breaking dentry handling fixes from Al and Jeff, a patch to
further restrict copy_file_range() to avoid potential data corruption
from Luis and a fix for !CONFIG_CEPH_FSCACHE kernels.  Everything but
the fscache fix is marked for stable.

----------------------------------------------------------------
Al Viro (2):
      ceph: fix RCU case handling in ceph_d_revalidate()
      ceph: add missing check in d_revalidate snapdir handling

Jeff Layton (2):
      ceph: don't try to handle hashed dentries in non-O_CREAT atomic_open
      ceph: return -EINVAL if given fsc mount option on kernel w/o support

Luis Henriques (2):
      ceph: fix use-after-free in __ceph_remove_cap()
      ceph: don't allow copy_file_range when stripe_count != 1

 fs/ceph/caps.c  | 10 +++++-----
 fs/ceph/dir.c   | 15 ++++++++-------
 fs/ceph/file.c  | 15 +++++++++++++--
 fs/ceph/inode.c |  1 +
 fs/ceph/super.c | 11 ++++++++++-
 5 files changed, 37 insertions(+), 15 deletions(-)
