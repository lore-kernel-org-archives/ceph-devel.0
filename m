From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: segmentation fault while using fio_ceph_objectstore
Date: Fri, 31 Mar 2017 10:49:33 -0700
Message-ID: <CAB7xdinVbPW_=rrAzP_FZV6hD+Q50ncy7hxR1X+LqLtSaC36jg@mail.gmail.com>
References: <CAB7xdikeEJC9W-e9k-Kaz5=qFK84=vCTDpFoqt=w-tj9otquGw@mail.gmail.com>
 <16f89bb4-916a-6339-e0c6-696a1a17f204@mirantis.com> <CAB7xdimt27RSuv6GoTNZkWt2Vhq_rmGfv-Ci_oj2=8f4r41=5Q@mail.gmail.com>
 <aa4a4d19-dfe1-5ddc-2f0f-a47493bfddca@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35453 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933276AbdCaRtf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Mar 2017 13:49:35 -0400
Received: by mail-vk0-f44.google.com with SMTP id r69so99533068vke.2
        for <ceph-devel@vger.kernel.org>; Fri, 31 Mar 2017 10:49:34 -0700 (PDT)
In-Reply-To: <aa4a4d19-dfe1-5ddc-2f0f-a47493bfddca@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Igor,

sure, i would be appreciated if you can share your ceph config and i
will try on master branch.

Thanks,
Sheng

On Fri, Mar 31, 2017 at 10:45 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Sheng,
>
> thanks a lot for your advise.
>
> Speaking of bluestore failures - would you mind to try master branch?
>
> I used FIO + bluestore extensively and and it works for me just fine,
> perhaps some issues in kraken...
>
> You may try my ceph config if you like too...
>
> Thanks,
>
> Igor
>
>
>
> On 31.03.2017 20:35, sheng qiu wrote:
>>
>> Hi Igor,
>>
>> thanks for your suggestions. i was able to run fio + kstore built with
>> tcmalloc. If you have problem with it, maybe try add
>> LD_PRELOAD=/path/to/libfio_ceph_objectstore.so before your fio
>> command.
>> it fixed my problem with tcmalloc and propose better performance than
>> jemalloc.
>> my problem is with bluestore that produces the above segmentation fault.
>>
>> Sage,
>> the code is cloned from ceph.git branch kraken.
>> If i run fio with qd=1, it's relatively stable, but if use qd > 1,
>> bluestore case frequently pop out the above segmentation fault.
>>
>> Thanks,
>> Sheng
>>
>>
>>
>> On Fri, Mar 31, 2017 at 9:49 AM, Igor Fedotov <ifedotov@mirantis.com>
>> wrote:
>>>
>>> Not sure it relates to your issue but I was unable to run fio +
>>> objectstore
>>> plugin built with tcmalloc.
>>>
>>> No issues after switching to jemalloc though, please do full revuild
>>> starting with
>>>
>>> ./do_cmake.sh -DWITH_FIO=ON -DFIO_INCLUDE_DIR=/root/fio/
>>> -DALLOCATOR=jemalloc
>>>
>>>
>>> Hope this helps,
>>>
>>> Igor
>>>
>>>
>>>
>>> On 31.03.2017 19:43, sheng qiu wrote:
>>>>
>>>> Hi,
>>>>
>>>> i am trying to use fio_ceph_objectstore as an external engine used by
>>>> fio to directly generate IO to objectstore backend without running a
>>>> ceph cluster. The purpose is to understand the performance of
>>>> objectstore backend.
>>>>
>>>> i was able to run kstore relatively stable, however with bluestore, it
>>>> frequently crash during the test.
>>>> here's the crash log:
>>>>
>>>> *** Caught signal (Segmentation fault) **
>>>>    in thread 7f6bc67f4700 thread_name:bstore_kv_sync
>>>>    ceph version ccd5a2 (4ccd5a2aafa15ccb6830fa0e339d57be67a50e24)
>>>>    1: (()+0x4f309e) [0x7f6bff71509e]
>>>>    2: (()+0x11390) [0x7f6bed0a8390]
>>>>    3: (malloc_usable_size()+0x28) [0x7f6becb4e4e8]
>>>>    4: (rocksdb::Arena::AllocateNewBlock(unsigned long)+0x7c)
>>>> [0x7f6bff80072c]
>>>>    5: (rocksdb::Arena::AllocateFallback(unsigned long, bool)+0x45)
>>>> [0x7f6bff8008a5]
>>>>    6: (rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned
>>>> long, rocksdb::Logger*)+0x16e) [0x7f6bff78a46e]
>>>>    7: (()+0x5a3c0b) [0x7f6bff7c5c0b]
>>>>    8: (rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType,
>>>> rocksdb::Slice const&, rocksdb::Slice const&, bool,
>>>> rocksdb::MemTablePostProcessInfo*)+0x8d9) [0x7f6bff7871d9]
>>>>    9: (rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice
>>>> const&, rocksdb::Slice const&)+0x30f) [0x7f6bff7c215f]
>>>>    10: (rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*)
>>>> const+0x53d) [0x7f6bff7bd3cd]
>>>>    11:
>>>>
>>>> (rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*,
>>>> 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*,
>>>> rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*,
>>>> bool)+0x140) [0x7f6bff7bfd50]
>>>>    12: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>>>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
>>>> unsigned long, bool)+0x1617) [0x7f6bff73e3c7]
>>>>    13: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>>>> rocksdb::WriteBatch*)+0x2a) [0x7f6bff73ec5a]
>>>>    14:
>>>>
>>>> (RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>)+0x249)
>>>> [0x7f6bff644469]
>>>>    15: (BlueStore::_kv_sync_thread()+0x12a7) [0x7f6bff5e5037]
>>>>    16: (BlueStore::KVSyncThread::entry()+0xd) [0x7f6bff6299ed]
>>>>    17: (Thread::entry_wrapper()+0x75) [0x7f6bff923335]
>>>>    18: (()+0x76ba) [0x7f6bed09e6ba]
>>>>    19: (clone()+0x6d) [0x7f6becbd082d]
>>>>
>>>> is there any clue how to fix it? any help would be appreciated.
>>>>
>>>> Thanks,
>>>> Sheng
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
