From: Mike Marshall <hubcap@omnibond.com>
Subject: Re: [GIT PULL] vfs: Add support for timestamp limits
Date: Thu, 29 Aug 2019 21:20:18 -0400
Message-ID: <CAOg9mSR25eAH7e1KhDZt_uscJSzyuSmELbCxgyh=-KWRxjZtcw@mail.gmail.com>
References: <20190829041132.26677-1-deepa.kernel@gmail.com>
 <CABeXuvoKD83B7iUqE33Y9E2OVtf61DKv-swZr-N=ozz-cMmGOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CABeXuvoKD83B7iUqE33Y9E2OVtf61DKv-swZr-N=ozz-cMmGOA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, jfs-discussion@lists.sourceforge.net, Dave Kleikamp <shaggy@kernel.org>, al@alarsen.net, yuchao0@huawei.com, Bob Copeland <me@bobcopeland.com>, Adrian Hunter <adrian.hunter@intel.com>, Andreas Dilger <adilger.kernel@dilger.ca>, mikulas@artax.karlin.mff.cuni.cz, stoph Hellwig <hch@lst.de>, nico@fluxnic.net, linux-cifs@vger.kernel.org, "Yan,
 Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, y2038 Mailman List <y2038@lists.linaro.org>, Richard Weinberger <richard@nod.at>, Steve French <sfrench@samba.org>, Anton Vorontsov <anton@enomsg.org>, linux@armlinux.org.uk, codalist@coda.cs.cmu.edu, Christoph Hellwig <hch@infradead.org>, coda@cs.cmu.edu, V9FS Developers <v9fs-developer@lists.sourceforge.net>, Ilya Dryomov <idryomov@gmail.com>, Ext4
List-Id: ceph-devel.vger.kernel.org

Hi Deepa...

I installed this patch series on top of Linux 5.3-rc6 and ran xfstests
on orangefs and got a regression... generic/258 failed
with: "Timestamp wrapped"...

# cat results/generic/258.out.bad
QA output created by 258
Creating file with timestamp of Jan 1, 1960
Testing for negative seconds since epoch
Timestamp wrapped: 0
Timestamp wrapped
(see /home/hubcap/xfstests-dev/results//generic/258.full for details)

Just to double check, I compiled Linux 5.3-rc6 without the timestamp series,
and 258 passed... then added the patch series back and the failure returned...

Also.... when I was using "git am" to apply the patch series, the ceph patch
failed, so I "git skipped" it...

I obtained the patch series from: https://github.com/deepa-hub/vfs limits
today.

-Mike

On Thu, Aug 29, 2019 at 12:38 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Adding the others who were on original cc, just in case.
> - Deepa
>
> On Wed, Aug 28, 2019 at 9:12 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > Hi Al, Arnd,
> >
> > This is a pull request for filling in min and max timestamps for filesystems.
> > I've added all the acks, and dropped the adfs patch. That will be merged through
> > Russell's tree.
> >
> > Thanks,
> > Deepa
> >
> > The following changes since commit 5d18cb62218608a1388858880ad3ec76d6cb0d3b:
> >
> >   Add linux-next specific files for 20190828 (2019-08-28 19:59:14 +1000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/deepa-hub/vfs limits
> >
> > for you to fetch changes up to f0f216afa4c7e4dee9121fde52ccf57f76119188:
> >
> >   isofs: Initialize filesystem timestamp ranges (2019-08-28 19:19:36 -0700)
> >
> > ----------------------------------------------------------------
> > Deepa Dinamani (19):
> >       vfs: Add file timestamp range support
> >       vfs: Add timestamp_truncate() api
> >       timestamp_truncate: Replace users of timespec64_trunc
> >       mount: Add mount warning for impending timestamp expiry
> >       utimes: Clamp the timestamps before update
> >       fs: Fill in max and min timestamps in superblock
> >       9p: Fill min and max timestamps in sb
> >       ext4: Initialize timestamps limits
> >       fs: nfs: Initialize filesystem timestamp ranges
> >       fs: cifs: Initialize filesystem timestamp ranges
> >       fs: fat: Initialize filesystem timestamp ranges
> >       fs: affs: Initialize filesystem timestamp ranges
> >       fs: sysv: Initialize filesystem timestamp ranges
> >       fs: ceph: Initialize filesystem timestamp ranges
> >       fs: orangefs: Initialize filesystem timestamp ranges
> >       fs: hpfs: Initialize filesystem timestamp ranges
> >       fs: omfs: Initialize filesystem timestamp ranges
> >       pstore: fs superblock limits
> >       isofs: Initialize filesystem timestamp ranges
> >
> >  fs/9p/vfs_super.c        |  6 +++++-
> >  fs/affs/amigaffs.c       |  2 +-
> >  fs/affs/amigaffs.h       |  3 +++
> >  fs/affs/inode.c          |  4 ++--
> >  fs/affs/super.c          |  4 ++++
> >  fs/attr.c                | 21 ++++++++++++---------
> >  fs/befs/linuxvfs.c       |  2 ++
> >  fs/bfs/inode.c           |  2 ++
> >  fs/ceph/super.c          |  2 ++
> >  fs/cifs/cifsfs.c         | 22 ++++++++++++++++++++++
> >  fs/cifs/netmisc.c        | 14 +++++++-------
> >  fs/coda/inode.c          |  3 +++
> >  fs/configfs/inode.c      | 12 ++++++------
> >  fs/cramfs/inode.c        |  2 ++
> >  fs/efs/super.c           |  2 ++
> >  fs/ext2/super.c          |  2 ++
> >  fs/ext4/ext4.h           | 10 +++++++++-
> >  fs/ext4/super.c          | 17 +++++++++++++++--
> >  fs/f2fs/file.c           | 21 ++++++++++++---------
> >  fs/fat/inode.c           | 12 ++++++++++++
> >  fs/freevxfs/vxfs_super.c |  2 ++
> >  fs/hpfs/hpfs_fn.h        |  6 ++----
> >  fs/hpfs/super.c          |  2 ++
> >  fs/inode.c               | 33 ++++++++++++++++++++++++++++++++-
> >  fs/isofs/inode.c         |  7 +++++++
> >  fs/jffs2/fs.c            |  3 +++
> >  fs/jfs/super.c           |  2 ++
> >  fs/kernfs/inode.c        |  7 +++----
> >  fs/minix/inode.c         |  2 ++
> >  fs/namespace.c           | 33 ++++++++++++++++++++++++++++++++-
> >  fs/nfs/super.c           | 20 +++++++++++++++++++-
> >  fs/ntfs/inode.c          | 21 ++++++++++++---------
> >  fs/omfs/inode.c          |  4 ++++
> >  fs/orangefs/super.c      |  2 ++
> >  fs/pstore/ram.c          |  2 ++
> >  fs/qnx4/inode.c          |  2 ++
> >  fs/qnx6/inode.c          |  2 ++
> >  fs/reiserfs/super.c      |  3 +++
> >  fs/romfs/super.c         |  2 ++
> >  fs/squashfs/super.c      |  2 ++
> >  fs/super.c               |  2 ++
> >  fs/sysv/super.c          |  5 ++++-
> >  fs/ubifs/file.c          | 21 ++++++++++++---------
> >  fs/ufs/super.c           |  7 +++++++
> >  fs/utimes.c              |  6 ++----
> >  fs/xfs/xfs_super.c       |  2 ++
> >  include/linux/fs.h       |  5 +++++
> >  include/linux/time64.h   |  2 ++
> >  48 files changed, 298 insertions(+), 72 deletions(-)

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
