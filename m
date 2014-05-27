From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Tue, 27 May 2014 12:32:37 -0400
Message-ID: <CANP1eJFV-4+moCm05Hf97yrA5TyDfdsrNhPP4=vH_01-AC-RdA@mail.gmail.com>
References: <CACJqLyb+D5n74OyjP4sRG2=G083GQ3BzEUt4i8iAdw6nEBfRJg@mail.gmail.com>
	<5383A410.6010002@profihost.ag>
	<CACJqLyZRY_Jd+6ED91UD1ibdaekC3cCj8ddtRDVHPqw2PTBrcA@mail.gmail.com>
	<53842B2C.10807@profihost.ag>
	<CACJqLyZ8E5xPfb97NNEF0mkZ+Kh-saThMWawkwHJoXe+mrDYHA@mail.gmail.com>
	<5384349A.7070608@profihost.ag>
	<CACJqLybezUtvB-W5b5PL3ujp-5jA_9Evhbh9efmrv97g3+e04w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:39463 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbaE0Qcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 May 2014 12:32:39 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so6647414lan.14
        for <ceph-devel@vger.kernel.org>; Tue, 27 May 2014 09:32:37 -0700 (PDT)
In-Reply-To: <CACJqLybezUtvB-W5b5PL3ujp-5jA_9Evhbh9efmrv97g3+e04w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If the locking on something the fdcache is scabbily bottleneck. Why
not test using a spinlock instead of a mutex. It may (or may not) be
an easy and cheap win esp. if the amount of work inside of the spin
lock (operating on the map and LRU) are pretty cheap operations.

Another fine option if this is a issue that comes up with multiple
data structures in Ceph is to look into the CDS project. They provide
a number of lock free and wait free data structures implemented in C++
that also happen to be portable to most operating systems (with
fallback and specials implementations for each).

Obviously non trivial to replace the current data structures with
different ones, but it's also easier then rolling your own. We've
started using CDS recently for other projects and in a C++ code base,
it's easier to use then liburcu and more portable (with windows
support).

The library is located here:
http://libcds.sourceforge.net/

Best,
- Milosz

On Tue, May 27, 2014 at 6:05 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Still not, I will try to push to master branch
>
> On Tue, May 27, 2014 at 2:45 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Am 27.05.2014 08:37, schrieb Haomai Wang:
>>> I'm not full sure the correctness of changes although it seemed ok to
>>> me. And I apply these changes to product env and no problems.
>>
>> Do you have a branch in your yuyuyu github account for this?
>>
>>> On Tue, May 27, 2014 at 2:05 PM, Stefan Priebe - Profihost AG
>>> <s.priebe@profihost.ag> wrote:
>>>> Am 27.05.2014 06:42, schrieb Haomai Wang:
>>>>> On Tue, May 27, 2014 at 4:29 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>>>>>> Hi Haomai,
>>>>>>
>>>>>> regarding the FDCache problems you're seeing. Isn't this branch interesting
>>>>>> for you? Have you ever tested it?
>>>>>>
>>>>>> http://lists.ceph.com/pipermail/ceph-commit-ceph.com/2014-January/007399.html
>>>>>>
>>>>>
>>>>> Yes, I noticed it. But my main job is improving performance on 0.67.5
>>>>> version. Before this branch, my improvement on this problem is avoid
>>>>> lfn_find in omap* methods with FileStore
>>>>> class.(https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg18505.html)
>>>>
>>>> Avoids mean just remove them? Are they not needed? Do you have a branch
>>>> for this?
>>>>
>>>>>> Greets,
>>>>>> Stefan
>>>>>>
>>>>>> Am 09.04.2014 12:05, schrieb Haomai Wang:
>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I would like to share some ideas about how to improve performance on
>>>>>>> ceph with SSD. Not much preciseness.
>>>>>>>
>>>>>>> Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).
>>>>>>> ceph version is 0.67.5(Dumping)
>>>>>>>
>>>>>>> At first, we find three bottleneck on filestore:
>>>>>>> 1. fdcache_lock(changed in Firely release)
>>>>>>> 2. lfn_find in omap_* methods
>>>>>>> 3. DBObjectMap header
>>>>>>>
>>>>>>> According to my understanding and the docs in
>>>>>>>
>>>>>>> ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/ObjectStore.h),
>>>>>>> I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully
>>>>>>> sure the correctness of this change, but it works well still now.
>>>>>>>
>>>>>>> DBObjectMap header patch is on the pull request queue and may be
>>>>>>> merged in the next feature merge window.
>>>>>>>
>>>>>>> With things above done, we get much performance improvement in disk
>>>>>>> util and benchmark results(3x-4x).
>>>>>>>
>>>>>>> Next, we find fdcache size become the main bottleneck. For example, if
>>>>>>> hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If hot
>>>>>>> data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With
>>>>>>> increase "filestore_fd_cache_size", the cost of lookup(FDCache) and
>>>>>>> cache miss is expensive and can't be afford. The implementation of
>>>>>>> FDCache isn't O(1). So we only can get high performance on fdcache hit
>>>>>>> range(maybe 100GB with 10240 fdcache size) and more data exceed the
>>>>>>> size of fdcaceh will be disaster. If you want to cache more fd(102400
>>>>>>> fdcache size), the implementation of FDCache will bring on extra CPU
>>>>>>> cost(can't be ignore) for each op.
>>>>>>>
>>>>>>> Because of the capacity of SSD(several hundreds GB), we try to
>>>>>>> increase the size of rbd object(16MB) so less fd cache is needed. As
>>>>>>> for FDCache implementation, we simply discard SimpleLRU but introduce
>>>>>>> RandomCache. Now we can set much larger fdcache size(near cache all
>>>>>>> fd) with little overload.
>>>>>>>
>>>>>>> With these, we achieve 3x-4x performance improvements on filestore with
>>>>>>> SSD.
>>>>>>>
>>>>>>> Maybe it exists something I missed or something wrong, hope can
>>>>>>> correct me. I hope it can help to improve FileStore on SSD and push
>>>>>>> into master branch.
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
>
>
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
