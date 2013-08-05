From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/2] ceph: Add pg_name filed in struct
 ceph_ioctl_dataloc.
Date: Sun, 4 Aug 2013 21:24:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308042117030.5645@cobra.newdream.net>
References: <201308051051060248738@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40862 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3HEEYD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 00:24:03 -0400
In-Reply-To: <201308051051060248738@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 5 Aug 2013, majianpeng wrote:
> As the 'ceph help' print, it will print pgs.But now it can't.
> So we add this.There are two type name of pg, temp and stable.
> Because the command 'ceph pg dump' print temp name,so we also print the
> temp name of pg.

Unfortunately we can't modify the ioctl structure like this without 
breaking the kernel/userspace ABI (a big no-no).  The usual way around 
that is to make a new ioctl (like CEPH_IOC_GET_DATALOC2) and a new 
structure (struct ceph_ioctl_dataloc2) with the additional fields.

What is this going to be used for?  You can get the full info from the 
montior with the 'ceph osd map <pool name> <object name> --format=json'.  
Does it need to come from the kernel this way?

Assuming we do want to go down this path, I would change a few things:

> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/ioctl.c | 10 +++++++++-
>  fs/ceph/ioctl.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index e0b4ef3..1d0f24c 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -209,9 +209,17 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
>  	snprintf(dl.object_name, sizeof(dl.object_name), "%llx.%08llx",
>  		 ceph_ino(inode), dl.object_no);
>  
> +	r = ceph_calc_ceph_temp_pg(&pgid, dl.object_name, osdc->osdmap,
> +					ceph_file_layout_pg_pool(ci->i_layout));
> +	if (r < 0) {
> +		down_read(&osdc->map_sem);
> +		return r;
> +	}
> +	snprintf(dl.pg_name, sizeof(dl.pg_name), "%llx.%08x",
> +		 pgid.pool, pgid.seed);

The pg name formatting is "%lld.%x", if we want this to match with the pg 
names used throughout the rest of the code.  But it sounds like you're 
actually after the raw hash seed, though, in which case I would drop the 
string and instead do

> @@ -58,6 +58,7 @@ struct ceph_ioctl_dataloc {
>  	__u64 object_no;             /* out: object # */
>  	__u64 object_size;           /* out: object size */
>  	char object_name[64];        /* out: object name */
> +	char pg_name[32];	     /* out: pg name*/

	__u64 pg_raw_seed;           /* out: placement seed */
	__u64 pg_num;                /* out: pg number */
	__u64 pg_pool;               /* out: pool id */

so that you get the raw value (which e.g. goes in the request) as well as 
which pg that maps to and the pool id.

sage

>  	__u64 block_offset;          /* out: offset in block */
>  	__u64 block_size;            /* out: block length */
>  	__s64 osd;                   /* out: osd # */
> -- 
> 1.8.3.rc1.44.gb387c77
> 
> 
> Thanks!
> Jianpeng MaN????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
