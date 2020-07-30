From: David Howells <dhowells@redhat.com>
Subject: Upcoming: fscache rewrite
Date: Thu, 30 Jul 2020 12:51:16 +0100
Message-ID: <447452.1596109876@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
Content-ID: <447451.1596109876.1@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: torvalds@linux-foundation.org
Cc: Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Anna Schumaker <anna.schumaker@netapp.com>, linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, Trond Myklebust <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: ceph-devel.vger.kernel.org

Hi Linus, Trond/Anna, Steve, Eric,

I have an fscache rewrite that I'm tempted to put in for the next merge
window:

	https://lore.kernel.org/linux-fsdevel/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/

It improves the code by:

 (*) Ripping out the stuff that uses page cache snooping and kernel_write()
     and using kiocb instead.  This gives multiple wins: uses async DIO rather
     than snooping for updated pages and then copying them, less VM overhead.

 (*) Object management is also simplified, getting rid of the state machine
     that was managing things and using a much simplified thread pool instead.

 (*) Object invalidation creates a tmpfile and diverts new activity to that so
     that it doesn't have to synchronise in-flight ADIO.

 (*) Using a bitmap stored in an xattr rather than using bmap to find out if
     a block is present in the cache.  Probing the backing filesystem's
     metadata to find out is not reliable in modern extent-based filesystems
     as them may insert or remove blocks of zeros.  Even SEEK_HOLE/SEEK_DATA
     are problematic since they don't distinguish transparently inserted
     bridging.

I've provided a read helper that handles ->readpage, ->readpages, and
preparatory writes in ->write_begin.  Willy is looking at using this as a way
to roll his new ->readahead op out into filesystems.  A good chunk of this
will move into MM code.

The code is simpler, and this is nice too:

 67 files changed, 5947 insertions(+), 8294 deletions(-)

not including documentation changes, which I need to convert to rst format
yet.  That removes a whole bunch more lines.

But there are reasons you might not want to take it yet:

 (1) It starts off by disabling fscache support in all the filesystems that
     use it: afs, nfs, cifs, ceph and 9p.  I've taken care of afs, Dave
     Wysochanski has patches for nfs:

	https://lore.kernel.org/linux-nfs/1596031949-26793-1-git-send-email-dwysocha@redhat.com/

     but they haven't been reviewed by Trond or Anna yet, and Jeff Layton has
     patches for ceph:

	https://marc.info/?l=ceph-devel&m=159541538914631&w=2

     and I've briefly discussed cifs with Steve, but nothing has started there
     yet.  9p I've not looked at yet.

     Now, if we're okay for going a kernel release with 4/5 filesystems with
     caching disabled and then pushing the changes for individual filesystems
     through their respective trees, it might be easier.

     Unfortunately, I wasn't able to get together with Trond and Anna at LSF
     to discuss this.

 (2) The patched afs fs passed xfstests -g quick (unlike the upstream code
     that oopses pretty quickly with caching enabled).  Dave and Jeff's nfs
     and ceph code is getting close, but not quite there yet.

 (3) Al has objections to the ITER_MAPPING iov_iter type that I added

	https://lore.kernel.org/linux-fsdevel/20200719014436.GG2786714@ZenIV.linux.org.uk/

     but note that iov_iter_for_each_range() is not actually used by anything.

     However, Willy likes it and would prefer to make it ITER_XARRAY instead
     as he might be able to use it in other places, though there's an issue
     where I'm calling find_get_pages_contig() which takes a mapping (though
     all it does is then get the xarray out of it).

     Instead I would have to use ITER_BVEC, which has quite a high overhead,
     though it would mean that the RCU read lock wouldn't be necessary.  This
     would require 1K of memory for every 256K block the cache wants to read;
     for any read >1M, I'd have to use vmalloc() instead.

     I'd also prefer not to use ITER_BVEC because the offset and length are
     superfluous here.  If ITER_MAPPING is not good, would it be possible to
     have an ITER_PAGEARRAY that just takes a page array instead?  Or, even,
     create a transient xarray?

 (4) The way object culling is managed needs overhauling too, but that's a
     whole 'nother patchset.  We could wait till that's done too, but its lack
     doesn't prevent what we have now being used.

Thoughts?

David
