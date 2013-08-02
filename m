From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: fix bugs about handling short-read for sync read
 mode.
Date: Fri, 2 Aug 2013 13:16:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308021316010.1128@cobra.newdream.net>
References: <201308020907510158900@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49825 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3HBUQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 16:16:52 -0400
In-Reply-To: <201308020907510158900@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: "zheng.z.yan" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

BTW, I was going to add this to the testing branch but it doesn't apply to 
the current tree.  Can you rebase on top of ceph-client.git #testing?

Thanks!
sage


On Fri, 2 Aug 2013, majianpeng wrote:

> cephfs . show_layout
> >layyout.data_pool:     0
> >layout.object_size:   4194304
> >layout.stripe_unit:   4194304
> >layout.stripe_count:  1
> 
> TestA:
> >dd if=/dev/urandom of=test bs=1M count=2 oflag=direct
> >dd if=/dev/urandom of=test bs=1M count=2 seek=4  oflag=direct
> >dd if=test of=/dev/null bs=6M count=1 iflag=direct
> The messages from func striped_read are:
> ceph:           file.c:350  : striped_read 0~6291456 (read 0) got 2097152 HITSTRIPE SHORT
> ceph:           file.c:350  : striped_read 2097152~4194304 (read 2097152) got 0 HITSTRIPE SHORT
> ceph:           file.c:381  : zero tail 4194304
> ceph:           file.c:390  : striped_read returns 6291456
> The hole of file is from 2M--4M.But actualy it zero the last 4M include
> the last 2M area which isn't a hole.
> Using this patch, the messages are:
> ceph:           file.c:350  : striped_read 0~6291456 (read 0) got 2097152 HITSTRIPE SHORT
> ceph:           file.c:358  :  zero gap 2097152 to 4194304
> ceph:           file.c:350  : striped_read 4194304~2097152 (read 4194304) got 2097152
> ceph:           file.c:384  : striped_read returns 6291456
> 
> TestB:
> >echo majianpeng > test
> >dd if=test of=/dev/null bs=2M count=1 iflag=direct
> The messages are:
> ceph:           file.c:350  : striped_read 0~6291456 (read 0) got 11 HITSTRIPE SHORT
> ceph:           file.c:350  : striped_read 11~6291445 (read 11) got 0 HITSTRIPE SHORT
> ceph:           file.c:390  : striped_read returns 11
> For this case,it did once more striped_read.It's no meaningless.
> Using this patch, the message are:
> ceph:           file.c:350  : striped_read 0~6291456 (read 0) got 11 HITSTRIPE SHORT
> ceph:           file.c:384  : striped_read returns 11
> 
> Big thanks to Yan Zheng for the patch.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/file.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..3d8d14d 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -349,44 +349,38 @@ more:
>  	dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
>  	     ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
>  
> -	if (ret > 0) {
> -		int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> -
> -		if (read < pos - off) {
> -			dout(" zero gap %llu to %llu\n", off + read, pos);
> -			ceph_zero_page_vector_range(page_align + read,
> -						    pos - off - read, pages);
> +	if (ret >= 0) {
> +		int  didpages;
> +		if (was_short && (pos + ret < inode->i_size)) {
> +			u64 tmp = min(this_len - ret,
> +				 inode->i_size - pos - ret);
> +			dout(" zero gap %llu to %llu\n",
> +				pos + ret, pos + ret + tmp);
> +			ceph_zero_page_vector_range(page_align + read + ret,
> +							tmp, pages);
> +			ret += tmp;
>  		}
> +
> +		didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>  		pos += ret;
>  		read = pos - off;
>  		left -= ret;
>  		page_pos += didpages;
>  		pages_left -= didpages;
>  
> -		/* hit stripe? */
> -		if (left && hit_stripe)
> +		/* hit stripe and need continue*/
> +		if (left && hit_stripe && pos < inode->i_size)
>  			goto more;
> +
>  	}
>  
> -	if (was_short) {
> +	if (ret >= 0) {
> +		ret = read;
>  		/* did we bounce off eof? */
>  		if (pos + left > inode->i_size)
>  			*checkeof = 1;
> -
> -		/* zero trailing bytes (inside i_size) */
> -		if (left > 0 && pos < inode->i_size) {
> -			if (pos + left > inode->i_size)
> -				left = inode->i_size - pos;
> -
> -			dout("zero tail %d\n", left);
> -			ceph_zero_page_vector_range(page_align + read, left,
> -						    pages);
> -			read += left;
> -		}
>  	}
>  
> -	if (ret >= 0)
> -		ret = read;
>  	dout("striped_read returns %d\n", ret);
>  	return ret;
>  }
> -- 
> 1.8.1.2
> 
> 
