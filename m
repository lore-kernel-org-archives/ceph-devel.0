From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Upcoming: fscache rewrite
Date: Thu, 30 Jul 2020 13:36:14 +0100
Message-ID: <488587.1596112574@warthog.procyon.org.uk>
References: <20200730121622.GB23808@casper.infradead.org> <447452.1596109876@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200730121622.GB23808-FZi0V3Vbi30CUdFEqe4BF2D2FQJk+8+b@public.gmane.org>
Content-ID: <488586.1596112574.1-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Wysochanski <dwysocha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Trond Myklebust <trondmy-F/q8l9xzQnoyLce1RVWEUA@public.gmane.org>, Anna Schumaker <anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, Steve French <sfrench-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Eric Van Hensbergen <ericvh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-cachefs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:

> I suspect you don't need to call find_get_pages_contig().  If you look
> at __readahead_batch() in pagemap.h, it does basically what you want
> (other than being wrapped up inside the readahead iterator).  You require
> the pages already be pinned in the xarray, so there's no need for the
> page_cache_get_speculative() dance that find_get_pages_contig) does,
> nor the check for xa_is_value().

I'll have a look at that.

> My main concern with your patchset is that it introduces a new page flag

Technically, the flag already exists - I'm just using it for something
different than the old fscache code used it for.

> to sleep on which basically means "I am writing this page to the fscache".
> I don't understand why you need it; you've elevated the refcount on
> the pages so they're not going to get reused for another purpose.
> All it does (as far as I can tell) is make a task calling truncate()
> wait for the page to finish being written to cache, which isn't actually
> necessary.

It's also used to prevent starting overlapping async DIO writes to the cache.

See fscache_read_done(), where it's set to cover writing what we've just read
from the server to the cache, and afs_write_back_from_locked_page(), where
it's set to cover writing the data to be written back to the cache.

David
