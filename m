From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph/iov_iter: fix bad iov_iter handling in ceph splice
 codepaths
Date: Mon, 09 Jan 2017 18:11:50 -0500
Message-ID: <1484003510.2609.32.camel@redhat.com>
References: <1483727016-343-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483727016-343-1-git-send-email-jlayton@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
List-Id: ceph-devel.vger.kernel.org

On Fri, 2017-01-06 at 13:23 -0500, Jeff Layton wrote:
> xfstest generic/095 triggers soft lockups in kcephfs. Basically it uses
> fio to drive some I/O via vmsplice ane splice. Ceph then ends trying to
> access an ITER_BVEC type iov_iter as a ITER_IOVEC one. That causes it to
> pick up a wrong offset and get stuck in an infinite loop while trying to
> populate the page array.
> 
> To fix this, add a new iov_iter helper for to determine the offset into
> the page for the current segment and have ceph call that.
> 
> dio_get_pagev_size has similar problems, so fix that as well by adding a
> new helper function in lib/iov_iter.c that does what it does, but for
> all iov_iter types.
> 
> Since we're moving that into generic code, we can also utilize the
> iterate_all_kinds macro to handle this. That means that we need to
> rework the logic a bit since we can't advance to the next vector while
> checking the current one.
> 
> Link: http://tracker.ceph.com/issues/18130
> Cc: "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ceph/file.c      | 28 ++------------------
>  include/linux/uio.h |  2 ++
>  lib/iov_iter.c      | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index f633165f3fdc..0cd9fc68a04e 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -35,29 +35,6 @@
>   */
>  
>  /*
> - * Calculate the length sum of direct io vectors that can
> - * be combined into one page vector.
> - */
> -static size_t dio_get_pagev_size(const struct iov_iter *it)
> -{
> -    const struct iovec *iov = it->iov;
> -    const struct iovec *iovend = iov + it->nr_segs;
> -    size_t size;
> -
> -    size = iov->iov_len - it->iov_offset;
> -    /*
> -     * An iov can be page vectored when both the current tail
> -     * and the next base are page aligned.
> -     */
> -    while (PAGE_ALIGNED((iov->iov_base + iov->iov_len)) &&
> -           (++iov < iovend && PAGE_ALIGNED((iov->iov_base)))) {
> -        size += iov->iov_len;
> -    }
> -    dout("dio_get_pagevlen len = %zu\n", size);
> -    return size;
> -}
> -
> -/*
>   * Allocate a page vector based on (@it, @nbytes).
>   * The return value is the tuple describing a page vector,
>   * that is (@pages, @page_align, @num_pages).
> @@ -71,8 +48,7 @@ dio_get_pages_alloc(const struct iov_iter *it, size_t nbytes,
>  	struct page **pages;
>  	int ret = 0, idx, npages;
>  
> -	align = (unsigned long)(it->iov->iov_base + it->iov_offset) &
> -		(PAGE_SIZE - 1);
> +	align = iov_iter_single_seg_page_offset(it);
>  	npages = calc_pages_for(align, nbytes);
>  	pages = kmalloc(sizeof(*pages) * npages, GFP_KERNEL);
>  	if (!pages) {

Found the bug with the earlier patch, and will be sending an updated one
after some more testing.

That said, I would love to be able to just get rid of ceph's
dio_get_pages_alloc as well and just use iov_iter_get_pages_alloc
instead, but I don't think we can because the bio_vec iterator block
does this:

                /* can't be more than PAGE_SIZE */
                *start = v.bv_offset;
                *pages = p = get_pages_array(1);
                if (!p)
                        return -ENOMEM;
                get_page(*p = v.bv_page);
                return v.bv_len;

...so what happens here is that iter_file_splice_write creates an
ITER_BVEC iov_iter. Then any filesystem driver that uses
iov_iter_get_pages or iov_iter_get_pages_alloc can only get a single
page for each call. The ceph code works around this by calling
iov_iter_get_pages in a loop until it gets enough, but that's rather
nasty.

I bet this makes splice writing to an O_DIRECT file on NFS suck too...

Why _is_ ITER_BVEC limited to a single page there? I wonder if we could
consider lifting that limitation in some cases if it really is
necessary?

> @@ -927,7 +903,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>  	}
>  
>  	while (iov_iter_count(iter) > 0) {
> -		u64 size = dio_get_pagev_size(iter);
> +		u64 size = iov_iter_pvec_size(iter);
>  		size_t start = 0;
>  		ssize_t len;
> 
>  
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 6e22b544d039..46fdfff3d7d6 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -83,6 +83,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
>  void iov_iter_advance(struct iov_iter *i, size_t bytes);
>  int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
>  size_t iov_iter_single_seg_count(const struct iov_iter *i);
> +size_t iov_iter_single_seg_page_offset(const struct iov_iter *i);
>  size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
>  			 struct iov_iter *i);
>  size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
> @@ -93,6 +94,7 @@ size_t copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
>  size_t iov_iter_zero(size_t bytes, struct iov_iter *);
>  unsigned long iov_iter_alignment(const struct iov_iter *i);
>  unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
> +size_t iov_iter_pvec_size(const struct iov_iter *i);
>  void iov_iter_init(struct iov_iter *i, int direction, const struct iovec *iov,
>  			unsigned long nr_segs, size_t count);
>  void iov_iter_kvec(struct iov_iter *i, int direction, const struct kvec *kvec,
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 6b415b5a100d..d22850bbb1e9 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -745,6 +745,24 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_single_seg_count);
>  
> +/* Return offset into page for current iov_iter segment */
> +size_t iov_iter_single_seg_page_offset(const struct iov_iter *i)
> +{
> +	size_t	base;
> +
> +	if (i->type & ITER_PIPE)
> +		base = i->pipe->bufs[i->idx].offset;
> +	else if (i->type & ITER_BVEC)
> +		base = i->bvec->bv_offset;
> +	else if (i->type & ITER_KVEC)
> +		base = (size_t)i->kvec->iov_base;
> +	else
> +		base = (size_t)i->iov->iov_base;
> +
> +	return (base + i->iov_offset) & (PAGE_SIZE - 1);
> +}
> +EXPORT_SYMBOL(iov_iter_single_seg_page_offset);
> +
>  void iov_iter_kvec(struct iov_iter *i, int direction,
>  			const struct kvec *kvec, unsigned long nr_segs,
>  			size_t count)
> @@ -830,6 +848,61 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_gap_alignment);
>  
> +/**
> + * iov_iter_pvec_size - find length of page aligned iovecs in iov_iter
> + * @i: iov_iter to in which to find the size
> + *
> + * Some filesystems can stitch together multiple iovecs into a single
> + * page vector when both the previous tail and current base are page
> + * aligned. This function discovers the length that can fit in a single
> + * pagevec and returns it.
> + */
> +size_t iov_iter_pvec_size(const struct iov_iter *i)
> +{
> +	size_t size = i->count;
> +	size_t pv_size = 0;
> +	bool contig = false, first = true;
> +
> +	if (!size)
> +		return 0;
> +
> +	/* Pipes are naturally aligned for this */
> +	if (unlikely(i->type & ITER_PIPE))
> +		return size;
> +
> +	/*
> +	 * An iov can be page vectored when the current base and previous
> +	 * tail are both page aligned. Note that we don't require that the
> +	 * initial base in the first iovec also be page aligned.
> +	 */
> +	iterate_all_kinds(i, size, v,
> +		({
> +		 if (first || (contig && PAGE_ALIGNED(v.iov_base))) {
> +			pv_size += v.iov_len;
> +			first = false;
> +			contig = PAGE_ALIGNED(v.iov_base + v.iov_len);
> +		 }; 0;
> +		 }),
> +		({
> +		 if (first || (contig && v.bv_offset == 0)) {
> +			pv_size += v.bv_len;
> +			first = false;
> +			contig = PAGE_ALIGNED(v.bv_offset + v.bv_len);
> +		 }
> +		 }),
> +		({
> +		 if (first || (contig && PAGE_ALIGNED(v.iov_base))) {
> +			pv_size += v.iov_len;
> +			first = false;
> +			contig = PAGE_ALIGNED(v.iov_base + v.iov_len);
> +		 }
> +		 }))
> +
> +	pv_size -= i->iov_offset;

The bug in this patch is the above. iterate_all_kinds will have already
accounted for the iov_offset, so there's no need to do this here (and it
throws off the calculation when you have to go around more than once).

> +	return pv_size;
> +}
> +EXPORT_SYMBOL(iov_iter_pvec_size);
> +
>  static inline size_t __pipe_get_pages(struct iov_iter *i,
>  				size_t maxsize,
>  				struct page **pages,

-- 
Jeff Layton <jlayton@redhat.com>
