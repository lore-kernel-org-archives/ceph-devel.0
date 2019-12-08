From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
Date: Sun, 8 Dec 2019 03:04:07 +0000
Message-ID: <20191208030407.GO4203@ZenIV.linux.org.uk>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
 <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
 <20191207060201.GN4203@ZenIV.linux.org.uk>
 <CABeXuvrvATrw9QfVpi1s80Duen6jf5sw+pU91yN_0f3N1xWJQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CABeXuvrvATrw9QfVpi1s80Duen6jf5sw+pU91yN_0f3N1xWJQQ@mail.gmail.com>
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
Cc: CIFS <linux-cifs@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, Jeff Layton <jlayton@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Steve French <stfrench@microsoft.com>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, ceph-devel <ceph-devel@vger.kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
List-Id: ceph-devel.vger.kernel.org

On Sat, Dec 07, 2019 at 06:04:38PM -0800, Deepa Dinamani wrote:
> On Fri, Dec 6, 2019 at 10:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Dec 05, 2019 at 06:43:26PM -0800, Deepa Dinamani wrote:
> > > On Mon, Dec 2, 2019 at 9:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > > > This series aims at deleting timespec64_trunc().
> > > > There is a new api: timestamp_truncate() that is the
> > > > replacement api. The api additionally does a limits
> > > > check on the filesystem timestamps.
> > >
> > > Al/Andrew, can one of you help merge these patches?
> >
> > Looks sane.  Could you check if #misc.timestamp looks sane to you?
> 
> Yes, that looks sane to me.
> 
> > One thing that leaves me scratching head is kernfs - surely we
> > are _not_ limited by any external layouts there, so why do we
> > need to bother with truncation?
> 
> I think I was more pedantic then, and was explicitly truncating times
> before assignment to inode timestamps. But, Arnd has since coached me
> that we should not introduce things to safe guard against all
> possibilities, but only what is needed currently. So this kernfs
> truncate is redundant, given the limits and the granularity match vfs
> timestamp representation limits.

OK...  I've tossed a followup removing the truncation from kernfs;
the whole series looks reasonably safe, but I don't think it's urgent
enough to even try getting it merged before -rc1.  So here's what
I'm going to do: immediately after -rc1 it gets renamed[*] to #imm.timestamp,
which will be in the never-modified mode, in #for-next from the very
begining and safe for other trees to pull.  Current shortlog:

Al Viro (1):
      kernfs: don't bother with timestamp truncation

Amir Goldstein (1):
      utimes: Clamp the timestamps in notify_change()

Deepa Dinamani (6):
      fs: fat: Eliminate timespec64_trunc() usage
      fs: cifs: Delete usage of timespec64_trunc
      fs: ceph: Delete timespec64_trunc() usage
      fs: ubifs: Eliminate timespec64_trunc() usage
      fs: Delete timespec64_trunc()
      fs: Do not overload update_time

Diffstat:
 fs/attr.c            | 23 +++++++++++------------
 fs/ceph/mds_client.c |  4 +---
 fs/cifs/inode.c      | 13 +++++++------
 fs/configfs/inode.c  |  9 +++------
 fs/f2fs/file.c       | 18 ++++++------------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 33 +++------------------------------
 fs/kernfs/inode.c    |  6 +++---
 fs/ntfs/inode.c      | 18 ++++++------------
 fs/ubifs/file.c      | 18 ++++++------------
 fs/ubifs/sb.c        | 11 ++++-------
 fs/utimes.c          |  4 ++--
 include/linux/fs.h   |  1 -
 13 files changed, 61 insertions(+), 107 deletions(-)

[*] right now it's based on v5.4; I don't see anything that would
warrant rebasing it to -rc1 at the moment, but if anything of that
sort shows up tomorrow, s/renamed/rebased to -rc1 and renamed/.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
