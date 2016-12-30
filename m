From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore with ZS
Date: Fri, 30 Dec 2016 09:00:42 -0600
Message-ID: <69cc6c27-1b2b-80c8-ae90-56614383491a@redhat.com>
References: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
 <ca516a6a-0089-2b7c-95aa-3a21de181f35@redhat.com>
 <BY2PR02MB396F6FA5C8A06E86A698208F49B0@BY2PR02MB396.namprd02.prod.outlook.com>
 <f8bc4a5c-1c7e-c311-e9d3-c3f54b77ac24@redhat.com>
 <BY2PR02MB3968021B4711649E7D72C04F49B0@BY2PR02MB396.namprd02.prod.outlook.com>
 <e20ef1b1-b6e4-4c65-b459-2d98cbe447c3@getmailbird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754109AbcL3PAo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Dec 2016 10:00:44 -0500
In-Reply-To: <e20ef1b1-b6e4-4c65-b459-2d98cbe447c3@getmailbird.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haodong Tang <tanghaodong25@gmail.com>, Somnath Roy <somnath.roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org, "Tang, Haodong" <haodong.tang@intel.com>



On 12/29/2016 09:37 PM, Haodong Tang wrote:
> Hi, Somnath, Mark

Hi Haodong,

Red Hat is technically on holiday until Monday.  Not sure if Somnath is 
also off @ Sandisk.  He's probably the best person to ask about the 
logging below.  See my other comments inline.

>
> I'm trying to get your
> patch(https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thread)
> installed and test BlueStore performance with ZetaScale. However getting
> two errors.
>
> When I restarted ceph-osd process, using "killall ceph-osd" and
> "ceph-osd -i ${process_id}
> --pid-file=/var/run/ceph/osd.${process_id}.pid", I got this error.
>
> 2016-12-27 13:21:10.384809 7f3149ee3a00 30
> bluestore.OnodeSpace(0x7f338b0557d8 in 0x7f3154725340) lookup
> 2016-12-27 13:21:10.384810 7f3149ee3a00 30
> bluestore.OnodeSpace(0x7f338b0557d8 in 0x7f3154725340) lookup
> #0:4c000000::::head# hit 0x7f315475b680
> 2016-12-27 13:21:10.384812 7f3149ee3a00 20
> bluestore.onode(0x7f315475b680) flush
> 2016-12-27 13:21:10.384812 7f3149ee3a00 20
> bluestore.onode(0x7f315475b680) flush done
> 2016-12-27 13:21:10.384814 7f3149ee3a00 30 zs: _get:844 ZSReadObject:
> [M0000000000000006c6._biginfo]
> 2016-12-27 13:21:10.384825 7f3149ee3a00 30 zs: _get:869 ZSReadObject
> logging: [1]110
> 2016-12-27 13:21:10.384828 7f3149ee3a00 30
> bluestore(/var/lib/ceph/mnt/osd-device-58-data) omap_get_values  got
> 0x00000000000006c6'._biginfo' -> _biginfo
> 2016-12-27 13:21:10.384831 7f3149ee3a00 30 zs: is_logging:120  M
> 00000000000006c6._fastinfoEkÿ^?(18)
> 2016-12-27 13:21:10.384835 7f3149ee3a00 30 zs: append_logging_prefix:104
>  2_1734_(7)
> 2016-12-27 13:21:10.384837 7f3149ee3a00 30 zs: _get:844 ZSReadObject:
> [2_1734_M0000000000000006c6._fastinfo]
> 2016-12-27 13:21:10.384854 7f3149ee3a00 30 zs: _get:857 ZSReadObject
> logging: [12]110
> 2016-12-27 13:21:10.384857 7f3149ee3a00 30 zs: is_logging:120  M
> 00000000000006c6._info(14)
> 2016-12-27 13:21:10.384860 7f3149ee3a00 30 zs: append_logging_prefix:104
>  2_1734_(7)
> 2016-12-27 13:21:10.384868 7f3149ee3a00 30 zs: _get:844 ZSReadObject:
> [2_1734_M0000000000000006c6._info]
> 2016-12-27 13:21:10.384872 7f3149ee3a00 30 zs: _get:857 ZSReadObject
> logging: [12]110
> 2016-12-27 13:21:10.384874 7f3149ee3a00 30 zs: _get:844 ZSReadObject:
> [M0000000000000006c6._infoverinfo]
> 2016-12-27 13:21:10.384879 7f3149ee3a00 30 zs: _get:869 ZSReadObject
> logging: [1]1
> 2016-12-27 13:21:10.384889 7f3149ee3a00 30
> bluestore(/var/lib/ceph/mnt/osd-device-58-data) omap_get_values  got
> 0x00000000000006c6'._infover' -> _infover
> 2016-12-27 13:21:10.384892 7f3149ee3a00 10
> bluestore(/var/lib/ceph/mnt/osd-device-58-data) omap_get_values
> 0.32_head oid #0:4c000000::::head# = 0
> 2016-12-27 13:21:10.386868 7f3149ee3a00 -1 /root/ceph/src/osd/PG.cc: In
> function 'static int PG::read_info(ObjectStore*, spg_t, const coll_t&,
> ceph::bufferlist&, pg_info_t&, std::map<unsigned int, pg_interval_t>&,
> __u8&)' thread 7f3149ee3a00 time 2016-12-27
> 13:21:10.384897/root/ceph/src/osd/PG.cc: 3142: FAILED
> assert(values.size() == 3 || values.size() == 4)
>
>  ceph version 11.0.2-2332-gd5d734c
> (d5d734ce16ab7c0770a00972478c39e07db4aed0)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x8b) [0x7f314a9aa1db]
>  2: (PG::read_info(ObjectStore*, spg_t, coll_t const&,
> ceph::buffer::list&, pg_info_t&, std::map<unsigned int, pg_interval_t,
> std::less<unsigned int>, std::allocator<std::pair<unsigned int const,
> pg_interval_t> > >&, unsigned char&)+0x174) [0x7f314a401d54] 3:
> (PG::read_state(ObjectStore*, ceph::buffer::list&)+0x76) [0x7f314a402856]
>  4: (OSD::load_pgs()+0x9b4) [0x7f314a3580e4]
>  5: (OSD::init()+0x2026) [0x7f314a366c76]
>  6: (main()+0x2a7e) [0x7f314a29cf1e]
>  7: (__libc_start_main()+0xf5) [0x7f3147628f45]
>  8: (()+0x4134a6) [0x7f314a3164a6]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
>
> When ran 4k random write test with ZS, I would hit 'transaction submit
> sync' error after about 100s, as shown below.
>
> 2016-12-28 15:50:13.001185 7ff810261700 -1
> /root/ceph/src/os/bluestore/BlueStore.cc: In function 'void
> BlueStore::_kv_sync_thread(uint32_t)' thread 7ff810261700 time
> 2016-12-28 15:50:12.999799
> /root/ceph/src/os/bluestore/BlueStore.cc: 6978: FAILED assert(r == 0)
>
>  ceph version 11.0.2-2332-gd5d734c
> (d5d734ce16ab7c0770a00972478c39e07db4aed0)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x8b) [0x7ff840ad31db]
>  2: (BlueStore::_kv_sync_thread(unsigned int)+0x295f) [0x7ff84084be3f]
>  3: (BlueStore::KVSyncThread::entry()+0x10) [0x7ff84086d970]
>  4: (()+0x8184) [0x7ff83f0d6184]
>  5: (clone()+0x6d) [0x7ff83d82a37d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> Nonetheless, we get more stable performance during 100s test with ZS
> compared with RocksDB. Rocks can provide higher peak performance but
> once compaction became frequent, there would be a great many of read ops
> from compaction, which throttles Rocks thourghput a lot. BlueStore with
> Rocks and ZS brought all most the same performance on average. Furthmore
> we took some tunings on Rocks while without any tuning for ZS. Min alloc
> size for both test is 64K. More detailed configuration as follows.
>
> FIO:
> 100 fio process as client based on 100 30G volumes
> 4k random write for 100s
>
>
> OSD side:
> "bluestore_min_alloc_size": 65536
> "osd_op_num_threads_per_shard": "2"
> "osd_op_num_shards": "8"
> "bluefs_buffered_io": true
>
> For Rocks:
> separated partition(40G, P3700) for db&wal
> "bluestore_rocksdb_options":
> "max_write_buffer_number=64,min_write_buffer_number_to_merge=2,recycle_log_file_num=64,compaction_style=kCompactionStyleLevel,compression=kNoCompression,write_buffer_size=134217728,target_file_size_base=134217728,max_background_compactions=32,level0_file_num_compaction_trigger=8,level0_slowdown_writes_trigger=32,level0_stop_writes_trigger=64,num_levels=5,max_bytes_for_level_base=1073741824,max_bytes_for_level_multiplier=8,compaction_threads=32,flusher_threads=8"

whoa, that's a lot of write buffers!  Are you sure you need that many? 
I'm worried that might be going too far.  Also, you might want to switch 
from 5 levels to fewer to reduce write amp.  In general you can watch 
compaction stats in the OSD log by grepping for "Amp" and see how bad 
the compaction looks.  I'd be curious how the current defaults compare 
to these settings.

>
> For ZS:
> separated partition(20G, P3700) for db
> "bluestore_kvbackend": zs
> "bluestore_sync_submit_transaction": false
>
> Somnath, any suggestions for superior zs configuration?

My understanding is that for ZS you really want to stick with a 4K 
min_alloc size.  I didn't see a lot of problems with 16K, but it might 
be worth trying 4K and see how it does.


Also you might want to apply PRs #12629 and 12634.  This combined with 
smaller extent_mapshard max/target sizes makes a very significant 
difference:

bluestore_extent_map_shard_max_size = 200
bluestore_extent_map_shard_target_size = 100


>
> Thanks,
> Haodong
>>
>> On 12/14/2016 6:27:02 AM, Somnath Roy <somnath.roy@sandisk.com> wrote:
>>
>> Ohh, for compilation ?
>> Hmm, strange , for me make -jis not much different. Need to see..
>>
>> -----Original Message-----
>> From: Somnath Roy
>> Sent: Tuesday, December 13, 2016 1:40 PM
>> To: 'Mark Nelson'
>> Cc: ceph-devel
>> Subject: RE: Bluestore with ZS
>>
>> Have you set bluestore_num_kv_sync_threads = (say 4 ?)
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Tuesday, December 13, 2016 1:13 PM
>> To: Somnath Roy
>> Cc: ceph-devel
>> Subject: Re: Bluestore with ZS
>>
>> I'm compiling it now in fact, though for some reason it's only using a
>> single thread to compile so it's going *very* slow.
>>
>> Mark
>>
>> On 12/13/2016 02:58 PM, Somnath Roy wrote:
>> > Mark,
>> > Multi kv sync code is quite stable and giving > 2x performance bump
>> for ZS than single threaded code. If you are planning to try out ZS I
>> would highly recommend to try with the following code base.
>> >
>> > https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thre
>> > ad
>> >
>> > Add the following in the ceph.conf in addition to what I mentioned
>> below.
>> >
>> > bluestore_num_kv_sync_threads =
>> >
>> > Let me know how it goes for you.
>> >
>> > Thanks & Regards
>> > Somnath
>> >
>> >
>> > -----Original Message-----
>> > From: Somnath Roy
>> > Sent: Wednesday, December 07, 2016 2:37 AM
>> > To: 'Mark Nelson'
>> > Cc: 'ceph-devel'
>> > Subject: RE: Bluestore with ZS
>> >
>> > Sage,
>> > Here is the multi kv sync code for your review.
>> >
>> > https://github.com/somnathr/ceph/tree/wip-bluestore-multi-kv-sync-thre
>> > ad
>> >
>> > It is giving ZS significant performance boost but we believe we can
>> optimize shim further. We are working on that.
>> >
>> > BTW, I have coded on top of your allocator changes
>> > (https://github.com/ceph/ceph/pull/12343)
>> >
>> > Thanks & Regards
>> > Somnath
>> >
>> >
>> > -----Original Message-----
>> > From: Somnath Roy
>> > Sent: Tuesday, December 06, 2016 7:56 AM
>> > To: 'Mark Nelson'
>> > Cc: ceph-devel
>> > Subject: RE: Bluestore with ZS
>> >
>> > No Problem , take your time..Hopefully, by then we can give you
>> stable multi_kv version.
>> >
>> > -----Original Message-----
>> > From: Mark Nelson [mailto:mnelson@redhat.com]
>> > Sent: Tuesday, December 06, 2016 7:54 AM
>> > To: Somnath Roy
>> > Cc: ceph-devel
>> > Subject: Re: Bluestore with ZS
>> >
>> > Excellent Somnath!
>> >
>> > I will attempt to test this today, though I also am going to be
>> looking at the new RBD erasure coding stuff so it might be a day or two.
>> >
>> > Mark
>> >
>> > On 12/06/2016 02:33 AM, Somnath Roy wrote:
>> >> Mark,
>> >> Please find the Bluestore + ZS integrated code synced with today's
>> master in the following location.
>> >>
>> >> https://github.com/somnathr/ceph/tree/wip-bluestore-zs
>> >>
>> >> As discussed in the standup , this is with single kv_sync_thread.
>> >> I am still cleaning up multi kv_sync_thread version and will send
>> out a pull request for Sage to review hopefully by tomorrow.
>> >>
>> >> Here is the steps you need to follow to use this.
>> >>
>> >> 1. ./do_cmake.sh -DWITH_ZS=1
>> >>
>> >> 2. make and make install
>> >>
>> >> 3. In the ceph.conf , use the following option.
>> >>
>> >> enable experimental unrecoverable data corrupting features =
>> >> bluestore zs rocksdb bluestore_sync_submit_transaction = false
>> >> bluestore_kvbackend=zs
>> >>
>> >> With smaller volumes you will be seeing rocks outperforming ZS ,
>> but, for bigger volumes ZS is catching up fast.
>> >> The code (shim layer and thus BlueStore) is no way optimally using
>> ZS yet and we are in process of optimizing it further (with multi
>> kv_sync, more batching etc. etc.).
>> >> Will keep community posted on this.
>> >>
>> >> Thanks & Regards
>> >> Somnath
>> >>
>> >>
>> >>
>> >> PLEASE NOTE: The information contained in this electronic mail
>> message is intended only for the use of the designated recipient(s)
>> named above. If the reader of this message is not the intended
>> recipient, you are hereby notified that you have received this message
>> in error and that any review, dissemination, distribution, or copying
>> of this message is strictly prohibited. If you have received this
>> communication in error, please notify the sender by telephone or
>> e-mail (as shown above) immediately and destroy any and all copies of
>> this message in your possession (whether hard copies or electronically
>> stored copies).
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
