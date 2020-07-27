From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: fix memory leak when reallocating pages array for
 writepages
Date: Mon, 27 Jul 2020 20:16:52 +0800
Message-ID: <3c8fb2aa-834b-a202-24b4-7eb29cd9b7c3@redhat.com>
References: <20200726122804.16008-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726555AbgG0MRF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:17:05 -0400
In-Reply-To: <20200726122804.16008-1-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org

On 2020/7/26 20:28, Jeff Layton wrote:
> Once we've replaced it, we don't want to keep the old one around
> anymore.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/addr.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 01ad09733ac7..01e167efa104 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1212,6 +1212,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>   			       locked_pages * sizeof(*pages));
>   			memset(data_pages + i, 0,
>   			       locked_pages * sizeof(*pages));

BTW， do we still need to memset() the data_pages ?

> +			kfree(data_pages);
>   		} else {
>   			BUG_ON(num_ops != req->r_num_ops);
>   			index = pages[i - 1]->index + 1;
