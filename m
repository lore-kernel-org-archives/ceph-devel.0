From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v4] fs: Fix page_mkwrite off-by-one errors
Date: Wed, 15 Jan 2020 09:10:47 -0800
Message-ID: <20200115171047.GA8247@magnolia>
References: <20200108131528.4279-1-agruenba@redhat.com>
 <20200108165710.GA18523@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200108165710.GA18523@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>, Richard Weinberger <richard@nod.at>, YueHaibing <yuehaibing@huawei.com>, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chao Yu <chao@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Artem Bityutskiy <dedekind1@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, Linus
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 08, 2020 at 08:57:10AM -0800, Christoph Hellwig wrote:
> I don't want to be the party pooper, but shouldn't this be a series
> with one patch to add the helper, and then once for each fs / piece
> of common code switched over?

The current patch in the iomap branch contains the chunks that add the
helper function, fix iomap, and whatever chunks for other filesystems
that don't cause /any/ merge complaints in for-next.  That means btrfs,
ceph, ext4, and ubifs will get fixed this time around.

Seeing as it's been floating around in for-next for a week now I'd
rather not rebase the branch just to rip out the four parts that haven't
given me any headaches so that they can be applied separately. :)

The acks from the other fs maintainers were very helpful, but at the
same time, I don't want to become a shadow vfs maintainer.

Therefore, whatever's in this v4 patch that isn't in [1] will have to be
sent separately.

[1] https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=iomap-5.6-merge&id=62e298db3fc3ebf41d996f3c86b44cbbdd3286bc

> On Wed, Jan 08, 2020 at 02:15:28PM +0100, Andreas Gruenbacher wrote:
> > Hi Darrick,
> > 
> > here's an updated version with the latest feedback incorporated.  Hope
> > you find that useful.
> > 
> > As far as the f2fs merge conflict goes, I've been told by Linus not to
> > resolve those kinds of conflicts but to point them out when sending the
> > merge request.  So this shouldn't be a big deal.
> 
> Also this isn't really the proper way to write a commit message.  This
> text would go into the cover letter if it was a series..

<urk> Yeah.

--D

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
