From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
Date: Thu, 5 Dec 2019 18:43:26 -0800
Message-ID: <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ceph-devel <ceph-devel@vger.kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jeff Layton <jlayton@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Richard Weinberger <richard@nod.at>, Steve French <stfrench@microsoft.com>
List-Id: ceph-devel.vger.kernel.org

On Mon, Dec 2, 2019 at 9:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> This series aims at deleting timespec64_trunc().
> There is a new api: timestamp_truncate() that is the
> replacement api. The api additionally does a limits
> check on the filesystem timestamps.

Al/Andrew, can one of you help merge these patches?

Thanks,
-Deepa
