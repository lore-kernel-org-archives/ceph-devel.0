From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 10:46:15 -0500
Message-ID: <b6ea38cf-732d-2867-d0b4-f3d94885e242@redhat.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com>
 <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
 <e2538609-7724-5e2f-b71a-8a32c45f4479@redhat.com>
 <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com>
 <fcd816f1-057d-7cc7-d989-4c8ee5ede2db@redhat.com>
 <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <34330d24-a43d-8c4b-aeaf-a7023e193aa1@mirantis.com>
 <BL2PR02MB2115DAD48209093E5449AA6DF4300@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------73873C32101817C2E52C3BA5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbcGLPqU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 11:46:20 -0400
In-Reply-To: <BL2PR02MB2115DAD48209093E5449AA6DF4300@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------73873C32101817C2E52C3BA5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I'm seeing the majority of memory growth happening during random reads 
still.  After looking through the massif output, it looks like it may be 
associated with the bufferptr creation in KernelDevice::read here:

https://github.com/ceph/ceph/blob/master/src/os/bluestore/KernelDevice.cc#L477

On 07/12/2016 10:36 AM, Somnath Roy wrote:
> << And another observation - the issue isn't reproduced with stupid allocator hence I suspect some bug in bitmap one
> I was about to co-relate that , it seems a bug in Bitamp allocator then.
> I need to check the memory growth is also related to Bitmap allocator related or not. I will do some digging.
>
> Thanks & Regards
> Somnath
> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Tuesday, July 12, 2016 8:32 AM
> To: Somnath Roy; Mark Nelson; ceph-devel
> Subject: Re: bluestore onode diet and encoding overhead
>
> Somnath,
>
> yeah,  you're right about db partition is getting out of space:
>
> -876> 2016-07-12 18:19:26.133795 7f8e6ddb7700 10 bluefs get_usage bdev 0
> free 0 (0 B) / 268431360 (255 MB), used 100%
> -875> 2016-07-12 18:19:26.133796 7f8e6ddb7700 10 bluefs get_usage bdev 1
> free 193986560 (185 MB) / 268427264 (255 MB), used 27%
> -874> 2016-07-12 18:19:26.133797 7f8e6ddb7700 10 bluefs get_usage bdev 2
> free 1073741824 (1024 MB) / 1074782208 (1024 MB), used 0%
>
> And I don't see much RAM consumption in this case.
>
> But the curious thing about my test case is that it shouldn't increase
> amount of metadata written as I'm doing writes within the first megabyte
> only( see fio script I posted last week).
>
> Looks like somebody wastes DB space - usage at bdev 0 is constantly
> growing while I'm running the test case...
> And another observation - the issue isn't reproduced with stupid
> allocator hence I suspect some bug in bitmap one...
>
> Thanks,
> Igor
>
>
> On 12.07.2016 18:14, Somnath Roy wrote:
>> Mark,
>> Recently, the default allocator is changed to Bitmap and I saw it is returning < 0 return value only in the following case.
>>
>>    count = m_bit_alloc->alloc_blocks_res(nblks, &start_blk);
>>    if (count == 0) {
>>      return -ENOSPC;
>>    }
>>
>> So, it seems it may not be the memory but db partition is getting out of space (?). I never faced it so far as I was running with 100GB of db partition may be.
>> The amount of metadata write going on to the db even after onode diet is starting from ~1K and over time it is reaching > 4k or so (I checked for 4K RW). It is growing as extents are growing. So, 8 GB may not be enough.
>> If this is true, next challenge is , how to automatically (or document) the size of rocksdb db partition based on the data partition size. For example, in the ZS case, we have calculated that we need ~9G db space per TB. We need to do similar calculation for rocksbd as well.
>>
>> Thanks & Regards
>> Somnath
>>
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Tuesday, July 12, 2016 6:03 AM
>> To: Igor Fedotov; Somnath Roy; ceph-devel
>> Subject: Re: bluestore onode diet and encoding overhead
>>
>> In this case I'm assigning per OSD:
>>
>> 1G Data (basically the top level OSD dir) 1G WAL 8G DB 140G Block
>>
>> Mark
>>
>> On 07/12/2016 07:57 AM, Igor Fedotov wrote:
>>> Mark,
>>>
>>> you can find my post named 'yet another assertion in bluestore during
>>> random write' last week. It contains steps to reproduce in my case.
>>>
>>> Also I did some investigations (still incomplete though) with tuning
>>> 'bluestore block db size' and 'bluestore block wal size'. Setting both
>>> to 256M fixes the issue for me.
>>>
>>> But I'm still uncertain if that's a bug or just inappropriate settings...
>>>
>>>
>>> Thanks,
>>>
>>> Igor
>>>
>>>
>>> On 12.07.2016 15:48, Mark Nelson wrote:
>>>> Oh, that's good to know!  Have you tracked it down at all?  I noticed
>>>> pretty extreme memory usage on the OSDs still, so that might be part
>>>> of it.  I'm doing a massif run now.
>>>>
>>>> Mark
>>>>
>>>> On 07/12/2016 07:40 AM, Igor Fedotov wrote:
>>>>> That's similar to what I have while running my test case with vstart...
>>>>> Without Somnath's settings though..
>>>>>
>>>>>
>>>>> On 12.07.2016 15:34, Mark Nelson wrote:
>>>>>> Hi Somnath,
>>>>>>
>>>>>> I accidentally screwed up my first run with your settings but reran
>>>>>> last night.  With your tuning the OSDs are failing to allocate to
>>>>>> bdev0 after about 30 minutes of testing:
>>>>>>
>>>>>> 2016-07-12 03:48:51.127781 7f0cef8b7700 -1 bluefs _allocate failed
>>>>>> to allocate 1048576 on bdev 0, free 0; fallback to bdev 1
>>>>>>
>>>>>> They are able to continue running, but ultimately this leads to an
>>>>>> assert later on.  I wonder if it's not compacting fast enough and
>>>>>> ends up consuming the entire disk with stale metadata.
>>>>>>
>>>>>> 2016-07-12 04:31:02.631982 7f0cef8b7700 -1
>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: In
>>>>>> function 'int BlueFS::_allocate(unsigned int, uint64_t,
>>>>>> std::vector<bluefs_extent_t>*)' thread 7f0cef8b7700 time 2016-07-12
>>>>>> 04:31:02.627138
>>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueFS.cc: 1398:
>>>>>> FAILED
>>>>>> assert(0 == "allocate failed... wtf")
>>>>>>
>>>>>>   ceph version v10.0.4-6936-gc7da2f7
>>>>>> (c7da2f7c869694246650a9276a2b67aed9bf818f)
>>>>>>   1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>> const*)+0x85) [0xd4cb75]
>>>>>>   2: (BlueFS::_allocate(unsigned int, unsigned long,
>>>>>> std::vector<bluefs_extent_t, std::allocator<bluefs_extent_t>
>>>>>>> *)+0x760) [0xb98220]
>>>>>>   3: (BlueFS::_compact_log()+0xd5b) [0xb9b5ab]
>>>>>>   4: (BlueFS::_maybe_compact_log()+0x2a0) [0xb9c040]
>>>>>>   5: (BlueFS::sync_metadata()+0x20f) [0xb9d28f]
>>>>>>   6: (BlueRocksDirectory::Fsync()+0xd) [0xbb2fad]
>>>>>>   7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&,
>>>>>> rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*,
>>>>>> unsigned long, bool)+0x1456) [0xbfdb96]
>>>>>>   8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&,
>>>>>> rocksdb::WriteBatch*)+0x27) [0xbfe7a7]
>>>>>>   9:
>>>>>> (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::
>>>>>> TransactionImpl>)+0x6b)
>>>>>>
>>>>>> [0xb3df2b]
>>>>>>   10: (BlueStore::_kv_sync_thread()+0xedb) [0xaf935b]
>>>>>>   11: (BlueStore::KVSyncThread::entry()+0xd) [0xb21e8d]
>>>>>>   12: (()+0x7dc5) [0x7f0d185c4dc5]
>>>>>>   13: (clone()+0x6d) [0x7f0d164bf28d]
>>>>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>>> needed to interpret this.
>>>>>>
>>>>>>
>>>>>> On 07/12/2016 02:13 AM, Somnath Roy wrote:
>>>>>>> Thanks Mark !
>>>>>>> Yes, quite similar result I am also seeing for 4K RW. BTW, did you
>>>>>>> get chance to try out the rocksdb tuning I posted earlier ? It may
>>>>>>> reduce the stalls in your environment.
>>>>>>>
>>>>>>> Regards
>>>>>>> Somnath
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>>>>>>> Sent: Tuesday, July 12, 2016 12:03 AM
>>>>>>> To: ceph-devel
>>>>>>> Subject: bluestore onode diet and encoding overhead
>>>>>>>
>>>>>>> Hi All,
>>>>>>>
>>>>>>> With Igor's patch last week I was able to get some bluestore
>>>>>>> performance runs in without segfaulting and started looking int
>>>>>>> the results.
>>>>>>> Somewhere along the line we really screwed up read performance,
>>>>>>> but that's another topic.  Right now I want to focus on random writes.
>>>>>>> Before we put the onode on a diet we were seeing massive amounts
>>>>>>> of read traffic in RocksDB during compaction that caused write
>>>>>>> stalls during 4K random writes.  Random write performance on fast
>>>>>>> hardware like NVMe devices was often below filestore at anything
>>>>>>> other than very large IO sizes.  This was largely due to the size
>>>>>>> of the onode compounded with RocksDB's tendency toward read and
>>>>>>> write amplification.
>>>>>>>
>>>>>>> The new test results look very promising.  We've dramatically
>>>>>>> improved performance of random writes at most IO sizes, so that
>>>>>>> they are now typically quite a bit higher than both filestore and
>>>>>>> older bluestore code.  Unfortunately for very small IO sizes
>>>>>>> performance hasn't improved much.  We are no longer seeing huge
>>>>>>> amounts of RocksDB read traffic and fewer write stalls.  We are
>>>>>>> however seeing huge memory usage (~9GB RSS per OSD) and very high
>>>>>>> CPU usage.  I think this confirms some of the memory issues
>>>>>>> somnath was continuing to see.  I don't think it's a leak exactly
>>>>>>> based on how the OSDs were behaving, but we need to run through massif still to be sure.
>>>>>>>
>>>>>>> I ended up spending some time tonight with perf and digging
>>>>>>> through the encode code.  I wrote up some notes with graphs and
>>>>>>> code snippets and decided to put them up on the web.  Basically
>>>>>>> some of the encoding changes we implemented last month to reduce
>>>>>>> the onode size also appear to result in more buffer::list appends
>>>>>>> and the associated overhead.
>>>>>>> I've been trying to think through ways to improve the situation
>>>>>>> and thought other people might have some ideas too.  Here's a link
>>>>>>> to the short writeup:
>>>>>>>
>>>>>>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view?
>>>>>>> usp=sharing
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Mark
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>> PLEASE NOTE: The information contained in this electronic mail
>>>>>>> message is intended only for the use of the designated
>>>>>>> recipient(s) named above. If the reader of this message is not the
>>>>>>> intended recipient, you are hereby notified that you have received
>>>>>>> this message in error and that any review, dissemination,
>>>>>>> distribution, or copying of this message is strictly prohibited.
>>>>>>> If you have received this communication in error, please notify
>>>>>>> the sender by telephone or e-mail (as shown above) immediately and
>>>>>>> destroy any and all copies of this message in your possession
>>>>>>> (whether hard copies or electronically stored copies).
>>>>>>> N     r  y   b X  ǧv ^ )޺{.n +   z ]z   {ay ʇڙ ,j
>>>>>>>    f   h   z  w
>>     j:+v   w j m         zZ+     ݢj"  !tml=
>>>>>>>
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>

--------------73873C32101817C2E52C3BA5
Content-Type: chemical/x-gulp;
 name="osd.0.massif.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="osd.0.massif.out"

desc: --massif-out-file=/tmp/cbt/ceph/valgrind/osd.0.massif.out
cmd: /usr/local/bin/ceph-osd -c /tmp/cbt/ceph/ceph.conf -i 0 --pid-file=/tmp/cbt/ceph/pid/ceph-osd.0.pid
time_unit: i
#-----------
snapshot=0
#-----------
time=0
mem_heap_B=0
mem_heap_extra_B=0
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=1
#-----------
time=2789831593
mem_heap_B=14325243
mem_heap_extra_B=1529717
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=2
#-----------
time=5649030643
mem_heap_B=82743602
mem_heap_extra_B=3039582
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=3
#-----------
time=7153124833
mem_heap_B=113778334
mem_heap_extra_B=3173226
mem_stacks_B=0
heap_tree=detailed
n8: 113778334 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 54558720 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 50364416 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 50364416 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 50364416 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 50364416 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 50364416 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 50364416 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 50331648 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 50331648 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 50331648 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 50331648 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 50331648 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 50331648 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 50331648 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 50331648 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 50331648 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 50331648 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 50331648 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 4194304 0xBC041B: KernelDevice::KernelDevice(void (*)(void*, void*), void*) (KernelDevice.cc:48)
   n2: 4194304 0xB8F880: BlockDevice::create(std::string const&, void (*)(void*, void*), void*) (BlockDevice.cc:59)
    n1: 3145728 0xB908E1: BlueFS::add_block_device(unsigned int, std::string) (BlueFS.cc:115)
     n0: 3145728 in 3 places, all below massif's threshold (01.00%)
    n0: 1048576 in 1 place, below massif's threshold (01.00%)
  n0: 0 in 4 places, all below massif's threshold (01.00%)
 n1: 25165824 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 25165824 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 25165824 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 25165824 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 25165824 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n1: 25165824 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 25165824 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 25165824 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 25165824 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 25165824 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 25165824 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 25165824 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 25165824 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 25165824 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 25165824 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 25165824 0xEAB928B: clone (clone.S:113)
 n0: 12645354 in 1085 places, all below massif's threshold (01.00%)
 n1: 11776000 0x7542AC: OSD::_make_pg(std::shared_ptr<OSDMap const>, spg_t) (OSD.cc:3024)
  n1: 11776000 0x754622: OSD::_open_lock_pg(std::shared_ptr<OSDMap const>, spg_t, bool) (OSD.cc:3002)
   n1: 11776000 0x75E8A3: OSD::_create_lock_pg(std::shared_ptr<OSDMap const>, spg_t, bool, bool, int, std::vector<int, std::allocator<int> >&, int, std::vector<int, std::allocator<int> >&, int, pg_history_t, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, ObjectStore::Transaction&) (OSD.cc:3132)
    n1: 11776000 0x77BBED: OSD::handle_pg_peering_evt(spg_t, pg_history_t const&, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, unsigned int, std::shared_ptr<PG::CephPeeringEvt>) (OSD.cc:3584)
     n1: 11776000 0x77D053: OSD::handle_pg_create(std::shared_ptr<OpRequest>) (OSD.cc:7625)
      n1: 11776000 0x77EBFE: OSD::dispatch_op(std::shared_ptr<OpRequest>) (OSD.cc:6144)
       n1: 11776000 0x77F66B: OSD::_dispatch(Message*) (OSD.cc:6321)
        n1: 11776000 0x77FB84: OSD::ms_dispatch(Message*) (OSD.cc:5832)
         n1: 11776000 0xECD668: DispatchQueue::entry() (Messenger.h:594)
          n1: 11776000 0xDBE5BB: DispatchQueue::DispatchThread::entry() (DispatchQueue.h:102)
           n1: 11776000 0xC97BDC3: start_thread (pthread_create.c:308)
            n0: 11776000 0xEAB928B: clone (clone.S:113)
 n1: 4290432 0xBCF88D: BitMapZone::init(long, long, bool) (new_allocator.h:104)
  n1: 4290432 0xBCFA29: BitMapZone::BitMapZone(long, long, bool) (BitAllocator.cc:402)
   n1: 4290432 0xBD072D: BitMapAreaLeaf::init(long, long, bool) (BitAllocator.cc:1063)
    n2: 4290432 0xBD0879: BitMapAreaLeaf::BitMapAreaLeaf(long, long, bool) (BitAllocator.cc:1047)
     n1: 4211840 0xBD0989: BitMapAreaIN::init(long, long, bool) (BitAllocator.cc:711)
      n1: 4211840 0xBD0C63: BitAllocator::init_check(long, long, bmap_alloc_mode, bool, bool) (BitAllocator.cc:1257)
       n1: 4211840 0xBD0E61: BitAllocator::BitAllocator(long, long, bmap_alloc_mode, bool) (BitAllocator.cc:1217)
        n1: 4211840 0xBCC935: BitMapAllocator::BitMapAllocator(long, long) (BitMapAllocator.cc:30)
         n2: 4211840 0xB861E9: Allocator::create(std::string, long, long) (Allocator.cc:17)
          n1: 4194304 0xAC6933: BlueStore::_open_alloc() (BlueStore.cc:1791)
           n1: 4194304 0xAF28A0: BlueStore::mount() (BlueStore.cc:2703)
            n1: 4194304 0x772D29: OSD::init() (OSD.cc:2028)
             n0: 4194304 0x6C68D6: main (ceph_osd.cc:609)
          n0: 17536 in 1 place, below massif's threshold (01.00%)
     n0: 78592 in 1 place, below massif's threshold (01.00%)
 n1: 2413368 0xBD0718: BitMapAreaLeaf::init(long, long, bool) (BitAllocator.cc:1063)
  n2: 2413368 0xBD0879: BitMapAreaLeaf::BitMapAreaLeaf(long, long, bool) (BitAllocator.cc:1047)
   n1: 2369160 0xBD0989: BitMapAreaIN::init(long, long, bool) (BitAllocator.cc:711)
    n1: 2369160 0xBD0C63: BitAllocator::init_check(long, long, bmap_alloc_mode, bool, bool) (BitAllocator.cc:1257)
     n1: 2369160 0xBD0E61: BitAllocator::BitAllocator(long, long, bmap_alloc_mode, bool) (BitAllocator.cc:1217)
      n1: 2369160 0xBCC935: BitMapAllocator::BitMapAllocator(long, long) (BitMapAllocator.cc:30)
       n2: 2369160 0xB861E9: Allocator::create(std::string, long, long) (Allocator.cc:17)
        n1: 2359296 0xAC6933: BlueStore::_open_alloc() (BlueStore.cc:1791)
         n1: 2359296 0xAF28A0: BlueStore::mount() (BlueStore.cc:2703)
          n1: 2359296 0x772D29: OSD::init() (OSD.cc:2028)
           n0: 2359296 0x6C68D6: main (ceph_osd.cc:609)
        n0: 9864 in 1 place, below massif's threshold (01.00%)
   n0: 44208 in 1 place, below massif's threshold (01.00%)
 n1: 1616892 0xE260C67: std::string::_Rep::_S_create(unsigned long, unsigned long, std::allocator<char> const&) (new_allocator.h:104)
  n0: 1616892 in 6 places, all below massif's threshold (01.00%)
 n2: 1311744 0xACB444: BlueStore::Collection::Collection(BlueStore*, BlueStore::Cache*, coll_t) (new_allocator.h:104)
  n1: 1310720 0xAE4FB8: BlueStore::_create_collection(BlueStore::TransContext*, coll_t, unsigned int, boost::intrusive_ptr<BlueStore::Collection>*) (BlueStore.cc:6812)
   n1: 1310720 0xB1575E: BlueStore::_txc_add_transaction(BlueStore::TransContext*, ObjectStore::Transaction*) (BlueStore.cc:5216)
    n1: 1310720 0xB17A08: BlueStore::queue_transactions(ObjectStore::Sequencer*, std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*) (BlueStore.cc:5124)
     n1: 1310720 0x7AA063: ObjectStore::queue_transaction(ObjectStore::Sequencer*, ObjectStore::Transaction&&, Context*, Context*, Context*, std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*) (ObjectStore.h:1818)
      n1: 1310720 0x7785CE: OSD::dispatch_context(PG::RecoveryCtx&, PG*, std::shared_ptr<OSDMap const>, ThreadPool::TPHandle*) (OSD.cc:7713)
       n1: 1310720 0x77BC68: OSD::handle_pg_peering_evt(spg_t, pg_history_t const&, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, unsigned int, std::shared_ptr<PG::CephPeeringEvt>) (OSD.cc:3587)
        n1: 1310720 0x77D053: OSD::handle_pg_create(std::shared_ptr<OpRequest>) (OSD.cc:7625)
         n1: 1310720 0x77EBFE: OSD::dispatch_op(std::shared_ptr<OpRequest>) (OSD.cc:6144)
          n1: 1310720 0x77F66B: OSD::_dispatch(Message*) (OSD.cc:6321)
           n1: 1310720 0x77FB84: OSD::ms_dispatch(Message*) (OSD.cc:5832)
            n1: 1310720 0xECD668: DispatchQueue::entry() (Messenger.h:594)
             n1: 1310720 0xDBE5BB: DispatchQueue::DispatchThread::entry() (DispatchQueue.h:102)
              n1: 1310720 0xC97BDC3: start_thread (pthread_create.c:308)
               n0: 1310720 0xEAB928B: clone (clone.S:113)
  n0: 1024 in 1 place, below massif's threshold (01.00%)
#-----------
snapshot=4
#-----------
time=9554390425
mem_heap_B=2920398815
mem_heap_extra_B=3370545
mem_stacks_B=0
heap_tree=detailed
n2: 2920398815 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 2860548096 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 2663415808 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 2663415808 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 2663415808 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 2663415808 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 2663415808 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 2663415808 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 2663383040 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 2663383040 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 2663383040 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 2663383040 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 2663383040 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 2663383040 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 2663383040 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 2663383040 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 2663383040 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 2663383040 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 2663383040 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 192937984 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 192937984 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 192937984 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 192937984 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 192937984 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n0: 59850719 in 1124 places, all below massif's threshold (01.00%)
#-----------
snapshot=5
#-----------
time=11462252059
mem_heap_B=865333112
mem_heap_extra_B=3315992
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=6
#-----------
time=13532573157
mem_heap_B=2736252185
mem_heap_extra_B=3433967
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=7
#-----------
time=15554014038
mem_heap_B=2023641803
mem_heap_extra_B=3480445
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=8
#-----------
time=17196104432
mem_heap_B=237164459
mem_heap_extra_B=3410981
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=9
#-----------
time=19656701621
mem_heap_B=1063913214
mem_heap_extra_B=3565354
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=10
#-----------
time=21297784882
mem_heap_B=2502883997
mem_heap_extra_B=3658067
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=11
#-----------
time=24191148424
mem_heap_B=2056597252
mem_heap_extra_B=3659612
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=12
#-----------
time=26502854954
mem_heap_B=2640094833
mem_heap_extra_B=3919759
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=13
#-----------
time=28043185468
mem_heap_B=2768725960
mem_heap_extra_B=3942096
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=14
#-----------
time=29840675103
mem_heap_B=256942743
mem_heap_extra_B=3744193
mem_stacks_B=0
heap_tree=detailed
n6: 256942743 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n4: 176193536 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 157319168 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 157319168 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 157319168 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 157319168 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 157319168 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 157319168 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 157286400 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 157286400 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 157286400 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 157286400 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 157286400 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 157286400 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 157286400 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 157286400 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 157286400 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 157286400 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 157286400 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 14680064 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 14680064 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 14680064 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 14680064 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 14680064 0xEAB928B: clone (clone.S:113)
  n1: 4194304 0xBC041B: KernelDevice::KernelDevice(void (*)(void*, void*), void*) (KernelDevice.cc:48)
   n2: 4194304 0xB8F880: BlockDevice::create(std::string const&, void (*)(void*, void*), void*) (BlockDevice.cc:59)
    n1: 3145728 0xB908E1: BlueFS::add_block_device(unsigned int, std::string) (BlueFS.cc:115)
     n0: 3145728 in 3 places, all below massif's threshold (01.00%)
    n0: 1048576 in 1 place, below massif's threshold (01.00%)
  n0: 0 in 3 places, all below massif's threshold (01.00%)
 n1: 41943040 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 41943040 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 41943040 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 41943040 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 41943040 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 41943040 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 33554432 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 33554432 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 33554432 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 33554432 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 33554432 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 33554432 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 33554432 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 33554432 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 33554432 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 33554432 0xEAB928B: clone (clone.S:113)
       n1: 8388608 0xC60527: rocksdb::MemTableInserter::MergeCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:963)
        n1: 8388608 0xC5CC68: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:375)
         n1: 8388608 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 8388608 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 8388608 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 8388608 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 8388608 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 8388608 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 8388608 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 8388608 0xEAB928B: clone (clone.S:113)
 n0: 19712199 in 1129 places, all below massif's threshold (01.00%)
 n1: 11776000 0x7542AC: OSD::_make_pg(std::shared_ptr<OSDMap const>, spg_t) (OSD.cc:3024)
  n1: 11776000 0x754622: OSD::_open_lock_pg(std::shared_ptr<OSDMap const>, spg_t, bool) (OSD.cc:3002)
   n1: 11776000 0x75E8A3: OSD::_create_lock_pg(std::shared_ptr<OSDMap const>, spg_t, bool, bool, int, std::vector<int, std::allocator<int> >&, int, std::vector<int, std::allocator<int> >&, int, pg_history_t, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, ObjectStore::Transaction&) (OSD.cc:3132)
    n1: 11776000 0x77BBED: OSD::handle_pg_peering_evt(spg_t, pg_history_t const&, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, unsigned int, std::shared_ptr<PG::CephPeeringEvt>) (OSD.cc:3584)
     n1: 11776000 0x77D053: OSD::handle_pg_create(std::shared_ptr<OpRequest>) (OSD.cc:7625)
      n1: 11776000 0x77EBFE: OSD::dispatch_op(std::shared_ptr<OpRequest>) (OSD.cc:6144)
       n1: 11776000 0x77F66B: OSD::_dispatch(Message*) (OSD.cc:6321)
        n1: 11776000 0x77FB84: OSD::ms_dispatch(Message*) (OSD.cc:5832)
         n1: 11776000 0xECD668: DispatchQueue::entry() (Messenger.h:594)
          n1: 11776000 0xDBE5BB: DispatchQueue::DispatchThread::entry() (DispatchQueue.h:102)
           n1: 11776000 0xC97BDC3: start_thread (pthread_create.c:308)
            n0: 11776000 0xEAB928B: clone (clone.S:113)
 n1: 4290432 0xBCF88D: BitMapZone::init(long, long, bool) (new_allocator.h:104)
  n1: 4290432 0xBCFA29: BitMapZone::BitMapZone(long, long, bool) (BitAllocator.cc:402)
   n1: 4290432 0xBD072D: BitMapAreaLeaf::init(long, long, bool) (BitAllocator.cc:1063)
    n2: 4290432 0xBD0879: BitMapAreaLeaf::BitMapAreaLeaf(long, long, bool) (BitAllocator.cc:1047)
     n1: 4211840 0xBD0989: BitMapAreaIN::init(long, long, bool) (BitAllocator.cc:711)
      n1: 4211840 0xBD0C63: BitAllocator::init_check(long, long, bmap_alloc_mode, bool, bool) (BitAllocator.cc:1257)
       n1: 4211840 0xBD0E61: BitAllocator::BitAllocator(long, long, bmap_alloc_mode, bool) (BitAllocator.cc:1217)
        n1: 4211840 0xBCC935: BitMapAllocator::BitMapAllocator(long, long) (BitMapAllocator.cc:30)
         n2: 4211840 0xB861E9: Allocator::create(std::string, long, long) (Allocator.cc:17)
          n1: 4194304 0xAC6933: BlueStore::_open_alloc() (BlueStore.cc:1791)
           n1: 4194304 0xAF28A0: BlueStore::mount() (BlueStore.cc:2703)
            n1: 4194304 0x772D29: OSD::init() (OSD.cc:2028)
             n0: 4194304 0x6C68D6: main (ceph_osd.cc:609)
          n0: 17536 in 1 place, below massif's threshold (01.00%)
     n0: 78592 in 1 place, below massif's threshold (01.00%)
 n1: 3027536 0x83E999: std::_List_node<pg_log_entry_t>* std::list<pg_log_entry_t, std::allocator<pg_log_entry_t> >::_M_create_node<pg_log_entry_t const&>(pg_log_entry_t const&) (new_allocator.h:104)
  n1: 3027536 0x80A5CE: PG::add_log_entry(pg_log_entry_t const&) (stl_list.h:1561)
   n1: 3027536 0x80AA88: PG::append_log(std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t, ObjectStore::Transaction&, bool) (PG.cc:3004)
    n1: 3027536 0x8F5D41: ReplicatedPG::log_operation(std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, eversion_t const&, eversion_t const&, bool, ObjectStore::Transaction&) (ReplicatedPG.h:390)
     n1: 3027536 0x9C6456: ReplicatedBackend::submit_transaction(hobject_t const&, eversion_t const&, std::unique_ptr<PGBackend::PGTransaction, std::default_delete<PGBackend::PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, std::shared_ptr<OpRequest>) (ReplicatedBackend.cc:611)
      n2: 3027536 0x88C11A: ReplicatedPG::issue_repop(ReplicatedPG::RepGather*, ReplicatedPG::OpContext*) (ReplicatedPG.cc:8518)
       n1: 3026064 0x8DD988: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:3071)
        n1: 3026064 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
         n1: 3026064 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
          n1: 3026064 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
           n1: 3026064 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
            n1: 3026064 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
             n1: 3026064 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
              n1: 3026064 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
               n1: 3026064 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 3026064 0xEAB928B: clone (clone.S:113)
       n0: 1472 in 1 place, below massif's threshold (01.00%)
#-----------
snapshot=15
#-----------
time=32153149052
mem_heap_B=534242356
mem_heap_extra_B=4015084
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=16
#-----------
time=34725079095
mem_heap_B=1973570197
mem_heap_extra_B=4685667
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=17
#-----------
time=37556372767
mem_heap_B=2866950352
mem_heap_extra_B=5498088
mem_stacks_B=0
heap_tree=detailed
n3: 2866950352 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 2784002048 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 2671804416 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 2671804416 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 2671804416 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 2671804416 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 2671804416 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 2671804416 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 2671771648 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 2671771648 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 2671771648 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 2671771648 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 2671771648 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 2671771648 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 2671771648 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 2671771648 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 2671771648 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 2671771648 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 2671771648 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 108003328 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 108003328 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 108003328 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 108003328 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 108003328 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n1: 41943040 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 41943040 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 41943040 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 41943040 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 41943040 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 41943040 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 33554432 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 33554432 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 33554432 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 33554432 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 33554432 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 33554432 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 33554432 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 33554432 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 33554432 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 33554432 0xEAB928B: clone (clone.S:113)
       n0: 8388608 in 1 place, below massif's threshold (01.00%)
 n0: 41005264 in 1135 places, all below massif's threshold (01.00%)
#-----------
snapshot=18
#-----------
time=39368435303
mem_heap_B=2637251101
mem_heap_extra_B=5364219
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=19
#-----------
time=41173142400
mem_heap_B=1798446409
mem_heap_extra_B=4887271
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=20
#-----------
time=42461174758
mem_heap_B=867249870
mem_heap_extra_B=4279674
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=21
#-----------
time=44521048741
mem_heap_B=2773825950
mem_heap_extra_B=4405298
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=22
#-----------
time=45550499351
mem_heap_B=2785756525
mem_heap_extra_B=4577747
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=23
#-----------
time=47609636976
mem_heap_B=2361926657
mem_heap_extra_B=4596463
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=24
#-----------
time=48896555612
mem_heap_B=98533118
mem_heap_extra_B=4332026
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=25
#-----------
time=50957148458
mem_heap_B=364656121
mem_heap_extra_B=4710551
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=26
#-----------
time=53548003012
mem_heap_B=498146957
mem_heap_extra_B=4989907
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=27
#-----------
time=55606779213
mem_heap_B=1927871502
mem_heap_extra_B=5769770
mem_stacks_B=0
heap_tree=detailed
n3: 1927871502 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 1823506432 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 1792049152 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 1792049152 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 1792049152 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 1792049152 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 1792049152 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 1792049152 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 1792016384 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 1792016384 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 1792016384 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 1792016384 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 1792016384 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 1792016384 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 1792016384 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 1792016384 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 1792016384 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 1792016384 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 1792016384 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 27262976 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 27262976 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 27262976 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 27262976 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 27262976 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n1: 58720256 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 58720256 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 58720256 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 58720256 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 58720256 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 58720256 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 50331648 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 50331648 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 50331648 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 50331648 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 50331648 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 50331648 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 50331648 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 50331648 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 50331648 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 50331648 0xEAB928B: clone (clone.S:113)
       n0: 8388608 in 1 place, below massif's threshold (01.00%)
 n0: 45644814 in 1136 places, all below massif's threshold (01.00%)
#-----------
snapshot=28
#-----------
time=57151012705
mem_heap_B=2798067916
mem_heap_extra_B=6240516
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=29
#-----------
time=59470207670
mem_heap_B=2866410957
mem_heap_extra_B=7237611
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=30
#-----------
time=61016543479
mem_heap_B=2895822630
mem_heap_extra_B=7246106
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=31
#-----------
time=63345730600
mem_heap_B=2675746486
mem_heap_extra_B=7038554
mem_stacks_B=0
heap_tree=detailed
n3: 2675746486 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 2569568256 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 2465234944 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 2465234944 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 2465234944 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 2465234944 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 2465234944 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 2465234944 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 2465202176 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 2465202176 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 2465202176 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 2465202176 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 2465202176 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 2465202176 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 2465202176 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 2465202176 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 2465202176 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 2465202176 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 2465202176 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 100139008 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 100139008 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 100139008 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 100139008 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 100139008 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n1: 58720256 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 58720256 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 58720256 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 58720256 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 58720256 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 58720256 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 50331648 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 50331648 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 50331648 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 50331648 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 50331648 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 50331648 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 50331648 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 50331648 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 50331648 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 50331648 0xEAB928B: clone (clone.S:113)
       n0: 8388608 in 1 place, below massif's threshold (01.00%)
 n0: 47457974 in 1139 places, all below massif's threshold (01.00%)
#-----------
snapshot=32
#-----------
time=65442272309
mem_heap_B=2149629005
mem_heap_extra_B=6521987
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=33
#-----------
time=66999611517
mem_heap_B=1711978413
mem_heap_extra_B=6089731
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=34
#-----------
time=68822047678
mem_heap_B=885467104
mem_heap_extra_B=5295624
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=35
#-----------
time=70366943752
mem_heap_B=2197226668
mem_heap_extra_B=5275652
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=36
#-----------
time=73197501455
mem_heap_B=2813051634
mem_heap_extra_B=6004542
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=37
#-----------
time=74741306327
mem_heap_B=2811578466
mem_heap_extra_B=6484758
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=38
#-----------
time=76542435494
mem_heap_B=2653573820
mem_heap_extra_B=6159788
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=39
#-----------
time=78600843135
mem_heap_B=142574877
mem_heap_extra_B=5816091
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=40
#-----------
time=79889416456
mem_heap_B=303813062
mem_heap_extra_B=5905226
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=41
#-----------
time=81704137769
mem_heap_B=443923610
mem_heap_extra_B=6403982
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=42
#-----------
time=84043224684
mem_heap_B=430559501
mem_heap_extra_B=6067419
mem_stacks_B=0
heap_tree=detailed
n6: 430559501 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 292585472 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 190873600 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 190873600 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 190873600 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 190873600 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 190873600 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 190873600 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 190840832 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 190840832 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 190840832 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 190840832 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 190840832 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 190840832 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 190840832 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 190840832 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 190840832 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 190840832 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 190840832 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 97517568 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 97517568 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 97517568 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 97517568 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 97517568 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n1: 83886080 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 83886080 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 83886080 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 83886080 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 83886080 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 83886080 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 67108864 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 67108864 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 67108864 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 67108864 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 67108864 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 67108864 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 67108864 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 67108864 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 67108864 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 67108864 0xEAB928B: clone (clone.S:113)
       n1: 16777216 0xC60527: rocksdb::MemTableInserter::MergeCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:963)
        n1: 16777216 0xC5CC68: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:375)
         n1: 16777216 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 16777216 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 16777216 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 16777216 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 16777216 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 16777216 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 16777216 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 16777216 0xEAB928B: clone (clone.S:113)
 n0: 26704621 in 1145 places, all below massif's threshold (01.00%)
 n1: 11776000 0x7542AC: OSD::_make_pg(std::shared_ptr<OSDMap const>, spg_t) (OSD.cc:3024)
  n1: 11776000 0x754622: OSD::_open_lock_pg(std::shared_ptr<OSDMap const>, spg_t, bool) (OSD.cc:3002)
   n1: 11776000 0x75E8A3: OSD::_create_lock_pg(std::shared_ptr<OSDMap const>, spg_t, bool, bool, int, std::vector<int, std::allocator<int> >&, int, std::vector<int, std::allocator<int> >&, int, pg_history_t, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, ObjectStore::Transaction&) (OSD.cc:3132)
    n1: 11776000 0x77BBED: OSD::handle_pg_peering_evt(spg_t, pg_history_t const&, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int const, pg_interval_t> > >&, unsigned int, std::shared_ptr<PG::CephPeeringEvt>) (OSD.cc:3584)
     n1: 11776000 0x77D053: OSD::handle_pg_create(std::shared_ptr<OpRequest>) (OSD.cc:7625)
      n1: 11776000 0x77EBFE: OSD::dispatch_op(std::shared_ptr<OpRequest>) (OSD.cc:6144)
       n1: 11776000 0x77F66B: OSD::_dispatch(Message*) (OSD.cc:6321)
        n1: 11776000 0x77FB84: OSD::ms_dispatch(Message*) (OSD.cc:5832)
         n1: 11776000 0xECD668: DispatchQueue::entry() (Messenger.h:594)
          n1: 11776000 0xDBE5BB: DispatchQueue::DispatchThread::entry() (DispatchQueue.h:102)
           n1: 11776000 0xC97BDC3: start_thread (pthread_create.c:308)
            n0: 11776000 0xEAB928B: clone (clone.S:113)
 n1: 9813824 0x83E999: std::_List_node<pg_log_entry_t>* std::list<pg_log_entry_t, std::allocator<pg_log_entry_t> >::_M_create_node<pg_log_entry_t const&>(pg_log_entry_t const&) (new_allocator.h:104)
  n1: 9813824 0x80A5CE: PG::add_log_entry(pg_log_entry_t const&) (stl_list.h:1561)
   n1: 9813824 0x80AA88: PG::append_log(std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t, ObjectStore::Transaction&, bool) (PG.cc:3004)
    n1: 9813824 0x8F5D41: ReplicatedPG::log_operation(std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, eversion_t const&, eversion_t const&, bool, ObjectStore::Transaction&) (ReplicatedPG.h:390)
     n1: 9813824 0x9C6456: ReplicatedBackend::submit_transaction(hobject_t const&, eversion_t const&, std::unique_ptr<PGBackend::PGTransaction, std::default_delete<PGBackend::PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, std::shared_ptr<OpRequest>) (ReplicatedBackend.cc:611)
      n2: 9813824 0x88C11A: ReplicatedPG::issue_repop(ReplicatedPG::RepGather*, ReplicatedPG::OpContext*) (ReplicatedPG.cc:8518)
       n1: 9812352 0x8DD988: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:3071)
        n1: 9812352 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
         n1: 9812352 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
          n1: 9812352 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
           n1: 9812352 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
            n1: 9812352 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
             n1: 9812352 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
              n1: 9812352 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
               n1: 9812352 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 9812352 0xEAB928B: clone (clone.S:113)
       n0: 1472 in 1 place, below massif's threshold (01.00%)
 n1: 5793504 0xAE310E: BlueStore::_do_write_big(BlueStore::TransContext*, boost::intrusive_ptr<BlueStore::Collection>&, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list::iterator&, BlueStore::WriteContext*) (BlueStore.h:351)
  n1: 5793504 0xB10C9A: BlueStore::_do_write(BlueStore::TransContext*, boost::intrusive_ptr<BlueStore::Collection>&, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (BlueStore.cc:6186)
   n1: 5793504 0xB1194D: BlueStore::_write(BlueStore::TransContext*, boost::intrusive_ptr<BlueStore::Collection>&, boost::intrusive_ptr<BlueStore::Onode>&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (BlueStore.cc:6225)
    n1: 5793504 0xB15B25: BlueStore::_txc_add_transaction(BlueStore::TransContext*, ObjectStore::Transaction*) (BlueStore.cc:5319)
     n1: 5793504 0xB17A08: BlueStore::queue_transactions(ObjectStore::Sequencer*, std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*) (BlueStore.cc:5124)
      n1: 5793504 0x8FD9DA: ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<OpRequest>) (ObjectStore.h:1818)
       n1: 5793504 0x9C660B: ReplicatedBackend::submit_transaction(hobject_t const&, eversion_t const&, std::unique_ptr<PGBackend::PGTransaction, std::default_delete<PGBackend::PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, std::shared_ptr<OpRequest>) (ReplicatedBackend.cc:624)
        n1: 5793504 0x88C11A: ReplicatedPG::issue_repop(ReplicatedPG::RepGather*, ReplicatedPG::OpContext*) (ReplicatedPG.cc:8518)
         n1: 5793504 0x8DD988: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:3071)
          n1: 5793504 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 5793504 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 5793504 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 5793504 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 5793504 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 5793504 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 5793504 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 5793504 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 5793504 0xEAB928B: clone (clone.S:113)
#-----------
snapshot=43
#-----------
time=86916664577
mem_heap_B=394179023
mem_heap_extra_B=6072401
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=44
#-----------
time=90004728039
mem_heap_B=2543619555
mem_heap_extra_B=9308605
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=45
#-----------
time=92063150148
mem_heap_B=2828142944
mem_heap_extra_B=10324984
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=46
#-----------
time=93349801291
mem_heap_B=2841185970
mem_heap_extra_B=9816798
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=47
#-----------
time=95442126687
mem_heap_B=2943129637
mem_heap_extra_B=10721323
mem_stacks_B=0
heap_tree=peak
n3: 2943129637 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 2791604224 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 2673377280 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 2673377280 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 2673377280 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 2673377280 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 2673377280 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 2673377280 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 2673344512 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 2673344512 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 2673344512 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 2673344512 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 2673344512 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 2673344512 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 2673344512 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 2673344512 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 2673344512 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 2673344512 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 2673344512 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 114032640 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 114032640 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 114032640 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 114032640 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 114032640 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n1: 92274688 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 92274688 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 92274688 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 92274688 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 92274688 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 92274688 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 75497472 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 75497472 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 75497472 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 75497472 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 75497472 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 75497472 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 75497472 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 75497472 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 75497472 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 75497472 0xEAB928B: clone (clone.S:113)
       n0: 16777216 in 1 place, below massif's threshold (01.00%)
 n0: 59250725 in 1149 places, all below massif's threshold (01.00%)
#-----------
snapshot=48
#-----------
time=97264250844
mem_heap_B=2875135516
mem_heap_extra_B=10679732
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=49
#-----------
time=99614816416
mem_heap_B=2807668997
mem_heap_extra_B=10449187
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=50
#-----------
time=100644375679
mem_heap_B=2643492394
mem_heap_extra_B=10327950
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=51
#-----------
time=101677516983
mem_heap_B=2437446872
mem_heap_extra_B=9996288
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=52
#-----------
time=102708033162
mem_heap_B=2245846577
mem_heap_extra_B=9839599
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=53
#-----------
time=103737833974
mem_heap_B=2078151540
mem_heap_extra_B=9317428
mem_stacks_B=0
heap_tree=detailed
n3: 2078151540 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n3: 1927053312 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 1847623680 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 1847623680 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 1847623680 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 1847623680 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 1847623680 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 1847623680 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 1847590912 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 1847590912 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 1847590912 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 1847590912 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 1847590912 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 1847590912 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 1847590912 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 1847590912 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 1847590912 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 1847590912 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 1847590912 0xEAB928B: clone (clone.S:113)
        n0: 32768 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n1: 75235328 0xED5C8E: Pipe::read_message(Message**, AuthSessionHandler*) (Pipe.cc:1904)
   n1: 75235328 0xEE19E1: Pipe::reader() (Pipe.cc:1606)
    n1: 75235328 0xEEA47B: Pipe::Reader::entry() (Pipe.h:52)
     n1: 75235328 0xC97BDC3: start_thread (pthread_create.c:308)
      n0: 75235328 0xEAB928B: clone (clone.S:113)
  n0: 4194304 in 4 places, all below massif's threshold (01.00%)
 n1: 92274688 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 92274688 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 92274688 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 92274688 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 92274688 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 92274688 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 75497472 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 75497472 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 75497472 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 75497472 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 75497472 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 75497472 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 75497472 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 75497472 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 75497472 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 75497472 0xEAB928B: clone (clone.S:113)
       n0: 16777216 in 1 place, below massif's threshold (01.00%)
 n0: 58823540 in 1149 places, all below massif's threshold (01.00%)
#-----------
snapshot=54
#-----------
time=104772881874
mem_heap_B=1927032700
mem_heap_extra_B=8988708
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=55
#-----------
time=105806384948
mem_heap_B=1741829329
mem_heap_extra_B=8562207
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=56
#-----------
time=106836066191
mem_heap_B=1523549476
mem_heap_extra_B=8195028
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=57
#-----------
time=107893981254
mem_heap_B=1346293178
mem_heap_extra_B=7880542
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=58
#-----------
time=108923762197
mem_heap_B=1009356277
mem_heap_extra_B=7299867
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=59
#-----------
time=109953212809
mem_heap_B=487667174
mem_heap_extra_B=6390962
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=60
#-----------
time=110982663433
mem_heap_B=1518845395
mem_heap_extra_B=6748109
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=61
#-----------
time=112012114300
mem_heap_B=2829658037
mem_heap_extra_B=7591971
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=62
#-----------
time=113041564976
mem_heap_B=2826737623
mem_heap_extra_B=7933097
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=63
#-----------
time=114071015904
mem_heap_B=2822523438
mem_heap_extra_B=7389210
mem_stacks_B=0
heap_tree=detailed
n3: 2822523438 (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
 n2: 2671771648 0xE13863: ceph::buffer::create_aligned(unsigned int, unsigned int) (buffer.cc:350)
  n2: 2667577344 0xBC2D6A: KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOContext*, bool) (KernelDevice.cc:477)
   n1: 2667577344 0xACCB93: std::_Function_handler<void (unsigned long, unsigned long), BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)::{lambda(unsigned long, unsigned long)#2}>::_M_invoke(std::_Any_data const&, unsigned long, unsigned long) (BlueStore.cc:3605)
    n1: 2667577344 0xB0454B: BlueStore::_do_read(BlueStore::Collection*, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int) (functional:2471)
     n2: 2667577344 0xB05D9F: BlueStore::read(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int, bool) (BlueStore.cc:3434)
      n1: 2667577344 0x9BF109: ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned long, unsigned long, unsigned int, ceph::buffer::list*) (ReplicatedBackend.cc:259)
       n2: 2667577344 0x8CAD6E: ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSDOp, std::allocator<OSDOp> >&) (ReplicatedPG.cc:4237)
        n1: 2667577344 0x8DC55D: ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*) (ReplicatedPG.cc:6595)
         n1: 2667577344 0x8DD3CC: ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*) (ReplicatedPG.cc:2912)
          n1: 2667577344 0x8E1241: ReplicatedPG::do_op(std::shared_ptr<OpRequest>&) (ReplicatedPG.cc:2125)
           n1: 2667577344 0x89EEC5: ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPHandle&) (ReplicatedPG.cc:1478)
            n1: 2667577344 0x75844B: OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, ThreadPool::TPHandle&) (OSD.cc:8887)
             n1: 2667577344 0x75869B: PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&) (OSD.cc:163)
              n1: 2667577344 0x779A5D: OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) (variant.hpp:1017)
               n1: 2667577344 0xD52805: ShardedThreadPool::shardedthreadpool_worker(unsigned int) (WorkQueue.cc:348)
                n1: 2667577344 0xD5495E: ShardedThreadPool::WorkThreadSharded::entry() (WorkQueue.h:684)
                 n1: 2667577344 0xC97BDC3: start_thread (pthread_create.c:308)
                  n0: 2667577344 0xEAB928B: clone (clone.S:113)
        n0: 0 in 1 place, below massif's threshold (01.00%)
      n0: 0 in 1 place, below massif's threshold (01.00%)
   n0: 0 in 2 places, all below massif's threshold (01.00%)
  n0: 4194304 in 5 places, all below massif's threshold (01.00%)
 n1: 92274688 0xC8D78E: rocksdb::Arena::AllocateNewBlock(unsigned long) (arena.cc:184)
  n1: 92274688 0xC8D845: rocksdb::Arena::AllocateFallback(unsigned long, bool) (arena.cc:95)
   n1: 92274688 0xC343CE: rocksdb::ConcurrentArena::AllocateAligned(unsigned long, unsigned long, rocksdb::Logger*) (concurrent_arena.h:61)
    n1: 92274688 0xCFA5A5: rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode(unsigned long, int) [clone .isra.63] (inlineskiplist.h:498)
     n1: 92274688 0xCFA631: rocksdb::(anonymous namespace)::SkipListRep::Allocate(unsigned long, char**) (inlineskiplist.h:485)
      n2: 92274688 0xC30EAF: rocksdb::MemTable::Add(unsigned long, rocksdb::ValueType, rocksdb::Slice const&, rocksdb::Slice const&, bool) (memtable.cc:368)
       n1: 75497472 0xC5F77C: rocksdb::MemTableInserter::PutCF(unsigned int, rocksdb::Slice const&, rocksdb::Slice const&) (write_batch.cc:778)
        n1: 75497472 0xC5CCDB: rocksdb::WriteBatch::Iterate(rocksdb::WriteBatch::Handler*) const (write_batch.cc:354)
         n1: 75497472 0xC5E3E3: rocksdb::WriteBatchInternal::InsertInto(rocksdb::autovector<rocksdb::WriteThread::Writer*, 8ul> const&, unsigned long, rocksdb::ColumnFamilyMemTables*, rocksdb::FlushScheduler*, bool, unsigned long, rocksdb::DB*, bool, bool) (write_batch.cc:1099)
          n1: 75497472 0xBFDE99: rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::WriteBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool) (db_impl.cc:4733)
           n1: 75497472 0xBFE7A5: rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBatch*) (db_impl.cc:4376)
            n1: 75497472 0xB3DDC9: RocksDBStore::submit_transaction(std::shared_ptr<KeyValueDB::TransactionImpl>) (RocksDBStore.cc:368)
             n1: 75497472 0xAF8E75: BlueStore::_kv_sync_thread() (BlueStore.cc:4899)
              n1: 75497472 0xB21E8B: BlueStore::KVSyncThread::entry() (BlueStore.h:1098)
               n1: 75497472 0xC97BDC3: start_thread (pthread_create.c:308)
                n0: 75497472 0xEAB928B: clone (clone.S:113)
       n0: 16777216 in 1 place, below massif's threshold (01.00%)
 n0: 58477102 in 1149 places, all below massif's threshold (01.00%)
#-----------
snapshot=64
#-----------
time=115100466880
mem_heap_B=2840705494
mem_heap_extra_B=7881418
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=65
#-----------
time=116129917492
mem_heap_B=2851121683
mem_heap_extra_B=7862757
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=66
#-----------
time=117159370374
mem_heap_B=2852904424
mem_heap_extra_B=8058032
mem_stacks_B=0
heap_tree=empty
#-----------
snapshot=67
#-----------
time=118192089840
mem_heap_B=2846412975
mem_heap_extra_B=8235257
mem_stacks_B=0
heap_tree=empty

--------------73873C32101817C2E52C3BA5--
