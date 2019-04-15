From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v1 15/15] ceph: use put_user_pages() instead of
 ceph_put_page_vector()
Date: Mon, 15 Apr 2019 15:46:59 +0800
Message-ID: <df4da184-fe8b-c189-43e5-fac58adb3ed9@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-16-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411210834.4105-16-jglisse@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jglisse@redhat.com, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Johannes Thumshirn <jthumshirn@suse.de>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Matthew Wilcox <willy@infradead.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 4/12/19 5:08 AM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> When page reference were taken through GUP (get_user_page*()) we need
> to drop them with put_user_pages().
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-block@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Yan Zheng <zyan@redhat.com>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> ---
>   fs/ceph/file.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 6c5b85f01721..5842ad3a4218 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -667,7 +667,8 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
>   			} else {
>   				iov_iter_advance(to, 0);
>   			}
> -			ceph_put_page_vector(pages, num_pages, false);
> +			/* iov_iter_get_pages_alloc() did call GUP */
> +			put_user_pages(pages, num_pages);

pages in pipe were not from get_user_pages(). Am I missing anything?

Regards
Yan, Zheng

>   		} else {
>   			int idx = 0;
>   			size_t left = ret > 0 ? ret : 0;
> 
