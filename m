From: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Upcoming: fscache rewrite
Date: Thu, 30 Jul 2020 13:16:22 +0100
Message-ID: <20200730121622.GB23808@casper.infradead.org>
References: <447452.1596109876@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <447452.1596109876-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Wysochanski <dwysocha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Trond Myklebust <trondmy-F/q8l9xzQnoyLce1RVWEUA@public.gmane.org>, Anna Schumaker <anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, Steve French <sfrench-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Eric Van Hensbergen <ericvh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-cachefs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Jul 30, 2020 at 12:51:16PM +0100, David Howells wrote:
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

I suspect you don't need to call find_get_pages_contig().  If you look
at __readahead_batch() in pagemap.h, it does basically what you want
(other than being wrapped up inside the readahead iterator).  You require
the pages already be pinned in the xarray, so there's no need for the
page_cache_get_speculative() dance that find_get_pages_contig) does,
nor the check for xa_is_value().

My main concern with your patchset is that it introduces a new page flag
to sleep on which basically means "I am writing this page to the fscache".
I don't understand why you need it; you've elevated the refcount on
the pages so they're not going to get reused for another purpose.
All it does (as far as I can tell) is make a task calling truncate()
wait for the page to finish being written to cache, which isn't actually
necessary.

Overall, I do like the patch series!  It's a big improvement over what we
currently have and will make it easier to finish the readpages->readahead
conversion.
