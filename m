From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/12] block/bio, fs: convert put_page() to
 put_user_page*()
Date: Tue, 6 Aug 2019 23:34:48 -0700
Message-ID: <20190807063448.GA6002@infradead.org>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
 <20190724061750.GA19397@infradead.org>
 <c35aa2bf-c830-9e57-78ca-9ce6fb6cb53b@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c35aa2bf-c830-9e57-78ca-9ce6fb6cb53b@nvidia.com>
Sender: netdev-owner@vger.kernel.org
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Anna Schumaker <anna.schumaker@netapp.com>, "David S . Miller" <davem@davemloft.net>, Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>, "Michael S . Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@v
List-Id: ceph-devel.vger.kernel.org

On Mon, Aug 05, 2019 at 03:54:35PM -0700, John Hubbard wrote:
> On 7/23/19 11:17 PM, Christoph Hellwig wrote:
> > On Tue, Jul 23, 2019 at 09:25:06PM -0700, john.hubbard@gmail.com wrote:
> >> * Store, in the iov_iter, a "came from gup (get_user_pages)" parameter.
> >>   Then, use the new iov_iter_get_pages_use_gup() to retrieve it when
> >>   it is time to release the pages. That allows choosing between put_page()
> >>   and put_user_page*().
> >>
> >> * Pass in one more piece of information to bio_release_pages: a "from_gup"
> >>   parameter. Similar use as above.
> >>
> >> * Change the block layer, and several file systems, to use
> >>   put_user_page*().
> > 
> > I think we can do this in a simple and better way.  We have 5 ITER_*
> > types.  Of those ITER_DISCARD as the name suggests never uses pages, so
> > we can skip handling it.  ITER_PIPE is rejected іn the direct I/O path,
> > which leaves us with three.
> > 
> 
> Hi Christoph,
> 
> Are you working on anything like this?

I was hoping I could steer you towards it.  But if you don't want to do
it yourself I'll add it to my ever growing todo list.

> Or on the put_user_bvec() idea?

I have a prototype from two month ago:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec

but that only survived the most basic testing, so it'll need more work,
which I'm not sure when I'll find time for.
