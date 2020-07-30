From: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Upcoming: fscache rewrite
Date: Thu, 30 Jul 2020 09:08:32 -0400
Message-ID: <2db05b3eb59bfb59688e7cb435c1b5f2096b8f8a.camel@redhat.com>
References: <447452.1596109876@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <447452.1596109876-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Dave Wysochanski <dwysocha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Trond Myklebust <trondmy-F/q8l9xzQnoyLce1RVWEUA@public.gmane.org>, Anna Schumaker <anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, Steve French <sfrench-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Eric Van Hensbergen <ericvh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-cachefs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2020-07-30 at 12:51 +0100, David Howells wrote:
> Hi Linus, Trond/Anna, Steve, Eric,
> 
> I have an fscache rewrite that I'm tempted to put in for the next merge
> window:
> 
> 	https://lore.kernel.org/linux-fsdevel/159465784033.1376674.18106463693989811037.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org/
> 
> It improves the code by:
> 
>  (*) Ripping out the stuff that uses page cache snooping and kernel_write()
>      and using kiocb instead.  This gives multiple wins: uses async DIO rather
>      than snooping for updated pages and then copying them, less VM overhead.
> 
>  (*) Object management is also simplified, getting rid of the state machine
>      that was managing things and using a much simplified thread pool instead.
> 
>  (*) Object invalidation creates a tmpfile and diverts new activity to that so
>      that it doesn't have to synchronise in-flight ADIO.
> 
>  (*) Using a bitmap stored in an xattr rather than using bmap to find out if
>      a block is present in the cache.  Probing the backing filesystem's
>      metadata to find out is not reliable in modern extent-based filesystems
>      as them may insert or remove blocks of zeros.  Even SEEK_HOLE/SEEK_DATA
>      are problematic since they don't distinguish transparently inserted
>      bridging.
> 
> I've provided a read helper that handles ->readpage, ->readpages, and
> preparatory writes in ->write_begin.  Willy is looking at using this as a way
> to roll his new ->readahead op out into filesystems.  A good chunk of this
> will move into MM code.
> 
> The code is simpler, and this is nice too:
> 
>  67 files changed, 5947 insertions(+), 8294 deletions(-)
> 
> not including documentation changes, which I need to convert to rst format
> yet.  That removes a whole bunch more lines.
> 
> But there are reasons you might not want to take it yet:
> 
>  (1) It starts off by disabling fscache support in all the filesystems that
>      use it: afs, nfs, cifs, ceph and 9p.  I've taken care of afs, Dave
>      Wysochanski has patches for nfs:
> 
> 	https://lore.kernel.org/linux-nfs/1596031949-26793-1-git-send-email-dwysocha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org/
> 
>      but they haven't been reviewed by Trond or Anna yet, and Jeff Layton has
>      patches for ceph:
> 
> 	https://marc.info/?l=ceph-devel&m=159541538914631&w=2
> 
>      and I've briefly discussed cifs with Steve, but nothing has started there
>      yet.  9p I've not looked at yet.
> 
>      Now, if we're okay for going a kernel release with 4/5 filesystems with
>      caching disabled and then pushing the changes for individual filesystems
>      through their respective trees, it might be easier.
> 
>      Unfortunately, I wasn't able to get together with Trond and Anna at LSF
>      to discuss this.
> 
>  (2) The patched afs fs passed xfstests -g quick (unlike the upstream code
>      that oopses pretty quickly with caching enabled).  Dave and Jeff's nfs
>      and ceph code is getting close, but not quite there yet.


That was my experience on cephfs+fscache too -- it often crashed down in
the fscache code. I'd support the approach in (1) above -- put this in
soon and disable the caches in the filesystems. Then push the changes to
reenable it via fs-specific trees.

The ceph patch series is more or less ready. It passes all of the
xfstest "quick" group run (aside from a few expected failures on
cephfs).

The only real exception is generic/531, which seems to trigger OOM kills
in my testing. The test tries to create a ton of files and leak the file
descriptors. I tend to think that workload is pretty unusual, and given
that fscache was terribly unstable and crashed before, this is still a
marked improvement.

>  (3) Al has objections to the ITER_MAPPING iov_iter type that I added
> 
> 	https://lore.kernel.org/linux-fsdevel/20200719014436.GG2786714-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org/
> 
>      but note that iov_iter_for_each_range() is not actually used by anything.
> 
>      However, Willy likes it and would prefer to make it ITER_XARRAY instead
>      as he might be able to use it in other places, though there's an issue
>      where I'm calling find_get_pages_contig() which takes a mapping (though
>      all it does is then get the xarray out of it).
> 
>      Instead I would have to use ITER_BVEC, which has quite a high overhead,
>      though it would mean that the RCU read lock wouldn't be necessary.  This
>      would require 1K of memory for every 256K block the cache wants to read;
>      for any read >1M, I'd have to use vmalloc() instead.
> 
>      I'd also prefer not to use ITER_BVEC because the offset and length are
>      superfluous here.  If ITER_MAPPING is not good, would it be possible to
>      have an ITER_PAGEARRAY that just takes a page array instead?  Or, even,
>      create a transient xarray?
> 
>  (4) The way object culling is managed needs overhauling too, but that's a
>      whole 'nother patchset.  We could wait till that's done too, but its lack
>      doesn't prevent what we have now being used.
> 
> Thoughts?
> 
> David
> 

-- 
Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
