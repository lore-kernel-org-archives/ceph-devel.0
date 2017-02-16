From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v3 0/2] iov_iter: allow iov_iter_get_pages_alloc to
 allocate more pages per call
Date: Thu, 16 Feb 2017 08:10:27 -0500
Message-ID: <1487250627.3661.1.camel@redhat.com>
References: <20170124212327.14517-1-jlayton@redhat.com>
         <20170125133205.21704-1-jlayton@redhat.com>
         <20170202095125.GF27291@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202095125.GF27291@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, lustre-devel@lists.lustre.org, v9fs-developer@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Chris Wilson <chris@chris-wilson.co.uk>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, 2017-02-02 at 09:51 +0000, Al Viro wrote:
> On Wed, Jan 25, 2017 at 08:32:03AM -0500, Jeff Layton wrote:
> > Small respin of the patch that I sent yesterday for the same thing.
> > 
> > This moves the maxsize handling into iov_iter_pvec_size, so that we don't
> > end up iterating past the max size we'll use anyway when trying to
> > determine the pagevec length.
> > 
> > Also, a respun patch to make ceph use iov_iter_get_pages_alloc instead of
> > trying to do it via its own routine.
> > 
> > Al, if these look ok, do you want to pick these up or shall I ask
> > Ilya to merge them via the ceph tree?
> 
> I'd rather have that kind of work go through the vfs tree; said that,
> I really wonder if this is the right approach.  Most of the users of
> iov_iter_get_pages()/iov_iter_get_pages_alloc() look like they want
> something like
> 	iov_iter_for_each_page(iter, size, f, data)
> with int (*f)(struct page *page, size_t from, size_t size, void *data)
> passed as callback.  Not everything fits that model, but there's a whole
> lot of things that do.
> 

While I do like the above proposal better than what I originally had,
I'm guessing it won't be ready in time for v4.11.

Would it be reasonable to take the patch I proposed for v4.11 as an
interim fix? It does fix a rather easy-to-trigger softlockup in the ceph
code that xfstests can reliably hit.

-- 
Jeff Layton <jlayton@redhat.com>
