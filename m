From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/12] block: bio_release_pages: use flags arg instead
 of bool
Date: Thu, 1 Aug 2019 10:20:04 +0200
Message-ID: <20190801082004.GA17348@lst.de>
References: <20190724042518.14363-1-jhubbard@nvidia.com> <20190724042518.14363-4-jhubbard@nvidia.com> <20190724053053.GA18330@infradead.org> <20190729205721.GB3760@redhat.com> <20190730102557.GA1700@lst.de> <20190730155702.GB10366@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730155702.GB10366@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Anna Schumaker <anna.schumaker@netapp.com>, "David S . Miller" <davem@davemloft.net>, Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>, "Michael S . Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@v
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 30, 2019 at 11:57:02AM -0400, Jerome Glisse wrote:
> Other user can also add page that are not coming from GUP but need to
> have a reference see __blkdev_direct_IO()

Except for the zero page case I mentioned in my last mail explicitly,
and the KVEC/PIPE type iov vecs from the original mail what other
pages do you see to get added?
