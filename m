From: David Zafman <david.zafman@inktank.com>
Subject: Re: 4 failed, 298 passed in dzafman-2013-09-23_17:50:06-rados-wip-5862-testing-basic-plana
Date: Tue, 24 Sep 2013 12:24:32 -0700
Message-ID: <9CF58714-945B-4B98-9E6B-FEDB7598294E@inktank.com>
References: <20130924054800.98114281785@teuthology.front.sepia.ceph.com> <5C49DD20-37BB-4462-9DE1-E9CBE94076E5@inktank.com> <alpine.DEB.2.00.1309241202150.25142@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:54376 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3IXTYh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 15:24:37 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so5578014obc.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 12:24:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309241202150.25142@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel@vger.kernel.org


The osd.4 crash in 13443 is bug #5951:

2013-09-23 21:23:28.378428 1034e700  0 filestore(/var/lib/ceph/osd/ceph-4)  error (17) File exists not handled on operation 20 (6579.0.0, or op 0, counting from 0)
2013-09-23 21:23:28.862204 1034e700  0 filestore(/var/lib/ceph/osd/ceph-4) unexpected error code
2013-09-23 21:23:28.864816 1034e700  0 filestore(/var/lib/ceph/osd/ceph-4)  transaction dump:
{ "ops": [
        { "op_num": 0,
          "op_name": "mkcoll",
          "collection": "4.6_head"},
        { "op_num": 1,
          "op_name": "collection_setattr",
          "collection": "4.6_head",
          "name": "info",
          "length": 1},
        { "op_num": 2,
          "op_name": "omap_setkeys",
          "collection": "meta",
          "oid": "16ef7597\/infos\/head\/\/-1",
          "attr_lens": { "4.6_biginfo": 125,
              "4.6_epoch": 4,
              "4.6_info": 576}},
        { "op_num": 3,
          "op_name": "touch",
          "collection": "meta",
          "oid": "1039d44e\/pglog_4.6\/0\/\/-1"},
        { "op_num": 4,
          "op_name": "omap_rmkeys",
          "collection": "meta",
          "oid": "1039d44e\/pglog_4.6\/0\/\/-1"},
        { "op_num": 5,
          "op_name": "omap_setkeys",
          "collection": "meta",
          "oid": "1039d44e\/pglog_4.6\/0\/\/-1",
          "attr_lens": {}}]}

2013-09-23 21:23:28.959220 1a282700  5 osd.4 pg_epoch: 424 pg[32.0( empty local-les=424 n=0 ec=96 les/c 400/400 419/419/419) [4,1] r=0 lpr=419 pi=364-418/6 mlcod 0'0 active] enter
 Started/Primary/Active/Activating
2013-09-23 21:23:29.116768 1034e700 -1 os/FileStore.cc: In function 'unsigned int FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int)' thread 1034e700 time 2013-0
 9-23 21:23:28.920055
os/FileStore.cc: 2461: FAILED assert(0 == "unexpected error")

 ceph version 0.69-220-g4f7526a (4f7526a785692795ee29f7101b8b18482b4c6e11)
 1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned long, int)+0xffc) [0x72473c]
 2: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long, ThreadPool::TPHandle*)+0x71) [0x72b241]
 3: (FileStore::_do_op(FileStore::OpSequencer*, ThreadPool::TPHandle&)+0x291) [0x72b4f1]
 4: (ThreadPool::worker(ThreadPool::WorkThread*)+0x4e6) [0x93da36]
 5: (ThreadPool::WorkThread::entry()+0x10) [0x93f840]
 6: (()+0x7e9a) [0x503be9a]
 7: (clone()+0x6d) [0x6c71ccd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

David Zafman
Senior Developer
http://www.inktank.com

On Sep 24, 2013, at 12:03 PM, Sage Weil <sage@inktank.com> wrote:

> On Tue, 24 Sep 2013, David Zafman wrote:
>> 
>> Rados suite test run results for wip-5862.  2 "scrub mismatch" from mon
>> (known problem).  2 are valgrind issues found with mds and osd. 
> 
> What is the osd valgrind failure?  And the osd.4 crash on 13443?
> 
> (Note that the teuthology.log will include message about valgrind issues 
> found in the mds log, but does not generate an actual error about it.)
> 
> Thanks!
> sage
> 
> 
>> 
>> David Zafman
>> Senior Developer
>> http://www.inktank.com
>> 
>> Begin forwarded message:
>> 
>>      From: teuthworker@teuthology.front.sepia.ceph.com
>> Subject: 4 failed, 298 passed in
>> dzafman-2013-09-23_17:50:06-rados-wip-5862-testing-basic-plana
>> Date: September 23, 2013 10:48:00 PM PDT
>> To: david.zafman@inktank.com
>> 
>> Test Run:
>> dzafman-2013-09-23_17:50:06-rados-wip-5862-testing-basic-plana
>> =================================================================
>> logs:  http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:50:06-rados-wip
>> -5862-testing-basic-plana/
>> failed: 4
>> hung:   0
>> passed: 298
>> 
>> Failed
>> =================================================================
>> [13187]  rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/snaps-few-objects.yaml}
>> -----------------------------------------------------------------
>> time:   2095s
>> log:   http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:50:06-rados-wi
>> p-5862-testing-basic-plana/13187/
>> 
>>    "2013-09-23 18:22:37.805204 mon.0 10.214.132.24:6789/0 514 : [ERR]
>> scrub
>>    mismatch" in cluster log
>> 
>> [13449]  rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
>> validater/valgrind.yaml}
>> -----------------------------------------------------------------
>> time:   1067s
>> log:   http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:50:06-rados-wi
>> p-5862-testing-basic-plana/13449/
>> 
>>    saw valgrind issues
>> 
>> [13443]  rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
>> validater/valgrind.yaml}
>> -----------------------------------------------------------------
>> time:   1307s
>> log:   http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:50:06-rados-wi
>> p-5862-testing-basic-plana/13443/
>> 
>>    timed out waiting for admin_socket to appear after osd.4 restart
>> 
>> [13227]  rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/snaps-few-objects.yaml}
>> -----------------------------------------------------------------
>> time:   2374s
>> log:   http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:50:06-rados-wi
>> p-5862-testing-basic-plana/13227/
>> 
>>    "2013-09-23 18:41:57.370588 mon.0 10.214.132.34:6789/0 20 : [ERR]
>> scrub
>>    mismatch" in cluster log
>> 
>> 
>> Passed
>> =================================================================
>> [13329] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/readwrite.yaml}
>> time:    1327s
>> 
>> [13414] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1926s
>> 
>> [13278] rados/singleton/{all/mon-thrasher.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    811s
>> 
>> [13368] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    322s
>> 
>> [13359] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1529s
>> 
>> [13403] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1651s
>> 
>> [13402] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1878s
>> 
>> [13405] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    836s
>> 
>> [13404] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    243s
>> 
>> [13407] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1249s
>> 
>> [13358] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/radosbench.yaml}
>> time:    3144s
>> 
>> [13360] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1994s
>> 
>> [13361] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1894s
>> 
>> [13362] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    276s
>> 
>> [13363] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    966s
>> 
>> [13364] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2300s
>> 
>> [13365] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml workloads/readwrite.yaml}
>> time:    1374s
>> 
>> [13366] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2202s
>> 
>> [13367] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1945s
>> 
>> [13386] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    279s
>> 
>> [13387] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    988s
>> 
>> [13295] rados/singleton-nomsgr/{all/objectcacher-stress.yaml}
>> time:    1144s
>> 
>> [13243] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2400s
>> 
>> [13242] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    445s
>> 
>> [13168] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/rados_5925.yaml}
>> time:    200s
>> 
>> [13169] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1455s
>> 
>> [13247] rados/multimon/{clusters/21.yaml msgr-failures/many.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    186s
>> 
>> [13246] rados/multimon/{clusters/21.yaml msgr-failures/few.yaml
>> tasks/mon_recovery.yaml}
>> time:    888s
>> 
>> [13245] rados/multimon/{clusters/21.yaml msgr-failures/few.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    191s
>> 
>> [13244] rados/multimon/{clusters/21.yaml msgr-failures/few.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    171s
>> 
>> [13162] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_workunit_loadgen_mix.yaml}
>> time:    1454s
>> 
>> [13163] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_workunit_loadgen_mostlyread.yaml}
>> time:    6072s
>> 
>> [13160] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_stress_watch.yaml}
>> time:    469s
>> 
>> [13161] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_workunit_loadgen_big.yaml}
>> time:    2034s
>> 
>> [13166] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    795s
>> 
>> [13167] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2350s
>> 
>> [13164] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/rados_5925.yaml}
>> time:    271s
>> 
>> [13165] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1082s
>> 
>> [13199] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2158s
>> 
>> [13412] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2124s
>> 
>> [13413] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml workloads/readwrite.yaml}
>> time:    1461s
>> 
>> [13410] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    285s
>> 
>> [13198] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    378s
>> 
>> [13416] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    261s
>> 
>> [13417] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/rados_api_tests.yaml}
>> time:    912s
>> 
>> [13389] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1405s
>> 
>> [13415] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1909s
>> 
>> [13319] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    2043s
>> 
>> [13323] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/readwrite.yaml}
>> time:    1258s
>> 
>> [13419] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/readwrite.yaml}
>> time:    1244s
>> 
>> [13318] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1883s
>> 
>> [13157] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_api_tests.yaml}
>> time:    1056s
>> 
>> [13156] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_workunit_loadgen_mostlyread.yaml}
>> time:    6006s
>> 
>> [13155] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_workunit_loadgen_mix.yaml}
>> time:    1477s
>> 
>> [13154] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_workunit_loadgen_big.yaml}
>> time:    2115s
>> 
>> [13153] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_stress_watch.yaml}
>> time:    449s
>> 
>> [13152] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_python.yaml}
>> time:    461s
>> 
>> [13151] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_cls_all.yaml}
>> time:    360s
>> 
>> [13150] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml tasks/rados_api_tests.yaml}
>> time:    1063s
>> 
>> [13248] rados/multimon/{clusters/21.yaml msgr-failures/many.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    203s
>> 
>> [13314] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    286s
>> 
>> [13317] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml workloads/readwrite.yaml}
>> time:    1199s
>> 
>> [13316] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2858s
>> 
>> [13311] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1359s
>> 
>> [13310] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2978s
>> 
>> [13159] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_python.yaml}
>> time:    545s
>> 
>> [13158] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml tasks/rados_cls_all.yaml}
>> time:    537s
>> 
>> [13395] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/readwrite.yaml}
>> time:    1420s
>> 
>> [13193] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1305s
>> 
>> [13397] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1918s
>> 
>> [13396] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1910s
>> 
>> [13258] rados/multimon/{clusters/6.yaml msgr-failures/few.yaml
>> tasks/mon_recovery.yaml}
>> time:    400s
>> 
>> [13259] rados/multimon/{clusters/6.yaml msgr-failures/many.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    171s
>> 
>> [13393] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/rados_api_tests.yaml}
>> time:    876s
>> 
>> [13219] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2475s
>> 
>> [13254] rados/multimon/{clusters/3.yaml msgr-failures/many.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    152s
>> 
>> [13255] rados/multimon/{clusters/3.yaml msgr-failures/many.yaml
>> tasks/mon_recovery.yaml}
>> time:    404s
>> 
>> [13256] rados/multimon/{clusters/6.yaml msgr-failures/few.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    162s
>> 
>> [13257] rados/multimon/{clusters/6.yaml msgr-failures/few.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    177s
>> 
>> [13250] rados/multimon/{clusters/3.yaml msgr-failures/few.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    173s
>> 
>> [13251] rados/multimon/{clusters/3.yaml msgr-failures/few.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    153s
>> 
>> [13252] rados/multimon/{clusters/3.yaml msgr-failures/few.yaml
>> tasks/mon_recovery.yaml}
>> time:    410s
>> 
>> [13253] rados/multimon/{clusters/3.yaml msgr-failures/many.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    149s
>> 
>> [13322] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/radosbench.yaml}
>> time:    2535s
>> 
>> [13398] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    308s
>> 
>> [13288] rados/singleton/{all/rest-api.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    203s
>> 
>> [13409] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1692s
>> 
>> [13313] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1892s
>> 
>> [13429] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    842s
>> 
>> [13408] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2001s
>> 
>> [13427] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1642s
>> 
>> [13315] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    857s
>> 
>> [13425] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/readwrite.yaml}
>> time:    1208s
>> 
>> [13312] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1905s
>> 
>> [13423] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/rados_api_tests.yaml}
>> time:    862s
>> 
>> [13422] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    256s
>> 
>> [13421] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1793s
>> 
>> [13420] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1926s
>> 
>> [13442] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
>> validater/lockdep.yaml}
>> time:    877s
>> 
>> [13451] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
>> validater/valgrind.yaml}
>> time:    396s
>> 
>> [13308] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    241s
>> 
>> [13309] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    744s
>> 
>> [13306] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1787s
>> 
>> [13307] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1836s
>> 
>> [13304] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/radosbench.yaml}
>> time:    2162s
>> 
>> [13305] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml workloads/readwrite.yaml}
>> time:    1282s
>> 
>> [13302] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    261s
>> 
>> [13303] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/rados_api_tests.yaml}
>> time:    718s
>> 
>> [13300] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1910s
>> 
>> [13301] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1772s
>> 
>> [13229] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1458s
>> 
>> [13228] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/rados_5925.yaml}
>> time:    221s
>> 
>> [13384] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2184s
>> 
>> [13385] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1953s
>> 
>> [13382] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2330s
>> 
>> [13383] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1607s
>> 
>> [13380] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    304s
>> 
>> [13381] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1147s
>> 
>> [13221] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1125s
>> 
>> [13220] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/rados_5925.yaml}
>> time:    299s
>> 
>> [13223] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2388s
>> 
>> [13222] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    433s
>> 
>> [13225] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/rados_api_tests.yaml}
>> time:    1084s
>> 
>> [13224] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/rados_5925.yaml}
>> time:    277s
>> 
>> [13388] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/radosbench.yaml}
>> time:    3196s
>> 
>> [13226] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/rados_mon_workunits.yaml}
>> time:    458s
>> 
>> [13392] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    223s
>> 
>> [13438] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1898s
>> 
>> [13439] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1833s
>> 
>> [13430] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2315s
>> 
>> [13431] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1446s
>> 
>> [13432] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1941s
>> 
>> [13433] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1854s
>> 
>> [13434] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    239s
>> 
>> [13435] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    889s
>> 
>> [13436] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2498s
>> 
>> [13437] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1365s
>> 
>> [13339] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    759s
>> 
>> [13338] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    234s
>> 
>> [13369] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/rados_api_tests.yaml}
>> time:    944s
>> 
>> [13333] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    760s
>> 
>> [13332] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    232s
>> 
>> [13331] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1724s
>> 
>> [13330] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1860s
>> 
>> [13337] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1645s
>> 
>> [13336] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1897s
>> 
>> [13335] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1322s
>> 
>> [13334] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/radosbench.yaml}
>> time:    3000s
>> 
>> [13238] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    421s
>> 
>> [13239] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2525s
>> 
>> [13232] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/rados_5925.yaml}
>> time:    254s
>> 
>> [13233] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1515s
>> 
>> [13230] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    481s
>> 
>> [13231] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    3058s
>> 
>> [13236] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/rados_5925.yaml}
>> time:    308s
>> 
>> [13237] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1161s
>> 
>> [13234] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    440s
>> 
>> [13235] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    3006s
>> 
>> [13406] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2481s
>> 
>> [13440] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
>> validater/lockdep.yaml}
>> time:    392s
>> 
>> [13324] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1913s
>> 
>> [13325] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1742s
>> 
>> [13326] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    333s
>> 
>> [13327] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/rados_api_tests.yaml}
>> time:    761s
>> 
>> [13320] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    249s
>> 
>> [13321] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/rados_api_tests.yaml}
>> time:    801s
>> 
>> [13289] rados/singleton/{all/rest-api.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    180s
>> 
>> [13279] rados/singleton/{all/mon-thrasher.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    820s
>> 
>> [13287] rados/singleton/{all/peer.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    309s
>> 
>> [13286] rados/singleton/{all/peer.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    162s
>> 
>> [13285] rados/singleton/{all/osd-recovery.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    258s
>> 
>> [13284] rados/singleton/{all/osd-recovery.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    242s
>> 
>> [13283] rados/singleton/{all/osd-recovery-incomplete.yaml
>> fs/btrfs.yaml msgr-failures/many.yaml}
>> time:    1303s
>> 
>> [13282] rados/singleton/{all/osd-recovery-incomplete.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml}
>> time:    1347s
>> 
>> [13281] rados/singleton/{all/osd-backfill.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    201s
>> 
>> [13280] rados/singleton/{all/osd-backfill.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    263s
>> 
>> [13207] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2241s
>> 
>> [13206] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    508s
>> 
>> [13205] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1202s
>> 
>> [13204] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
>> workloads/rados_5925.yaml}
>> time:    304s
>> 
>> [13203] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2039s
>> 
>> [13202] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    675s
>> 
>> [13201] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1177s
>> 
>> [13200] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/rados_5925.yaml}
>> time:    278s
>> 
>> [13445] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
>> validater/valgrind.yaml}
>> time:    440s
>> 
>> [13444] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
>> validater/lockdep.yaml}
>> time:    348s
>> 
>> [13447] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
>> validater/valgrind.yaml}
>> time:    525s
>> 
>> [13446] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
>> validater/lockdep.yaml}
>> time:    454s
>> 
>> [13441] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
>> validater/valgrind.yaml}
>> time:    549s
>> 
>> [13241] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1274s
>> 
>> [13209] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1526s
>> 
>> [13208] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/rados_5925.yaml}
>> time:    241s
>> 
>> [13411] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/pggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    802s
>> 
>> [13240] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
>> workloads/rados_5925.yaml}
>> time:    318s
>> 
>> [13371] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/readwrite.yaml}
>> time:    1508s
>> 
>> [13428] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    257s
>> 
>> [13401] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml workloads/readwrite.yaml}
>> time:    1265s
>> 
>> [13450] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
>> validater/lockdep.yaml}
>> time:    272s
>> 
>> [13298] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/radosbench.yaml}
>> time:    3243s
>> 
>> [13299] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/readwrite.yaml}
>> time:    1422s
>> 
>> [13353] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml workloads/readwrite.yaml}
>> time:    1460s
>> 
>> [13352] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/radosbench.yaml}
>> time:    2159s
>> 
>> [13355] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1724s
>> 
>> [13354] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1957s
>> 
>> [13357] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/rados_api_tests.yaml}
>> time:    859s
>> 
>> [13356] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/morepggrow.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    244s
>> 
>> [13290] rados/singleton/{all/thrash-rados.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    791s
>> 
>> [13291] rados/singleton/{all/thrash-rados.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    821s
>> 
>> [13292] rados/singleton-nomsgr/{all/filejournal.yaml}
>> time:    181s
>> 
>> [13293]
>> rados/singleton-nomsgr/{all/filestore-idempotent-aio-journal.yaml}
>> time:    7518s
>> 
>> [13294] rados/singleton-nomsgr/{all/filestore-idempotent.yaml}
>> time:    8612s
>> 
>> [13249] rados/multimon/{clusters/21.yaml msgr-failures/many.yaml
>> tasks/mon_recovery.yaml}
>> time:    881s
>> 
>> [13296] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    253s
>> 
>> [13297] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/rados_api_tests.yaml}
>> time:    816s
>> 
>> [13210] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    391s
>> 
>> [13211] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    3040s
>> 
>> [13212] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/rados_5925.yaml}
>> time:    225s
>> 
>> [13213] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1384s
>> 
>> [13214] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    418s
>> 
>> [13215] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2987s
>> 
>> [13216] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/rados_5925.yaml}
>> time:    294s
>> 
>> [13217] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1265s
>> 
>> [13218] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    405s
>> 
>> [13192] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/rados_5925.yaml}
>> time:    462s
>> 
>> [13191] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2665s
>> 
>> [13190] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    382s
>> 
>> [13197] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1144s
>> 
>> [13196] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
>> workloads/rados_5925.yaml}
>> time:    547s
>> 
>> [13195] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2714s
>> 
>> [13194] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    399s
>> 
>> [13391] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1956s
>> 
>> [13448] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
>> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
>> validater/lockdep.yaml}
>> time:    720s
>> 
>> [13426] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1833s
>> 
>> [13346] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/radosbench.yaml}
>> time:    3037s
>> 
>> [13347] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/readwrite.yaml}
>> time:    1379s
>> 
>> [13400] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/radosbench.yaml}
>> time:    2830s
>> 
>> [13394] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/radosbench.yaml}
>> time:    3258s
>> 
>> [13418] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/radosbench.yaml}
>> time:    2363s
>> 
>> [13344] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    261s
>> 
>> [13345] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/rados_api_tests.yaml}
>> time:    927s
>> 
>> [13390] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2411s
>> 
>> [13184] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/rados_5925.yaml}
>> time:    271s
>> 
>> [13185] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/rados_api_tests.yaml}
>> time:    1361s
>> 
>> [13186] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml
>> thrashers/force-sync-many.yaml workloads/rados_mon_workunits.yaml}
>> time:    389s
>> 
>> [13341] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/readwrite.yaml}
>> time:    1393s
>> 
>> [13180] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/rados_5925.yaml}
>> time:    505s
>> 
>> [13181] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1314s
>> 
>> [13182] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    479s
>> 
>> [13183] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2152s
>> 
>> [13348] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1911s
>> 
>> [13349] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/default.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    2113s
>> 
>> [13188] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/rados_5925.yaml}
>> time:    210s
>> 
>> [13189] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1403s
>> 
>> [13276] rados/singleton/{all/mon-config-keys.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    466s
>> 
>> [13342] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1833s
>> 
>> [13424] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/radosbench.yaml}
>> time:    2304s
>> 
>> [13277] rados/singleton/{all/mon-config-keys.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    451s
>> 
>> [13265] rados/multimon/{clusters/9.yaml msgr-failures/many.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    176s
>> 
>> [13264] rados/multimon/{clusters/9.yaml msgr-failures/few.yaml
>> tasks/mon_recovery.yaml}
>> time:    545s
>> 
>> [13267] rados/multimon/{clusters/9.yaml msgr-failures/many.yaml
>> tasks/mon_recovery.yaml}
>> time:    515s
>> 
>> [13266] rados/multimon/{clusters/9.yaml msgr-failures/many.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    173s
>> 
>> [13261] rados/multimon/{clusters/6.yaml msgr-failures/many.yaml
>> tasks/mon_recovery.yaml}
>> time:    466s
>> 
>> [13260] rados/multimon/{clusters/6.yaml msgr-failures/many.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    167s
>> 
>> [13263] rados/multimon/{clusters/9.yaml msgr-failures/few.yaml
>> tasks/mon_clock_with_skews.yaml}
>> time:    177s
>> 
>> [13262] rados/multimon/{clusters/9.yaml msgr-failures/few.yaml
>> tasks/mon_clock_no_skews.yaml}
>> time:    191s
>> 
>> [13269] rados/singleton/{all/admin-socket.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    117s
>> 
>> [13268] rados/singleton/{all/admin-socket.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    117s
>> 
>> [13343] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1701s
>> 
>> [13379] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1767s
>> 
>> [13378] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    1967s
>> 
>> [13377] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/readwrite.yaml}
>> time:    1301s
>> 
>> [13376] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/radosbench.yaml}
>> time:    3180s
>> 
>> [13375] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/rados_api_tests.yaml}
>> time:    905s
>> 
>> [13374] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    318s
>> 
>> [13373] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/snaps-many-objects.yaml}
>> time:    1913s
>> 
>> [13372] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2092s
>> 
>> [13340] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
>> workloads/radosbench.yaml}
>> time:    2672s
>> 
>> [13370] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/osd-delay.yaml thrashers/default.yaml
>> workloads/radosbench.yaml}
>> time:    2708s
>> 
>> [13351] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/rados_api_tests.yaml}
>> time:    921s
>> 
>> [13399] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/rados_api_tests.yaml}
>> time:    753s
>> 
>> [13328] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
>> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
>> workloads/radosbench.yaml}
>> time:    3182s
>> 
>> [13350] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
>> msgr-failures/few.yaml thrashers/mapgap.yaml
>> workloads/admin_socket_objecter_requests.yaml}
>> time:    275s
>> 
>> [13179] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2196s
>> 
>> [13178] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    413s
>> 
>> [13274] rados/singleton/{all/lost-unfound.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    186s
>> 
>> [13275] rados/singleton/{all/lost-unfound.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    215s
>> 
>> [13272] rados/singleton/{all/dump-stuck.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    222s
>> 
>> [13273] rados/singleton/{all/dump-stuck.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    240s
>> 
>> [13270] rados/singleton/{all/cephtool.yaml fs/btrfs.yaml
>> msgr-failures/few.yaml}
>> time:    347s
>> 
>> [13271] rados/singleton/{all/cephtool.yaml fs/btrfs.yaml
>> msgr-failures/many.yaml}
>> time:    367s
>> 
>> [13171] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2857s
>> 
>> [13170] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    724s
>> 
>> [13173] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1300s
>> 
>> [13172] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/rados_5925.yaml}
>> time:    216s
>> 
>> [13175] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/snaps-few-objects.yaml}
>> time:    2867s
>> 
>> [13174] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
>> workloads/rados_mon_workunits.yaml}
>> time:    699s
>> 
>> [13177] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/rados_api_tests.yaml}
>> time:    1168s
>> 
>> [13176] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
>> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
>> workloads/rados_5925.yaml}
>> time:    527s
>> 
>> 
>> 

