From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/12] block/bio, fs: convert put_page() to
 put_user_page*()
Date: Tue, 23 Jul 2019 23:17:50 -0700
Message-ID: <20190724061750.GA19397@infradead.org>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190724042518.14363-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john.hubbard@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Anna Schumaker <anna.schumaker@netapp.com>, "David S . Miller" <davem@davemloft.net>, Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>, "Michael S . Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 23, 2019 at 09:25:06PM -0700, john.hubbard@gmail.com wrote:
> * Store, in the iov_iter, a "came from gup (get_user_pages)" parameter.
>   Then, use the new iov_iter_get_pages_use_gup() to retrieve it when
>   it is time to release the pages. That allows choosing between put_page()
>   and put_user_page*().
> 
> * Pass in one more piece of information to bio_release_pages: a "from_gup"
>   parameter. Similar use as above.
> 
> * Change the block layer, and several file systems, to use
>   put_user_page*().

I think we can do this in a simple and better way.  We have 5 ITER_*
types.  Of those ITER_DISCARD as the name suggests never uses pages, so
we can skip handling it.  ITER_PIPE is rejected іn the direct I/O path,
which leaves us with three.

Out of those ITER_BVEC needs a user page reference, so we want to call
put_user_page* on it.  ITER_BVEC always already has page reference,
which means in the block direct I/O path path we alread don't take
a page reference.  We should extent that handling to all other calls
of iov_iter_get_pages / iov_iter_get_pages_alloc.  I think we should
just reject ITER_KVEC for direct I/O as well as we have no users and
it is rather pointless.  Alternatively if we see a use for it the
callers should always have a life page reference anyway (or might
be on kmalloc memory), so we really should not take a reference either.

In other words:  the only time we should ever have to put a page in
this patch is when they are user pages.  We'll need to clean up
various bits of code for that, but that can be done gradually before
even getting to the actual put_user_pages conversion.
