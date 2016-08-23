From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Tue, 23 Aug 2016 05:35:33 +0000
Message-ID: <BL2PR02MB2115046BFE90A28756E2C5B3F4EB0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608102121090.17770@piezo.us.to>
 <BL2PR02MB2115CDD714FC3883028291F8F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608111629170.17762@piezo.us.to>
 <7dc67e25-4e1c-09a1-8667-ee47572b9290@redhat.com>
 <alpine.DEB.2.11.1608111635230.17762@piezo.us.to>
 <BL2PR02MB2115D3D79C6194FD81E598F3F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608112226280.17762@piezo.us.to>
 <BL2PR02MB2115BB77EA5BA38BCF48E52DF4110@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608151952230.14754@piezo.us.to>
 <BL2PR02MB21150BE782012D52DBB8FF26F4130@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB2115FFBBBF5A04D62910A239F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222156580.25681@piezo.us.to>
 <BL2PR02MB2115C713F6AF6B989B4DC536F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BLUPR0201MB19080C16D04BBD56AFB8481CE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <BL2PR02MB2115DA709F31B00E604229E7F4EB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BLUPR0201MB1908A6C29035CA84DD79D2ACE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <BL2PR02MB21152C73410490729F47C8B3F4EB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BLUPR0201MB1908DC68CBDFDFDA084AC341E2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0077.outbound.protection.outlook.com ([104.47.36.77]:31872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751847AbcHWFfh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 01:35:37 -0400
In-Reply-To: <BLUPR0201MB1908DC68CBDFDFDA084AC341E2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

It is by default doing async compaction , right ? Only if the option is set=
 true, it is going for sync compaction..So, code is not same I guess ?

-----Original Message-----
From: Varada Kari=20
Sent: Monday, August 22, 2016 10:31 PM
To: Somnath Roy; Sage Weil
Cc: Mark Nelson; ceph-devel
Subject: Re: Bluestore assert

Nope. Then the code is same. We shouldn't be seeing any issue. Logs would h=
elp anyway. Let us run with debugs on and see.

Varada

On Tuesday 23 August 2016 10:57 AM, Somnath Roy wrote:
> bluefs_compact_log_sync =3D false by default, you mean to say make it tru=
e ?
>
> -----Original Message-----
> From: Varada Kari
> Sent: Monday, August 22, 2016 10:25 PM
> To: Somnath Roy; Sage Weil
> Cc: Mark Nelson; ceph-devel
> Subject: Re: Bluestore assert
>
> Can you try disabling the async log compaction and check once?
> bluefs_compact_log_sync to false.
>
> Varada
>
> On Tuesday 23 August 2016 10:48 AM, Somnath Roy wrote:
>> Well, it is trying to get a map for an epoch and failing.This is part of=
 meta object read and going to rocksdb/Bluefs, so, it seems it is also a co=
rruption at BlueFS level.=20
>> Logs are not useful, I am modifying code to print detailed output during=
 crash , hope we can figure out something with that for the other crashes.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Varada Kari
>> Sent: Monday, August 22, 2016 10:09 PM
>> To: Somnath Roy; Sage Weil
>> Cc: Mark Nelson; ceph-devel
>> Subject: Re: Bluestore assert
>>
>> We added couple of new asserts in the code and changed the log compactio=
n to async. That was the recent change happened on BlueFS. But this one see=
ms we are not able to read from BlueStore.
>> But the other assert what you have posted, was from BlueFS(read from roc=
ksdb). May be we should write some unit test cases to reproduce the same is=
sue similar to rocksdb write patterns.
>> Can you point me to the logs?
>>
>> Varada
>>
>> On Tuesday 23 August 2016 04:42 AM, Somnath Roy wrote:
>>> Sage,
>>> I think there are some bug introduced recently in the BlueFS and I am g=
etting the corruption like this which I was not facing earlier.
>>>
>>>    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_LOG_v1=
 {"time_micros": 1471906521248538, "job": 3, "event": "compaction_started",=
 "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L2": []=
, "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, 2007, =
2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input_data_=
size": 1648188401}
>>>     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hello/cls_=
hello.cc:305: loading cls_hello
>>>     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/cephfs/cls=
_cephfs.cc:202: loading cephfs_size_scan
>>>     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not permi=
tted to load kvs
>>>     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed to lo=
ad OSD map for epoch 321, got 0 bytes
>>>      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h: In=20
>>> function 'OSDMapRef OSDService::get_map(epoch_t)' thread=20
>>> 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
>>> osd/OSD.h: 999: FAILED assert(ret)
>>>
>>>  ceph version 11.0.0-1688-g6f48ee6
>>> (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x80) [0x5617f2a99e80]
>>>  2: (OSDService::get_map(unsigned int)+0x5d) [0x5617f2395fdd]
>>>  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
>>>  4: (main()+0x2fe0) [0x5617f229d1f0]
>>>  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
>>>  6: (_start()+0x29) [0x5617f22eb909]
>>>
>>> OSDs are not coming up (after a restart) and eventually I had to recrea=
te the cluster.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Somnath Roy
>>> Sent: Monday, August 22, 2016 3:01 PM
>>> To: 'Sage Weil'
>>> Cc: Mark Nelson; ceph-devel
>>> Subject: RE: Bluestore assert
>>>
>>> "compaction_style=3DkCompactionStyleUniversal"  in the bluestore_rocksd=
b_options .
>>> Here is the option I am using..
>>>
>>>         bluestore_rocksdb_options =3D "max_write_buffer_number=3D16,min=
_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_thre=
ads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_background=
_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D8388=
6080,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trigger=
=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compacti=
on_style=3DkCompactionStyleUniversal"
>>>
>>> Here is another one after 4 hours of 4K RW :-)...Sorry to bombard you w=
ith all these , I am adding more log for the next time if I hit it..
>>>
>>>
>>>      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
>>> os/bluestore/BlueFS.cc: In function 'int=20
>>> BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, char*)'
>>> thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
>>> os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)
>>>
>>>  ceph version 11.0.0-1688-g3fcc89c
>>> (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x80) [0x5581ed453cb0]
>>>  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned long,=20
>>> unsigned long, char*)+0x836) [0x5581ed11c1b6]
>>>  3: (BlueRocksRandomAccessFile::Read(unsigned long, unsigned long,=20
>>> rocksdb::Slice*, char*) const+0x20) [0x5581ed13f840]
>>>  4: (rocksdb::RandomAccessFileReader::Read(unsigned long, unsigned=20
>>> long, rocksdb::Slice*, char*) const+0x83f) [0x5581ed2c6f4f]
>>>  5: (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader*,
>>> rocksdb::Footer const&, rocksdb::ReadOptions const&,=20
>>> rocksdb::BlockHandle const&, rocksdb::BlockContents*, rocksdb::Env*,=20
>>> bool, rocksdb::Slice const&, rocksdb::PersistentCacheOptions const&,
>>> rocksdb::Logger*)+0x358) [0x5581ed291c18]
>>>  6: (()+0x94fd54) [0x5581ed282d54]
>>>  7:=20
>>> (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedT
>>> a b le::Rep*, rocksdb::ReadOptions const&, rocksdb::Slice const&,
>>> rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
>>>  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&,=20
>>> rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x508)=20
>>> [0x5581ed28ba68]
>>>  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,=20
>>> rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor=20
>>> const&, rocksdb::Slice const&, rocksdb::GetContext*,=20
>>> rocksdb::HistogramImpl*, bool, int)+0x158) [0x5581ed252118]
>>>  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=20
>>> rocksdb::LookupKey const&, std::__cxx11::basic_string<char,=20
>>> std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*,=20
>>> rocksdb::MergeContext*, bool*, bool*, unsigned long*)+0x4f8)=20
>>> [0x5581ed25c458]
>>>  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&,=20
>>> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
>>> std::__cxx11::basic_string<char, std::char_traits<char>,=20
>>> std::allocator<char> >*, bool*)+0x5fa) [0x5581ed1f3f7a]
>>>  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=20
>>> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
>>> std::__cxx11::basic_string<char, std::char_traits<char>,=20
>>> std::allocator<char> >*)+0x22) [0x5581ed1f4182]
>>>  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
>>> std::char_traits<char>, std::allocator<char> > const&,=20
>>> std::__cxx11::basic_string<char, std::char_traits<char>,=20
>>> std::allocator<char> > const&, ceph::buffer::list*)+0x157)=20
>>> [0x5581ed1d21d7]
>>>  14: (BlueStore::Collection::get_onode(ghobject_t const&,
>>> bool)+0x55b) [0x5581ed02802b]
>>>  15: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
>>> ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
>>>  16: (BlueStore::queue_transactions(ObjectStore::Sequencer*,
>>> std::vector<ObjectStore::Transaction,
>>> std::allocator<ObjectStore::Transaction> >&,=20
>>> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362)=20
>>> [0x5581ed032bc2]
>>>  17:=20
>>> (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transacti
>>> o n , std::allocator<ObjectStore::Transaction> >&,
>>> std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
>>>  18:=20
>>> (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>)+0xd39)
>>> [0x5581ecef89e9]
>>>  19:=20
>>> (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x2fb
>>> )
>>> [0x5581ecefeb4b]
>>>  20: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
>>> ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
>>>  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409)=20
>>> [0x5581eccdd2e9]
>>>  22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
>>> const&)+0x52) [0x5581eccdd542]
>>>  23: (OSD::ShardedOpWQ::_process(unsigned int,
>>> ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]
>>>  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned
>>> int)+0x89f) [0x5581ed440b2f]
>>>  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
>>> [0x5581ed4441f0]
>>>  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
>>>  27: (()+0x76fa) [0x7f8ed9e4e6fa]
>>>  28: (clone()+0x6d) [0x7f8ed7caeb5d]
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.
>>>
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sweil@redhat.com]
>>> Sent: Monday, August 22, 2016 2:57 PM
>>> To: Somnath Roy
>>> Cc: Mark Nelson; ceph-devel
>>> Subject: RE: Bluestore assert
>>>
>>> On Mon, 22 Aug 2016, Somnath Roy wrote:
>>>> FYI, I was running rocksdb by enabling universal style compaction=20
>>>> during this time.
>>> How are you selecting universal compaction?
>>>
>>> sage
>>> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that you have received this message in error and that any review, d=
issemination, distribution, or copying of this message is strictly prohibit=
ed. If you have received this communication in error, please notify the sen=
der by telephone or e-mail (as shown above) immediately and destroy any and=
 all copies of this message in your possession (whether hard copies or elec=
tronically stored copies).
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
>>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>

