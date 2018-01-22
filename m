From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Ceph Luminous - pg is down due to src/osd/SnapMapper.cc: 246:
 FAILED assert(r == -2)
Date: Mon, 22 Jan 2018 19:49:18 +0100
Message-ID: <c7392c9a-699b-0405-2252-b4da25c3b700@profihost.ag>
References: <a02d6d40-e4e7-5f9a-0f9a-b3939f376c70@profihost.ag>
 <CAJ4mKGYOzVdhBPT+ZEa92czYb5aYznxWPR-_rr=yCLdg1bVhbQ@mail.gmail.com>
 <d1684448-0ff9-5e09-5e10-effbf9e75d68@profihost.ag>
 <alpine.DEB.2.11.1801171426290.24931@piezo.novalocal>
 <8e353d25-47e8-181f-0dc5-cea0f64cbb36@profihost.ag>
 <alpine.DEB.2.11.1801171848400.24931@piezo.novalocal>
 <3bc02498-69fc-f544-c34b-8368341fd28e@profihost.ag>
 <alpine.DEB.2.11.1801171856230.24931@piezo.novalocal>
 <28f90497-df9f-f628-835b-c6c75a752f66@profihost.ag>
 <alpine.DEB.2.11.1801181314130.8186@piezo.novalocal>
 <bed7d881-fa34-80fc-6611-99a5f43292fa@profihost.ag>
 <alpine.DEB.2.11.1801181424040.8186@piezo.novalocal>
 <8f1028e2-d322-0006-30c9-6f7f4922cb40@profihost.ag>
 <alpine.DEB.2.11.1801192018060.24931@piezo.novalocal>
 <bcac326d-8f5b-be5b-2ac5-d55573553e59@profihost.ag>
 <alpine.DEB.2.11.1801212022230.24931@piezo.novalocal>
 <ee4a5fa6-2765-5d84-4be5-b191869fcfda@profihost.ag>
 <alpine.DEB.2.11.1801221430010.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:27171 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbeAVStU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Jan 2018 13:49:20 -0500
In-Reply-To: <alpine.DEB.2.11.1801221430010.24931@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

thanks! That one fixed it! Now i'm just waiting if the log ever stops
telling me:
2018-01-22 19:48:44.204004 osd.45 [ERR] osd.45 found snap mapper error
on pg 3.33e oid
3:7cc2e79f:::rbd_data.52ab946b8b4567.00000000000043fb:b0d7c snaps in
mapper: , oi: b0d7c...repaired

Currently it seems it does an endless repair and never ends.

Greets,
Stefan
Am 22.01.2018 um 15:30 schrieb Sage Weil:
> On Mon, 22 Jan 2018, Stefan Priebe - Profihost AG wrote:
>> Hi Sage,
>>
>> get_snaps returned the error as there are no snaps in the snapmapper. So
>> it's OK to skip the assert.
>>
>> My biggest problem is now that i'm not able to run a scrub on all PGs to
>> fix all those errors because in around 1-3% the osd seem to deadlock and
>> needs to get killed to proceed.
> 
> I believe this will fix it:
> 
> https://github.com/liewegas/ceph/commit/wip-snapmapper
> 
> Cherry-pick that and let me know?
> 
> Thanks!
> sage
> 
> 
>>
>> The log output is always:
>>     -3> 2018-01-22 14:02:41.725678 7f10025fe700  0 log_channel(cluster)
>> log [WRN] : slow request 141.951820 seconds old, received at
>>  2018-01-22 14:00:19.773706: osd_repop(client.142132381.0:1310126 3.a65
>> e927921/927902 3:a65be829:::rbd_data.4fbc586b8b4567.00000000
>> 00000157:head v 927921'526559757) currently commit_sent
>>     -2> 2018-01-22 14:02:41.725679 7f10025fe700  0 log_channel(cluster)
>> log [WRN] : slow request 141.643853 seconds old, received at
>>  2018-01-22 14:00:20.081674: osd_repop(client.139148241.0:15454227 3.ff7
>> e927921/927798 3:eff12952:::rbd_data.2494d06b8b4567.0000000
>> 00000147d:head v 927921'29105383) currently commit_sent
>>     -1> 2018-01-22 14:02:41.725684 7f10025fe700  0 log_channel(cluster)
>> log [WRN] : slow request 141.313220 seconds old, received at
>>  2018-01-22 14:00:20.412307: osd_repop(client.138984198.0:82792023 3.de6
>> e927921/927725 3:67b9dc7d:::rbd_data.7750506b8b4567.0000000
>> 000000aff:head v 927921'164552063) currently commit_sent
>>      0> 2018-01-22 14:02:42.426910 7f0fc23fe700 -1 *** Caught signal
>> (Aborted) **
>>  in thread 7f0fc23fe700 thread_name:tp_osd_tp
>>
>>  ceph version 12.2.2-94-g92923ef
>> (92923ef323d32d8321e86703ce1f9016f19472fb) luminous (stable)
>>  1: (()+0xa4423c) [0x561d876ab23c]
>>  2: (()+0xf890) [0x7f100b974890]
>>  3: (pthread_cond_wait()+0xbf) [0x7f100b97104f]
>>  4: (ObjectStore::apply_transactions(ObjectStore::Sequencer*,
>> std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Tran
>> saction> >&, Context*)+0x254) [0x561d8746ac54]
>>  5: (ObjectStore::apply_transaction(ObjectStore::Sequencer*,
>> ObjectStore::Transaction&&, Context*)+0x5c) [0x561d87199b2c]
>>  6: (PG::_scan_snaps(ScrubMap&)+0x8f7) [0x561d871ebf77]
>>  7: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool,
>> unsigned int, ThreadPool::TPHandle&)+0x22f) [0x561d871ecc4f]
>>  8: (PG::replica_scrub(boost::intrusive_ptr<OpRequest>,
>> ThreadPool::TPHandle&)+0x624) [0x561d871ed574]
>>  9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
>> ThreadPool::TPHandle&)+0x8b6) [0x561d872ac756]
>>  10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
>> [0x561d87138bc7]
>>  11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
>> const&)+0x57) [0x561d873b0db7]
>>  12: (OSD::ShardedOpWQ::_process(unsigned int,
>> ceph::heartbeat_handle_d*)+0x108c) [0x561d87167d1c]
>>  13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
>> [0x561d876f42bd]
>>  14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561d876f6280]
>>  15: (()+0x8064) [0x7f100b96d064]
>>  16: (clone()+0x6d) [0x7f100aa6162d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- logging levels ---
>>    0/ 5 none
>>    0/ 0 lockdep
>>    0/ 0 context
>>    0/ 0 crush
>>    0/ 0 mds
>>    0/ 0 mds_balancer
>>    0/ 0 mds_locker
>>    0/ 0 mds_log
>>    0/ 0 mds_log_expire
>>    0/ 0 mds_migrator
>>    0/ 0 buffer
>>    0/ 0 timer
>>    0/ 0 filer
>>    0/ 1 striper
>>    0/ 0 objecter
>>    0/ 0 rados
>>    0/ 0 rbd
>>    0/ 5 rbd_mirror
>>    0/ 5 rbd_replay
>>    0/ 0 journaler
>>    0/ 0 objectcacher
>>    0/ 0 client
>>    0/ 0 osd
>>    0/ 0 optracker
>>    0/ 0 objclass
>>    0/ 0 filestore
>>    0/ 0 journal
>>    0/ 0 ms
>>    0/ 0 mon
>>    0/ 0 monc
>>    0/ 0 paxos
>>    0/ 0 tp
>>    0/ 0 auth
>>    1/ 5 crypto
>>    0/ 0 finisher
>>    1/ 1 reserver
>>    0/ 0 heartbeatmap
>>    0/ 0 perfcounter
>>    0/ 0 rgw
>>    1/10 civetweb
>>    1/ 5 javaclient
>>    0/ 0 asok
>>    0/ 0 throttle
>>    0/ 0 refs
>>    1/ 5 xio
>>    1/ 5 compressor
>>    1/ 5 bluestore
>>    1/ 5 bluefs
>>    1/ 3 bdev
>>    1/ 5 kstore
>>    4/ 5 rocksdb
>>    4/ 5 leveldb
>>    4/ 5 memdb
>>    1/ 5 kinetic
>>    1/ 5 fuse
>>    1/ 5 mgr
>>    1/ 5 mgrc
>>    1/ 5 dpdk
>>    1/ 5 eventtrace
>>   -2/-2 (syslog threshold)
>>   -1/-1 (stderr threshold)
>>   max_recent     10000
>>   max_new         1000
>>   log_file /var/log/ceph/ceph-osd.59.log
>> --- end dump of recent events ---
>>
>>
>> Greets,
>> Stefan
>>
>> Am 21.01.2018 um 21:27 schrieb Sage Weil:
>>> On Fri, 19 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>> Hi Sage,
>>>>
>>>> thanks for your reply. I'll do this. What i still don't understand is
>>>> the following and i hope you might have an idea:
>>>> 1.) All the snaps mentioned here are fresh - i created them today
>>>> running luminous? How can they be missing in snapmapper again?
>>>
>>> I'm not sure.  It might help if you can set debug_osd=1/10 (or 1/20) so 
>>> that when you hit the crash we have some context as to what is going on.
>>>
>>> Did you track down which part of get_snaps() is returning the error?
>>>
>>>> 2.) How did this happen? The cluster was jewel and was updated to
>>>> luminous when all this happened.
>>>
>>> Did this start right after the upgrade?
>>>
>>> I started a PR that relaxes some of these assertions so that they clean up 
>>> instead (unless the debug option is enabled, for our regression testing), 
>>> but I'm still unclear about what the inconsistency is... any loggin you 
>>> can provide would help!
>>>
>>> Thanks-
>>> sage
>>>
>>>
>>>
>>>>
>>>> Greets,
>>>> Stefan
>>>>
>>>>
>>>> Am 19.01.2018 um 21:19 schrieb Sage Weil:
>>>>> I'm guessing it is coming from
>>>>>
>>>>>   object_snaps out;
>>>>>   int r = get_snaps(oid, &out);
>>>>>   if (r < 0)
>>>>>     return r;
>>>>>
>>>>> in SnapMapper::update_snaps().  I would add a debug statement to to 
>>>>> confirm that, and possibly also add debug lines to the various return 
>>>>> points in get_snaps() so you can see why get_snaps is returning an error.
>>>>>
>>>>> I'm guessing the way to proceed is to warn but ignore the error, but it's 
>>>>> hard to say without seeing what the inconsistency there is and whether we 
>>>>> can tolerate it...
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>> On Fri, 19 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>
>>>>>> HI Sage,
>>>>>>
>>>>>> any ideas for this one sawing while doing a deep scrub:
>>>>>>
>>>>>>     -1> 2018-01-19 21:14:20.474287 7fbcdeffe700 -1 osd.5 pg_epoch:
>>>>>> 925542 pg[3.306( v 925542'78349255 (925334'78347749,925542'78349255]
>>>>>> local-lis/les=925503/925504 n=1752 ec=15/15 lis/c 925503/925503 les/c/f
>>>>>> 925504/925517/0 925503/925503/925503) [75,31,5] r=2 lpr=925503 luod=0'0
>>>>>> crt=925542'78349255 lcod 925542'78349254 active] _scan_snaps no head for
>>>>>> 3:60c0267d:::rbd_data.103fdc6b8b4567.0000000000004c8e:b0ce7 (have MIN)
>>>>>>
>>>>>>      0> 2018-01-19 21:14:20.477650 7fbcd3bfe700 -1
>>>>>> /build/ceph/src/osd/PG.cc: In function 'void PG::update_snap_map(const
>>>>>> std::vector<pg_log_entry_t>&, ObjectStore::Transaction&)' thread
>>>>>> 7fbcd3bfe700 time 2018-01-19 21:14:20.474752
>>>>>> /build/ceph/src/osd/PG.cc: 3420: FAILED assert(r == 0)
>>>>>>
>>>>>>  ceph version 12.2.2-94-g92923ef
>>>>>> (92923ef323d32d8321e86703ce1f9016f19472fb) luminous (stable)
>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>> const*)+0x102) [0x55c0100d0372]
>>>>>>  2: (PG::update_snap_map(std::vector<pg_log_entry_t,
>>>>>> std::allocator<pg_log_entry_t> > const&,
>>>>>> anObjectStore::Transaction&)+0x3a5) [0x55c00fbcfe35]
>>>>>>  3: (PG::append_log(std::vector<pg_log_entry_t,
>>>>>> std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
>>>>>> ObjectStore::Transaction&, bool)+0x540) [0x55c00fbf5fc0]
>>>>>>  4: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
>>>>>> std::allocator<pg_log_entry_t> > const&,
>>>>>> boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
>>>>>> eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x55c00fceaeb4]
>>>>>>  5: (ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
>>>>>> [0x55c00fdf6642]
>>>>>>  6:
>>>>>> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
>>>>>> [0x55c00fdfc684]
>>>>>>  7: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
>>>>>> [0x55c00fd22030]
>>>>>>  8: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
>>>>>> ThreadPool::TPHandle&)+0x77b) [0x55c00fc8e33b]
>>>>>>  9: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>>>>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
>>>>>> [0x55c00fb1abc7]
>>>>>>  10: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
>>>>>> const&)+0x57) [0x55c00fd92ad7]
>>>>>>  11: (OSD::ShardedOpWQ::_process(unsigned int,
>>>>>> ceph::heartbeat_handle_d*)+0x108c) [0x55c00fb49d1c]
>>>>>>  12: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
>>>>>> [0x55c0100d5ffd]
>>>>>>  13: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55c0100d7fc0]
>>>>>>  14: (()+0x8064) [0x7fbd284fb064]
>>>>>>  15: (clone()+0x6d) [0x7fbd275ef62d]
>>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>>> needed to interpret this.
>>>>>>
>>>>>>
>>>>>> Stefan
>>>>>>
>>>>>> Am 18.01.2018 um 15:24 schrieb Sage Weil:
>>>>>>> On Thu, 18 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>> Hi Sage,
>>>>>>>>
>>>>>>>> Am 18.01.2018 um 14:16 schrieb Sage Weil:
>>>>>>>>> On Thu, 18 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> it also crashes in (marked with HERE):
>>>>>>>>>>
>>>>>>>>>> int SnapMapper::get_snaps(
>>>>>>>>>>   const hobject_t &oid,
>>>>>>>>>>   object_snaps *out)
>>>>>>>>>> {
>>>>>>>>>>   assert(check(oid));
>>>>>>>>>>   set<string> keys;
>>>>>>>>>>   map<string, bufferlist> got;
>>>>>>>>>>   keys.insert(to_object_key(oid));
>>>>>>>>>>   int r = backend.get_keys(keys, &got);
>>>>>>>>>>   if (r < 0)
>>>>>>>>>>     return r;
>>>>>>>>>>   if (got.empty())
>>>>>>>>>>     return -ENOENT;
>>>>>>>>>>   if (out) {
>>>>>>>>>>     bufferlist::iterator bp = got.begin()->second.begin();
>>>>>>>>>>     ::decode(*out, bp);
>>>>>>>>>>     dout(20) << __func__ << " " << oid << " " << out->snaps << dendl;
>>>>>>>>>>     assert(!out->snaps.empty());            ########### HERE ###########
>>>>>>>>>>   } else {
>>>>>>>>>>     dout(20) << __func__ << " " << oid << " (out == NULL)" << dendl;
>>>>>>>>>>   }
>>>>>>>>>>   return 0;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> is it save to comment that assert?
>>>>>>>>>
>>>>>>>>> I think so.  All of these asserts are just about ensuring the snapmapper 
>>>>>>>>> state is consistent, and it's only purpose is to find snaps to trim.  
>>>>>>>>> Since your snapmapper metadata is clearly not consistent, there isn't a 
>>>>>>>>> whole lot of risk here.  You might want to set nosnaptrim for the time 
>>>>>>>>> being so you don't get a surprise if trimming kicks in.  The next step is 
>>>>>>>>> probably going to be to do a scrub and see what it finds, repairs, or 
>>>>>>>>> can't repair.
>>>>>>>>
>>>>>>>> snap trimming works fine i already trimmed and removed some snaps.
>>>>>>>>
>>>>>>>> I was able to get the cluster into a state where all is backfilled. But
>>>>>>>> enabling / doing deep-scrubs results into this one:
>>>>>>>>      0> 2018-01-18 13:00:54.843076 7fbd253ff700 -1
>>>>>>>> /build/ceph/src/osd/SnapMapper.cc: In function 'int
>>>>>>>> SnapMapper::get_snaps(const h
>>>>>>>> object_t&, SnapMapper::object_snaps*)' thread 7fbd253ff700 time
>>>>>>>> 2018-01-18 13:00:54.840396
>>>>>>>> /build/ceph/src/osd/SnapMapper.cc: 154: FAILED assert(!out->snaps.empty())
>>>>>>>
>>>>>>> I think if you switch that assert to a warning it will repair...
>>>>>>>
>>>>>>> sage
>>>>>>>
>>>>>>>>
>>>>>>>>  ceph version 12.2.2-94-g92923ef
>>>>>>>> (92923ef323d32d8321e86703ce1f9016f19472fb) luminous (stable)
>>>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>>>> const*)+0x102) [0x5561ce28d1f2]
>>>>>>>>  2: (SnapMapper::get_snaps(hobject_t const&,
>>>>>>>> SnapMapper::object_snaps*)+0x46b) [0x5561cdef755b]
>>>>>>>>  3: (SnapMapper::get_snaps(hobject_t const&, std::set<snapid_t,
>>>>>>>> std::less<snapid_t>, std::allocator<snapid_t> >*)+0xd7) [0x5561cdef7
>>>>>>>> 697]
>>>>>>>>  4: (PG::_scan_snaps(ScrubMap&)+0x692) [0x5561cdd8ad22]
>>>>>>>>  5: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool,
>>>>>>>> unsigned int, ThreadPool::TPHandle&)+0x22f) [0x5561cdd8bc5f]
>>>>>>>>  6: (PG::replica_scrub(boost::intrusive_ptr<OpRequest>,
>>>>>>>> ThreadPool::TPHandle&)+0x624) [0x5561cdd8c584]
>>>>>>>>  7: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
>>>>>>>> ThreadPool::TPHandle&)+0x8b6) [0x5561cde4b326]
>>>>>>>>  8: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>>>>>>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
>>>>>>>> [0x5561cdcd7bc7]
>>>>>>>>  9: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
>>>>>>>> const&)+0x57) [0x5561cdf4f957]
>>>>>>>>  10: (OSD::ShardedOpWQ::_process(unsigned int,
>>>>>>>> ceph::heartbeat_handle_d*)+0x108c) [0x5561cdd06d1c]
>>>>>>>>  11: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
>>>>>>>> [0x5561ce292e7d]
>>>>>>>>  12: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x5561ce294e40]
>>>>>>>>  13: (()+0x8064) [0x7fbd70d86064]
>>>>>>>>  14: (clone()+0x6d) [0x7fbd6fe7a62d]
>>>>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>>>>> needed to interpret this.
>>>>>>>>
>>>>>>>>
>>>>>>>> Greets,
>>>>>>>> Stefan
>>>>>>>>
>>>>>>>>> sage
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Stefan
>>>>>>>>>> Am 17.01.2018 um 19:56 schrieb Sage Weil:
>>>>>>>>>>> On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Am 17.01.2018 um 19:48 schrieb Sage Weil:
>>>>>>>>>>>>> On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>>>>>> Hi Sage,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> this gives me another crash while that pg is recovering:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>      0> 2018-01-17 19:25:09.328935 7f48f8fff700 -1
>>>>>>>>>>>>>> /build/ceph/src/osd/PrimaryLogPG.cc: In function 'virtual void
>>>>>>>>>>>>>> PrimaryLogPG::on_l
>>>>>>>>>>>>>> ocal_recover(const hobject_t&, const ObjectRecoveryInfo&,
>>>>>>>>>>>>>> ObjectContextRef, bool, ObjectStore::Transaction*)' thread 7f48f8fff700 ti
>>>>>>>>>>>>>> me 2018-01-17 19:25:09.322287
>>>>>>>>>>>>>> /build/ceph/src/osd/PrimaryLogPG.cc: 358: FAILED assert(p !=
>>>>>>>>>>>>>> recovery_info.ss.clone_snaps.end())
>>>>>>>>>>>>>
>>>>>>>>>>>>> Is this a cache tiering pool?
>>>>>>>>>>>>
>>>>>>>>>>>> no normal 3 replica but the pg is degraded:
>>>>>>>>>>>> ceph pg dump | grep 3.80e
>>>>>>>>>>>>
>>>>>>>>>>>> 3.80e      1709                  0     1579         0       0 6183674368
>>>>>>>>>>>> 10014    10014 active+undersized+degraded+remapped+backfill_wait
>>>>>>>>>>>> 2018-01-17 19:42:55.840884  918403'70041375  918403:77171331 [50,54,86]
>>>>>>>>>>>>        50       [39]             39  907737'69776430 2018-01-14
>>>>>>>>>>>> 22:19:54.110864  907737'69776430 2018-01-14 22:19:54.110864
>>>>>>>>>>>
>>>>>>>>>>> Hrm, no real clues on teh root cause then.  Something like this will work 
>>>>>>>>>>> around the current assert:
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/src/osd/PrimaryLogPG.cc b/src/osd/PrimaryLogPG.cc
>>>>>>>>>>> index d42f3a401b..0f76134f74 100644
>>>>>>>>>>> --- a/src/osd/PrimaryLogPG.cc
>>>>>>>>>>> +++ b/src/osd/PrimaryLogPG.cc
>>>>>>>>>>> @@ -372,8 +372,11 @@ void PrimaryLogPG::on_local_recover(
>>>>>>>>>>>      set<snapid_t> snaps;
>>>>>>>>>>>      dout(20) << " snapset " << recovery_info.ss << dendl;
>>>>>>>>>>>      auto p = recovery_info.ss.clone_snaps.find(hoid.snap);
>>>>>>>>>>> -    assert(p != recovery_info.ss.clone_snaps.end());  // hmm, should we warn?
>>>>>>>>>>> -    snaps.insert(p->second.begin(), p->second.end());
>>>>>>>>>>> +    if (p != recovery_info.ss.clone_snaps.end()) {
>>>>>>>>>>> +      derr << __func__ << " no clone_snaps for " << hoid << dendl;
>>>>>>>>>>> +    } else {
>>>>>>>>>>> +      snaps.insert(p->second.begin(), p->second.end());
>>>>>>>>>>> +    }
>>>>>>>>>>>      dout(20) << " snaps " << snaps << dendl;
>>>>>>>>>>>      snap_mapper.add_oid(
>>>>>>>>>>>        recovery_info.soid,
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Stefan
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> s
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>  ceph version 12.2.2-94-g92923ef
>>>>>>>>>>>>>> (92923ef323d32d8321e86703ce1f9016f19472fb) luminous (stable)
>>>>>>>>>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>>>>>>>>>> const*)+0x102) [0x55addb5eb1f2]
>>>>>>>>>>>>>>  2: (PrimaryLogPG::on_local_recover(hobject_t const&, ObjectRecoveryInfo
>>>>>>>>>>>>>> const&, std::shared_ptr<ObjectContext>, bool,
>>>>>>>>>>>>>> ObjectStore::Transaction*)+0x11f0) [0x55addb1957a0]
>>>>>>>>>>>>>>  3: (ReplicatedBackend::handle_push(pg_shard_t, PushOp const&,
>>>>>>>>>>>>>> PushReplyOp*, ObjectStore::Transaction*)+0x31d) [0x55addb3071ed]
>>>>>>>>>>>>>>  4: (ReplicatedBackend::_do_push(boost::intrusive_ptr<OpRequest>)+0x18f)
>>>>>>>>>>>>>> [0x55addb30748f]
>>>>>>>>>>>>>>  5:
>>>>>>>>>>>>>> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2d1)
>>>>>>>>>>>>>> [0x55addb317531]
>>>>>>>>>>>>>>  6: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
>>>>>>>>>>>>>> [0x55addb23cf10]
>>>>>>>>>>>>>>  7: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
>>>>>>>>>>>>>> ThreadPool::TPHandle&)+0x77b) [0x55addb1a91eb]
>>>>>>>>>>>>>>  8: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>>>>>>>>>>>>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
>>>>>>>>>>>>>> [0x55addb035bc7]
>>>>>>>>>>>>>>  9: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
>>>>>>>>>>>>>> const&)+0x57) [0x55addb2ad957]
>>>>>>>>>>>>>>  10: (OSD::ShardedOpWQ::_process(unsigned int,
>>>>>>>>>>>>>> ceph::heartbeat_handle_d*)+0x108c) [0x55addb064d1c]
>>>>>>>>>>>>>>  11: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
>>>>>>>>>>>>>> [0x55addb5f0e7d]
>>>>>>>>>>>>>>  12: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55addb5f2e40]
>>>>>>>>>>>>>>  13: (()+0x8064) [0x7f4955b68064]
>>>>>>>>>>>>>>  14: (clone()+0x6d) [0x7f4954c5c62d]
>>>>>>>>>>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>>>>>>>>>>> needed to interpret this.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Greets,
>>>>>>>>>>>>>> Stefan
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Am 17.01.2018 um 15:28 schrieb Sage Weil:
>>>>>>>>>>>>>>> On Wed, 17 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> i there any chance to fix this instead of removing manually all the clones?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I believe you can avoid the immediate problem and get the PG up by 
>>>>>>>>>>>>>>> commenting out the assert.  set_snaps() will overwrite the object->snap 
>>>>>>>>>>>>>>> list mapping.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The problem is you'll probably still a stray snapid -> object mapping, so 
>>>>>>>>>>>>>>> when snaptrimming runs you might end up with a PG in the snaptrim_error 
>>>>>>>>>>>>>>> state that won't trim (although from a quick look at the code it won't 
>>>>>>>>>>>>>>> crash).  I'd probably remove the assert and deal with that if/when it 
>>>>>>>>>>>>>>> happens.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm adding a ticket to relax these asserts for production but keep them 
>>>>>>>>>>>>>>> enabled for qa.  This isn't something that needs to take down the OSD!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> sage
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>  > 
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Stefan
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Am 16.01.2018 um 23:24 schrieb Gregory Farnum:
>>>>>>>>>>>>>>>>> On Mon, Jan 15, 2018 at 5:23 PM, Stefan Priebe - Profihost AG
>>>>>>>>>>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> currently one of my clusters is missing a whole pg due to all 3 osds
>>>>>>>>>>>>>>>>>> being down.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> All of them fail with:
>>>>>>>>>>>>>>>>>>     0> 2018-01-16 02:05:33.353293 7f944dbfe700 -1
>>>>>>>>>>>>>>>>>> /build/ceph/src/osd/SnapMapper.cc: In function 'void
>>>>>>>>>>>>>>>>>> SnapMapper::add_oid(const hobject_t&, const std::set<snapid_t>&,
>>>>>>>>>>>>>>>>>> MapCacher::Transaction<std::basic_string<char>, ceph::buffer::list>*)'
>>>>>>>>>>>>>>>>>> thread 7f944dbfe700 time 2018-01-16 02:05:33.349946
>>>>>>>>>>>>>>>>>> /build/ceph/src/osd/SnapMapper.cc: 246: FAILED assert(r == -2)
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>  ceph version 12.2.2-93-gd6da8d7
>>>>>>>>>>>>>>>>>> (d6da8d77a4b2220e6bdd61e4bdd911a9cd91946c) luminous (stable)
>>>>>>>>>>>>>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>>>>>>>>>>>>>> const*)+0x102) [0x561f9ff0b1e2]
>>>>>>>>>>>>>>>>>>  2: (SnapMapper::add_oid(hobject_t const&, std::set<snapid_t,
>>>>>>>>>>>>>>>>>> std::less<snapid_t>, std::allocator<snapid_t> > const&,
>>>>>>>>>>>>>>>>>> MapCacher::Transaction<std::string, ceph::buffer::list>*)+0x64b)
>>>>>>>>>>>>>>>>>> [0x561f9fb76f3b]
>>>>>>>>>>>>>>>>>>  3: (PG::update_snap_map(std::vector<pg_log_entry_t,
>>>>>>>>>>>>>>>>>> std::allocator<pg_log_entry_t> > const&,
>>>>>>>>>>>>>>>>>> ObjectStore::Transaction&)+0x38f) [0x561f9fa0ae3f]
>>>>>>>>>>>>>>>>>>  4: (PG::append_log(std::vector<pg_log_entry_t,
>>>>>>>>>>>>>>>>>> std::allocator<pg_log_entry_t> > const&, eversion_t, eversion_t,
>>>>>>>>>>>>>>>>>> ObjectStore::Transaction&, bool)+0x538) [0x561f9fa31018]
>>>>>>>>>>>>>>>>>>  5: (PrimaryLogPG::log_operation(std::vector<pg_log_entry_t,
>>>>>>>>>>>>>>>>>> std::allocator<pg_log_entry_t> > const&,
>>>>>>>>>>>>>>>>>> boost::optional<pg_hit_set_history_t> const&, eversion_t const&,
>>>>>>>>>>>>>>>>>> eversion_t const&, bool, ObjectStore::Transaction&)+0x64) [0x561f9fb25d64]
>>>>>>>>>>>>>>>>>>  6: (ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)+0xa92)
>>>>>>>>>>>>>>>>>> [0x561f9fc314b2]
>>>>>>>>>>>>>>>>>>  7:
>>>>>>>>>>>>>>>>>> (ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)+0x2a4)
>>>>>>>>>>>>>>>>>> [0x561f9fc374f4]
>>>>>>>>>>>>>>>>>>  8: (PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)+0x50)
>>>>>>>>>>>>>>>>>> [0x561f9fb5cf10]
>>>>>>>>>>>>>>>>>>  9: (PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&,
>>>>>>>>>>>>>>>>>> ThreadPool::TPHandle&)+0x77b) [0x561f9fac91eb]
>>>>>>>>>>>>>>>>>>  10: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>>>>>>>>>>>>>>>>> boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f7)
>>>>>>>>>>>>>>>>>> [0x561f9f955bc7]
>>>>>>>>>>>>>>>>>>  11: (PGQueueable::RunVis::operator()(boost::intrusive_ptr<OpRequest>
>>>>>>>>>>>>>>>>>> const&)+0x57) [0x561f9fbcd947]
>>>>>>>>>>>>>>>>>>  12: (OSD::ShardedOpWQ::_process(unsigned int,
>>>>>>>>>>>>>>>>>> ceph::heartbeat_handle_d*)+0x108c) [0x561f9f984d1c]
>>>>>>>>>>>>>>>>>>  13: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x88d)
>>>>>>>>>>>>>>>>>> [0x561f9ff10e6d]
>>>>>>>>>>>>>>>>>>  14: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x561f9ff12e30]
>>>>>>>>>>>>>>>>>>  15: (()+0x8064) [0x7f949afcb064]
>>>>>>>>>>>>>>>>>>  16: (clone()+0x6d) [0x7f949a0bf62d]
>>>>>>>>>>>>>>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>>>>>>>>>>>>>>> needed to interpret this.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> By the time it gets there, something else has gone wrong. The OSD is
>>>>>>>>>>>>>>>>> adding a snapid/object pair to its "SnapMapper", and discovering that
>>>>>>>>>>>>>>>>> there are already entries (which it thinks there shouldn't be).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> You'll need to post more of a log, along with background, if anybody's
>>>>>>>>>>>>>>>>> going to diagnose it: is there cache tiering on the cluster? What is
>>>>>>>>>>>>>>>>> this pool used for? Were there other errors on this PG in the past?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I also notice a separate email about deleting the data; I don't have
>>>>>>>>>>>>>>>>> any experience with this but you'd probably have to export the PG
>>>>>>>>>>>>>>>>> using ceph-objectstore-tool and then find a way to delete the object
>>>>>>>>>>>>>>>>> out of it. I see options to remove both an object and
>>>>>>>>>>>>>>>>> "remove-clone-metadata" on a particular ID, but I've not used any of
>>>>>>>>>>>>>>>>> them myself.
>>>>>>>>>>>>>>>>> -Greg
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>
>>
