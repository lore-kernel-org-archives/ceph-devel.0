From: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: [PATCH v2 31/34] fs/nfs: convert put_page() to put_user_page*()
Date: Mon, 5 Aug 2019 01:26:59 +0100
Message-ID: <cf978e10-facc-ba5b-d7e4-d7fc2c3f7ebc@oracle.com>
References: <20190804224915.28669-1-jhubbard@nvidia.com>
 <20190804224915.28669-32-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190804224915.28669-32-jhubbard@nvidia.com>
Content-Language: en-GB
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-arm-kernel@lists.infradead.org, linux-nfs@vg
List-Id: ceph-devel.vger.kernel.org

On 04/08/2019 11:49 pm, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Calum Mackay <calum.mackay@oracle.com>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   fs/nfs/direct.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Calum Mackay <calum.mackay@oracle.com>


> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 0cb442406168..c0c1b9f2c069 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -276,13 +276,6 @@ ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   	return nfs_file_direct_write(iocb, iter);
>   }
>   
> -static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
> -{
> -	unsigned int i;
> -	for (i = 0; i < npages; i++)
> -		put_page(pages[i]);
> -}
> -
>   void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
>   			      struct nfs_direct_req *dreq)
>   {
> @@ -512,7 +505,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>   			pos += req_len;
>   			dreq->bytes_left -= req_len;
>   		}
> -		nfs_direct_release_pages(pagevec, npages);
> +		put_user_pages(pagevec, npages);
>   		kvfree(pagevec);
>   		if (result < 0)
>   			break;
> @@ -935,7 +928,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>   			pos += req_len;
>   			dreq->bytes_left -= req_len;
>   		}
> -		nfs_direct_release_pages(pagevec, npages);
> +		put_user_pages(pagevec, npages);
>   		kvfree(pagevec);
>   		if (result < 0)
>   			break;
> 
