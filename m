From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: Fix page_mkwrite off-by-one errors
Date: Thu, 28 Nov 2019 07:45:16 -0800
Message-ID: <20191128154516.GA17166@infradead.org>
References: <20191127151811.9229-1-agruenba@redhat.com>
 <20191127154954.GT6219@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127154954.GT6219@magnolia>
Sender: linux-kernel-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Nov 27, 2019 at 07:49:54AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 27, 2019 at 04:18:11PM +0100, Andreas Gruenbacher wrote:
> > Fix a check in block_page_mkwrite meant to determine whether an offset
> > is within the inode size.  This error has spread to several filesystems
> > and to iomap_page_mkwrite, so fix those instances as well.
> 
> Seeing how this has gotten screwed up at least six times in the kernel,
> maybe we need a static inline helper to do this for us?

Yes.  I think we really want a little helper that checks the mapping
and the offset.  That also gives us the opportunity to document the
semantics.

> 
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> 
> The iomap part looks ok,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> (I might just extract the iomap part and put it in the iomap tree if
> someone doesn't merge this one before I get to it...)

I think we should just pull in the helper and conversions through
some tree after all iomap bits are merged.  It might as well be
the iomap tree as that seems to the place for file system read/write
infrastructure these days.
