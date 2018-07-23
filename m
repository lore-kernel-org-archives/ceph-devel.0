From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] fs: ceph: Adding new return type vm_fault_t
Date: Mon, 23 Jul 2018 18:19:00 +0800
Message-ID: <AECDD239-E0F9-4887-ABDF-5DDAB21DF6C7@redhat.com>
References: <20180722121636.GA30907@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180722121636.GA30907@jordon-HP-15-Notebook-PC>
Sender: linux-kernel-owner@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: willy@infradead.org, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ajitn.linux@gmail.com, brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
List-Id: ceph-devel.vger.kernel.org



> On Jul 22, 2018, at 20:16, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> Use new return type vm_fault_t for page_mkwrite
> and fault handler.
> 
> vmf_error() is the newly introduce inline function
> in 4.17
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> fs/ceph/addr.c | 62 ++++++++++++++++++++++++++++++----------------------------
> 1 file changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b4336b4..3031d44 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1427,7 +1427,7 @@ static void ceph_restore_sigs(sigset_t *oldset)
> /*
>  * vm ops
>  */
> -static int ceph_filemap_fault(struct vm_fault *vmf)
> +static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
> {
> 	struct vm_area_struct *vma = vmf->vma;
> 	struct inode *inode = file_inode(vma->vm_file);
> @@ -1435,8 +1435,9 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 	struct ceph_file_info *fi = vma->vm_file->private_data;
> 	struct page *pinned_page = NULL;
> 	loff_t off = vmf->pgoff << PAGE_SHIFT;
> -	int want, got, ret;
> +	int want, got, err;
> 	sigset_t oldset;
> +	vm_fault_t ret;
> 
> 	ceph_block_sigs(&oldset);
> 
> @@ -1448,8 +1449,8 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 		want = CEPH_CAP_FILE_CACHE;
> 
> 	got = 0;
> -	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
> -	if (ret < 0)
> +	err = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
> +	if (err < 0)
> 		goto out_restore;
> 
> 	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
> @@ -1461,16 +1462,17 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 		ceph_add_rw_context(fi, &rw_ctx);
> 		ret = filemap_fault(vmf);
> 		ceph_del_rw_context(fi, &rw_ctx);
> +		dout("filemap_fault %p %llu~%zd drop cap refs %s ret %x\n",
> +			inode, off, (size_t)PAGE_SIZE,
> +				ceph_cap_string(got), ret);
> 	} else
> -		ret = -EAGAIN;
> +		err = -EAGAIN;
> 
> -	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
> -	     inode, off, (size_t)PAGE_SIZE, ceph_cap_string(got), ret);
> 	if (pinned_page)
> 		put_page(pinned_page);
> 	ceph_put_cap_refs(ci, got);
> 
> -	if (ret != -EAGAIN)
> +	if (err != -EAGAIN)
> 		goto out_restore;
> 
> 	/* read inline data */
> @@ -1478,7 +1480,6 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 		/* does not support inline data > PAGE_SIZE */
> 		ret = VM_FAULT_SIGBUS;
> 	} else {
> -		int ret1;
> 		struct address_space *mapping = inode->i_mapping;
> 		struct page *page = find_or_create_page(mapping, 0,
> 						mapping_gfp_constraint(mapping,
> @@ -1487,32 +1488,32 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 			ret = VM_FAULT_OOM;
> 			goto out_inline;
> 		}
> -		ret1 = __ceph_do_getattr(inode, page,
> +		err = __ceph_do_getattr(inode, page,
> 					 CEPH_STAT_CAP_INLINE_DATA, true);
> -		if (ret1 < 0 || off >= i_size_read(inode)) {
> +		if (err < 0 || off >= i_size_read(inode)) {
> 			unlock_page(page);
> 			put_page(page);
> -			if (ret1 < 0)
> -				ret = ret1;
> +			if (err == -ENOMEM)
> +				ret = VM_FAULT_OOM;
> 			else
> 				ret = VM_FAULT_SIGBUS;
> 			goto out_inline;
> 		}
> -		if (ret1 < PAGE_SIZE)
> -			zero_user_segment(page, ret1, PAGE_SIZE);
> +		if (err < PAGE_SIZE)
> +			zero_user_segment(page, err, PAGE_SIZE);
> 		else
> 			flush_dcache_page(page);
> 		SetPageUptodate(page);
> 		vmf->page = page;
> 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
> out_inline:
> -		dout("filemap_fault %p %llu~%zd read inline data ret %d\n",
> +		dout("filemap_fault %p %llu~%zd read inline data ret %x\n",
> 		     inode, off, (size_t)PAGE_SIZE, ret);
> 	}
> out_restore:
> 	ceph_restore_sigs(&oldset);
> -	if (ret < 0)
> -		ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +	if (err < 0)
> +		ret = vmf_error(err);
> 
> 	return ret;
> }
> @@ -1520,7 +1521,7 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> /*
>  * Reuse write_begin here for simplicity.
>  */
> -static int ceph_page_mkwrite(struct vm_fault *vmf)
> +static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
> {
> 	struct vm_area_struct *vma = vmf->vma;
> 	struct inode *inode = file_inode(vma->vm_file);
> @@ -1531,8 +1532,9 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 	loff_t off = page_offset(page);
> 	loff_t size = i_size_read(inode);
> 	size_t len;
> -	int want, got, ret;
> +	int want, got, err;
> 	sigset_t oldset;
> +	vm_fault_t ret;
> 
> 	prealloc_cf = ceph_alloc_cap_flush();
> 	if (!prealloc_cf)
> @@ -1546,10 +1548,10 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 			lock_page(page);
> 			locked_page = page;
> 		}
> -		ret = ceph_uninline_data(vma->vm_file, locked_page);
> +		err = ceph_uninline_data(vma->vm_file, locked_page);
> 		if (locked_page)
> 			unlock_page(locked_page);
> -		if (ret < 0)
> +		if (err < 0)
> 			goto out_free;
> 	}
> 
> @@ -1566,9 +1568,9 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 		want = CEPH_CAP_FILE_BUFFER;
> 
> 	got = 0;
> -	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
> +	err = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
> 			    &got, NULL);
> -	if (ret < 0)
> +	if (err < 0)
> 		goto out_free;
> 
> 	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
> @@ -1586,13 +1588,13 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 			break;
> 		}
> 
> -		ret = ceph_update_writeable_page(vma->vm_file, off, len, page);
> -		if (ret >= 0) {
> +		err = ceph_update_writeable_page(vma->vm_file, off, len, page);
> +		if (err >= 0) {
> 			/* success.  we'll keep the page locked. */
> 			set_page_dirty(page);
> 			ret = VM_FAULT_LOCKED;
> 		}
> -	} while (ret == -EAGAIN);
> +	} while (err == -EAGAIN);
> 
> 	if (ret == VM_FAULT_LOCKED ||
> 	    ci->i_inline_version != CEPH_INLINE_NONE) {
> @@ -1606,14 +1608,14 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 			__mark_inode_dirty(inode, dirty);
> 	}
> 
> -	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %d\n",
> +	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
> 	     inode, off, len, ceph_cap_string(got), ret);
> 	ceph_put_cap_refs(ci, got);
> out_free:
> 	ceph_restore_sigs(&oldset);
> 	ceph_free_cap_flush(prealloc_cf);
> -	if (ret < 0)
> -		ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +	if (err < 0)
> +		ret = vmf_error(err);
> 	return ret;
> }
> 

Applied, thanks

Yan, Zheng

> -- 
> 1.9.1
> 
