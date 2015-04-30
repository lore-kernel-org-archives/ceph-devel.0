From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Hitting tcmalloc bug even with patch applied
Date: Thu, 30 Apr 2015 14:15:04 +0800
Message-ID: <CACJqLya3b9wH9id8KVYf2Otpim6Y1mu+y9w3QAAuonPwrR1dnQ@mail.gmail.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv>
	<553E9B11.8040906@adfin.com>
	<553E9D02.70606@redhat.com>
	<9E914F5BD7F48A4782456CEB550A422824E76364@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANP1eJHo43HtxMJnyHu2GGGZt8bvMgAoU9qK4cpbXya0bM8hXQ@mail.gmail.com>
	<085BC98701B92B4C86AE7696562D284D18B9ABAC@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35081 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbbD3GPF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 02:15:05 -0400
Received: by pabtp1 with SMTP id tp1so50112560pab.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 23:15:04 -0700 (PDT)
In-Reply-To: <085BC98701B92B4C86AE7696562D284D18B9ABAC@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>
Cc: Milosz Tanski <milosz@adfin.com>, Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Mark Nelson <mnelson@redhat.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <Somnath.Roy@sandisk.com>

Hmm, I think we need to pay a lot attention to this problem especially
for fast storage device backend.

I think the way to solve this problem rely to ceph itself instead of
tcmalloc or jemalloc optimization.

I'm not sure the most consuming memory is used by which part,
frequently-used object like ObjectContext/OpTracker or buffers in
bufferlist. Could tcmalloc or jemalloc provide with malloc/free usage
statistic infos which contain callstack, so we may see the memory
bottleneck from it?

On the other hand, maybe ceph need to consider to do memory management
itself for the main or frequent memory users.

On Wed, Apr 29, 2015 at 2:04 AM, Vijayendra Shamanna
<Vijayendra.Shamanna@sandisk.com> wrote:
> Hi Milosz,
>
> The OSD op worker threads which handle requests are part of sharded thread pool. We observed that the distribution across these shards was a bit uneven. Most of the new/delete were originating from Index Manager code in the read path when we last checked.
>
> Thanks,
> Viju
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Milosz Tanski
> Sent: Tuesday, April 28, 2015 11:08 PM
> To: Chaitanya Huilgol
> Cc: Mark Nelson; Alexandre DERUMIER; ceph-devel; Somnath Roy
> Subject: Re: Hitting tcmalloc bug even with patch applied
>
> On Tue, Apr 28, 2015 at 9:58 AM, Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com> wrote:
>>
>> Hi,
>>
>> The default  cache size is 32M, the tcmalloc documentation is outdated.
>>  As Somnath mentioned, the tcmalloc fix is to make the env effective as without this fix the library does not use exported value of ' TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES'.
>> The degenerated case is hit less frequently with higher value of the cache size but we still do encounter the issue.
>> We are not very sure of what is leading to this, the hypothesis so far
>> is
>> - Change in OSDs mem allocation profile causing the tcmalloc to bring
>> different size segments to the thread cache
>> - Change in load on the shard threads (the distribution is uneven)
>> one less active threads due to I/O started on a different pool, this
>> may cause tcmalloc to move memory to these threads
>
> Actually reading this (older) documentation:
> http://gperftools.googlecode.com/svn/trunk/doc/tcmalloc.html#Sizing_Thread_Cache_Free_Lists
> It describes the problem of sizing the thread free list and potential problems. The asymmetric alloc/free, eg. cross thread alloc/free, in that case you're basically guaranteeing that you will see worst case behavior. In this case you don't benefit from thread cache but you pay the price for the thread cache (maintaing it / always freeing to the global pool). This would be common in a case you have different IO threads from network threads (IO allocates space, network thread sends it and frees it).
>
> Am I correct Chaitanya. That's what you're talking about in the second statement?
>
> That's why I was hoping Alexandre would we able to provide us with some callgraphs that indicate where these free/delete are originating from.
>
>>
>>
>> If you want to test with increased cache value, you can export this
>> value in the /etc/init/ceph-osd.conf upstart script
>>
>> Regards,
>> Chaitanya
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: 28 April 2015 02:03
>> To: Milosz Tanski; Alexandre DERUMIER; ceph-devel; Somnath Roy
>> Subject: Re: Hitting tcmalloc bug even with patch applied
>>
>>
>>
>> On 04/27/2015 03:24 PM, Milosz Tanski wrote:
>> >
>> >
>> > On 4/27/15 8:06 AM, Alexandre DERUMIER wrote:
>> >> Hi,
>> >>
>> >> I'm hitting the tcmalloc even with patch apply.
>> >> It's mainly occur when I try to bench fio with a lot jobs (20 - 40
>> >> jobs)
>> >>
>> >> Does It need to tuned something in osd environnement variable ?
>> >>
>> >>
>> >> I double check it with
>> >>
>> >> #g++ -o gperftest gperftest.c -ltcmalloc # export
>> >> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=67108864
>> >> # ./gperftest
>> >> Tcmalloc OK! Internal and Env cache size are same:67108864
>> >>
>> >>
>> >> perf top
>> >> -------
>> >>    10.04%  libtcmalloc.so.4.1.2  [.] tcmalloc::ThreadCache::ReleaseToCentralCache
>> >>     8.19%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::FetchFromSpans
>> >>     3.89%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::ReleaseToSpans
>> >>     2.04%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::ReleaseListToSpans
>> >>     1.79%  libtcmalloc.so.4.1.2  [.] operator new
>> >>     1.25%  ceph-osd              [.] ConfFile::load_from_buffer
>> >>     1.21%  libtcmalloc.so.4.1.2  [.] operator delete
>> >>     1.14%  [kernel]              [k] _raw_spin_lock
>> >>     1.08%  libstdc++.so.6.0.19   [.] std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string
>> >>     1.04%  [kernel]              [k] __schedule
>> >>     1.00%  libpthread-2.17.so    [.] pthread_mutex_trylock
>> >>     0.90%  [kernel]              [k] native_write_msr_safe
>> >>     0.89%  [kernel]              [k] __switch_to
>> >>     0.79%  [kernel]              [k] _raw_spin_lock_irqsave
>> >>     0.73%  [kernel]              [k] copy_user_enhanced_fast_string
>> >>
>> >
>> > This is obviously going to be more painful but .... can you perform a capture for one OSD process using, pref record -p $OSD_PID. Ideally one with a callgraph and one without.
>> >
>> > That can be helpful to investigate further. Can see which parts of those tcmalloc functions are the biggest offer in terms of time. We can also see if there's a new/delete pastern in OSD code that is somehow trigger this degenerate case.
>>
>> If on a newish (3.11+) kernel that has libunwind compiled into perf, I've found that dwarf callgraphs are much more detailed.  The frequency may need to be lowered to make it work well.  -F 100 or something perhaps.
>>
>> >
>> >>
>> >>
>> >> Regards,
>> >>
>> >> Alexandre
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> >> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > ceph-devel" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>
>
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
