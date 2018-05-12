From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 0/6] Transition vfs to 64-bit timestamps
Date: Fri, 11 May 2018 21:59:15 -0700
Message-ID: <20180512045921.18311-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, andreas.dilger@intel.com, anton@tuxera.com, balbi@kernel.org, bfields@fieldses.org, ceph-devel@vger.kernel.org, darrick.wong@oracle.com, dhowells@redhat.com, dsterba@suse.com, dwmw2@infradead.org, hch@lst.de, hirofumi@mail.parknet.co.jp, hubcap@omnibond.com, jack@suse.com, jaegeuk@kernel.org, jaharkes@cs.cmu.edu, jslaby@suse.com, keescook@chromium.org, mark@fasheh.com, miklos@szeredi.hu, nico@linaro.org, reiserfs-devel@vger.kernel.org, richard@nod.at, sage@redhat.com, sfrench@samba.org, swhiteho@redhat.com, tj@kernel.org, trond.myklebust@primarydata.com, tytso@mit.edu, zyan@redhat.com
List-Id: ceph-devel.vger.kernel.org

The series aims to switch vfs timestamps to use
struct timespec64. Currently vfs uses struct timespec,
which is not y2038 safe.

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

Deepa Dinamani (6):
  fs: add timespec64_truncate()
  lustre: Use long long type to print inode time
  ceph: make inode time prints to be long long
  fs: nfs: get rid of memcpys for inode times
  udf: Simplify calls to udf_disk_stamp_to_time
  vfs: change inode times to use struct timespec64

 .../staging/lustre/lustre/llite/llite_lib.c   | 12 +--
 drivers/staging/lustre/lustre/lmv/lmv_obd.c   |  7 +-
 drivers/staging/lustre/lustre/mdc/mdc_reint.c |  6 +-
 drivers/staging/lustre/lustre/obdclass/obdo.c |  6 +-
 drivers/tty/tty_io.c                          | 15 +++-
 drivers/usb/gadget/function/f_fs.c            |  2 +-
 fs/adfs/inode.c                               |  7 +-
 fs/afs/fsclient.c                             |  2 +-
 fs/attr.c                                     | 14 +--
 fs/bad_inode.c                                |  2 +-
 fs/btrfs/file.c                               |  6 +-
 fs/btrfs/inode.c                              |  8 +-
 fs/btrfs/ioctl.c                              |  4 +-
 fs/btrfs/root-tree.c                          |  4 +-
 fs/btrfs/transaction.c                        |  2 +-
 fs/ceph/addr.c                                | 12 +--
 fs/ceph/cache.c                               |  4 +-
 fs/ceph/caps.c                                |  6 +-
 fs/ceph/file.c                                |  6 +-
 fs/ceph/inode.c                               | 86 ++++++++++---------
 fs/ceph/mds_client.c                          |  7 +-
 fs/ceph/snap.c                                |  6 +-
 fs/cifs/cache.c                               |  4 +-
 fs/cifs/fscache.c                             |  8 +-
 fs/cifs/inode.c                               | 26 +++---
 fs/coda/coda_linux.c                          | 12 +--
 fs/configfs/inode.c                           | 12 +--
 fs/cramfs/inode.c                             |  2 +-
 fs/ext4/ext4.h                                | 34 +++++---
 fs/ext4/ialloc.c                              |  4 +-
 fs/ext4/namei.c                               |  2 +-
 fs/f2fs/f2fs.h                                | 10 ++-
 fs/f2fs/file.c                                | 12 +--
 fs/f2fs/inode.c                               | 12 +--
 fs/f2fs/namei.c                               |  4 +-
 fs/fat/inode.c                                | 20 +++--
 fs/fat/namei_msdos.c                          | 21 +++--
 fs/fat/namei_vfat.c                           | 22 +++--
 fs/fuse/inode.c                               |  2 +-
 fs/gfs2/dir.c                                 |  6 +-
 fs/gfs2/glops.c                               |  4 +-
 fs/hfs/inode.c                                |  4 +-
 fs/hfsplus/inode.c                            | 12 +--
 fs/hostfs/hostfs_kern.c                       |  6 +-
 fs/inode.c                                    | 58 +++++++++----
 fs/jffs2/dir.c                                | 18 ++--
 fs/jffs2/file.c                               |  2 +-
 fs/jffs2/fs.c                                 | 12 +--
 fs/kernfs/dir.c                               |  4 +-
 fs/kernfs/inode.c                             |  8 +-
 fs/locks.c                                    |  2 +-
 fs/nfs/callback_proc.c                        |  4 +-
 fs/nfs/fscache-index.c                        |  4 +-
 fs/nfs/fscache.c                              | 12 +--
 fs/nfs/inode.c                                | 39 +++++----
 fs/nfs/nfs2xdr.c                              | 25 +++---
 fs/nfs/nfs3xdr.c                              |  8 +-
 fs/nfs/nfs4xdr.c                              |  7 +-
 fs/nfsd/blocklayout.c                         |  8 +-
 fs/nfsd/nfs3xdr.c                             | 14 +--
 fs/nfsd/nfs4xdr.c                             |  7 +-
 fs/nfsd/nfsxdr.c                              |  2 +-
 fs/ntfs/inode.c                               | 30 +++----
 fs/ocfs2/dlmglue.c                            | 20 +++--
 fs/ocfs2/file.c                               |  6 +-
 fs/orangefs/inode.c                           |  2 +-
 fs/orangefs/orangefs-kernel.h                 |  2 +-
 fs/overlayfs/inode.c                          |  2 +-
 fs/overlayfs/overlayfs.h                      |  2 +-
 fs/proc/uptime.c                              |  2 +-
 fs/pstore/inode.c                             |  2 +-
 fs/reiserfs/namei.c                           |  2 +-
 fs/reiserfs/xattr.c                           |  4 +-
 fs/ubifs/dir.c                                |  4 +-
 fs/ubifs/file.c                               | 23 ++---
 fs/ubifs/ubifs.h                              |  2 +-
 fs/udf/ialloc.c                               |  4 +-
 fs/udf/inode.c                                | 59 +++++++------
 fs/udf/super.c                                | 16 ++--
 fs/udf/udfdecl.h                              |  4 +-
 fs/udf/udftime.c                              |  9 +-
 fs/xfs/xfs_inode.c                            |  2 +-
 fs/xfs/xfs_iops.c                             |  2 +-
 fs/xfs/xfs_trans_inode.c                      |  2 +-
 include/linux/fs.h                            | 24 +++---
 include/linux/stat.h                          |  8 +-
 86 files changed, 522 insertions(+), 408 deletions(-)


base-commit: 1c25af77721fa388cb01b2afc7fbe4f1f98685fd
-- 
2.17.0

CC: andreas.dilger@intel.com
Cc: <anton@tuxera.com>
Cc: <balbi@kernel.org>
Cc: <bfields@fieldses.org>
Cc: ceph-devel@vger.kernel.org
Cc: <darrick.wong@oracle.com>
Cc: <dhowells@redhat.com>
Cc: <dsterba@suse.com>
Cc: <dwmw2@infradead.org>
Cc: <hch@lst.de>
Cc: <hirofumi@mail.parknet.co.jp>
Cc: <hubcap@omnibond.com>
Cc: <jack@suse.com>
Cc: jack@suse.com
Cc: <jaegeuk@kernel.org>
Cc: <jaharkes@cs.cmu.edu>
Cc: <jslaby@suse.com>
Cc: <keescook@chromium.org>
Cc: <mark@fasheh.com>
Cc: <miklos@szeredi.hu>
Cc: <nico@linaro.org>
Cc: <reiserfs-devel@vger.kernel.org>
Cc: <richard@nod.at>
Cc: <sage@redhat.com>
Cc: <sfrench@samba.org>
Cc: <swhiteho@redhat.com>
Cc: <tj@kernel.org>
Cc: <trond.myklebust@primarydata.com>
Cc: trond.myklebust@primarydata.com
Cc: <tytso@mit.edu>
Cc: <viro@zeniv.linux.org.uk>
Cc: zyan@redhat.com
