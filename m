From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Mon, 22 Aug 2016 23:10:04 +0000
Message-ID: <BL2PR02MB2115C713F6AF6B989B4DC536F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:65024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756798AbcHVXKJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 19:10:09 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I think there are some bug introduced recently in the BlueFS and I am getti=
ng the corruption like this which I was not facing earlier.

   -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EVENT_LOG_v1 {"t=
ime_micros": 1471906521248538, "job": 3, "event": "compaction_started", "fi=
les_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "files_L2": [], "f=
iles_L3": [], "files_L4": [], "files_L5": [], "files_L6": [1998, 2007, 2013=
, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "input_data_size=
": 1648188401}
    -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/hello/cls_hell=
o.cc:305: loading cls_hello
    -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/cephfs/cls_cep=
hfs.cc:202: loading cephfs_size_scan
    -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class not permitted=
 to load kvs
    -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 failed to load O=
SD map for epoch 321, got 0 bytes
     0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h: In function '=
OSDMapRef OSDService::get_map(epoch_t)' thread 7fb6ba94d8c0 time 2016-08-22=
 15:55:27.214638
osd/OSD.h: 999: FAILED assert(ret)

 ceph version 11.0.0-1688-g6f48ee6 (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea=
4)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0=
x80) [0x5617f2a99e80]
 2: (OSDService::get_map(unsigned int)+0x5d) [0x5617f2395fdd]
 3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
 4: (main()+0x2fe0) [0x5617f229d1f0]
 5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
 6: (_start()+0x29) [0x5617f22eb909]

OSDs are not coming up (after a restart) and eventually I had to recreate t=
he cluster.

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy
Sent: Monday, August 22, 2016 3:01 PM
To: 'Sage Weil'
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

"compaction_style=3DkCompactionStyleUniversal"  in the bluestore_rocksdb_op=
tions .
Here is the option I am using..

        bluestore_rocksdb_options =3D "max_write_buffer_number=3D16,min_wri=
te_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_threads=
=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_background_fl=
ushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D8388608=
0,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trigger=3D4=
00,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compaction_s=
tyle=3DkCompactionStyleUniversal"

Here is another one after 4 hours of 4K RW :-)...Sorry to bombard you with =
all these , I am adding more log for the next time if I hit it..


     0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1 os/bluestore/BlueFS.cc: =
In function 'int BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t=
, char*)' thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)

 ceph version 11.0.0-1688-g3fcc89c (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc=
0)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0=
x80) [0x5581ed453cb0]
 2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned long, unsigned long=
, char*)+0x836) [0x5581ed11c1b6]
 3: (BlueRocksRandomAccessFile::Read(unsigned long, unsigned long, rocksdb:=
:Slice*, char*) const+0x20) [0x5581ed13f840]
 4: (rocksdb::RandomAccessFileReader::Read(unsigned long, unsigned long, ro=
cksdb::Slice*, char*) const+0x83f) [0x5581ed2c6f4f]
 5: (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReader*, rocksdb::=
Footer const&, rocksdb::ReadOptions const&, rocksdb::BlockHandle const&, ro=
cksdb::BlockContents*, rocksdb::Env*, bool, rocksdb::Slice const&, rocksdb:=
:PersistentCacheOptions const&, rocksdb::Logger*)+0x358) [0x5581ed291c18]
 6: (()+0x94fd54) [0x5581ed282d54]
 7: (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::BlockBasedTabl=
e::Rep*, rocksdb::ReadOptions const&, rocksdb::Slice const&, rocksdb::Block=
Iter*)+0x60c) [0x5581ed284b3c]
 8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions const&, rocksdb::Sl=
ice const&, rocksdb::GetContext*, bool)+0x508) [0x5581ed28ba68]
 9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&, rocksdb::Interna=
lKeyComparator const&, rocksdb::FileDescriptor const&, rocksdb::Slice const=
&, rocksdb::GetContext*, rocksdb::HistogramImpl*, bool, int)+0x158) [0x5581=
ed252118]
 10: (rocksdb::Version::Get(rocksdb::ReadOptions const&, rocksdb::LookupKey=
 const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allo=
cator<char> >*, rocksdb::Status*, rocksdb::MergeContext*, bool*, bool*, uns=
igned long*)+0x4f8) [0x5581ed25c458]
 11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions const&, rocksdb::Column=
FamilyHandle*, rocksdb::Slice const&, std::__cxx11::basic_string<char, std:=
:char_traits<char>, std::allocator<char> >*, bool*)+0x5fa) [0x5581ed1f3f7a]
 12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&, rocksdb::ColumnFami=
lyHandle*, rocksdb::Slice const&, std::__cxx11::basic_string<char, std::cha=
r_traits<char>, std::allocator<char> >*)+0x22) [0x5581ed1f4182]
 13: (RocksDBStore::get(std::__cxx11::basic_string<char, std::char_traits<c=
har>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::=
char_traits<char>, std::allocator<char> > const&, ceph::buffer::list*)+0x15=
7) [0x5581ed1d21d7]
 14: (BlueStore::Collection::get_onode(ghobject_t const&, bool)+0x55b) [0x5=
581ed02802b]
 15: (BlueStore::_txc_add_transaction(BlueStore::TransContext*, ObjectStore=
::Transaction*)+0x1e49) [0x5581ed0318a9]
 16: (BlueStore::queue_transactions(ObjectStore::Sequencer*, std::vector<Ob=
jectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, std::s=
hared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362) [0x5581ed032bc2]
 17: (ReplicatedPG::queue_transactions(std::vector<ObjectStore::Transaction=
, std::allocator<ObjectStore::Transaction> >&, std::shared_ptr<OpRequest>)+=
0x81) [0x5581ecea5e51]
 18: (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpRequest>)+0xd39) [=
0x5581ecef89e9]
 19: (ReplicatedBackend::handle_message(std::shared_ptr<OpRequest>)+0x2fb) =
[0x5581ecefeb4b]
 20: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::TPH=
andle&)+0xbd) [0x5581ece4c63d]
 21: (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>,=
 ThreadPool::TPHandle&)+0x409) [0x5581eccdd2e9]
 22: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest> const&)+0x=
52) [0x5581eccdd542]
 23: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0=
x73f) [0x5581eccfd30f]
 24: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x89f) [0x5=
581ed440b2f]
 25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x5581ed4441f0]
 26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
 27: (()+0x76fa) [0x7f8ed9e4e6fa]
 28: (clone()+0x6d) [0x7f8ed7caeb5d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed t=
o interpret this.


Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Monday, August 22, 2016 2:57 PM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

On Mon, 22 Aug 2016, Somnath Roy wrote:
> FYI, I was running rocksdb by enabling universal style compaction
> during this time.

How are you selecting universal compaction?

sage
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
