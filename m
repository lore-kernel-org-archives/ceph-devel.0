From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Add check returned value on func
 ceph_calc_ceph_pg.
Date: Fri, 2 Aug 2013 13:12:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308021312350.1128@cobra.newdream.net>
References: <201308021814466765843@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49776 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3HBUMj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 16:12:39 -0400
In-Reply-To: <201308021814466765843@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Applied, thanks!

On Fri, 2 Aug 2013, majianpeng wrote:

> Func ceph_calc_ceph_pg maybe failed.So add check for returned value.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/ioctl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index e0b4ef3..8c463dd 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -209,8 +209,12 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
>  	snprintf(dl.object_name, sizeof(dl.object_name), "%llx.%08llx",
>  		 ceph_ino(inode), dl.object_no);
>  
> -	ceph_calc_ceph_pg(&pgid, dl.object_name, osdc->osdmap,
> -		ceph_file_layout_pg_pool(ci->i_layout));
> +	r = ceph_calc_ceph_pg(&pgid, dl.object_name, osdc->osdmap,
> +				ceph_file_layout_pg_pool(ci->i_layout));
> +	if (r < 0) {
> +		up_read(&osdc->map_sem);
> +		return r;
> +	}
>  
>  	dl.osd = ceph_calc_pg_primary(osdc->osdmap, pgid);
>  	if (dl.osd >= 0) {
> -- 
> 1.8.1.2
> 
> 
> Thanks!
> Jianpeng Ma
