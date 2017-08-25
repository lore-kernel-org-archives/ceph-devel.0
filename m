From: Linux Chips <linux.chips@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Sat, 26 Aug 2017 02:03:03 +0300
Message-ID: <18fbddea-9b94-bc9c-46d5-08076b591d13@gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com>
 <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal>
 <cf976b97-5173-cf89-010f-a3d492944304@gmail.com>
 <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal>
 <e79cb096-bb5c-5e1c-5e03-5ca8b324b9e2@gmail.com>
 <alpine.DEB.2.11.1708240351220.20435@piezo.novalocal>
 <12a4771a-dab2-3e98-c925-119b09c2d2d0@gmail.com>
 <alpine.DEB.2.11.1708252243080.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38171 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935440AbdHYXDH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Aug 2017 19:03:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id o76so620652wrb.5
        for <ceph-devel@vger.kernel.org>; Fri, 25 Aug 2017 16:03:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708252243080.20435@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mustafa Muhammad <mustafa1024m@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/26/2017 01:46 AM, Sage Weil wrote:
> On Sat, 26 Aug 2017, Linux Chips wrote:
>> On 08/24/2017 06:58 AM, Sage Weil wrote:
>>>
>>> Okay, so I think the combination of (1) removing empty PGs and (2) pruning
>>> past_intervals will help.  (1) can be scripted by looking in
>>> current/$pg_HEAD directories and picking out the ones with 0 or 1 objects
>>> in them, doing ceph-objecstore-tool export to make a backup (just in
>>> case), and then removing them (with ceph-objectstore-tool).  Be careful of
>>> PGs for empty pools since those will be naturally empty (and you want
>>> to keep them).
>>>
>>> For (2), see the wip-prune-past-intervals-jewel branch in ceph-ci.git.. if
>>> that is applied to the kraken branch it ought ot work (although it's
>>> untested).  Alternatively, you can just upgrade to luminous, as it
>>> implements a more sophisticated version of the same thing.  You need to
>>> upgrade mons, mark all osds down, upgrade osds and start at least one of
>>> them, and then set 'ceph osd require-osd-release luminous' before it'll
>>> switch to the new past intervals representation.  Definitely test it on
>>> your test cluster to ensure it reduces the memory usage!
>>>
>>> If that doesn't sort things out we'll need to see a heap profile for an
>>> OOMing OSD to make sure we know what is using all of the RAM...
>>>
>>> sage
>>>
>>
>> well, big thank you sage. we tested the upgrade on the test cluster. and it
>> did work in an awesome way. and we did not even needed to remove any pg with
>> the tool.
> 
> OMG what a relief!  This is great news for a Friday night!  :)
> 
>> I read about the prune thing in the release notes, so when our attempts failed
>> to start the cluster, we tried upgrading, but it did not help. it turned out
>> that we missed the 'ceph osd require-osd-release luminous' thing. I mean we
>> was looking on the command in the release notes upgrade section, and said to
>> each other "it dose not matter, it would only restrict the old osds from
>> joining" and moved on. damn, we would be up a week ago.
>> having said that, I think the release notes should highlight this in the
>> future.
> 
> Good point--I'll update the wording to make it clear that a lot of new
> behavior does not kick in until the switch is flipped.
> 
>> now we have upgraded the production cluster, and it is up and running now,
>> memory foot print was down to the tenth. the largest ram using osd i saw was
>> about 6.5GB.
>> but we faced some issues, particularly OSDs crashing with "FAILED
>> assert(interval.last > last)"
> 
> Just to clarify: this production cluster never ran the hacky kraken patch
> I posted that prune past intervals, right?  If so, then yes, please open a
> ticket with any/all osd.299 bugs you still have.  If it ran the kraken
> patch, then let's not bother--I don't want to confuse the situation with
> logs from that weird code.no we did not run any patched versions, this cluster only ran on the 
packages from the official repo.
any more info we need to get into the bug report before i clean the osds up?
> 
> Anyway, I'm delighted you're back up (and I'm sorry the release notes
> wording didn't help lead you there a week ago)!
> 
> FWIW the 6.5gb still sounds very high; I'd confirm that after the cluster
> stabilizes a restarted OSD shrinks back down to a more typical size (I
> suspect the allocator isn't releasing memory back to the OS due to
> fragmentation etc).
to be clear here, the 6.5 was during peering operation. the usage got 
lower after a few minuets. they are now at about 2-2.5GB. sometimes they 
spike to 4G, i think when starting a new recovery or something.
another thing we noticed. in kraken (and jewel) if the noup is set, the 
starting osd will consume about 3G ram by the time it is waiting for the 
noup flag removal. while in luminous, it was about 700-800 MB.

> 
> Thanks, and enjoy the weekend!
> sage
> 
> 
>>
>>
>> logs:
>>
>>     -34> 2017-08-26 00:38:00.505114 7f14556b4d00  0 osd.299 1085665 load_pgs
>> opened 455 pgs
>>     -33> 2017-08-26 00:38:00.505787 7f14556b4d00 10 osd.299 1085665 19.f1e
>> needs 1050342-1085230
>>     -32> 2017-08-26 00:38:00.505814 7f14556b4d00  1 osd.299 1085665
>> build_past_intervals_parallel over 1050342-1085230
>>     -31> 2017-08-26 00:38:00.505818 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050342
>>     -30> 2017-08-26 00:38:00.505824 7f14556b4d00 20 osd.299 0 get_map 1050342 -
>> loading and decoding 0x7f14b3dfb0c0
>>     -29> 2017-08-26 00:38:00.506245 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050342 780781 bytes
>>     -28> 2017-08-26 00:38:00.508539 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050342 pg 19.f1e first map, acting [80]
>> up [80], same_interval_since = 1050342
>>     -27> 2017-08-26 00:38:00.508547 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050343
>>     -26> 2017-08-26 00:38:00.508550 7f14556b4d00 20 osd.299 0 get_map 1050343 -
>> loading and decoding 0x7f14b3dfad80
>>     -25> 2017-08-26 00:38:00.508997 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050343 781371 bytes
>>     -24> 2017-08-26 00:38:00.511176 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050344
>>     -23> 2017-08-26 00:38:00.511196 7f14556b4d00 20 osd.299 0 get_map 1050344 -
>> loading and decoding 0x7f14b3dfb740
>>     -22> 2017-08-26 00:38:00.511625 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050344 782446 bytes
>>     -21> 2017-08-26 00:38:00.513813 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050345
>>     -20> 2017-08-26 00:38:00.513820 7f14556b4d00 20 osd.299 0 get_map 1050345 -
>> loading and decoding 0x7f14b3dfba80
>>     -19> 2017-08-26 00:38:00.514260 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050345 782071 bytes
>>     -18> 2017-08-26 00:38:00.516463 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050346
>>     -17> 2017-08-26 00:38:00.516488 7f14556b4d00 20 osd.299 0 get_map 1050346 -
>> loading and decoding 0x7f14b79c4000
>>     -16> 2017-08-26 00:38:00.516927 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050346 781955 bytes
>>     -15> 2017-08-26 00:38:00.519047 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050347
>>     -14> 2017-08-26 00:38:00.519054 7f14556b4d00 20 osd.299 0 get_map 1050347 -
>> loading and decoding 0x7f14b79c4340
>>     -13> 2017-08-26 00:38:00.519500 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050347 781930 bytes
>>     -12> 2017-08-26 00:38:00.521612 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050348
>>     -11> 2017-08-26 00:38:00.521619 7f14556b4d00 20 osd.299 0 get_map 1050348 -
>> loading and decoding 0x7f14b79c4680
>>     -10> 2017-08-26 00:38:00.522074 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050348 784883 bytes
>>      -9> 2017-08-26 00:38:00.524245 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050349
>>      -8> 2017-08-26 00:38:00.524252 7f14556b4d00 20 osd.299 0 get_map 1050349 -
>> loading and decoding 0x7f14b79c49c0
>>      -7> 2017-08-26 00:38:00.524706 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050349 785081 bytes
>>      -6> 2017-08-26 00:38:00.526854 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050350
>>      -5> 2017-08-26 00:38:00.526861 7f14556b4d00 20 osd.299 0 get_map 1050350 -
>> loading and decoding 0x7f14b79c4d00
>>      -4> 2017-08-26 00:38:00.527330 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050350 785948 bytes
>>      -3> 2017-08-26 00:38:00.529505 7f14556b4d00 10 osd.299 1085665
>> build_past_intervals_parallel epoch 1050351
>>      -2> 2017-08-26 00:38:00.529512 7f14556b4d00 20 osd.299 0 get_map 1050351 -
>> loading and decoding 0x7f14b79c5040
>>      -1> 2017-08-26 00:38:00.529979 7f14556b4d00 10 osd.299 0 add_map_bl
>> 1050351 788650 bytes
>>       0> 2017-08-26 00:38:00.534373 7f14556b4d00 -1
>> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/12.1.4/rpm/el7/BUILD/ceph-12.1.4/src/osd/osd_types.cc:
>> In function 'virtual void pi_compact_rep::add_interval(bool, const
>> PastIntervals::pg_interval_t&)' thread 7f14556b4d00 time 2017-08-26
>> 00:38:00.532119
>> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/12.1.4/rpm/el7/BUILD/ceph-12.1.4/src/osd/osd_types.cc:
>> 3205: FAILED assert(interval.last > last)
>>
>>   ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>>   1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x110) [0x7f145612f420]
>>   2: (pi_compact_rep::add_interval(bool, PastIntervals::pg_interval_t
>> const&)+0x3b2) [0x7f1455e030b2]
>>   3: (PastIntervals::check_new_interval(int, int, std::vector<int,
>> std::allocator<int> > const&, std::vector<int, std::allocator<int> > const&,
>> int, int, std::vector<int, std::allocator<int> > const&, std::vector<int,
>> std::allocator<int> > const&, unsigned int, unsigned int,
>> std::shared_ptr<OSDMap const>, std::shared_ptr<OSDMap const>, pg_t,
>> IsPGRecoverablePredicate*, PastIntervals*, std::ostream*)+0x380)
>> [0x7f1455de8ab0]
>>   4: (OSD::build_past_intervals_parallel()+0xa8f) [0x7f1455bbc71f]
>>   5: (OSD::load_pgs()+0x503) [0x7f1455bbef13]
>>   6: (OSD::init()+0x2179) [0x7f1455bd7779]
>>   7: (main()+0x2def) [0x7f1455add56f]
>>   8: (__libc_start_main()+0xf5) [0x7f1451d14b35]
>>   9: (()+0x4ac8a6) [0x7f1455b7b8a6]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
>> interpret this.
>>
>> --- logging levels ---
>>     0/ 5 none
>>     0/ 1 lockdep
>>     0/ 1 context
>>     1/ 1 crush
>>     1/ 5 mds
>>     1/ 5 mds_balancer
>>     1/ 5 mds_locker
>>     1/ 5 mds_log
>>     1/ 5 mds_log_expire
>>     1/ 5 mds_migrator
>>     0/ 1 buffer
>>     0/ 1 timer
>>     0/ 1 filer
>>     0/ 1 striper
>>     0/ 1 objecter
>>     0/ 5 rados
>>     0/ 5 rbd
>>     0/ 5 rbd_mirror
>>     0/ 5 rbd_replay
>>     0/ 5 journaler
>>     0/ 5 objectcacher
>>     0/ 5 client
>>    20/20 osd
>>     0/ 5 optracker
>>     0/ 5 objclass
>>     1/ 3 filestore
>>     1/ 3 journal
>>     0/ 5 ms
>>     1/ 5 mon
>>     0/10 monc
>>     1/ 5 paxos
>>     0/ 5 tp
>>     1/ 5 auth
>>     1/ 5 crypto
>>     1/ 1 finisher
>>     1/ 5 heartbeatmap
>>     1/ 5 perfcounter
>>     1/ 5 rgw
>>     1/10 civetweb
>>     1/ 5 javaclient
>>     1/ 5 asok
>>     1/ 1 throttle
>>     0/ 0 refs
>>     1/ 5 xio
>>     1/ 5 compressor
>>     1/ 5 bluestore
>>     1/ 5 bluefs
>>     1/ 3 bdev
>>     1/ 5 kstore
>>     4/ 5 rocksdb
>>     4/ 5 leveldb
>>     4/ 5 memdb
>>     1/ 5 kinetic
>>     1/ 5 fuse
>>     1/ 5 mgr
>>     1/ 5 mgrc
>>     1/ 5 dpdk
>>     1/ 5 eventtrace
>>    -2/-2 (syslog threshold)
>>    -1/-1 (stderr threshold)
>>    max_recent     10000
>>    max_new         1000
>>    log_file /var/log/ceph/ceph-osd.299.log
>> --- end dump of recent events ---
>> 2017-08-26 00:38:00.572479 7f14556b4d00 -1 *** Caught signal (Aborted) **
>>   in thread 7f14556b4d00 thread_name:ceph-osd
>>
>>   ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>>   1: (()+0xa21a01) [0x7f14560f0a01]
>>   2: (()+0xf370) [0x7f1452cfe370]
>>   3: (gsignal()+0x37) [0x7f1451d281d7]
>>   4: (abort()+0x148) [0x7f1451d298c8]
>>   5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x284) [0x7f145612f594]
>>   6: (pi_compact_rep::add_interval(bool, PastIntervals::pg_interval_t
>> const&)+0x3b2) [0x7f1455e030b2]
>>   7: (PastIntervals::check_new_interval(int, int, std::vector<int,
>> std::allocator<int> > const&, std::vector<int, std::allocator<int> > const&,
>> int, int, std::vector<int, std::allocator<int> > const&, std::vector<int,
>> std::allocator<int> > const&, unsigned int, unsigned int,
>> std::shared_ptr<OSDMap const>, std::shared_ptr<OSDMap const>, pg_t,
>> IsPGRecoverablePredicate*, PastIntervals*, std::ostream*)+0x380)
>> [0x7f1455de8ab0]
>>   8: (OSD::build_past_intervals_parallel()+0xa8f) [0x7f1455bbc71f]
>>   9: (OSD::load_pgs()+0x503) [0x7f1455bbef13]
>>   10: (OSD::init()+0x2179) [0x7f1455bd7779]
>>   11: (main()+0x2def) [0x7f1455add56f]
>>   12: (__libc_start_main()+0xf5) [0x7f1451d14b35]
>>   13: (()+0x4ac8a6) [0x7f1455b7b8a6]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
>> interpret this.
>>
>> --- begin dump of recent events ---
>>       0> 2017-08-26 00:38:00.572479 7f14556b4d00 -1 *** Caught signal (Aborted)
>> **
>>   in thread 7f14556b4d00 thread_name:ceph-osd
>>
>>   ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>>   1: (()+0xa21a01) [0x7f14560f0a01]
>>   2: (()+0xf370) [0x7f1452cfe370]
>>   3: (gsignal()+0x37) [0x7f1451d281d7]
>>   4: (abort()+0x148) [0x7f1451d298c8]
>>   5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x284) [0x7f145612f594]
>>   6: (pi_compact_rep::add_interval(bool, PastIntervals::pg_interval_t
>> const&)+0x3b2) [0x7f1455e030b2]
>>   7: (PastIntervals::check_new_interval(int, int, std::vector<int,
>> std::allocator<int> > const&, std::vector<int, std::allocator<int> > const&,
>> int, int, std::vector<int, std::allocator<int> > const&, std::vector<int,
>> std::allocator<int> > const&, unsigned int, unsigned int,
>> std::shared_ptr<OSDMap const>, std::shared_ptr<OSDMap const>, pg_t,
>> IsPGRecoverablePredicate*, PastIntervals*, std::ostream*)+0x380)
>> [0x7f1455de8ab0]
>>   8: (OSD::build_past_intervals_parallel()+0xa8f) [0x7f1455bbc71f]
>>   9: (OSD::load_pgs()+0x503) [0x7f1455bbef13]
>>   10: (OSD::init()+0x2179) [0x7f1455bd7779]
>>   11: (main()+0x2def) [0x7f1455add56f]
>>   12: (__libc_start_main()+0xf5) [0x7f1451d14b35]
>>   13: (()+0x4ac8a6) [0x7f1455b7b8a6]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
>> interpret this.
>>
>> --- logging levels ---
>>     0/ 5 none
>>     0/ 1 lockdep
>>     0/ 1 context
>>     1/ 1 crush
>>     1/ 5 mds
>>     1/ 5 mds_balancer
>>     1/ 5 mds_locker
>>     1/ 5 mds_log
>>     1/ 5 mds_log_expire
>>     1/ 5 mds_migrator
>>     0/ 1 buffer
>>     0/ 1 timer
>>     0/ 1 filer
>>     0/ 1 striper
>>     0/ 1 objecter
>>     0/ 5 rados
>>     0/ 5 rbd
>>     0/ 5 rbd_mirror
>>     0/ 5 rbd_replay
>>     0/ 5 journaler
>>     0/ 5 objectcacher
>>     0/ 5 client
>>    20/20 osd
>>     0/ 5 optracker
>>     0/ 5 objclass
>>     1/ 3 filestore
>>     1/ 3 journal
>>     0/ 5 ms
>>     1/ 5 mon
>>     0/10 monc
>>     1/ 5 paxos
>>     0/ 5 tp
>>     1/ 5 auth
>>     1/ 5 crypto
>>     1/ 1 finisher
>>     1/ 5 heartbeatmap
>>     1/ 5 perfcounter
>>     1/ 5 rgw
>>     1/10 civetweb
>>     1/ 5 javaclient
>>     1/ 5 asok
>>     1/ 1 throttle
>>     0/ 0 refs
>>     1/ 5 xio
>>     1/ 5 compressor
>>     1/ 5 bluestore
>>     1/ 5 bluefs
>>     1/ 3 bdev
>>     1/ 5 kstore
>>     4/ 5 rocksdb
>>     4/ 5 leveldb
>>     4/ 5 memdb
>>     1/ 5 kinetic
>>     1/ 5 fuse
>>     1/ 5 mgr
>>     1/ 5 mgrc
>>     1/ 5 dpdk
>>     1/ 5 eventtrace
>>    -2/-2 (syslog threshold)
>>    -1/-1 (stderr threshold)
>>    max_recent     10000
>>    max_new         1000
>>    log_file /var/log/ceph/ceph-osd.299.log
>> --- end dump of recent events ---
>>
>>
>> ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-299/ --op info --pgid
>> 19.f1e
>> {
>>      "pgid": "19.f1e",
>>      "last_update": "0'0",
>>      "last_complete": "0'0",
>>      "log_tail": "0'0",
>>      "last_user_version": 0,
>>      "last_backfill": "MAX",
>>      "last_backfill_bitwise": 0,
>>      "purged_snaps": [],
>>      "history": {
>>          "epoch_created": 1084817,
>>          "epoch_pool_created": 1084817,
>>          "last_epoch_started": 1085232,
>>          "last_interval_started": 1085230,
>>          "last_epoch_clean": 1050342,
>>          "last_interval_clean": 1050342,
>>          "last_epoch_split": 0,
>>          "last_epoch_marked_full": 1061015,
>>          "same_up_since": 1085230,
>>          "same_interval_since": 1085230,
>>          "same_primary_since": 1085230,
>>          "last_scrub": "960114'865853",
>>          "last_scrub_stamp": "2017-08-25 17:32:06.181006",
>>          "last_deep_scrub": "952725'861179",
>>          "last_deep_scrub_stamp": "2017-08-25 17:32:06.181006",
>>          "last_clean_scrub_stamp": "2017-08-25 17:32:06.181006"
>>      },
>>      "stats": {
>>          "version": "0'0",
>>          "reported_seq": "424",
>>          "reported_epoch": "1085650",
>>          "state": "active+undersized+degraded",
>>          "last_fresh": "2017-08-25 18:52:46.520078",
>>          "last_change": "2017-08-25 18:38:16.356266",
>>          "last_active": "2017-08-25 18:52:46.520078",
>>          "last_peered": "2017-08-25 18:52:46.520078",
>>          "last_clean": "2017-08-25 17:32:06.181006",
>>          "last_became_active": "2017-08-25 18:38:16.356266",
>>          "last_became_peered": "2017-08-25 18:38:16.356266",
>>          "last_unstale": "2017-08-25 18:52:46.520078",
>>          "last_undegraded": "2017-08-25 18:38:16.304877",
>>          "last_fullsized": "2017-08-25 18:38:16.304877",
>>          "mapping_epoch": 1085230,
>>          "log_start": "0'0",
>>          "ondisk_log_start": "0'0",
>>          "created": 1084817,
>>          "last_epoch_clean": 1050342,
>>          "parent": "0.0",
>>          "parent_split_bits": 0,
>>          "last_scrub": "960114'865853",
>>          "last_scrub_stamp": "2017-08-25 17:32:06.181006",
>>          "last_deep_scrub": "952725'861179",
>>          "last_deep_scrub_stamp": "2017-08-25 17:32:06.181006",
>>          "last_clean_scrub_stamp": "2017-08-25 17:32:06.181006",
>>          "log_size": 0,
>>          "ondisk_log_size": 0,
>>          "stats_invalid": false,
>>          "dirty_stats_invalid": false,
>>          "omap_stats_invalid": false,
>>          "hitset_stats_invalid": false,
>>          "hitset_bytes_stats_invalid": false,
>>          "pin_stats_invalid": false,
>>          "stat_sum": {
>>              "num_bytes": 0,
>>              "num_objects": 0,
>>              "num_object_clones": 0,
>>              "num_object_copies": 0,
>>              "num_objects_missing_on_primary": 0,
>>              "num_objects_missing": 0,
>>              "num_objects_degraded": 0,
>>              "num_objects_misplaced": 0,
>>              "num_objects_unfound": 0,
>>              "num_objects_dirty": 0,
>>              "num_whiteouts": 0,
>>              "num_read": 0,
>>              "num_read_kb": 0,
>>              "num_write": 0,
>>              "num_write_kb": 0,
>>              "num_scrub_errors": 0,
>>              "num_shallow_scrub_errors": 0,
>>              "num_deep_scrub_errors": 0,
>>              "num_objects_recovered": 0,
>>              "num_bytes_recovered": 0,
>>              "num_keys_recovered": 0,
>>              "num_objects_omap": 0,
>>              "num_objects_hit_set_archive": 0,
>>              "num_bytes_hit_set_archive": 0,
>>              "num_flush": 0,
>>              "num_flush_kb": 0,
>>              "num_evict": 0,
>>              "num_evict_kb": 0,
>>              "num_promote": 0,
>>              "num_flush_mode_high": 0,
>>              "num_flush_mode_low": 0,
>>              "num_evict_mode_some": 0,
>>              "num_evict_mode_full": 0,
>>              "num_objects_pinned": 0,
>>              "num_legacy_snapsets": 0
>>          },
>>          "up": [
>>              299
>>          ],
>>          "acting": [
>>              299
>>          ],
>>          "blocked_by": [],
>>          "up_primary": 299,
>>          "acting_primary": 299
>>      },
>>      "empty": 1,
>>      "dne": 0,
>>      "incomplete": 0,
>>      "last_epoch_started": 1085232,
>>      "hit_set_history": {
>>          "current_last_update": "0'0",
>>          "history": []
>>      }
>> }
>>
>>
>> ll /var/lib/ceph/osd/ceph-299/current/19.f1e_head/
>> total 0
>> -rw-r--r-- 1 root root 0 Aug 25 18:38 __head_00000F1E__13
>>
>> ceph pg 19.f1e query
>> .
>> .
>>              "blocked": "peering is blocked due to down osds",
>>              "down_osds_we_would_probe": [
>>                  299
>>              ],
>>              "peering_blocked_by": [
>>                  {
>>                      "osd": 299,
>>                      "current_lost_at": 0,
>>                      "comment": "starting or marking this osd lost may let us
>> proceed"
>>                  }
>>              ]
>> .
>> .
>> .
>>
>>
>>
>> removing the pg with ceph-objectstore-tool did the trick. but i am not sure if
>> that will happen to a pg with real data in it or not.
>> should i report this in the bug tracker?
>>
>> thanks
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

