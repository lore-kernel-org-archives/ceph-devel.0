From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [parch] ceph: cleanup types in striped_read()
Date: Tue, 23 Jul 2013 12:02:09 -0500
Message-ID: <51EEB711.3030506@linaro.org>
References: <20130723134801.GA15116@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:37018 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764Ab3GWRCK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jul 2013 13:02:10 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so10827544obc.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jul 2013 10:02:10 -0700 (PDT)
In-Reply-To: <20130723134801.GA15116@longonot.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 07/23/2013 08:48 AM, Dan Carpenter wrote:
> We pass in a u64 value for "len" and then immediately truncate away the
> upper 32 bits.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good.

Reviewed-by: Alex Elder <alex.elder@linaro.org>

> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..93e53c8 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -313,9 +313,9 @@ static int striped_read(struct inode *inode,
>  {
>  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> -	u64 pos, this_len;
> +	u64 pos, this_len, left;
>  	int io_align, page_align;
> -	int left, pages_left;
> +	int pages_left;
>  	int read;
>  	struct page **page_pos;
>  	int ret;
> @@ -346,7 +346,7 @@ more:
>  		ret = 0;
>  	hit_stripe = this_len < left;
>  	was_short = ret >= 0 && ret < this_len;
> -	dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
> +	dout("striped_read %llu~%llu (read %u) got %d%s%s\n", pos, left, read,
>  	     ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>  
>  	if (ret > 0) {
> @@ -378,7 +378,7 @@ more:
>  			if (pos + left > inode->i_size)
>  				left = inode->i_size - pos;
>  
> -			dout("zero tail %d\n", left);
> +			dout("zero tail %llu\n", left);
>  			ceph_zero_page_vector_range(page_align + read, left,
>  						    pages);
>  			read += left;
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

