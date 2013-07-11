From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Don't do set_layout for file which has been
 written.
Date: Thu, 11 Jul 2013 11:54:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307111154260.5149@cobra.newdream.net>
References: <201307111004467716774@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44300 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab3GKSyv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 14:54:51 -0400
In-Reply-To: <201307111004467716774@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Jul 2013, majianpeng wrote:
> Cephfs don't change the layout which has been written.So add this check
> before do.

This could conceivaably change in the future, and I'm not sure there is 
harm is the MDS round trip to get the error code here...?

sage

> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index e0b4ef3..cbea896 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -72,6 +72,9 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
>  	struct ceph_ioctl_layout nl;
>  	int err;
>  
> +	/*Only for file which has never been written*/
> +	if (i_size_read(inode) > 0 || ci->i_truncate_seq > 1)
> +		return -ENOTEMPTY;
>  	if (copy_from_user(&l, arg, sizeof(l)))
>  		return -EFAULT;
>  
> -- 
> 1.8.1.2
> N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
