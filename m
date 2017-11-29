From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: DBObjectMap::header_lock forcing filestore threads to be sequentail
Date: Wed, 29 Nov 2017 07:25:45 -0800
Message-ID: <CAJ4mKGb6TdZ4dzJs6AeBxGsp1asLSpFm8Q=i4ZHNy22kyGCOYg@mail.gmail.com>
References: <CAJACTueeM+yPph=1sA9YDEa_FB+7w7XObd8ZrzdU-qzvfiCPYA@mail.gmail.com>
 <CAJ4mKGaWZnm-cvTtXfPrteHnN0zAyHYyCfQ9vgL+-m1Kdo=EaA@mail.gmail.com>
 <CAJACTuf9i7d6Lbfgtqa_UYVGPZEU0jRdtucBo5jG-4ejjA6JXw@mail.gmail.com> <CAOi4hNfDWAYHYpZMNPbF_ngQ6j=DV0ich68mtRA5iMdTRfax7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:42365 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932958AbdK2PZr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 10:25:47 -0500
Received: by mail-io0-f176.google.com with SMTP id u42so4054756ioi.9
        for <ceph-devel@vger.kernel.org>; Wed, 29 Nov 2017 07:25:47 -0800 (PST)
In-Reply-To: <CAOi4hNfDWAYHYpZMNPbF_ngQ6j=DV0ich68mtRA5iMdTRfax7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yuxiang fang <abcdeffyx@gmail.com>
Cc: Xuehan Xu <xxhdx1985126@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 28, 2017 at 8:46 PM, yuxiang fang <abcdeffyx@gmail.com> wrote:
> Hi Xuehan
>
> Have a look at DBObjectMap::_lookup_map_header, it does things following:
>
> step 1. look up object header in memory cache, go step 2 if miss, or else return
> step 2. look up object header in leveldb, go step 3 if hit, or else
> return, that is code "db->get(HOBJECT_TO_SEQ, map_header_key(oid),
> &out);"
> step 3. add header to memory cache
>
> step 1 and step 3 is cpu intensive, and step 2 is I/O intensive.
>
> I think bottleneck is in step 2, you can watch cpu usage of filestore
> transaction apply threads to confirm it.
>
> So there are two solutions to improve it:
> 1. promote cache hit ratio, avoid to inject too much objects that have
> omap k/v, maybe you can use xattr.
> 2. speed up step 2, separate omap directory off osd directory and move
> leveldb to ssd by using filestore_omap_backend_path.

I think your diagnosis is correct, but I'd like to see some less
invasive methods for improving it.

I haven't spent much time looking at the code, but I think it ought to
be possible to set up a different consistency mechanism which drops
locks around IO while preventing concurrent access to the specific
header in question, right?

Oh, and I presume the runtime efficiency of finding the cache size is
not really an issue, but if it is that's easy to optimize away with a
counter...
-Greg

>
> thanks
> ivan from eisoo
>
>
> On Wed, Nov 29, 2017 at 11:11 AM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> Thanks, Greg and yuxiang:-)
>>
>> We used mdtest on 70 nodes issuing "file creations" to cephfs to test
>> the maximum file creations that a cephfs instance with only one active
>> mds can do. During the test, we found that, even after the test, there
>> are still a lot of I/Os on the data pool, and the osd is under heavy
>> presure, just as shown in the attachment "apply_latency" and
>> "op_queue_ops". This should be caused by storing files' backtraces.
>>
>> We also used gdbprof to probe the OSD, the result of which is in the
>> attachment "gdb.create.rocksdb.xfs.log". The result shows that the
>> major time of the execution of the OSD's filestore threads is spent on
>> waiting on the DBObjectMap::header_lock, and the only feasible actual
>> execution of filestore threads is adding the object header to
>> DBObjectMap::caches. Adding object headers would cause
>> DBObjectMap::caches to trim in which the cache's size has to computed
>> which is an O(N) operation in GNU STL list::size implementation. On
>> the other hand, adding object headers is protected by locking
>> "DBObjectMap::header_lock", and our configuration
>> "filestore_omap_header_cache_size" is 204800 which is very large and
>> would make the cache size computation take considerable time. So we
>> think it may be appropriate to move the adding object header operation
>> out of the locking field of  "DBObjectMap::header_lock", or maybe some
>> other mechanism of DBObjectMap::caches should be considered.
>>
>> Thanks:-)
>>
>> On 29 November 2017 at 06:59, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Tue, Nov 28, 2017 at 1:51 AM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>>> Hi, everone.
>>>>
>>>> Recently, we did some stress tests on mds. We found that, when doing
>>>> file creation test, the mdlog trim operations are very slow. After
>>>> doing some debugging, we found that this could be due to execution of
>>>> the OSD's filestore theads being forced to be nearly sequential. This
>>>> can be found out in our result of gdbprof probing, which is attached
>>>> with this email. In the gdbprof result, we can see that the most time
>>>> consuming work of the filestore threads is the sizing of
>>>> DBObjectMap::caches, and the reason of sequential execution of
>>>> filestore threads is the locking of DBObjectMap::header_lock.
>>>>
>>>> After reading the corresponding source code, we found that
>>>> MapHeaderLock is already doing the mutual exclusion of access of the
>>>> omap object header. It seems that the locking of
>>>> DBObjectMap::header_lock is not very necessary, or at least, it's not
>>>> needed when adding the header to DBObjectMap::caches, which would lead
>>>> to the sizing of the cache.
>>>>
>>>> Is this right?
>>>
>>> I'm a bit confused; can you explain exactly what you're testing and
>>> exactly what you're measuring that leads you to think the mutexes are
>>> overly expensive?
>>>
>>> Note that there's both a header_lock and a cache_lock; in a quick skim
>>> they don't seem to be in gratuitous use (unless there are some disk
>>> accesses hiding underneath the header_lock?) and the idea of them
>>> being a performance bottleneck has not come up before.
>>> -Greg
