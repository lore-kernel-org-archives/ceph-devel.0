From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: mem use doubles due to buffer::create_page_aligned + bluestore
 obj content caching
Date: Mon, 13 Mar 2017 17:06:42 +0300
Message-ID: <5d9e0423-0719-670d-ed26-6f0a33eb6073@mirantis.com>
References: <6b06369d-6b18-f4f0-b7ae-0c0114288e41@mirantis.com>
 <CAJ4mKGYnbTAXA16vsKkDoj8LaddtxDD7-yghqODsnBJ9qMz6_g@mail.gmail.com>
 <e746f38b-d870-49d3-7f37-722b03a01005@mirantis.com>
 <CAJ4mKGb0irpqukaEK4b7hufTfH-KJ4fp5260naKeQzHjnN4zNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34625 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdCMOGq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Mar 2017 10:06:46 -0400
Received: by mail-lf0-f47.google.com with SMTP id z15so42015518lfd.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Mar 2017 07:06:44 -0700 (PDT)
In-Reply-To: <CAJ4mKGb0irpqukaEK4b7hufTfH-KJ4fp5260naKeQzHjnN4zNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11.03.2017 0:24, Gregory Farnum wrote:
> On Mon, Mar 6, 2017 at 1:47 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> On 3/6/2017 9:44 PM, Gregory Farnum wrote:
>>> On Mon, Mar 6, 2017 at 9:35 AM, Igor Fedotov <ifedotov@mirantis.com>
>>> wrote:
>>>> Hi Cephers,
>>>>
>>>> I've just created a ticket related to bluestore object content caching in
>>>> particular and buffer::create_page_aligned in general.
>>>>
>>>> But I'd like to additionally share this information here as well since
>>>> the
>>>> root cause seems to be pretty global.
>>>>
>>>> Ticker URL:
>>>>
>>>> http://tracker.ceph.com/issues/19198
>>>>
>>>> Description:
>>>>
>>>> When caching object content BlueStore uses twice as much memory than it
>>>> really needs for that data amount.
>>>>
>>>> The root cause seems to be in buffer::create_page_aligned implementation.
>>>> Actually it results in
>>>> new raw_posix_aligned()
>>>>
>>>>     calling mempool::buffer_data::alloc_char.allocate_aligned(len, align);
>>>>
>>>>         calling  posix_memalign((void**)(void*)&ptr, align, total);
>>>>
>>>> sequence that in fact does 2 allocations:
>>>>
>>>> 1) for raw_posix_aligned struct
>>>> 2) for data itself (4096 bytes).
>>>>
>>>> It looks like this sequence causes 2 * 4096 bytes allocation instead of
>>>> sizeof(raw_posix_aligned) + alignment + 4096.
>>>> The additional trick is that mempool stuff is unable to estimate such an
>>>> overhead and hence BlueStore cache cleanup doesn't work properly.
>>>>
>>>> It's not clear for me why allocator(s) behave that inefficiently for such
>>>> a
>>>> pattern though.
>>>>
>>>> The issue is reproducible under Ubuntu 16.04.1 LTS for both jemalloc and
>>>> tcmalloc builds.
>>>>
>>>>
>>>> The ticket contains the patch to reproduce the issue and one can see that
>>>> for 16Gb content system mem usage tend to be ~32Gb.
>>>>
>>>> Patch firstly allocates 4K pages 0x400000 times using:
>>>>
>>>> ...
>>>>
>>>> +  size_t alloc_count = 0x400000; // allocate 16 Gb total
>>>> +  allocs.resize(alloc_count);
>>>> +  for( auto i = 0u; i < alloc_count; ++i) {
>>>> +    bufferptr p = buffer::create_page_aligned(bsize);
>>>> +    bufferlist* bl = new bufferlist;
>>>> +    bl->append(p);
>>>> +    *(bl->c_str()) = 0; // touch the page to increment system mem use
>>>>
>>>> ...
>>>>
>>>> then do the same reproducing  create_page_aligned() implementation:
>>>>
>>>> +  struct fake_raw_posix_aligned{
>>>> +    char stub[8];
>>>> +    void* data;
>>>> +    fake_raw_posix_aligned() {
>>>> +      ::posix_memalign(&data, 0x1000, 0x1000);
>>>> //mempool::buffer_data::alloc_char.allocate_aligned(0x1000, 0x1000);
>>>> +      *((char*)data) = 0; // touch the page
>>>> +    }
>>>> +    ~fake_raw_posix_aligned() {
>>>> +      ::free(data);
>>>> +    }
>>>> +  };
>>>> +  vector <fake_raw_posix_aligned*> allocs2;
>>>>
>>>> +  allocs2.resize(alloc_count);
>>>> +  for( auto i = 0u; i < alloc_count; ++i) {
>>>> +    allocs2[i] = new fake_raw_posix_aligned();
>>>> ...
>>>>
>>>> Output shows 32Gb usage in both cases.
>>>>
>>>> Mem before: VmRSS: 45232 kB
>>>> Mem after: VmRSS: 33599524 kB
>>>> Mem actually used: 33554292 kB
>>>> Mem pool reports: 16777216 kB
>>>> Mem before2: VmRSS: 2161412 kB
>>>> Mem after2: VmRSS: 33632268 kB
>>>> Mem actually used: 32226156544 bytes
>>>>
>>>>
>>>> In general there are two issues here:
>>>> 1) Doubled memory usage
>>>> 2) mempool is unaware of such an overhead and miscalculates the actual
>>>> mem
>>>> usage.
>>>>
>>>> There is probably a way to resolve 2) by forcing raw_combined::create()
>>>> use
>>>> in buffer::create_page_aligned and tuning mempool calculation to take
>>>> page
>>>> alignment into account. But I'd like to get some comments/thoughts
>>>> first....
>>> Is this memory being allocated and then freed, so it's "just" imposing
>>> extra work on malloc? Or are we leaking the old unaligned page as
>>> well?
>> I don't see any issues after free call. I'm mostly about unexpectedly high
>> memory usage while data block is allocated.
>> And mempool miscalculation related to that.
>> Surely this is more critical for long-living allocations, e.g. data blocks
>> in BlueStore cache.
> Yeah, that's what I meant by "leak", which I realize isn't quite the
> typical usage.
>
> Do you have any proposed patches or fixes to deal with it? :)
Just some thoughts, none of them seems ideal though...
1) Get rid of bluestore *content* cache. IMO object metadata caching is 
much more important and hence it's better to use memory for that. As a 
result no long-living aligned page allocations...
2) Do not use raw_posix_aligned in buffer::create_aligned and rollback 
to raw_combined::create(). For the latter mempool's mechanics can be 
fixed to measure alignment overhead properly and hence BlueStore cache 
will handle mem limits properly. Mem use for page aligned buffers is 
still ineffective though...

Thanks,
Igor
