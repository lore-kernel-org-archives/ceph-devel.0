From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Use of C++17 memory_resource and mempools
Date: Mon, 15 Jan 2018 17:01:01 -0500
Message-ID: <5151a0e6-1781-388f-32db-d7a5e466b458@redhat.com>
References: <CA+2bHPbpW21ava_8Kz6xPTHjt9Ls54q49-LEr2ZayBanBdTJjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:44204 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeAOWBF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 17:01:05 -0500
Received: by mail-oi0-f42.google.com with SMTP id g128so9253869oib.11
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 14:01:04 -0800 (PST)
In-Reply-To: <CA+2bHPbpW21ava_8Kz6xPTHjt9Ls54q49-LEr2ZayBanBdTJjw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


On 01/15/2018 12:47 PM, Patrick Donnelly wrote:
> I've been going through the MDS cache objects moving referenced
> containers into the mempools to improve accuracy of cache size. This
> is being tracked in:
>
> http://tracker.ceph.com/issues/21402
>
> One issue I've found is that any method which takes a container
> argument needs special handling when the container we sometimes pass
> is part of the mempool. For example, CDir::_committed  [2] will need
> to copy the contents of the lists referenced in
> CDir::waiting_for_commit [3] in order to call MDSRank::queue_waiters
> [1]. This is because the types will no longer match:
>
> CDir.h:
>
> mempool::mds_co::compact_map<version_t,
> mempool::mds_co::list<MDSInternalContextBase*> > waiting_for_commit;
>
> (the list values would be passed to queue_waiters:)
>
> versus:
>
> MDSRank.h:
>
> void queue_waiters(list<MDSInternalContextBase*>& ls)
>
> Namely, we have
>
> std::list<MDSInternalContextBase*>
>
> and
>
> mempool::mds_co::list<MDSInternalContextBase*> aka
> std::list<MDSInternalContextBase*,
> mempool::mds_co::pool_allocator<MDSInternalContextBase*>>
>
> Apparently the new way to work around this problem where the templated
> allocator does not match is to embed the allocator in the object. This
> is done using the std::memory_resource [4] in C++17. So instead of:
>
> void queue_waiters(list<MDSInternalContextBase*>& ls)
>
> we would have:
>
> void queue_waiters(std::pmr::list<MDSInternalContextBase*>& ls)
>
> All of the callers of MDSRank::queue_waiters would also need updated
> to use either std::pmr::list or the MDSCacheObject's
> mempool::mds_co::list.
>
> Does anyone have any plans or opinions on using this with our mempool
> infrastructure? My understanding is that this is still experimental
> with the latest gcc, so this isn't something to be done today but may
> we should develop code with this in mind.
>
> [1] https://github.com/ceph/ceph/blob/aab2defacae9e0885e08b399f15b20c495b59d99/src/mds/MDSRank.h#L287
> [2] https://github.com/ceph/ceph/blob/aab2defacae9e0885e08b399f15b20c495b59d99/src/mds/CDir.cc#L2407
> [3] https://github.com/ceph/ceph/blob/aab2defacae9e0885e08b399f15b20c495b59d99/src/mds/CDir.h#L632
> [4] http://en.cppreference.com/w/cpp/memory/memory_resource
>

Hi Patrick,

I agree that polymorphic allocators sound perfect for this. That's 
unfortunate that it's not available in libstdc++ yet, according to 
https://gcc.gnu.org/onlinedocs/libstdc++/manual/status.html#table.cxx17_status. 
We should keep an eye on that.

Casey
