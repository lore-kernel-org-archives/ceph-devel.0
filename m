From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL RESEND] vfs: Add support for timestamp
 limits
Date: Fri, 30 Aug 2019 18:23:43 +0200
Message-ID: <CAK8P3a3WUmeewmNscdKpUf3fB3eLV1X=YdLQt8cvS_tqq7OroQ@mail.gmail.com>
References: <CAK8P3a1XjOMpuS12Xao1xqOLFOuz1Jb8dTAfrhLcE643sSkC5g@mail.gmail.com>
 <20190830154744.4868-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20190830154744.4868-1-deepa.kernel@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, jfs-discussion@lists.sourceforge.net, Dave Kleikamp <shaggy@kernel.org>, Anders Larsen <al@alarsen.net>, Bob Copeland <me@bobcopeland.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mtd <linux-mtd@lists.infradead.org>, mikulas@artax.karlin.mff.cuni.cz, Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org, Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, y2038 Mailman List <y2038@lists.linaro.org>, Richard Weinberger <richard@nod.at>, Steve French <sfrench@samba.org>, Anton Vorontsov <anton@enomsg.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, codalist@coda.cs.cmu.edu, Christoph Hellwig <hch@infradead.org>, coda@cs.cmu.edu, V9FS Developers <v9fs-devel>
List-Id: ceph-devel.vger.kernel.org

On Fri, Aug 30, 2019 at 5:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> [resending, rebased onto linux v5.3-rc6, and dropped orangefs patch from the series]
>
> Hi Al, Arnd,
>
> This is a pull request for filling in min and max timestamps for filesystems.
> I've added all the acks, and dropped the adfs patch. That will be merged through
> Russell's tree.
>
> Dropped orangefs until the maintainers decide what its limits should be.

I've merged this into my
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038
branch. Since you did not include a tag description, I took the text from
the last patch series as the commit text, with a link to the pull request
on lore.kernel.org.

Al, let me know in case you have any objections to this going through
the y2038 branch, and you would rather take it through vfs.git.

     Arnd
