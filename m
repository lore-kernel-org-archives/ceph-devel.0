From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [GIT PULL] Transition vfs to 64-bit timestamps
Date: Fri, 25 May 2018 16:35:31 -0700
Message-ID: <20180525233528.GA371@deepa-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org, andreas.dilger@intel.com, anton@tuxera.com, balbi@kernel.org, bfields@fieldses.org, ceph-devel@vger.kernel.org, darrick.wong@oracle.com, dhowells@redhat.com, dsterba@suse.com, dwmw2@infradead.org, hch@lst.de, hirofumi@mail.parknet.co.jp, hubcap@omnibond.com, jack@suse.com, jaegeuk@kernel.org, jaharkes@cs.cmu.edu, jslaby@suse.com, keescook@chromium.org, mark@fasheh.com, miklos@szeredi.hu, nico@linaro.org, reiserfs-devel@vger.kernel.org, richard@nod.at, sage@redhat.com, sfrench@samba.org, swhiteho@redhat.com, tj@kernel.org, trond.myklebust@primarydata.com, tytso@mit.edu, zyan@redhat.com
List-Id: ceph-devel.vger.kernel.org

Hi Thomas,

This is a pull request for the series that I sent earlier.
The series aims to switch vfs timestamps to use
struct timespec64. Currently vfs uses struct timespec,
which is not y2038 safe.

The flag patch applies cleanly. I've not seen the timestamps
update logic change often. The series applies cleanly on 4.17-rc6
and linux-next tip (top commit: next-20180517).

I'm not sure how to merge this kind of a series with a flag patch.
We are targeting 4.18 for this.
Let me know if you have other suggestions.

The series involves the following:
1. Add vfs helper functions for supporting struct timepec64 timestamps.
2. Cast prints of vfs timestamps to avoid warnings after the switch.
3. Simplify code using vfs timestamps so that the actual
   replacement becomes easy.
4. Convert vfs timestamps to use struct timespec64 using a script.
   This is a flag day patch.

I've tried to keep the conversions with the script simple, to
aid in the reviews. I've kept all the internal filesystem data
structures and function signatures the same.

Next steps:
1. Convert APIs that can handle timespec64, instead of converting
   timestamps at the boundaries.
2. Update internal data structures to avoid timestamp conversions.

-- 
Changes from v1:
* Fix the pointer bug in the udf patch.
* Include Kees's patch for pstore.
* Fix hostfs regression found by kbuild bot.

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the Git repository at:

  https://github.com/deepa-hub/vfs vfs_timespec64

for you to fetch changes up to 213ae530f442029284ab6041812df0571ebd9da7:

  vfs: change inode times to use struct timespec64 (2018-05-25 15:31:14 -0700)

----------------------------------------------------------------
Deepa Dinamani (6):
      fs: add timespec64_truncate()
      lustre: Use long long type to print inode time
      ceph: make inode time prints to be long long
      fs: nfs: get rid of memcpys for inode times
      udf: Simplify calls to udf_disk_stamp_to_time
      vfs: change inode times to use struct timespec64

Kees Cook (1):
      pstore: Convert internal records to timespec64

 drivers/firmware/efi/efi-pstore.c               | 27 ++++----
 drivers/staging/lustre/lustre/llite/llite_lib.c | 12 ++--
 drivers/staging/lustre/lustre/llite/namei.c     |  5 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c     |  7 +-
 drivers/staging/lustre/lustre/mdc/mdc_reint.c   |  6 +-
 drivers/staging/lustre/lustre/obdclass/obdo.c   |  6 +-
 drivers/tty/tty_io.c                            | 15 ++++-
 drivers/usb/gadget/function/f_fs.c              |  2 +-
 fs/adfs/inode.c                                 |  7 +-
 fs/afs/fsclient.c                               |  2 +-
 fs/attr.c                                       | 14 ++--
 fs/bad_inode.c                                  |  2 +-
 fs/btrfs/file.c                                 |  6 +-
 fs/btrfs/inode.c                                |  8 +--
 fs/btrfs/ioctl.c                                |  4 +-
 fs/btrfs/root-tree.c                            |  4 +-
 fs/btrfs/transaction.c                          |  2 +-
 fs/ceph/addr.c                                  | 12 ++--
 fs/ceph/cache.c                                 |  4 +-
 fs/ceph/caps.c                                  |  6 +-
 fs/ceph/file.c                                  |  6 +-
 fs/ceph/inode.c                                 | 86 +++++++++++++------------
 fs/ceph/mds_client.c                            |  7 +-
 fs/ceph/snap.c                                  |  6 +-
 fs/cifs/cache.c                                 |  4 +-
 fs/cifs/fscache.c                               |  8 +--
 fs/cifs/inode.c                                 | 26 ++++----
 fs/coda/coda_linux.c                            | 12 ++--
 fs/configfs/inode.c                             | 12 ++--
 fs/cramfs/inode.c                               |  2 +-
 fs/ext4/ext4.h                                  | 34 ++++++----
 fs/ext4/ialloc.c                                |  4 +-
 fs/ext4/namei.c                                 |  2 +-
 fs/f2fs/f2fs.h                                  | 10 ++-
 fs/f2fs/file.c                                  | 12 ++--
 fs/f2fs/inode.c                                 | 12 ++--
 fs/f2fs/namei.c                                 |  4 +-
 fs/fat/inode.c                                  | 20 ++++--
 fs/fat/namei_msdos.c                            | 21 +++---
 fs/fat/namei_vfat.c                             | 22 ++++---
 fs/fuse/inode.c                                 |  2 +-
 fs/gfs2/dir.c                                   |  6 +-
 fs/gfs2/glops.c                                 |  4 +-
 fs/hfs/inode.c                                  |  4 +-
 fs/hfsplus/inode.c                              | 12 ++--
 fs/hostfs/hostfs_kern.c                         | 12 ++--
 fs/inode.c                                      | 58 ++++++++++++-----
 fs/jffs2/dir.c                                  | 18 +++---
 fs/jffs2/file.c                                 |  2 +-
 fs/jffs2/fs.c                                   | 12 ++--
 fs/kernfs/dir.c                                 |  4 +-
 fs/kernfs/inode.c                               |  8 +--
 fs/locks.c                                      |  2 +-
 fs/nfs/callback_proc.c                          |  4 +-
 fs/nfs/fscache-index.c                          |  4 +-
 fs/nfs/fscache.c                                | 12 ++--
 fs/nfs/inode.c                                  | 39 ++++++-----
 fs/nfs/nfs2xdr.c                                | 25 ++++---
 fs/nfs/nfs3xdr.c                                |  8 ++-
 fs/nfs/nfs4xdr.c                                |  7 +-
 fs/nfsd/blocklayout.c                           |  8 ++-
 fs/nfsd/nfs3xdr.c                               | 14 ++--
 fs/nfsd/nfs4xdr.c                               |  7 +-
 fs/nfsd/nfsxdr.c                                |  2 +-
 fs/ntfs/inode.c                                 | 30 ++++-----
 fs/ocfs2/dlmglue.c                              | 20 ++++--
 fs/ocfs2/file.c                                 |  6 +-
 fs/orangefs/inode.c                             |  2 +-
 fs/orangefs/orangefs-kernel.h                   |  2 +-
 fs/overlayfs/inode.c                            |  2 +-
 fs/overlayfs/overlayfs.h                        |  2 +-
 fs/proc/uptime.c                                |  2 +-
 fs/pstore/platform.c                            |  2 +-
 fs/pstore/ram.c                                 | 21 ++++--
 fs/reiserfs/namei.c                             |  2 +-
 fs/reiserfs/xattr.c                             |  4 +-
 fs/ubifs/dir.c                                  |  4 +-
 fs/ubifs/file.c                                 | 23 +++----
 fs/ubifs/ubifs.h                                |  2 +-
 fs/udf/ialloc.c                                 |  4 +-
 fs/udf/inode.c                                  | 59 +++++++++--------
 fs/udf/super.c                                  | 17 +++--
 fs/udf/udfdecl.h                                |  4 +-
 fs/udf/udftime.c                                |  9 +--
 fs/xfs/xfs_inode.c                              |  2 +-
 fs/xfs/xfs_iops.c                               |  2 +-
 fs/xfs/xfs_trans_inode.c                        |  2 +-
 include/linux/fs.h                              | 24 +++----
 include/linux/pstore.h                          |  2 +-
 include/linux/stat.h                            |  8 +--
 90 files changed, 558 insertions(+), 434 deletions(-)
--
2.17.0
