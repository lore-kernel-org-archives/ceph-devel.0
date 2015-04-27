From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Hitting tcmalloc bug even with patch applied
Date: Mon, 27 Apr 2015 16:24:49 -0400
Message-ID: <553E9B11.8040906@adfin.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37585 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964912AbbD0UYw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 16:24:52 -0400
Received: by igblo3 with SMTP id lo3so3735177igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 13:24:51 -0700 (PDT)
In-Reply-To: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <somnath.roy@sandisk.com>



On 4/27/15 8:06 AM, Alexandre DERUMIER wrote:
> Hi,
> 
> I'm hitting the tcmalloc even with patch apply.
> It's mainly occur when I try to bench fio with a lot jobs (20 - 40 jobs)
> 
> Does It need to tuned something in osd environnement variable ?
> 
> 
> I double check it with
> 
> #g++ -o gperftest gperftest.c -ltcmalloc
> # export TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=67108864
> # ./gperftest 
> Tcmalloc OK! Internal and Env cache size are same:67108864
> 
> 
> perf top
> -------
>   10.04%  libtcmalloc.so.4.1.2  [.] tcmalloc::ThreadCache::ReleaseToCentralCache
>    8.19%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::FetchFromSpans
>    3.89%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::ReleaseToSpans
>    2.04%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::ReleaseListToSpans
>    1.79%  libtcmalloc.so.4.1.2  [.] operator new
>    1.25%  ceph-osd              [.] ConfFile::load_from_buffer
>    1.21%  libtcmalloc.so.4.1.2  [.] operator delete
>    1.14%  [kernel]              [k] _raw_spin_lock
>    1.08%  libstdc++.so.6.0.19   [.] std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string
>    1.04%  [kernel]              [k] __schedule
>    1.00%  libpthread-2.17.so    [.] pthread_mutex_trylock
>    0.90%  [kernel]              [k] native_write_msr_safe
>    0.89%  [kernel]              [k] __switch_to
>    0.79%  [kernel]              [k] _raw_spin_lock_irqsave
>    0.73%  [kernel]              [k] copy_user_enhanced_fast_string
> 

This is obviously going to be more painful but .... can you perform a capture for one OSD process using, pref record -p $OSD_PID. Ideally one with a callgraph and one without.

That can be helpful to investigate further. Can see which parts of those tcmalloc functions are the biggest offer in terms of time. We can also see if there's a new/delete pastern in OSD code that is somehow trigger this degenerate case.

> 
> 
> Regards,
> 
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
