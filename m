From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] ceph: fix direct-io on non-page-aligned buffers
Date: Wed, 15 Dec 2010 21:15:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012152111270.13669@cobra.newdream.net>
References: <1292474959-2834-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54702 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab0LPFJ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 00:09:59 -0500
In-Reply-To: <1292474959-2834-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>

On Wed, 15 Dec 2010, Sage Weil wrote:
> From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> 
> The user buffer may be 512-byte aligned, not page-aligned.  We were
> assuming the buffer was page-aligned and only accounting for
> non-page-aligned io offsets.
> 
> Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>

This is unchanged, except for some minor type changes (u64 to unsigned 
long).  Unfortunately I can't seem to find the test I was using for the 
other directio alignment bugs (which varied io but not buffer alignment).

Anyway, it's in the master branch.  If it looks okay I can send this to 
Linus for 2.6.37.

sage




> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  fs/ceph/file.c |   31 +++++++++++++++++++------------
>  1 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8d79b89..e860d8f 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -282,7 +282,8 @@ int ceph_release(struct inode *inode, struct file *file)
>  static int striped_read(struct inode *inode,
>  			u64 off, u64 len,
>  			struct page **pages, int num_pages,
> -			int *checkeof, bool align_to_pages)
> +			int *checkeof, bool align_to_pages,
> +			unsigned long buf_align)
>  {
>  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> @@ -307,7 +308,7 @@ static int striped_read(struct inode *inode,
>  
>  more:
>  	if (align_to_pages)
> -		page_align = (pos - io_align) & ~PAGE_MASK;
> +		page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
>  	else
>  		page_align = pos & ~PAGE_MASK;
>  	this_len = left;
> @@ -376,16 +377,18 @@ static ssize_t ceph_sync_read(struct file *file, char __user *data,
>  	struct inode *inode = file->f_dentry->d_inode;
>  	struct page **pages;
>  	u64 off = *poff;
> -	int num_pages = calc_pages_for(off, len);
> -	int ret;
> +	int num_pages, ret;
>  
>  	dout("sync_read on file %p %llu~%u %s\n", file, off, len,
>  	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
>  
> -	if (file->f_flags & O_DIRECT)
> +	if (file->f_flags & O_DIRECT) {
> +		num_pages = calc_pages_for((unsigned long)data, len);
>  		pages = ceph_get_direct_page_vector(data, num_pages);
> -	else
> +	} else {
> +		num_pages = calc_pages_for(off, len);
>  		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> +	}
>  	if (IS_ERR(pages))
>  		return PTR_ERR(pages);
>  
> @@ -400,7 +403,8 @@ static ssize_t ceph_sync_read(struct file *file, char __user *data,
>  		goto done;
>  
>  	ret = striped_read(inode, off, len, pages, num_pages, checkeof,
> -			   file->f_flags & O_DIRECT);
> +			   file->f_flags & O_DIRECT,
> +			   (unsigned long)data & ~PAGE_MASK);
>  
>  	if (ret >= 0 && (file->f_flags & O_DIRECT) == 0)
>  		ret = ceph_copy_page_vector_to_user(pages, data, off, ret);
> @@ -456,6 +460,7 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>  	int do_sync = 0;
>  	int check_caps = 0;
>  	int page_align, io_align;
> +	unsigned long buf_align;
>  	int ret;
>  	struct timespec mtime = CURRENT_TIME;
>  
> @@ -471,6 +476,7 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>  		pos = *offset;
>  
>  	io_align = pos & ~PAGE_MASK;
> +	buf_align = (unsigned long)data & ~PAGE_MASK;
>  
>  	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + left);
>  	if (ret < 0)
> @@ -496,12 +502,15 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>  	 */
>  more:
>  	len = left;
> -	if (file->f_flags & O_DIRECT)
> +	if (file->f_flags & O_DIRECT) {
>  		/* write from beginning of first page, regardless of
>  		   io alignment */
> -		page_align = (pos - io_align) & ~PAGE_MASK;
> -	else
> +		page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
> +		num_pages = calc_pages_for((unsigned long)data, len);
> +	} else {
>  		page_align = pos & ~PAGE_MASK;
> +		num_pages = calc_pages_for(pos, len);
> +	}
>  	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
>  				    ceph_vino(inode), pos, &len,
>  				    CEPH_OSD_OP_WRITE, flags,
> @@ -512,8 +521,6 @@ more:
>  	if (!req)
>  		return -ENOMEM;
>  
> -	num_pages = calc_pages_for(pos, len);
> -
>  	if (file->f_flags & O_DIRECT) {
>  		pages = ceph_get_direct_page_vector(data, num_pages);
>  		if (IS_ERR(pages)) {
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
