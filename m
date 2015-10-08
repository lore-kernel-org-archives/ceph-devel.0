From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: a patch to improve cephfs direct io performance
Date: Thu, 8 Oct 2015 16:52:32 +0800
Message-ID: <CAAM7YAnxfrm0HMRhriwB7sYVxj2Pd=i_pZr6vo2W4qhUjwvMYA@mail.gmail.com>
References: <5604C4F7.10300@unissoft-nj.com>
	<CAAM7YAkeHOO+VR22B2NZWyhOvgNq=CqZJKJzE3Gi5GiRJgR2vg@mail.gmail.com>
	<560BAE17.2020002@unissoft-nj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33520 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbbJHIwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Oct 2015 04:52:34 -0400
Received: by lbos8 with SMTP id s8so38734339lbo.0
        for <ceph-devel@vger.kernel.org>; Thu, 08 Oct 2015 01:52:32 -0700 (PDT)
In-Reply-To: <560BAE17.2020002@unissoft-nj.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zhucaifeng <zhucaifeng@unissoft-nj.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 30, 2015 at 5:40 PM, zhucaifeng <zhucaifeng@unissoft-nj.com> wrote:
> Hi, Yan
>
> iov_iter APIs seems unsuitable for the direct io manipulation below.
> iov_iter APIs
> hide how to iterate over elements, whileas dio_xxx below explicitly control
> over
> the iteration. They conflict with each other in the principle.
>
> The patch for the newest kernel branch is below.
>
> Best Regards
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8b79d87..3938ac9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
>
> @@ -34,6 +34,115 @@
>   * need to wait for MDS acknowledgement.
>   */
>
> +/*
> + * Calculate the length sum of direct io vectors that can
> + * be combined into one page vector.
> + */
> +static int
> +dio_get_pagevlen(const struct iov_iter *it)
> +{
> +    const struct iovec *iov = it->iov;
> +    const struct iovec *iovend = iov + it->nr_segs;
> +    int pagevlen;
> +
> +    pagevlen = iov->iov_len - it->iov_offset;
> +    /*
> +     * An iov can be page vectored when both the current tail
> +     * and the next base are page aligned.
> +     */
> +    while (PAGE_ALIGNED((iov->iov_base + iov->iov_len)) &&
> +           (++iov < iovend && PAGE_ALIGNED((iov->iov_base)))) {
> +        pagevlen += iov->iov_len;
> +    }
> +    dout("dio_get_pagevlen len = %d\n", pagevlen);
> +    return pagevlen;
> +}
> +
> +/*
> + * Grab @num_pages from the process vm space. These pages are
> + * continuous and start from @data.
> + */
> +static int
> +dio_grab_pages(const void *data, int num_pages, bool write_page,
> +    struct page **pages)
> +{
> +    int got = 0;
> +    int rc = 0;
> +
> +    down_read(&current->mm->mmap_sem);
> +    while (got < num_pages) {
> +        rc = get_user_pages(current, current->mm,
> +            (unsigned long)data + ((unsigned long)got * PAGE_SIZE),
> +            num_pages - got, write_page, 0, pages + got, NULL);
> +        if (rc < 0)
> +            break;
> +        BUG_ON(rc == 0);
> +        got += rc;
> +    }
> +    up_read(&current->mm->mmap_sem);
> +    return got;
> +}
> +
> +static void
> +dio_free_pagev(struct page **pages, int num_pages, bool dirty)
> +{
> +    int i;
> +
> +    for (i = 0; i < num_pages; i++) {
> +        if (dirty)
> +            set_page_dirty_lock(pages[i]);
> +        put_page(pages[i]);
> +    }
> +    kfree(pages);
> +}
> +
> +/*
> + * Allocate a page vector based on (@it, @pagevlen).
> + * The return value is the tuple describing a page vector,
> + * that is (@pages, @pagevlen, @page_align, @num_pages).
> + */
> +static struct page **
> +dio_alloc_pagev(const struct iov_iter *it, int pagevlen, bool write_page,
> +    size_t *page_align, int *num_pages)
> +{
> +    const struct iovec *iov = it->iov;
> +    struct page **pages;
> +    int n, m, k, npages;
> +    int align;
> +    int len;
> +    void *data;
> +
> +    data = iov->iov_base + it->iov_offset;
> +    len = iov->iov_len - it->iov_offset;
> +    align = ((ulong)data) & ~PAGE_MASK;
> +    npages = calc_pages_for((ulong)data, pagevlen);
> +    pages = kmalloc(sizeof(*pages) * npages, GFP_NOFS);
> +    if (!pages)
> +        return ERR_PTR(-ENOMEM);
> +    for (n = 0; n < npages; n += m) {
> +        m = calc_pages_for((ulong)data, len);
> +        if (n + m > npages)
> +            m = npages - n;
> +        k = dio_grab_pages(data, m, write_page, pages + n);
> +        if (k < m) {
> +            n += k;
> +            goto failed;
> +        }
> +
> +        iov++;
> +        data = iov->iov_base;
> +        len = iov->iov_len;
> +    }
> +    *num_pages = npages;
> +    *page_align = align;
> +    dout("dio_alloc_pagev: alloc pages pages[0:%d], page align %d\n",
> +        npages, align);
> +    return pages;
> +
> +failed:
> +    dio_free_pagev(pages, n, false);
> +    return ERR_PTR(-ENOMEM);
> +}
>
>  /*
>   * Prepare an open request.  Preallocate ceph_cap to avoid an
> @@ -462,17 +571,17 @@ static ssize_t ceph_sync_read(struct kiocb *iocb,
> struct iov_iter *i,
>              size_t start;
>              ssize_t n;
>
> -            n = iov_iter_get_pages_alloc(i, &pages, INT_MAX, &start);
> -            if (n < 0)
> -                return n;
> -
> -            num_pages = (n + start + PAGE_SIZE - 1) / PAGE_SIZE;
> +            n = dio_get_pagevlen(i);
> +            pages = dio_alloc_pagev(i, n, true, &start,
> +                &num_pages);
> +            if (IS_ERR(pages))
> +                return PTR_ERR(pages);
>
>              ret = striped_read(inode, off, n,
>                         pages, num_pages, checkeof,
>                         1, start);
>
> -            ceph_put_page_vector(pages, num_pages, true);
> +            dio_free_pagev(pages, num_pages, true);
>
>              if (ret <= 0)
>                  break;
> @@ -596,7 +705,7 @@ ceph_sync_direct_write(struct kiocb *iocb, struct
> iov_iter *from, loff_t pos,
>          CEPH_OSD_FLAG_WRITE;
>
>      while (iov_iter_count(from) > 0) {
> -        u64 len = iov_iter_single_seg_count(from);
> +        u64 len = dio_get_pagevlen(from);
>          size_t start;
>          ssize_t n;
>
> @@ -615,14 +724,15 @@ ceph_sync_direct_write(struct kiocb *iocb, struct
> iov_iter *from, loff_t pos,
>
>          osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC, 0);
>
> -        n = iov_iter_get_pages_alloc(from, &pages, len, &start);
> -        if (unlikely(n < 0)) {
> -            ret = n;
> +        n = len;
> +        pages = dio_alloc_pagev(from, len, false, &start,
> +            &num_pages);
> +        if (IS_ERR(pages)) {
>              ceph_osdc_put_request(req);
> +            ret = PTR_ERR(pages);
>              break;
>          }
>
> -        num_pages = (n + start + PAGE_SIZE - 1) / PAGE_SIZE;
>          /*
>           * throw out any page cache pages in this range. this
>           * may block.
> @@ -639,8 +749,7 @@ ceph_sync_direct_write(struct kiocb *iocb, struct
> iov_iter *from, loff_t pos,
>          if (!ret)
>              ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
>
> -        ceph_put_page_vector(pages, num_pages, false);
> -
> +        dio_free_pagev(pages, num_pages, false);
>          ceph_osdc_put_request(req);
>          if (ret)
>              break;
>
>

applied (with a few modification), thanks

Yan, Zheng
