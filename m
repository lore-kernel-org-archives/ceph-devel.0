From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Don't forget the 'up_read(&osdc->map_sem)' if met
 error.
Date: Tue, 16 Jul 2013 17:44:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307161743570.21178@cobra.newdream.net>
References: <201307161936127882610@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45859 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab3GQAoB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 20:44:01 -0400
In-Reply-To: <201307161936127882610@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Applied, thanks!

sage

On Tue, 16 Jul 2013, majianpeng wrote:

> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/ioctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index e0b4ef3..a5ce62e 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -196,8 +196,10 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
>  	r = ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, len,
>  					  &dl.object_no, &dl.object_offset,
>  					  &olen);
> -	if (r < 0)
> +	if (r < 0) {
> +		up_read(&osdc->map_sem);
>  		return -EIO;
> +	}
>  	dl.file_offset -= dl.object_offset;
>  	dl.object_size = ceph_file_layout_object_size(ci->i_layout);
>  	dl.block_size = ceph_file_layout_su(ci->i_layout);
> -- 
> 1.8.1.2
