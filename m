From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [GIT PULL RESEND] vfs: Add support for timestamp limits
Date: Fri, 30 Aug 2019 08:47:44 -0700
Message-ID: <20190830154744.4868-1-deepa.kernel@gmail.com>
References: <CAK8P3a1XjOMpuS12Xao1xqOLFOuz1Jb8dTAfrhLcE643sSkC5g@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1XjOMpuS12Xao1xqOLFOuz1Jb8dTAfrhLcE643sSkC5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, viro@zeniv.linux.org.uk
Cc: adilger@dilger.ca, aivazian.tigran@gmail.com, darrick.wong@oracle.com, deepa.kernel@gmail.com, dsterba@suse.com, gregkh@linuxfoundation.org, jlayton@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, me@bobcopeland.com, y2038@lists.linaro.org, adrian.hunter@intel.com, al@alarsen.net, anna.schumaker@netapp.com, anton@enomsg.org, asmadeus@codewreck.org, ccross@android.com, ceph-devel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, dedekind1@gmail.com, devel@lists.orangefs.org, dushistov@mail.ru, dwmw2@infradead.org, ericvh@gmail.com, hch@infradead.org, hch@lst.de, hirofumi@mail.parknet.co.jp, hubcap@omnibond.com, idryomov@gmail.com, jack@suse.com, jaegeuk@kernel.org, jaharkes@cs.cmu.edu, jfs-discu
List-Id: ceph-devel.vger.kernel.org

[resending, rebased onto linux v5.3-rc6, and dropped orangefs patch from the series]

Hi Al, Arnd,

This is a pull request for filling in min and max timestamps for filesystems.
I've added all the acks, and dropped the adfs patch. That will be merged through
Russell's tree.

Dropped orangefs until the maintainers decide what its limits should be.

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  https://github.com/deepa-hub/vfs limits

for you to fetch changes up to 5ad32b3acded06183f40806f76b030c3143017bb:

  isofs: Initialize filesystem timestamp ranges (2019-08-30 08:11:25 -0700)

----------------------------------------------------------------

- Deepa

Deepa Dinamani (18):
      vfs: Add file timestamp range support
      vfs: Add timestamp_truncate() api
      timestamp_truncate: Replace users of timespec64_trunc
      mount: Add mount warning for impending timestamp expiry
      utimes: Clamp the timestamps before update
      fs: Fill in max and min timestamps in superblock
      9p: Fill min and max timestamps in sb
      ext4: Initialize timestamps limits
      fs: nfs: Initialize filesystem timestamp ranges
      fs: cifs: Initialize filesystem timestamp ranges
      fs: fat: Initialize filesystem timestamp ranges
      fs: affs: Initialize filesystem timestamp ranges
      fs: sysv: Initialize filesystem timestamp ranges
      fs: ceph: Initialize filesystem timestamp ranges
      fs: hpfs: Initialize filesystem timestamp ranges
      fs: omfs: Initialize filesystem timestamp ranges
      pstore: fs superblock limits
      isofs: Initialize filesystem timestamp ranges

 fs/9p/vfs_super.c        |  6 +++++-
 fs/affs/amigaffs.c       |  2 +-
 fs/affs/amigaffs.h       |  3 +++
 fs/affs/inode.c          |  4 ++--
 fs/affs/super.c          |  4 ++++
 fs/attr.c                | 21 ++++++++++++---------
 fs/befs/linuxvfs.c       |  2 ++
 fs/bfs/inode.c           |  2 ++
 fs/ceph/super.c          |  2 ++
 fs/cifs/cifsfs.c         | 22 ++++++++++++++++++++++
 fs/cifs/netmisc.c        | 14 +++++++-------
 fs/coda/inode.c          |  3 +++
 fs/configfs/inode.c      | 12 ++++++------
 fs/cramfs/inode.c        |  2 ++
 fs/efs/super.c           |  2 ++
 fs/ext2/super.c          |  2 ++
 fs/ext4/ext4.h           | 10 +++++++++-
 fs/ext4/super.c          | 17 +++++++++++++++--
 fs/f2fs/file.c           | 21 ++++++++++++---------
 fs/fat/inode.c           | 12 ++++++++++++
 fs/freevxfs/vxfs_super.c |  2 ++
 fs/hpfs/hpfs_fn.h        |  6 ++----
 fs/hpfs/super.c          |  2 ++
 fs/inode.c               | 33 ++++++++++++++++++++++++++++++++-
 fs/isofs/inode.c         |  7 +++++++
 fs/jffs2/fs.c            |  3 +++
 fs/jfs/super.c           |  2 ++
 fs/kernfs/inode.c        |  7 +++----
 fs/minix/inode.c         |  2 ++
 fs/namespace.c           | 33 ++++++++++++++++++++++++++++++++-
 fs/nfs/super.c           | 20 +++++++++++++++++++-
 fs/ntfs/inode.c          | 21 ++++++++++++---------
 fs/omfs/inode.c          |  4 ++++
 fs/pstore/ram.c          |  2 ++
 fs/qnx4/inode.c          |  2 ++
 fs/qnx6/inode.c          |  2 ++
 fs/reiserfs/super.c      |  3 +++
 fs/romfs/super.c         |  2 ++
 fs/squashfs/super.c      |  2 ++
 fs/super.c               |  2 ++
 fs/sysv/super.c          |  5 ++++-
 fs/ubifs/file.c          | 21 ++++++++++++---------
 fs/ufs/super.c           |  7 +++++++
 fs/utimes.c              |  6 ++----
 fs/xfs/xfs_super.c       |  2 ++
 include/linux/fs.h       |  5 +++++
 include/linux/time64.h   |  2 ++
 47 files changed, 296 insertions(+), 72 deletions(-)
