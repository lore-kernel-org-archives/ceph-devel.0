From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 00/12] block/bio, fs: convert put_page() to
	put_user_page*()
Date: Thu, 25 Jul 2019 18:24:16 -0700
Message-ID: <88864b91-516d-9774-f4ca-b45927ac4556@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<8621066c-e242-c449-eb04-4f2ce6867140@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8621066c-e242-c449-eb04-4f2ce6867140@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bob Liu <bob.liu@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Anna Schumaker <anna.schumaker@netapp.com>
List-Id: ceph-devel.vger.kernel.org

On 7/24/19 5:41 PM, Bob Liu wrote:
> On 7/24/19 12:25 PM, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Hi,
>>
>> This is mostly Jerome's work, converting the block/bio and related areas
>> to call put_user_page*() instead of put_page(). Because I've changed
>> Jerome's patches, in some cases significantly, I'd like to get his
>> feedback before we actually leave him listed as the author (he might
>> want to disown some or all of these).
>>
> 
> Could you add some background to the commit log for people don't have the context..
> Why this converting? What's the main differences?
> 

Hi Bob,

1. Many of the patches have a blurb like this:

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

...and if you look at that commit, you'll find several pages of
information in its commit description, which should address your point.

2. This whole series has to be re-worked, as per the other feedback thread.
So I'll keep your comment in mind when I post a new series.

thanks,
-- 
John Hubbard
NVIDIA
