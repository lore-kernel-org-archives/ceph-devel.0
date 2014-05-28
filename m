From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: refactor readpage_nounlock() to make the logic
 clearer
Date: Wed, 28 May 2014 07:24:13 -0500
Message-ID: <5385D56D.9030205@ieee.org>
References: <1401260798-28541-1-git-send-email-zhenzhang.zhang@huawei.com> <53858BC3.8070604@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58787 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaE1MYO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 May 2014 08:24:14 -0400
Received: by mail-ie0-f169.google.com with SMTP id at1so10312903iec.28
        for <ceph-devel@vger.kernel.org>; Wed, 28 May 2014 05:24:14 -0700 (PDT)
In-Reply-To: <53858BC3.8070604@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Zhen <zhenzhang.zhang@huawei.com>, sage@inktank.com, ukernel@gmail.com
Cc: ceph-devel@vger.kernel.org

On 05/28/2014 02:09 AM, Zhang Zhen wrote:
> If the return value of ceph_osdc_readpages() is not negative,
> it is certainly greater than or equal to zero.
> 
> Remove the useless condition judgment and redundant braces.
> 
> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>

This looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  fs/ceph/addr.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b53278c..6aa2e3f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -211,18 +211,15 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>  		SetPageError(page);
>  		ceph_fscache_readpage_cancel(inode, page);
>  		goto out;
> -	} else {
> -		if (err < PAGE_CACHE_SIZE) {
> -		/* zero fill remainder of page */
> -			zero_user_segment(page, err, PAGE_CACHE_SIZE);
> -		} else {
> -			flush_dcache_page(page);
> -		}
>  	}
> -	SetPageUptodate(page);
> +	if (err < PAGE_CACHE_SIZE)
> +		/* zero fill remainder of page */
> +		zero_user_segment(page, err, PAGE_CACHE_SIZE);
> +	else
> +		flush_dcache_page(page);
> 
> -	if (err >= 0)
> -		ceph_readpage_to_fscache(inode, page);
> +	SetPageUptodate(page);
> +	ceph_readpage_to_fscache(inode, page);
> 
>  out:
>  	return err < 0 ? err : 0;
> 

