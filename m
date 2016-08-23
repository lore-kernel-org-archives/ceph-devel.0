From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: Bluestore assert
Date: Tue, 23 Aug 2016 05:30:33 +0000
Message-ID: <BLUPR0201MB1908DC68CBDFDFDA084AC341E2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:58688
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754177AbcHWFoz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 01:44:55 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Nope. Then the code is same. We shouldn't be seeing any issue. Logs=0A=
would help anyway. Let us run with debugs on and see.=0A=
=0A=
Varada=0A=
=0A=
On Tuesday 23 August 2016 10:57 AM, Somnath Roy wrote:=0A=
> bluefs_compact_log_sync =3D false by default, you mean to say make it tru=
e ?=0A=
>=0A=
> -----Original Message-----=0A=
> From: Varada Kari =0A=
> Sent: Monday, August 22, 2016 10:25 PM=0A=
> To: Somnath Roy; Sage Weil=0A=
> Cc: Mark Nelson; ceph-devel=0A=
> Subject: Re: Bluestore assert=0A=
>=0A=
> Can you try disabling the async log compaction and check once?=0A=
> bluefs_compact_log_sync to false.=0A=
>=0A=
> Varada=0A=
>=0A=
> On Tuesday 23 August 2016 10:48 AM, Somnath Roy wrote:=0A=
>> Well, it is trying to get a map for an epoch and failing.This is part of=
 meta object read and going to rocksdb/Bluefs, so, it seems it is also a co=
rruption at BlueFS level. =0A=
>> Logs are not useful, I am modifying code to print detailed output during=
 crash , hope we can figure out something with that for the other crashes.=
=0A=
>>=0A=
>> Thanks & Regards=0A=
>> Somnath=0A=
>>=0A=
>> -----Original Message-----=0A=
>> From: Varada Kari=0A=
>> Sent: Monday, August 22, 2016 10:09 PM=0A=
>> To: Somnath Roy; Sage Weil=0A=
>> Cc: Mark Nelson; ceph-devel=0A=
>> Subject: Re: Bluestore assert=0A=
>>=0A=
>> We added couple of new asserts in the code and changed the log compactio=
n to async. That was the recent change happened on BlueFS. But this one see=
ms we are not able to read from BlueStore.=0A=
>> But the other assert what you have posted, was from BlueFS(read from roc=
ksdb). May be we should write some unit test cases to reproduce the same is=
sue similar to rocksdb write patterns.=0A=
>> Can you point me to the logs?=0A=
>>=0A=
>> Varada=0A=
>>=0A=
>> On Tuesday 23 August 2016 04:42 AM, Somnath Roy wrote:=0A=
>>> Sage,=0A=
>>> I think there are some bug introduced recently in the BlueFS and I am g=
etting the corruption like this which I was not facing earlier.=0A=
>>>=0A=
>>>    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_LOG_v1=
 {"time_micros": 1471906521248538, "job": 3, "event": "compaction_started",=
 "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L2": []=
, "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, 2007, =
2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input_data_=
size": 1648188401}=0A=
>>>     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hello/cls_=
hello.cc:305: loading cls_hello=0A=
>>>     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/cephfs/cls=
_cephfs.cc:202: loading cephfs_size_scan=0A=
>>>     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not permi=
tted to load kvs=0A=
>>>     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed to lo=
ad OSD map for epoch 321, got 0 bytes=0A=
>>>      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h: In =0A=
>>> function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7fb6ba94d8c0 =
=0A=
>>> time 2016-08-22 15:55:27.214638=0A=
>>> osd/OSD.h: 999: FAILED assert(ret)=0A=
>>>=0A=
>>>  ceph version 11.0.0-1688-g6f48ee6=0A=
>>> (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)=0A=
>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char=0A=
>>> const*)+0x80) [0x5617f2a99e80]=0A=
>>>  2: (OSDService::get_map(unsigned int)+0x5d) [0x5617f2395fdd]=0A=
>>>  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]=0A=
>>>  4: (main()+0x2fe0) [0x5617f229d1f0]=0A=
>>>  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]=0A=
>>>  6: (_start()+0x29) [0x5617f22eb909]=0A=
>>>=0A=
>>> OSDs are not coming up (after a restart) and eventually I had to recrea=
te the cluster.=0A=
>>>=0A=
>>> Thanks & Regards=0A=
>>> Somnath=0A=
>>>=0A=
>>> -----Original Message-----=0A=
>>> From: Somnath Roy=0A=
>>> Sent: Monday, August 22, 2016 3:01 PM=0A=
>>> To: 'Sage Weil'=0A=
>>> Cc: Mark Nelson; ceph-devel=0A=
>>> Subject: RE: Bluestore assert=0A=
>>>=0A=
>>> "compaction_style=3DkCompactionStyleUniversal"  in the bluestore_rocksd=
b_options .=0A=
>>> Here is the option I am using..=0A=
>>>=0A=
>>>         bluestore_rocksdb_options =3D "max_write_buffer_number=3D16,min=
_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_thre=
ads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_background=
_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D8388=
6080,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trigger=
=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compacti=
on_style=3DkCompactionStyleUniversal"=0A=
>>>=0A=
>>> Here is another one after 4 hours of 4K RW :-)...Sorry to bombard you w=
ith all these , I am adding more log for the next time if I hit it..=0A=
>>>=0A=
>>>=0A=
>>>      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1=0A=
>>> os/bluestore/BlueFS.cc: In function 'int =0A=
>>> BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, char*)'=0A=
>>> thread 7f8e7afff700 time 2016-08-22 17:37:24.722706=0A=
>>> os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)=0A=
>>>=0A=
>>>  ceph version 11.0.0-1688-g3fcc89c=0A=
>>> (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)=0A=
>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char=0A=
>>> const*)+0x80) [0x5581ed453cb0]=0A=
>>>  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned long, =0A=
>>> unsigned long, char*)+0x836) [0x5581ed11c1b6]=0A=
>>>  3: (BlueRocksRandomAccessFile::Read(unsigned long, unsigned long, =0A=
>>> rocksdb::Slice*, char*) const+0x20) [0x5581ed13f840]=0A=
>>>  4: (rocksdb::RandomAccessFileReader::Read(unsigned long, unsigned =0A=
>>> long, rocksdb::Slice*, char*) const+0x83f) [0x5581ed2c6f4f]=0A=
>>>  5: (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader*,=0A=
>>> rocksdb::Footer const&, rocksdb::ReadOptions const&, =0A=
>>> rocksdb::BlockHandle const&, rocksdb::BlockContents*, rocksdb::Env*, =
=0A=
>>> bool, rocksdb::Slice const&, rocksdb::PersistentCacheOptions const&,=0A=
>>> rocksdb::Logger*)+0x358) [0x5581ed291c18]=0A=
>>>  6: (()+0x94fd54) [0x5581ed282d54]=0A=
>>>  7: =0A=
>>> (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedTa=
=0A=
>>> b le::Rep*, rocksdb::ReadOptions const&, rocksdb::Slice const&,=0A=
>>> rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]=0A=
>>>  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&, =0A=
>>> rocksdb::Slice const&, rocksdb::GetContext*, bool)+0x508) =0A=
>>> [0x5581ed28ba68]=0A=
>>>  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&, =0A=
>>> rocksdb::InternalKeyComparator const&, rocksdb::FileDescriptor =0A=
>>> const&, rocksdb::Slice const&, rocksdb::GetContext*, =0A=
>>> rocksdb::HistogramImpl*, bool, int)+0x158) [0x5581ed252118]=0A=
>>>  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&, =0A=
>>> rocksdb::LookupKey const&, std::__cxx11::basic_string<char, =0A=
>>> std::char_traits<char>, std::allocator<char> >*, rocksdb::Status*, =0A=
>>> rocksdb::MergeContext*, bool*, bool*, unsigned long*)+0x4f8) =0A=
>>> [0x5581ed25c458]=0A=
>>>  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&, =0A=
>>> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&, =0A=
>>> std::__cxx11::basic_string<char, std::char_traits<char>, =0A=
>>> std::allocator<char> >*, bool*)+0x5fa) [0x5581ed1f3f7a]=0A=
>>>  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&, =0A=
>>> rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&, =0A=
>>> std::__cxx11::basic_string<char, std::char_traits<char>, =0A=
>>> std::allocator<char> >*)+0x22) [0x5581ed1f4182]=0A=
>>>  13: (RocksDBStore::get(std::__cxx11::basic_string<char,=0A=
>>> std::char_traits<char>, std::allocator<char> > const&, =0A=
>>> std::__cxx11::basic_string<char, std::char_traits<char>, =0A=
>>> std::allocator<char> > const&, ceph::buffer::list*)+0x157) =0A=
>>> [0x5581ed1d21d7]=0A=
>>>  14: (BlueStore::Collection::get_onode(ghobject_t const&, =0A=
>>> bool)+0x55b) [0x5581ed02802b]=0A=
>>>  15: (BlueStore::_txc_add_transaction(BlueStore::TransContext*,=0A=
>>> ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]=0A=
>>>  16: (BlueStore::queue_transactions(ObjectStore::Sequencer*,=0A=
>>> std::vector<ObjectStore::Transaction,=0A=
>>> std::allocator<ObjectStore::Transaction> >&, =0A=
>>> std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362) =0A=
>>> [0x5581ed032bc2]=0A=
>>>  17: =0A=
>>> (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transactio=
=0A=
>>> n , std::allocator<ObjectStore::Transaction> >&,=0A=
>>> std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]=0A=
>>>  18: =0A=
>>> (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>)+0xd39)=0A=
>>> [0x5581ecef89e9]=0A=
>>>  19: =0A=
>>> (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x2fb)=
=0A=
>>> [0x5581ecefeb4b]=0A=
>>>  20: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,=0A=
>>> ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]=0A=
>>>  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,=0A=
>>> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409) =0A=
>>> [0x5581eccdd2e9]=0A=
>>>  22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>=0A=
>>> const&)+0x52) [0x5581eccdd542]=0A=
>>>  23: (OSD::ShardedOpWQ::_process(unsigned int,=0A=
>>> ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]=0A=
>>>  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned =0A=
>>> int)+0x89f) [0x5581ed440b2f]=0A=
>>>  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)=0A=
>>> [0x5581ed4441f0]=0A=
>>>  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]=0A=
>>>  27: (()+0x76fa) [0x7f8ed9e4e6fa]=0A=
>>>  28: (clone()+0x6d) [0x7f8ed7caeb5d]=0A=
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.=0A=
>>>=0A=
>>>=0A=
>>> Thanks & Regards=0A=
>>> Somnath=0A=
>>>=0A=
>>> -----Original Message-----=0A=
>>> From: Sage Weil [mailto:sweil@redhat.com]=0A=
>>> Sent: Monday, August 22, 2016 2:57 PM=0A=
>>> To: Somnath Roy=0A=
>>> Cc: Mark Nelson; ceph-devel=0A=
>>> Subject: RE: Bluestore assert=0A=
>>>=0A=
>>> On Mon, 22 Aug 2016, Somnath Roy wrote:=0A=
>>>> FYI, I was running rocksdb by enabling universal style compaction =0A=
>>>> during this time.=0A=
>>> How are you selecting universal compaction?=0A=
>>>=0A=
>>> sage=0A=
>>> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that you have received this message in error and that any review, d=
issemination, distribution, or copying of this message is strictly prohibit=
ed. If you have received this communication in error, please notify the sen=
der by telephone or e-mail (as shown above) immediately and destroy any and=
 all copies of this message in your possession (whether hard copies or elec=
tronically stored copies).=0A=
>>> --=0A=
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
=0A=
>>> in the body of a message to majordomo@vger.kernel.org More majordomo =
=0A=
>>> info at  http://vger.kernel.org/majordomo-info.html=0A=
>>>=0A=
>=0A=
=0A=
