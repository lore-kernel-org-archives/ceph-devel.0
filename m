From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] ceph: simplify ceph_sync_write() page_align, calculation
Date: Sat, 16 Feb 2013 16:20:42 -0800
Message-ID: <5120225A.7050305@inktank.com>
References: <511FBCD4.5040709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:52301 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111Ab3BQAUs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 19:20:48 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so1914133dam.4
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 16:20:47 -0800 (PST)
In-Reply-To: <511FBCD4.5040709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/16/2013 09:07 AM, Alex Elder wrote:
> In ceph_sync_write() there is some magic that computes page_align
> for an osd request.  But a little analysis shows it can be
> simplified.
>
> First, we have:
>   	io_align = pos & ~PAGE_MASK;
> which is used here:
> 	page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
>
> Note (pos - io_align) simply rounds "pos" down to the nearest multiple
> of the page size.
>
> We also have:
>   	buf_align = (unsigned long)data & ~PAGE_MASK;
>
> Adding buf_align to that rounded-down "pos" value will stay within
> the same page; the result will just be offset by the page offset for
> the "data" pointer.  The final mask therefore leaves just the value
> of "buf_align".
>
> The same simplification can be done in striped_read().
>
> One more simplification.  Note that the result of calc_pages_for()
> is invariant of which page the offset starts in--the only thing that
> matters is the offset within the starting page.  We will have
> put the proper page offset to use into "page_align", so just use
> that in calculating num_pages.
>
> This resolves:
>      http://tracker.ceph.com/issues/4166
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   fs/ceph/file.c |   18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 9c4325e..6123ad4 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -331,10 +331,7 @@ static int striped_read(struct inode *inode,
>   	io_align = off & ~PAGE_MASK;
>
>   more:
> -	if (o_direct)
> -		page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
> -	else
> -		page_align = pos & ~PAGE_MASK;
> +	page_align = o_direct ? buf_align : io_align;
>   	this_len = left;
>   	ret = ceph_osdc_readpages(&fsc->client->osdc, ceph_vino(inode),
>   				  &ci->i_layout, pos, &this_len,
> @@ -526,15 +523,10 @@ more:
>   	io_align = pos & ~PAGE_MASK;
>   	buf_align = (unsigned long)data & ~PAGE_MASK;
>   	len = left;
> -	if (file->f_flags & O_DIRECT) {
> -		/* write from beginning of first page, regardless of
> -		   io alignment */
> -		page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
> -		num_pages = calc_pages_for((unsigned long)data, len);
> -	} else {
> -		page_align = pos & ~PAGE_MASK;
> -		num_pages = calc_pages_for(pos, len);
> -	}
> +
> +	/* write from beginning of first page, regardless of io alignment */
> +	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
> +	num_pages = calc_pages_for(page_align, len);
>   	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
>   				    ceph_vino(inode), pos, &len,
>   				    CEPH_OSD_OP_WRITE, flags,
>

