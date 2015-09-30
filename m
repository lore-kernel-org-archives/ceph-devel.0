From: zhucaifeng <zhucaifeng@unissoft-nj.com>
Subject: Re: a patch to improve cephfs direct io performance
Date: Wed, 30 Sep 2015 22:45:55 +0800
Message-ID: <560BF5A3.7000507@unissoft-nj.com>
References: <5604C4F7.10300@unissoft-nj.com>
 <CAAM7YAkeHOO+VR22B2NZWyhOvgNq=CqZJKJzE3Gi5GiRJgR2vg@mail.gmail.com>
 <560BAE17.2020002@unissoft-nj.com>
 <CAAM7YAm+n-XmKXc0BBnp4gyBiJt39u3Ku5sfxVvfs=3a3D9-YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbgau1.qq.com ([54.206.16.166]:42921 "EHLO smtpbgau1.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbbI3OqB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Sep 2015 10:46:01 -0400
In-Reply-To: <CAAM7YAm+n-XmKXc0BBnp4gyBiJt39u3Ku5sfxVvfs=3a3D9-YQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Yan

dio_get_pagevlen() calculate the length sum of multiple iovs that can
be combined into one page vector. If needed, the length sum may be
shortened by ceph_osdc_new_request() in ceph_sync_direct_write().
Nevertheless, the number of pages, derived from the length sum,
may expand across multiple iovs.

However, according to my understanding, iov_iter_get_pages() can only get
pages for one iov a time. To get pages for next iovs, iov_iter_advance()
must be called before calling iov_iter_get_pages() again. But calling
iov_iter_advance() without actual data IO is obviously unacceptable.
That is my reason why iov_iter APIs are unfit for combining mutli iovs
into one page vector.

Best Regards


> On Wed, Sep 30, 2015 at 5:40 PM, zhucaifeng <zhucaifeng@unissoft-nj.com> wrote:
>> Hi, Yan
>>
>> iov_iter APIs seems unsuitable for the direct io manipulation below.
>> iov_iter APIs
>> hide how to iterate over elements, whileas dio_xxx below explicitly control
>> over
>> the iteration. They conflict with each other in the principle.
> why? I think it's easy to replace dio_alloc_pagev() by
> iov_iter_get_pages(). We just need to use dio_get_pagevlen() to
> calculate how many page to get each time.
>
> Regards
> Yan, Zheng
>
>> The patch for the newest kernel branch is below.
>>
>> Best Regards
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 8b79d87..3938ac9 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>>
>> @@ -34,6 +34,115 @@
>>    * need to wait for MDS acknowledgement.
>>    */
>>
>> +/*
>> + * Calculate the length sum of direct io vectors that can
>> + * be combined into one page vector.
>> + */
>> +static int
>> +dio_get_pagevlen(const struct iov_iter *it)
>> +{
>> +    const struct iovec *iov = it->iov;
>> +    const struct iovec *iovend = iov + it->nr_segs;
>> +    int pagevlen;
>> +
>> +    pagevlen = iov->iov_len - it->iov_offset;
>> +    /*
>> +     * An iov can be page vectored when both the current tail
>> +     * and the next base are page aligned.
>> +     */
>> +    while (PAGE_ALIGNED((iov->iov_base + iov->iov_len)) &&
>> +           (++iov < iovend && PAGE_ALIGNED((iov->iov_base)))) {
>> +        pagevlen += iov->iov_len;
>> +    }
>> +    dout("dio_get_pagevlen len = %d\n", pagevlen);
>> +    return pagevlen;
>> +}
>> +
>> +/*
>> + * Grab @num_pages from the process vm space. These pages are
>> + * continuous and start from @data.
>> + */
>> +static int
>> +dio_grab_pages(const void *data, int num_pages, bool write_page,
>> +    struct page **pages)
>> +{
>> +    int got = 0;
>> +    int rc = 0;
>> +
>> +    down_read(&current->mm->mmap_sem);
>> +    while (got < num_pages) {
>> +        rc = get_user_pages(current, current->mm,
>> +            (unsigned long)data + ((unsigned long)got * PAGE_SIZE),
>> +            num_pages - got, write_page, 0, pages + got, NULL);
>> +        if (rc < 0)
>> +            break;
>> +        BUG_ON(rc == 0);
>> +        got += rc;
>> +    }
>> +    up_read(&current->mm->mmap_sem);
>> +    return got;
>> +}
>> +
>> +static void
>> +dio_free_pagev(struct page **pages, int num_pages, bool dirty)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < num_pages; i++) {
>> +        if (dirty)
>> +            set_page_dirty_lock(pages[i]);
>> +        put_page(pages[i]);
>> +    }
>> +    kfree(pages);
>> +}
>> +
>> +/*
>> + * Allocate a page vector based on (@it, @pagevlen).
>> + * The return value is the tuple describing a page vector,
>> + * that is (@pages, @pagevlen, @page_align, @num_pages).
>> + */
>> +static struct page **
>> +dio_alloc_pagev(const struct iov_iter *it, int pagevlen, bool write_page,
>> +    size_t *page_align, int *num_pages)
>> +{
>> +    const struct iovec *iov = it->iov;
>> +    struct page **pages;
>> +    int n, m, k, npages;
>> +    int align;
>> +    int len;
>> +    void *data;
>> +
>> +    data = iov->iov_base + it->iov_offset;
>> +    len = iov->iov_len - it->iov_offset;
>> +    align = ((ulong)data) & ~PAGE_MASK;
>> +    npages = calc_pages_for((ulong)data, pagevlen);
>> +    pages = kmalloc(sizeof(*pages) * npages, GFP_NOFS);
>> +    if (!pages)
>> +        return ERR_PTR(-ENOMEM);
>> +    for (n = 0; n < npages; n += m) {
>> +        m = calc_pages_for((ulong)data, len);
>> +        if (n + m > npages)
>> +            m = npages - n;
>> +        k = dio_grab_pages(data, m, write_page, pages + n);
>> +        if (k < m) {
>> +            n += k;
>> +            goto failed;
>> +        }
>> +
>> +        iov++;
>> +        data = iov->iov_base;
>> +        len = iov->iov_len;
>> +    }
>> +    *num_pages = npages;
>> +    *page_align = align;
>> +    dout("dio_alloc_pagev: alloc pages pages[0:%d], page align %d\n",
>> +        npages, align);
>> +    return pages;
>> +
>> +failed:
>> +    dio_free_pagev(pages, n, false);
>> +    return ERR_PTR(-ENOMEM);
>> +}
>>
>>   /*
>>    * Prepare an open request.  Preallocate ceph_cap to avoid an
>> @@ -462,17 +571,17 @@ static ssize_t ceph_sync_read(struct kiocb *iocb,
>> struct iov_iter *i,
>>               size_t start;
>>               ssize_t n;
>>
>> -            n = iov_iter_get_pages_alloc(i, &pages, INT_MAX, &start);
>> -            if (n < 0)
>> -                return n;
>> -
>> -            num_pages = (n + start + PAGE_SIZE - 1) / PAGE_SIZE;
>> +            n = dio_get_pagevlen(i);
>> +            pages = dio_alloc_pagev(i, n, true, &start,
>> +                &num_pages);
>> +            if (IS_ERR(pages))
>> +                return PTR_ERR(pages);
>>
>>               ret = striped_read(inode, off, n,
>>                          pages, num_pages, checkeof,
>>                          1, start);
>>
>> -            ceph_put_page_vector(pages, num_pages, true);
>> +            dio_free_pagev(pages, num_pages, true);
>>
>>               if (ret <= 0)
>>                   break;
>> @@ -596,7 +705,7 @@ ceph_sync_direct_write(struct kiocb *iocb, struct
>> iov_iter *from, loff_t pos,
>>           CEPH_OSD_FLAG_WRITE;
>>
>>       while (iov_iter_count(from) > 0) {
>> -        u64 len = iov_iter_single_seg_count(from);
>> +        u64 len = dio_get_pagevlen(from);
>>           size_t start;
>>           ssize_t n;
>>
>> @@ -615,14 +724,15 @@ ceph_sync_direct_write(struct kiocb *iocb, struct
>> iov_iter *from, loff_t pos,
>>
>>           osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC, 0);
>>
>> -        n = iov_iter_get_pages_alloc(from, &pages, len, &start);
>> -        if (unlikely(n < 0)) {
>> -            ret = n;
>> +        n = len;
>> +        pages = dio_alloc_pagev(from, len, false, &start,
>> +            &num_pages);
>> +        if (IS_ERR(pages)) {
>>               ceph_osdc_put_request(req);
>> +            ret = PTR_ERR(pages);
>>               break;
>>           }
>>
>> -        num_pages = (n + start + PAGE_SIZE - 1) / PAGE_SIZE;
>>           /*
>>            * throw out any page cache pages in this range. this
>>            * may block.
>> @@ -639,8 +749,7 @@ ceph_sync_direct_write(struct kiocb *iocb, struct
>> iov_iter *from, loff_t pos,
>>           if (!ret)
>>               ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
>>
>> -        ceph_put_page_vector(pages, num_pages, false);
>> -
>> +        dio_free_pagev(pages, num_pages, false);
>>           ceph_osdc_put_request(req);
>>           if (ret)
>>               break;
>>
>>
>>
>>> Hi, zhucaifeng
>>>
>>> The patch generally looks good. But I think there is minor flaw, see
>>> my comment below. Besides, could you write a patch for the newest
>>> kernel (it's easier because there is iov_iter_get_pages() helper).
>>>
>>>
>>> On Fri, Sep 25, 2015 at 11:52 AM, zhucaifeng <zhucaifeng@unissoft-nj.com>
>>> wrote:
>>>> Hi, all
>>>>
>>>> When using cephfs, we find that cephfs direct io is very slow.
>>>> For example, installing Windows 7 takes more than 1 hour on a
>>>> virtual machine whose disk is a file in cephfs.
>>>>
>>>> The cause is that when doing direct io, both ceph_sync_direct_write
>>>> and ceph_sync_read iterate iov elements one by one, and send one
>>>> osd_op request for each iov that covers about 4K~8K bytes data. The
>>>> result is lots of small requests and replies shuttled among the kernel
>>>> client and OSDs.
>>>>
>>>> The fix tries to combine as many iovs as possible into one page vector,
>>>> and
>>>> then send one request for this page vector. In this way, small requests
>>>> and
>>>> replies are reduced; the OSD can serve a large read/write request one
>>>> time.
>>>>
>>>> We observe that the performance is improved by about 5~15 times,
>>>> dependent
>>>> on
>>>> different application workload.
>>>>
>>>> The fix is below. Some change notes are as follows:
>>>>       - function ceph_get_direct_page_vetor and ceph_put_page_vector
>>>>         are moved from net/ceph/pagevec.c to fs/ceph/file.c, and are
>>>>         renamed as dio_grab_pages and dio_free_pagev respectively.
>>>>
>>>>       - function dio_get_pagevlen and dio_alloc_pagev are newly
>>>> introduced.
>>>>
>>>>         dio_get_pagevlen is to calculate the page vector length in bytes
>>>>         from the io vectors. Except for the first and last one, an io
>>>> vector
>>>>         can be merged into a page vector iff its base and tail are page
>>>> aligned.
>>>>         for the first vector, only its tail should be page aligned; for
>>>> the
>>>> last
>>>>         vector, only its head should be page aligned.
>>>>
>>>>         dio_alloc_pagev allocates pages for each io vector and put these
>>>> pages
>>>>         together in one page pointer array.
>>>>
>>>> Best Regards!
>>>>
>>>> --- /home/linux-3.10.0-229.7.2.el7/fs/ceph/file.c    2015-05-16
>>>> 09:05:28.000000000 +0800
>>>> +++ ./fs/ceph/file.c    2015-09-17 10:43:44.798591846 +0800
>>>> @@ -34,6 +34,115 @@
>>>>     * need to wait for MDS acknowledgement.
>>>>     */
>>>>
>>>> +/*
>>>> + * Calculate the length sum of direct io vectors that can
>>>> + * be combined into one page vector.
>>>> + */
>>>> +static int
>>>> +dio_get_pagevlen(const struct iov_iter *it)
>>>> +{
>>>> +    const struct iovec *iov = it->iov;
>>>> +    const struct iovec *iovend = iov + it->nr_segs;
>>>> +    int pagevlen;
>>>> +
>>>> +    pagevlen = iov->iov_len - it->iov_offset;
>>>> +    /*
>>>> +     * An iov can be page vectored when both the current tail
>>>> +     * and the next base are page aligned.
>>>> +     */
>>>> +    while (PAGE_ALIGNED((iov->iov_base + iov->iov_len)) &&
>>>> +           (++iov < iovend && PAGE_ALIGNED((iov->iov_base)))) {
>>>> +        pagevlen += iov->iov_len;
>>>> +    }
>>>> +    dout("dio_get_pagevlen len = %d\n", pagevlen);
>>>> +    return pagevlen;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Grab @num_pages from the process vm space. These pages are
>>>> + * continuous and start from @data.
>>>> + */
>>>> +static int
>>>> +dio_grab_pages(const void *data, int num_pages, bool write_page,
>>>> +    struct page **pages)
>>>> +{
>>>> +    int got = 0;
>>>> +    int rc = 0;
>>>> +
>>>> +    down_read(&current->mm->mmap_sem);
>>>> +    while (got < num_pages) {
>>>> +        rc = get_user_pages(current, current->mm,
>>>> +            (unsigned long)data + ((unsigned long)got * PAGE_SIZE),
>>>> +            num_pages - got, write_page, 0, pages + got, NULL);
>>>> +        if (rc < 0)
>>>> +            break;
>>>> +        BUG_ON(rc == 0);
>>>> +        got += rc;
>>>> +    }
>>>> +    up_read(&current->mm->mmap_sem);
>>>> +    return got;
>>>> +}
>>>> +
>>>> +static void
>>>> +dio_free_pagev(struct page **pages, int num_pages, bool dirty)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < num_pages; i++) {
>>>> +        if (dirty)
>>>> +            set_page_dirty_lock(pages[i]);
>>>> +        put_page(pages[i]);
>>>> +    }
>>>> +    kfree(pages);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Allocate a page vector based on (@it, @pagevlen).
>>>> + * The return value is the tuple describing a page vector,
>>>> + * that is (@pages, @pagevlen, @page_align, @num_pages).
>>>> + */
>>>> +static struct page **
>>>> +dio_alloc_pagev(const struct iov_iter *it, int pagevlen, bool
>>>> write_page,
>>>> +    int *page_align, int *num_pages)
>>>> +{
>>>> +    const struct iovec *iov = it->iov;
>>>> +    struct page **pages;
>>>> +    int n, m, k, npages;
>>>> +    int align;
>>>> +    int len;
>>>> +    void *data;
>>>> +
>>>> +    data = iov->iov_base + it->iov_offset;
>>>> +    len = iov->iov_len - it->iov_offset;
>>>> +    align = ((ulong)data) & ~PAGE_MASK;
>>>> +    npages = calc_pages_for((ulong)data, pagevlen);
>>>> +    pages = kmalloc(sizeof(*pages) * npages, GFP_NOFS);
>>>> +    if (!pages)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +    for (n = 0; n < npages; n += m) {
>>>> +        m = calc_pages_for((ulong)data, len);
>>>> +        if (n + m > npages)
>>>> +            m = npages - n;
>>>> +        k = dio_grab_pages(data, m, write_page, pages + n);
>>>> +        if (k < m) {
>>>> +            n += k;
>>>> +            goto failed;
>>>> +        }
>>> if (align + len) is not page aligned, the loop should stop.
>>>
>>>> +
>>>> +        iov++;
>>>> +        data = iov->iov_base;
>>> if (unsigned long)data is not page aligned, the loop should stop
>>>
>>>
>>> Regards
>>> Yan, Zheng
>>>
>>>> +        len = iov->iov_len;
>>>> +    }
>>>> +    *num_pages = npages;
>>>> +    *page_align = align;
>>>> +    dout("dio_alloc_pagev: alloc pages pages[0:%d], page align %d\n",
>>>> +        npages, align);
>>>> +    return pages;
>>>> +
>>>> +failed:
>>>> +    dio_free_pagev(pages, n, false);
>>>> +    return ERR_PTR(-ENOMEM);
>>>> +}
>>>>
>>>>    /*
>>>>     * Prepare an open request.  Preallocate ceph_cap to avoid an
>>>> @@ -354,13 +463,14 @@ more:
>>>>        if (ret >= 0) {
>>>>            int didpages;
>>>>            if (was_short && (pos + ret < inode->i_size)) {
>>>> -            u64 tmp = min(this_len - ret,
>>>> +            u64 zlen = min(this_len - ret,
>>>>                        inode->i_size - pos - ret);
>>>> +            int zoff = (o_direct ? buf_align : io_align) +
>>>> +                   read + ret;
>>>>                dout(" zero gap %llu to %llu\n",
>>>> -                pos + ret, pos + ret + tmp);
>>>> -            ceph_zero_page_vector_range(page_align + read + ret,
>>>> -                            tmp, pages);
>>>> -            ret += tmp;
>>>> +                pos + ret, pos + ret + zlen);
>>>> +            ceph_zero_page_vector_range(zoff, zlen, pages);
>>>> +            ret += zlen;
>>>>            }
>>>>
>>>>            didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>>>> @@ -421,19 +531,19 @@ static ssize_t ceph_sync_read(struct kio
>>>>
>>>>        if (file->f_flags & O_DIRECT) {
>>>>            while (iov_iter_count(i)) {
>>>> -            void __user *data = i->iov[0].iov_base + i->iov_offset;
>>>> -            size_t len = i->iov[0].iov_len - i->iov_offset;
>>>> -
>>>> -            num_pages = calc_pages_for((unsigned long)data, len);
>>>> -            pages = ceph_get_direct_page_vector(data,
>>>> -                                num_pages, true);
>>>> +            int page_align;
>>>> +            size_t len;
>>>> +
>>>> +            len = dio_get_pagevlen(i);
>>>> +            pages = dio_alloc_pagev(i, len, true, &page_align,
>>>> +                &num_pages);
>>>>                if (IS_ERR(pages))
>>>>                    return PTR_ERR(pages);
>>>>
>>>>                ret = striped_read(inode, off, len,
>>>>                           pages, num_pages, checkeof,
>>>> -                       1, (unsigned long)data & ~PAGE_MASK);
>>>> -            ceph_put_page_vector(pages, num_pages, true);
>>>> +                       1, page_align);
>>>> +            dio_free_pagev(pages, num_pages, true);
>>>>
>>>>                if (ret <= 0)
>>>>                    break;
>>>> @@ -570,10 +680,7 @@ ceph_sync_direct_write(struct kiocb *ioc
>>>>        iov_iter_init(&i, iov, nr_segs, count, 0);
>>>>
>>>>        while (iov_iter_count(&i) > 0) {
>>>> -        void __user *data = i.iov->iov_base + i.iov_offset;
>>>> -        u64 len = i.iov->iov_len - i.iov_offset;
>>>> -
>>>> -        page_align = (unsigned long)data & ~PAGE_MASK;
>>>> +        u64 len = dio_get_pagevlen(&i);
>>>>
>>>>            snapc = ci->i_snap_realm->cached_context;
>>>>            vino = ceph_vino(inode);
>>>> @@ -589,8 +696,7 @@ ceph_sync_direct_write(struct kiocb *ioc
>>>>                break;
>>>>            }
>>>>
>>>> -        num_pages = calc_pages_for(page_align, len);
>>>> -        pages = ceph_get_direct_page_vector(data, num_pages, false);
>>>> +        pages = dio_alloc_pagev(&i, len, false, &page_align,
>>>> &num_pages);
>>>>            if (IS_ERR(pages)) {
>>>>                ret = PTR_ERR(pages);
>>>>                goto out;
>>>> @@ -612,7 +718,7 @@ ceph_sync_direct_write(struct kiocb *ioc
>>>>            if (!ret)
>>>>                ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
>>>>
>>>> -        ceph_put_page_vector(pages, num_pages, false);
>>>> +        dio_free_pagev(pages, num_pages, false);
>>>>
>>>>    out:
>>>>            ceph_osdc_put_request(req);
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>



