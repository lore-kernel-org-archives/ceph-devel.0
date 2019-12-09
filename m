From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
Date: Mon, 9 Dec 2019 00:48:20 +0000
Message-ID: <20191209004820.GZ4203@ZenIV.linux.org.uk>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
 <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
 <20191207060201.GN4203@ZenIV.linux.org.uk>
 <CABeXuvrvATrw9QfVpi1s80Duen6jf5sw+pU91yN_0f3N1xWJQQ@mail.gmail.com>
 <20191208030407.GO4203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191208030407.GO4203@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ceph-devel <ceph-devel@vger.kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jeff Layton <jlayton@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Richard Weinberger <richard@nod.at>, Steve French <stfrench@microsoft.com>
List-Id: ceph-devel.vger.kernel.org

On Sun, Dec 08, 2019 at 03:04:07AM +0000, Al Viro wrote:

> OK...  I've tossed a followup removing the truncation from kernfs;
> the whole series looks reasonably safe, but I don't think it's urgent
> enough to even try getting it merged before -rc1.  So here's what
> I'm going to do: immediately after -rc1 it gets renamed[*] to #imm.timestamp,
> which will be in the never-modified mode, in #for-next from the very
> begining and safe for other trees to pull.

Rebased to -rc1, pushed out as #imm.timestamp, included into #for-next.
Never-modified mode...
