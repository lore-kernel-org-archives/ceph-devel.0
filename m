From: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 0/2] iov_iter: allow iov_iter_get_pages_alloc to
 allocate more pages per call
Date: Thu, 02 Feb 2017 08:00:52 -0500
Message-ID: <1486040452.2812.6.camel@redhat.com>
References: <20170124212327.14517-1-jlayton@redhat.com>
         <20170125133205.21704-1-jlayton@redhat.com>
         <20170202095125.GF27291@ZenIV.linux.org.uk>
         <20170202105651.GA32111@infradead.org>
         <20170202111625.GG27291@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170202111625.GG27291-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lustre-devel-aLEFhgZF4x6X6Mz3xDxJMA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 2017-02-02 at 11:16 +0000, Al Viro wrote:
> On Thu, Feb 02, 2017 at 02:56:51AM -0800, Christoph Hellwig wrote:
> > > I really wonder if this is the right approach.  Most of the users of
> > > iov_iter_get_pages()/iov_iter_get_pages_alloc() look like they want
> > > something like
> > > 	iov_iter_for_each_page(iter, size, f, data)
> > > with int (*f)(struct page *page, size_t from, size_t size, void *data)
> > > passed as callback.  Not everything fits that model, but there's a whole
> > > lot of things that do.
> > 

Yeah, that does seem nicer.

My only concern is that it sounds more invasive, and I'd like to get
some sort of interim fix in for Ceph in the meantime (preferably
something we can send to stable). It really is trivial to vmsplice some
data into the kernel, and then splice write that to a DIO file --
instant softlockup in my testing.

This patch also makes vectored DIO with small iovecs on NFS a lot more
efficient, which is a nice bonus.
 
> > I was planning to do that, mostly because of the iomap dio code that
> > would not only get a lot cleaner with this, but also support multi-page
> > bvecs that we hope to have in the block layer soon.  The issue with it
> > is that we need to touch all the arch get_user_pages_fast
> > implementations, so it's going to be a relatively invasive change that I
> > didn't want to fix with just introducing the new direct I/O code.
> 
> I'm not sure we need to touch any get_user_pages_fast() at all; let it
> fill a medium-sized array and use that as a buffer.  In particular,
> I *really* don't like the idea of having the callbacks done in an
> inconsistent locking environment - sometimes under ->mmap_sem, sometimes
> not.
> 

Yeah, that might work. You could kmalloc the buffer array according to
the maxsize value. For small ones we could even consider using an on-
stack buffer.

> I played with "let it fill bio_vec array", but it doesn't really fit the
> users; variant with callbacks is cleaner, IMO.

I looked at converting this over to a bio_vec array as well, but that
really doesn't work well for Ceph. I like the callback idea better too.

-- 
Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
