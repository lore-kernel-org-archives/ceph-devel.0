From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] ceph: set up page array mempool with correct size
Date: Wed, 03 Apr 2013 11:50:36 -0700
Message-ID: <515C79FC.3070304@inktank.com>
References: <5159AC83.4060007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47218 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759718Ab3DCSuz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 14:50:55 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so1005761pbb.37
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 11:50:55 -0700 (PDT)
In-Reply-To: <5159AC83.4060007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/01/2013 08:49 AM, Alex Elder wrote:
> In create_fs_client() a memory pool is set up be used for arrays of
> pages that might be needed in ceph_writepages_start() if memory is
> tight.  There are two problems with the way it's initialized:
>      - The size provided is the number of pages we want in the
>        array, but it should be the number of bytes required for
>        that many page pointers.
>      - The number of pages computed can end up being 0, while we
>        will always need at least one page.
>
> This patch fixes both of these problems.
>
> This resolves the two simple problems defined in:
>      http://tracker.ceph.com/issues/4603
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   fs/ceph/super.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 9fe17c6c..318bee0 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -479,6 +479,8 @@ static struct ceph_fs_client
> *create_fs_client(struct ceph_mount_options *fsopt,
>   		CEPH_FEATURE_FLOCK |
>   		CEPH_FEATURE_DIRLAYOUTHASH;
>   	const unsigned required_features = 0;
> +	int page_count;
> +	size_t size;
>   	int err = -ENOMEM;
>
>   	fsc = kzalloc(sizeof(*fsc), GFP_KERNEL);
> @@ -522,8 +524,9 @@ static struct ceph_fs_client
> *create_fs_client(struct ceph_mount_options *fsopt,
>
>   	/* set up mempools */
>   	err = -ENOMEM;
> -	fsc->wb_pagevec_pool = mempool_create_kmalloc_pool(10,
> -			      fsc->mount_options->wsize >> PAGE_CACHE_SHIFT);
> +	page_count = fsc->mount_options->wsize >> PAGE_CACHE_SHIFT;
> +	size = sizeof (struct page *) * (page_count ? page_count : 1);
> +	fsc->wb_pagevec_pool = mempool_create_kmalloc_pool(10, size);
>   	if (!fsc->wb_pagevec_pool)
>   		goto fail_trunc_wq;
>

