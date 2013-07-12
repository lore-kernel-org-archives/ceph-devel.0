From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Don't get layout from mds for regular file which
 has been written.
Date: Fri, 12 Jul 2013 14:06:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307121400470.25223@cobra.newdream.net>
References: <201307111659490192618@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57531 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965359Ab3GLVGg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 17:06:36 -0400
In-Reply-To: <201307111659490192618@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Jul 2013, majianpeng wrote:
> For regular file which has been written, it can't change layout.
> So it can get layout from local rather than mds.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/ioctl.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index e0b4ef3..2b74879 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -17,10 +17,16 @@
>  static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
>  {
>  	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
> +	struct inode *inode = file_inode(file);
>  	struct ceph_ioctl_layout l;
> -	int err;
> +	int err = 0;
> +
> +	/*For regular file which has been written,it can't change layout
> +	 * So it don't get layout from mds*/

style nit: space after /* and before */

> +	if (!(S_ISREG(inode->i_mode) && (i_size_read(inode) > 0 ||
> +		ci->i_truncate_seq > 1)))
> +		err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT);

I think a more defensive approach would be to use the helper to see if we 
are holding any of the Fcrwbl caps; if so, we can assume the layout is 
valid.

Note that we should be doing the same thing in getxattr when exposing the 
ceph.file.layout[.*] xattrs.. right now they are blindingly assuming that 
whatever is in cache is correct, which isn't strictly true.  :/

sage


> -	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT);
>  	if (!err) {
>  		l.stripe_unit = ceph_file_layout_su(ci->i_layout);
>  		l.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
> -- 
> 1.8.1.2
> 
