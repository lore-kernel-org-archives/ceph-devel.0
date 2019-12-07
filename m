From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
Date: Sat, 7 Dec 2019 06:02:01 +0000
Message-ID: <20191207060201.GN4203@ZenIV.linux.org.uk>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
 <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ceph-devel <ceph-devel@vger.kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jeff Layton <jlayton@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Richard Weinberger <richard@nod.at>, Steve French <stfrench@microsoft.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, Dec 05, 2019 at 06:43:26PM -0800, Deepa Dinamani wrote:
> On Mon, Dec 2, 2019 at 9:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > This series aims at deleting timespec64_trunc().
> > There is a new api: timestamp_truncate() that is the
> > replacement api. The api additionally does a limits
> > check on the filesystem timestamps.
> 
> Al/Andrew, can one of you help merge these patches?

Looks sane.  Could you check if #misc.timestamp looks sane to you?

One thing that leaves me scratching head is kernfs - surely we
are _not_ limited by any external layouts there, so why do we
need to bother with truncation?
