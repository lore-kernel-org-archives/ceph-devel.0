From: Mark Nelson <mnelson@redhat.com>
Subject: Re: wip-denc
Date: Tue, 13 Sep 2016 21:41:59 -0500
Message-ID: <4038573e-5f56-cf04-2f5d-64760db777db@redhat.com>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
 <a89da24e-7791-ef4a-acce-9f653eaac08e@redhat.com>
 <BL2PR02MB2115A35131A2704721503480F4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbcINCmE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 22:42:04 -0400
In-Reply-To: <BL2PR02MB2115A35131A2704721503480F4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Here's another one to add to the pile:

      0> 2016-09-13 22:31:45.142288 7f22a1d92700 -1 
/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitMapAllocator.cc: In 
function 'virtual void BitMapAllocator::commit_start()' thread 
7f22a1d92700 time 2016-09-13 22:31:45.137789
/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitMapAllocator.cc: 339: 
FAILED assert(m_committing.empty())

  ceph version v10.0.4-8831-ge3e37f1 
(e3e37f11cc0e5cd0b2b0cb29109c66abe328de64)
  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x85) [0x5636eac23b55]
  2: (BitMapAllocator::commit_start()+0x2e4) [0x5636eaa9c434]
  3: (BlueFS::sync_metadata()+0x1be) [0x5636eaa6c3be]
  4: (BlueRocksDirectory::Fsync()+0xd) [0x5636eaa7ff4d]
  5: 
(rocksdb::FlushJob::WriteLevel0Table(rocksdb::autovector<rocksdb::MemTable*, 
8ul> const&, rocksdb::VersionEdit*, rocksdb::FileMetaData*)+0xc52) 
[0x5636eaaf6852]
  6: (rocksdb::FlushJob::Run(rocksdb::FileMetaData*)+0x33b) [0x5636eaaf963b]
  7: 
(rocksdb::DBImpl::FlushMemTableToOutputFile(rocksdb::ColumnFamilyData*, 
rocksdb::MutableCFOptions const&, bool*, rocksdb::JobContext*, 
rocksdb::LogBuffer*)+0x3ad) [0x5636eaab73ad]
  8: (rocksdb::DBImpl::BackgroundFlush(bool*, rocksdb::JobContext*, 
rocksdb::LogBuffer*)+0x3ba) [0x5636eaab7efa]
  9: (rocksdb::DBImpl::BackgroundCallFlush()+0x25c) [0x5636eaacd58c]
  10: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1a1) [0x5636eab75111]
  11: (()+0x9361f3) [0x5636eab751f3]
  12: (()+0x7dc5) [0x7f22c4a8edc5]
  13: (clone()+0x6d) [0x7f22c3975ced]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- logging levels ---
    0/ 5 none
    0/ 0 lockdep
    0/ 0 context
    0/ 0 crush
    0/ 0 mds
    0/ 0 mds_balancer
    0/ 0 mds_locker
    0/ 0 mds_log
    0/ 0 mds_log_expire
    0/ 0 mds_migrator
    0/ 0 buffer
    0/ 0 timer
    0/ 0 filer
    0/ 1 striper
    0/ 0 objecter
    0/ 0 rados
    0/ 0 rbd
    0/ 5 rbd_mirror
    0/ 5 rbd_replay
    0/ 0 journaler
    0/ 0 objectcacher
    0/ 0 client
    0/ 0 osd
    0/ 0 optracker
    0/ 0 objclass
    0/ 0 filestore
    0/ 0 journal
    0/ 0 ms
    0/ 0 mon
    0/ 0 monc
    0/ 0 paxos
    0/ 0 tp
    0/ 0 auth
    1/ 5 crypto
    0/ 0 finisher
    0/ 0 heartbeatmap
    0/ 0 perfcounter
    0/ 0 rgw
    1/10 civetweb
    1/ 5 javaclient
    0/ 0 asok
    0/ 0 throttle
    0/ 0 refs
    1/ 5 xio
    1/ 5 compressor
    1/ 5 newstore
    0/ 0 bluestore
    0/ 0 bluefs
    0/ 0 bdev
    1/ 5 kstore
    4/ 5 rocksdb
    4/ 5 leveldb
    4/ 5 memdb
    1/ 5 kinetic
    1/ 5 fuse
   -2/-2 (syslog threshold)
   -1/-1 (stderr threshold)
   max_recent     10000
   max_new         1000
   log_file /tmp/cbt/ceph/log/osd.5.log
--- end dump of recent events ---
2016-09-13 22:31:45.187609 7f22a1d92700 -1 *** Caught signal (Aborted) **
  in thread 7f22a1d92700 thread_name:rocksdb:bg0

  ceph version v10.0.4-8831-ge3e37f1 
(e3e37f11cc0e5cd0b2b0cb29109c66abe328de64)
  1: (()+0x869fba) [0x5636eaaa8fba]
  2: (()+0xf100) [0x7f22c4a96100]
  3: (gsignal()+0x37) [0x7f22c38b45f7]
  4: (abort()+0x148) [0x7f22c38b5ce8]
  5: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x267) [0x5636eac23d37]
  6: (BitMapAllocator::commit_start()+0x2e4) [0x5636eaa9c434]
  7: (BlueFS::sync_metadata()+0x1be) [0x5636eaa6c3be]
  8: (BlueRocksDirectory::Fsync()+0xd) [0x5636eaa7ff4d]
  9: 
(rocksdb::FlushJob::WriteLevel0Table(rocksdb::autovector<rocksdb::MemTable*, 
8ul> const&, rocksdb::VersionEdit*, rocksdb::FileMetaData*)+0xc52) 
[0x5636eaaf6852]
  10: (rocksdb::FlushJob::Run(rocksdb::FileMetaData*)+0x33b) 
[0x5636eaaf963b]
  11: 
(rocksdb::DBImpl::FlushMemTableToOutputFile(rocksdb::ColumnFamilyData*, 
rocksdb::MutableCFOptions const&, bool*, rocksdb::JobContext*, 
rocksdb::LogBuffer*)+0x3ad) [0x5636eaab73ad]
  12: (rocksdb::DBImpl::BackgroundFlush(bool*, rocksdb::JobContext*, 
rocksdb::LogBuffer*)+0x3ba) [0x5636eaab7efa]
  13: (rocksdb::DBImpl::BackgroundCallFlush()+0x25c) [0x5636eaacd58c]
  14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1a1) [0x5636eab75111]
  15: (()+0x9361f3) [0x5636eab751f3]
  16: (()+0x7dc5) [0x7f22c4a8edc5]
  17: (clone()+0x6d) [0x7f22c3975ced]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
      0> 2016-09-13 22:31:45.187609 7f22a1d92700 -1 *** Caught signal 
(Aborted) **
  in thread 7f22a1d92700 thread_name:rocksdb:bg0

  ceph version v10.0.4-8831-ge3e37f1 
(e3e37f11cc0e5cd0b2b0cb29109c66abe328de64)
  1: (()+0x869fba) [0x5636eaaa8fba]
  2: (()+0xf100) [0x7f22c4a96100]
  3: (gsignal()+0x37) [0x7f22c38b45f7]
  4: (abort()+0x148) [0x7f22c38b5ce8]
  5: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x267) [0x5636eac23d37]
  6: (BitMapAllocator::commit_start()+0x2e4) [0x5636eaa9c434]
  7: (BlueFS::sync_metadata()+0x1be) [0x5636eaa6c3be]
  8: (BlueRocksDirectory::Fsync()+0xd) [0x5636eaa7ff4d]
  9: 
(rocksdb::FlushJob::WriteLevel0Table(rocksdb::autovector<rocksdb::MemTable*, 
8ul> const&, rocksdb::VersionEdit*, rocksdb::FileMetaData*)+0xc52) 
[0x5636eaaf6852]
  10: (rocksdb::FlushJob::Run(rocksdb::FileMetaData*)+0x33b) 
[0x5636eaaf963b]
  11: 
(rocksdb::DBImpl::FlushMemTableToOutputFile(rocksdb::ColumnFamilyData*, 
rocksdb::MutableCFOptions const&, bool*, rocksdb::JobContext*, 
rocksdb::LogBuffer*)+0x3ad) [0x5636eaab73ad]
  12: (rocksdb::DBImpl::BackgroundFlush(bool*, rocksdb::JobContext*, 
rocksdb::LogBuffer*)+0x3ba) [0x5636eaab7efa]
  13: (rocksdb::DBImpl::BackgroundCallFlush()+0x25c) [0x5636eaacd58c]
  14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1a1) [0x5636eab75111]
  15: (()+0x9361f3) [0x5636eab751f3]
  16: (()+0x7dc5) [0x7f22c4a8edc5]
  17: (clone()+0x6d) [0x7f22c3975ced]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- logging levels ---
    0/ 5 none
    0/ 0 lockdep
    0/ 0 context
    0/ 0 crush
    0/ 0 mds
    0/ 0 mds_balancer
    0/ 0 mds_locker
    0/ 0 mds_log
    0/ 0 mds_log_expire
    0/ 0 mds_migrator
    0/ 0 buffer
    0/ 0 timer
    0/ 0 filer
    0/ 1 striper
    0/ 0 objecter
    0/ 0 rados
    0/ 0 rbd
    0/ 5 rbd_mirror
    0/ 5 rbd_replay
    0/ 0 journaler
    0/ 0 objectcacher
    0/ 0 client
    0/ 0 osd
    0/ 0 optracker
    0/ 0 objclass
    0/ 0 filestore
    0/ 0 journal
    0/ 0 ms
    0/ 0 mon
    0/ 0 monc
    0/ 0 paxos
    0/ 0 tp
    0/ 0 auth
    1/ 5 crypto
    0/ 0 finisher
    0/ 0 heartbeatmap
    0/ 0 perfcounter
    0/ 0 rgw
    1/10 civetweb
    1/ 5 javaclient
    0/ 0 asok
    0/ 0 throttle
    0/ 0 refs
    1/ 5 xio
    1/ 5 compressor
    1/ 5 newstore
    0/ 0 bluestore
    0/ 0 bluefs
    0/ 0 bdev
    1/ 5 kstore
    4/ 5 rocksdb
    4/ 5 leveldb
    4/ 5 memdb
    1/ 5 kinetic
    1/ 5 fuse
   -2/-2 (syslog threshold)
   -1/-1 (stderr threshold)
   max_recent     10000
   max_new         1000
   log_file /tmp/cbt/ceph/log/osd.5.log
--- end dump of recent events ---


On 09/13/2016 07:29 PM, Somnath Roy wrote:
> Sage/Mark,
> I cherry-picked the 5 commits related to memory leak from the pull request and it seems to be *fixing* the memory issue so far in my setup. Got the following crash though.
>
> /root/ceph-master/src/os/bluestore/BlueStore.h: 319: FAILED assert(bc.empty())
>
>  ceph version v11.0.0-2254-g8c52058 (8c52058bc8a0f060e06037196627c19b7d258f1f)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x80) [0x55d6cde26ef0]
>  2: (BlueStore::SharedBlob::~SharedBlob()+0x82) [0x55d6cdbabee2]
>  3: (BlueStore::SharedBlob::put()+0x17d) [0x55d6cdb581dd]
>  4: (BlueStore::Onode::put()+0x1e8) [0x55d6cdbaca88]
>  5: (BlueStore::TwoQCache::trim(unsigned long, unsigned long)+0x7b3) [0x55d6cdb6e6d3]
>  6: (BlueStore::getattr(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, ghobject_t const&, char const*, ceph::buffer::ptr&)+0x120) [0x55d6cdb93810]
>  7: (PGBackend::objects_get_attr(hobject_t const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, ceph::buffer::list*)+0x106) [0x55d6cd970216]
>  8: (ReplicatedPG::get_object_context(hobject_t const&, bool, std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, ceph::buffer::list, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, ceph::buffer::list> > >*)+0x92e) [0x55d6cd8f0cee]
>  9: (ReplicatedPG::prep_object_replica_pushes(hobject_t const&, eversion_t, PGBackend::RecoveryHandle*)+0x1a4) [0x55d6cd8f9654]
>  10: (ReplicatedPG::recover_replicas(unsigned long, ThreadPool::TPHandle&)+0x1093) [0x55d6cd937d83]
>  11: (ReplicatedPG::start_recovery_ops(unsigned long, ThreadPool::TPHandle&, unsigned long*)+0xd86) [0x55d6cd9406a6]
>  12: (OSD::do_recovery(PG*, unsigned int, unsigned long, ThreadPool::TPHandle&)+0x426) [0x55d6cd7b2f96]
>  13: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x5bf) [0x55d6cd7b3b6f]
>  14: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x7f9) [0x55d6cde2bca9]
>  15: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55d6cde2f060]
>  16: (()+0x76fa) [0x7fd9251296fa]
>  17: (clone()+0x6d) [0x7fd923a14b5d]
>
>
> I comment out the following commit as it seems a double delete from BlueStore::SharedBlob::put() (?).
>
> 681c368c3e809c3291430582bc5d11f9cc44b4ca
>
> Another point, probably, not related to leak fix, but, in the latest master (+ your 1st 5 commits) I am hitting the following assert after OSD restart. If I run IO for some time..
>
> Thread 1 "ceph-osd" received signal SIGABRT, Aborted.
> 0x00007ffff47fd418 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff47fd418 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007ffff47ff01a in __GI_abort () at abort.c:89
> #2  0x0000555555fa114b in ceph::__ceph_assert_fail (assertion=assertion@entry=0x5555562460ed "rm.empty()",
>     file=file@entry=0x555556245fd8 "/root/ceph-master/src/os/bluestore/StupidAllocator.cc", line=line@entry=305,
>     func=func@entry=0x5555562462c0 <StupidAllocator::init_rm_free(unsigned long, unsigned long)::__PRETTY_FUNCTION__> "virtual void StupidAllocator::init_rm_free(uint64_t, uint64_t)") at /root/ceph-master/src/common/assert.cc:78
> #3  0x0000555555df6d5c in StupidAllocator::init_rm_free (this=0x55555f06f7a0, offset=<optimized out>, length=<optimized out>)
>     at /root/ceph-master/src/os/bluestore/StupidAllocator.cc:305
> #4  0x0000555555dd33aa in BlueFS::mount (this=0x55555f266580) at /root/ceph-master/src/os/bluestore/BlueFS.cc:366
> #5  0x0000555555d017e5 in BlueStore::_open_db (this=this@entry=0x55555f162000, create=create@entry=false) at /root/ceph-master/src/os/bluestore/BlueStore.cc:3008
> #6  0x0000555555d1c02d in BlueStore::mount (this=0x55555f162000) at /root/ceph-master/src/os/bluestore/BlueStore.cc:3659
> #7  0x0000555555924ef3 in OSD::init (this=0x55555f14a000) at /root/ceph-master/src/osd/OSD.cc:2025
> #8  0x00005555558838ff in main (argc=<optimized out>, argv=<optimized out>) at /root/ceph-master/src/ceph_osd.cc:609
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, September 13, 2016 4:46 PM
> To: Sage Weil; ceph-devel@vger.kernel.org
> Subject: Re: wip-denc
>
>
>
> On 09/13/2016 04:17 PM, Sage Weil wrote:
>> Hi everyone,
>>
>> Okay, I have a new wip-denc branch working and ready for some review:
>>
>> https://github.com/ceph/ceph/pull/11027
>>
>> Highlights:
>>
>> - This includes appender/iterator changes to buffer* to speed up
>> encoding and decoding (fewer bounds checks, simpler structures).
>>
>> - Accordingly, classes/types using the new-style have different
>> arguments types for encode/decode.  There is also a new bound_encode()
>> method that is used to calculate how big of a buffer to preallocate.
>>
>> - Most of the important helpers for doing types have new versions that
>> work with the new framework (e.g., the ENCODE_START macro has a new
>> DENC_START counterpart).
>>
>> - There is also a mechanism that lets you define the bound_encode,
>> encode, and decode methods all in one go using some template magic.
>> This only works for pretty simple types, but it is handy.  It looks like so:
>>
>>   struct foo_t {
>>     uint32_t a, b;
>>     ...
>>     DENC(foo_t, v, p) {
>>       DENC_START(1, 1, p);
>>       denc(v.a, p);
>>       denc(v.b, p);
>>       ...
>>       DENC_FINISH(p);
>>     }
>>   };
>>   WRITE_CLASS_DENC(foo_t)
>>
>>
>> - For new-style types, a new 'denc' function that is overload to do
>> either bound_encode, encode, or decode (based on argument types) is defined.
>> That means that
>>
>>   ::denc(v, p);
>>
>> will work for size_t& p, bufferptr::iterator& p, or
>> bufferlist::contiguous_appender& p.  This facilitates the DENC
>> definitions above.
>>
>> - There is glue to invoke new-style encode/decode when old-style
>> encode() and decode() are invoked, provided a denc_traits<T> is defined.
>>
>> - Most of the common containers are there list, vector, set, map,
>> pair, but others need to be converted.
>>
>> - Currently, we're a bit aggressive about using the new-style over the
>> old-style when we have the change.  For example, if you have
>>
>>   vector<int32_t> foo;
>>   ::encode(foo, bl);
>>
>> it will see that it knows how to do int32_t new-style and invoke the
>> new-style vector<> code.  I think this is going to be a net win, since
>> we avoid doing bounds checks on append for every element (and the
>> bound_encode is O(1) for thees base types).  On the other hand, it is
>> currently smart enough to not use new-style for individual integer
>> types, like so
>>
>>   int32_t v;
>>   ::encode(v, bl);
>>
>> although I suspect after the optimizer gets done with it the generated
>> machine code is almost identical.
>>
>> - Most of the key bluestore types are converted over so that we can do
>> some benchmarking.
>>
>> An overview is at the top of the new denc.h header here:
>>
>> https://github.com/liewegas/ceph/blob/wip-denc/src/include/denc.h#L55
>>
>> I think I've captured the best of Allen's, Varada's, and Sam's various
>> approaches, but we'll see how it behaves.  Let me know what you think!
>
> So far this is working pretty well!  It's not even crashing anymore. :D
>
> Just recapping from IRC for ceph-devel: Overall append overhead is lower than it was before, but not as low as we got it in the old code by creating a single appender all the way from ENCODE_START to ENCODE_FINISH and (manually) estimating the memory to allocate across the whole thing.  On the other hand we are faster overall now with the extentmap sharding, so we're on the right track!  Here we're calling encode_some potentially many times in ExtentMap::update and creating a new appender for each encode_some call.  Not sure if we are flushing multiple times or only at the end, but buffer::list::append is still consuming a decent chunk of CPU, and encode_some itself is too. I'm suspicious of the c_str() calls and pbl->append(bufferptr(bp, 0, l) even though they aren't being explicitly si
 ngled out by perf.  In any event there's probably some tweaking to do here.
>
> Beyond that I don't have much to report yet.  Rb_tree_increment in encode_spanning_blobs and BitMapAreaLeaf::child_check_n_lock are starting to show up as bigger % consumers than they used to, so that's good news.
>
> FWIW, it looks like we are getting about a 1-4% performance improvement over master from this in my CPU limited case.  So far memory usage is still pretty high, with OSDs using about 5.3GB of RSS per OSD at the end of a 5 minute randwrite test.
>
> Mark
>
>>
>> Thanks-
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
