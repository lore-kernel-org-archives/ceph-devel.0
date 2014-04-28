From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: delete unnecessary condition judgment
Date: Mon, 28 Apr 2014 09:16:47 -0500
Message-ID: <535E62CF.4030108@ieee.org>
References: <1398666300-28368-1-git-send-email-zhenzhang.zhang@huawei.com> <535DF4EF.8060703@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41281 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbaD1OQv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Apr 2014 10:16:51 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so822209pdj.10
        for <ceph-devel@vger.kernel.org>; Mon, 28 Apr 2014 07:16:50 -0700 (PDT)
In-Reply-To: <535DF4EF.8060703@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Zhen <zhenzhang.zhang@huawei.com>, sage@inktank.com, ukernel@gmail.com
Cc: ceph-devel@vger.kernel.org

On 04/28/2014 01:27 AM, Zhang Zhen wrote:
> If the return number of ceph_osdc_readpages() is not
> less than zero, it is certainly greater than or
> equal to zero.
>
> So the condition judgment is unnecessary.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
> ---
>   fs/ceph/addr.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b53278c..8f579d2 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -221,8 +221,7 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>   	}
>   	SetPageUptodate(page);
>
> -	if (err >= 0)
> -		ceph_readpage_to_fscache(inode, page);
> +	ceph_readpage_to_fscache(inode, page);
>
>   out:
>   	return err < 0 ? err : 0;
>

