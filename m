From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: wip-memstore and wip-objectstore
Date: Wed, 23 Jul 2014 11:32:52 +0800
Message-ID: <CACJqLybAdM10XTxtMBS_csvPQj8BYFKqtq62n+bNEL5vbkRp7Q@mail.gmail.com>
References: <alpine.DEB.2.00.1407220747400.15853@cobra.newdream.net>
	<alpine.DEB.2.00.1407220847170.15853@cobra.newdream.net>
	<CACJqLybMDnmD85jgdFxiBmH3cJ5seogBiwWMzeehWezVjujyDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:62658 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbaGWDcx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 23:32:53 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so522145wev.40
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 20:32:52 -0700 (PDT)
In-Reply-To: <CACJqLybMDnmD85jgdFxiBmH3cJ5seogBiwWMzeehWezVjujyDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi sage,

The fix is https://github.com/ceph/ceph/pull/2136. :-)

On Wed, Jul 23, 2014 at 12:48 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Thanks, I will dive into it and fix it next.
>
> On Tue, Jul 22, 2014 at 11:49 PM, Sage Weil <sweil@redhat.com> wrote:
>> Hi Haomai,
>>
>> Hmm, one other thing: I'm testing the fix in wip-8701 and it is tripping
>> over the KeyValueStore test.  This
>>
>>  ./ceph_test_objectstore --gtest_filter=ObjectStore/StoreTest.BigRGWObjectName/1
>>
>> fails with
>>
>>      0> 2014-07-22 08:45:25.640932 7fe617fff700 -1 *** Caught signal (Segmentation fault) **
>>  in thread 7fe617fff700
>>
>>  ceph version 0.82-649-gc5732e4 (c5732e4aefbd80f29b766756478d79808f0245d7)
>>  1: (ceph::BackTrace::BackTrace(int)+0x2d) [0xa09a7b]
>>  2: ./ceph_test_objectstore() [0xb145b6]
>>  3: (()+0x10340) [0x7fe621313340]
>>  4: (std::pair<unsigned long const, ghobject_t>::pair(unsigned long const&, ghobject_t const&)+0x18) [0xadb710]
>>  5: (std::map<unsigned long, ghobject_t, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, ghobject_t> > >::operator[](unsigned long const&)+0x109) [0xad957f]
>>  6: (RandomCache<ghobject_t, std::pair<coll_t, std::tr1::shared_ptr<StripObjectMap::StripObjectHeader> > >::trim_cache(unsigned long)+0xc2) [0xad7218]
>>  7: (RandomCache<ghobject_t, std::pair<coll_t, std::tr1::shared_ptr<StripObjectMap::StripObjectHeader> > >::add(ghobject_t, std::pair<coll_t, std::tr1::shared_ptr<StripObjectMap::StripObjectHeader> >)+0x70) [0xad53a2]
>>  8: (StripObjectMap::lookup_strip_header(coll_t const&, ghobject_t const&, std::tr1::shared_ptr<StripObjectMap::StripObjectHeader>*)+0x4d3) [0xab1fb1]
>>  9: (KeyValueStore::BufferTransaction::lookup_cached_header(coll_t const&, ghobject_t const&, std::tr1::shared_ptr<StripObjectMap::StripObjectHeader>*, bool)+0x1dc) [0xab32c0]
>>  10: (KeyValueStore::_remove(coll_t, ghobject_t const&, KeyValueStore::BufferTransaction&)+0x188) [0xac0472]
>>  11: (KeyValueStore::_do_transaction(ObjectStore::Transaction&, KeyValueStore::BufferTransaction&, ThreadPool::TPHandle*)+0x632) [0xabba0c]
>>  12: (KeyValueStore::_do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long, ThreadPool::TPHandle*)+0x138) [0xabb2ee]
>>  13: (KeyValueStore::_do_op(KeyValueStore::OpSequencer*, ThreadPool::TPHandle&)+0x1f5) [0xabac11]
>>  14: (KeyValueStore::OpWQ::_process(KeyValueStore::OpSequencer*, ThreadPool::TPHandle&)+0x2f) [0xad3f23]
>>  15: (ThreadPool::WorkQueue<KeyValueStore::OpSequencer>::_void_process(void*, ThreadPool::TPHandle&)+0x33) [0xadf645]
>>  16: (ThreadPool::worker(ThreadPool::WorkThread*)+0x734) [0xb28f7c]
>>  17: (ThreadPool::WorkThread::entry()+0x23) [0xb2d031]
>>  18: (Thread::entry_wrapper()+0x79) [0xb21647]
>>  19: (Thread::_entry_func(void*)+0x18) [0xb215c4]
>>  20: (()+0x8182) [0x7fe62130b182]
>>  21: (clone()+0x6d) [0x7fe61fc8330d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>
>> It's a new test (long file names and collection_move) that addresses an
>> issue with the FileStore, but KeyValueStore doesn't seem to like it
>> either...
>>
>> Thanks!
>> sage
>>
>>
>> On Tue, 22 Jul 2014, Sage Weil wrote:
>>
>>> Hi Haomai,
>>>
>>> Do you mind looking at wip-memstore at
>>>
>>>       https://github.com/ceph/ceph/pull/2125
>>>
>>> A couple minor fixes and then we can enable it in ceph_test_objectstore.
>>>
>>> Also, I would love any feedback on wip-objectstore
>>>
>>>       https://github.com/ceph/ceph/pull/2124
>>>
>>> That one is RFC at this point.  I'm trying to simplify the ObjectStore
>>> interface as much as possible.
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
