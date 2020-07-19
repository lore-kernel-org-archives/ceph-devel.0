From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 01/32] iov_iter: Add ITER_MAPPING
Date: Sun, 19 Jul 2020 02:44:36 +0100
Message-ID: <20200719014436.GG2786714@ZenIV.linux.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
 <159465785214.1376674.6062549291411362531.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <159465785214.1376674.6062549291411362531.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Jul 13, 2020 at 05:30:52PM +0100, David Howells wrote:
> Add an iterator, ITER_MAPPING, that walks through a set of pages attached
> to an address_space, starting at a given page and offset and walking for
> the specified amount of bytes.
> 
> The caller must guarantee that the pages are all present and they must be
> locked using PG_locked, PG_writeback or PG_fscache to prevent them from
> going away or being migrated whilst they're being accessed.
> 
> This is useful for copying data from socket buffers to inodes in network
> filesystems and for transferring data between those inodes and the cache
> using direct I/O.
> 
> Whilst it is true that ITER_BVEC could be used instead, that would require
> a bio_vec array to be allocated to refer to all the pages - which should be
> redundant if inode->i_pages also points to all these pages.
> 
> This could also be turned into an ITER_XARRAY, taking and xarray pointer
> instead of a mapping pointer.  It would be mostly trivial, except for the
> use of find_get_pages_contig() by iov_iter_get_pages*().
> 

My main problem here is that your iterate_mapping() assumes that STEP is
safe under rcu_read_lock(), with no visible mentioning of that fact.
Note, BTW, that iov_iter_for_each_range() quietly calls user-supplied
callback in such context.

Incidentally, do you ever have different steps for bvec and mapping?

> +	if (unlikely(iov_iter_is_mapping(i))) {
> +		/* We really don't want to fetch pages if we can avoid it */
> +		i->iov_offset += size;
> +		i->count -= size;
> +		return;

That's... not nice.  At the very least you want to cap size by i->count here
(and for discard case as well, while we are at it).
