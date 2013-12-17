From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: check caps in filemap_fault and page_mkwrite
Date: Mon, 16 Dec 2013 21:21:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312162100490.1560@cobra.newdream.net>
References: <1387246022-21914-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41600 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3LQFVn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 00:21:43 -0500
In-Reply-To: <1387246022-21914-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, milosz@adfin.com

On Tue, 17 Dec 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Adds cap check to the page fault handler. The check prevents page
> fault handler from adding new page to the page cache while Fcb caps
> are being revoked. This solves Fc revoking hang in multiple clients
> mmap IO workload.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

Aside from the typo below, this looks good to me.

Reviewed-by: Sage Weil <sage@inktank.com>

> ---
>  fs/ceph/addr.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index ec3ba43..4212694 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1207,6 +1207,41 @@ const struct address_space_operations ceph_aops = {
>  /*
>   * vm ops
>   */
> +static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct ceph_file_info *fi = vma->vm_file->private_data;
> +	loff_t off = vmf->pgoff << PAGE_CACHE_SHIFT;
> +	int want, got, ret;
> +
> +	dout("filemap_fault %p %llx.%llx %llu~%zd trying to get caps\n",
> +	     inode, ceph_vinop(inode), off, PAGE_CACHE_SIZE);
> +	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> +		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
> +	else
> +		want = CEPH_CAP_FILE_CACHE;
> +	while (1) {
> +		got = 0;
> +		ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
> +		if (ret == 0)
> +			break;
> +		if (ret != -ERESTARTSYS) {
> +			WARN_ON(1);
> +			return VM_FAULT_SIGBUS;
> +		}
> +	}
> +	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
> +	     inode, off, PAGE_CACHE_SIZE, ceph_cap_string(got));
> +
> +	ret = filemap_fault(vma, vmf);
> +
> +	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
> +	     inode, off, PAGE_CACHE_SIZE, ceph_cap_string(got), ret);
> +	ceph_put_cap_refs(ci, got);
> +
> +	return ret;
> +}
>  
>  /*
>   * Reuse write_begin here for simplicity.
> @@ -1214,23 +1249,41 @@ const struct address_space_operations ceph_aops = {
>  static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
>  {
>  	struct inode *inode = file_inode(vma->vm_file);
> -	struct page *page = vmf->page;
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct ceph_file_info *fi = vma->vm_file->private_data;
>  	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
> +	struct page *page = vmf->page;
>  	loff_t off = page_offset(page);
> -	loff_t size, len;
> -	int ret;
> -
> -	/* Update time before taking page lock */
> -	file_update_time(vma->vm_file);
> +	loff_t size = i_size_read(inode);
> +	size_t len;
> +	int want, got, ret;
>  
> -	size = i_size_read(inode);
>  	if (off + PAGE_CACHE_SIZE <= size)
>  		len = PAGE_CACHE_SIZE;
>  	else
>  		len = size & ~PAGE_CACHE_MASK;
>  
> -	dout("page_mkwrite %p %llu~%llu page %p idx %lu\n", inode,
> -	     off, len, page, page->index);
> +	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
> +	     inode, ceph_vinop(inode), off, len, size);
> +	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> +		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> +	else
> +		want = CEPH_CAP_FILE_BUFFER;
> +	while (1) {
> +		got = 0;
> +		ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, off + len);
> +		if (ret == 0)
> +			break;
> +		if (ret != -ERESTARTSYS) {
> +			WARN_ON(1);
> +			return VM_FAULT_SIGBUS;
> +		}
> +	}
> +	dout("papge_mkwrite %p %llu~%zd got cap refs on %s\n",

page_mkwrite

> +	     inode, off, len, ceph_cap_string(got));
> +
> +	/* Update time before taking page lock */
> +	file_update_time(vma->vm_file);
>  
>  	lock_page(page);
>  
> @@ -1252,14 +1305,26 @@ static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
>  			ret = VM_FAULT_SIGBUS;
>  	}
>  out:
> -	dout("page_mkwrite %p %llu~%llu = %d\n", inode, off, len, ret);
> -	if (ret != VM_FAULT_LOCKED)
> +	if (ret != VM_FAULT_LOCKED) {
>  		unlock_page(page);
> +	} else {
> +		int dirty;
> +		spin_lock(&ci->i_ceph_lock);
> +		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
> +		spin_unlock(&ci->i_ceph_lock);
> +		if (dirty)
> +			__mark_inode_dirty(inode, dirty);
> +	}
> +
> +	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %d\n",
> +	     inode, off, len, ceph_cap_string(got), ret);
> +	ceph_put_cap_refs(ci, got);
> +
>  	return ret;
>  }
>  
>  static struct vm_operations_struct ceph_vmops = {
> -	.fault		= filemap_fault,
> +	.fault		= ceph_filemap_fault,
>  	.page_mkwrite	= ceph_page_mkwrite,
>  	.remap_pages	= generic_file_remap_pages,
>  };
> -- 
> 1.8.1.4
> 
> 
