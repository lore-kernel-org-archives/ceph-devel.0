From: Igor Fedotov <ifedotov-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ceph osd commit latency increase over time,
 until restart
Date: Fri, 15 Feb 2019 15:46:22 +0300
Message-ID: <4566cd3c-39ef-975f-9f34-ee1b2a1ca552@suse.de>
References: <395511117.2665.1548405853447.JavaMail.zimbra@oxygem.tv>
 <0ab7d2b9-3611-c380-cbf6-c39cec0e673d@suse.de>
 <1323366475.173629.1549292678511.JavaMail.zimbra@oxygem.tv>
 <2062110719.174905.1549294821422.JavaMail.zimbra@oxygem.tv>
 <d4558d4b-b1c9-211a-626a-0c14df3e29b9@suse.de>
 <825077993.841032.1549638894023.JavaMail.zimbra@oxygem.tv>
 <2132634351.842536.1549641461010.JavaMail.zimbra@oxygem.tv>
 <c26e0eca-1a1c-3354-bff6-4560e3aea4c5@suse.de>
 <1554220830.1076801.1550047328269.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4897656043153500787=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1554220830.1076801.1550047328269.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============4897656043153500787==
Content-Type: multipart/alternative;
 boundary="------------80F1686A3EED05D79162FAF8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------80F1686A3EED05D79162FAF8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

I've read through your reports, nothing obvious so far.

I can only see several times average latency increase for OSD write ops 
(in seconds)

0.002040060 (first hour) vs.

0.002483516 (last 24 hours) vs.
0.008382087 (last hour)

subop_w_latency:
0.000478934 (first hour) vs.
0.000537956 (last 24 hours) vs.
0.003073475 (last hour)

and OSD read ops, osd_r_latency:

0.000408595 (first hour)
0.000709031 (24 hours)
0.004979540 (last hour)
   
What's interesting is that such latency differences aren't observed at neither BlueStore level (any _lat params under "bluestore" section) nor rocksdb one.

Which probably means that the issue is rather somewhere above BlueStore.

Suggest to proceed with perf dumps collection to see if the picture stays the same.

W.r.t. memory usage you observed I see nothing suspicious so far - No decrease in RSS report is a known artifact that seems to be safe.

Thanks,
Igor

On 2/13/2019 11:42 AM, Alexandre DERUMIER wrote:
> Hi Igor,
>
> Thanks again for helping !
>
>
>
> I have upgrade to last mimic this weekend, and with new autotune memory,
> I have setup osd_memory_target to 8G.  (my nvme are 6TB)
>
>
> I have done a lot of perf dump and mempool dump and ps of process to see rss memory at different hours,
> here the reports for osd.0:
>
> http://odisoweb1.odiso.net/perfanalysis/
>
>
> osd has been started the 12-02-2019 at 08:00
>
> first report after 1h running
> http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.perf.txt
> http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.dump_mempools.txt
> http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.ps.txt
>
>
>
> report  after 24 before counter resets
>
> http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.perf.txt
> http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.dump_mempools.txt
> http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.ps.txt
>
> report 1h after counter reset
> http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.perf.txt
> http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.dump_mempools.txt
> http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.ps.txt
>
>
>
>
> I'm seeing the bluestore buffer bytes memory increasing up to 4G  around 12-02-2019 at 14:00
> http://odisoweb1.odiso.net/perfanalysis/graphs2.png
> Then after that, slowly decreasing.
>
>
> Another strange thing,
> I'm seeing total bytes at 5G at 12-02-2018.13:30
> http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.13:30.dump_mempools.txt
> Then is decreasing over time (around 3,7G this morning), but RSS is still at 8G
>
>
> I'm graphing mempools counters too since yesterday, so I'll able to track them over time.
>
> ----- Mail original -----
> De: "Igor Fedotov" <ifedotov-l3A5Bk7waGM@public.gmane.org>
> À: "Alexandre Derumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> Cc: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Envoyé: Lundi 11 Février 2019 12:03:17
> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>
> On 2/8/2019 6:57 PM, Alexandre DERUMIER wrote:
>> another mempool dump after 1h run. (latency ok)
>>
>> Biggest difference:
>>
>> before restart
>> -------------
>> "bluestore_cache_other": {
>> "items": 48661920,
>> "bytes": 1539544228
>> },
>> "bluestore_cache_data": {
>> "items": 54,
>> "bytes": 643072
>> },
>> (other caches seem to be quite low too, like bluestore_cache_other take all the memory)
>>
>>
>> After restart
>> -------------
>> "bluestore_cache_other": {
>> "items": 12432298,
>> "bytes": 500834899
>> },
>> "bluestore_cache_data": {
>> "items": 40084,
>> "bytes": 1056235520
>> },
>>
> This is fine as cache is warming after restart and some rebalancing
> between data and metadata might occur.
>
> What relates to allocator and most probably to fragmentation growth is :
>
> "bluestore_alloc": {
> "items": 165053952,
> "bytes": 165053952
> },
>
> which had been higher before the reset (if I got these dumps' order
> properly)
>
> "bluestore_alloc": {
> "items": 210243456,
> "bytes": 210243456
> },
>
> But as I mentioned - I'm not 100% sure this might cause such a huge
> latency increase...
>
> Do you have perf counters dump after the restart?
>
> Could you collect some more dumps - for both mempool and perf counters?
>
> So ideally I'd like to have:
>
> 1) mempool/perf counters dumps after the restart (1hour is OK)
>
> 2) mempool/perf counters dumps in 24+ hours after restart
>
> 3) reset perf counters after 2), wait for 1 hour (and without OSD
> restart) and dump mempool/perf counters again.
>
> So we'll be able to learn both allocator mem usage growth and operation
> latency distribution for the following periods:
>
> a) 1st hour after restart
>
> b) 25th hour.
>
>
> Thanks,
>
> Igor
>
>
>> full mempool dump after restart
>> -------------------------------
>>
>> {
>> "mempool": {
>> "by_pool": {
>> "bloom_filter": {
>> "items": 0,
>> "bytes": 0
>> },
>> "bluestore_alloc": {
>> "items": 165053952,
>> "bytes": 165053952
>> },
>> "bluestore_cache_data": {
>> "items": 40084,
>> "bytes": 1056235520
>> },
>> "bluestore_cache_onode": {
>> "items": 22225,
>> "bytes": 14935200
>> },
>> "bluestore_cache_other": {
>> "items": 12432298,
>> "bytes": 500834899
>> },
>> "bluestore_fsck": {
>> "items": 0,
>> "bytes": 0
>> },
>> "bluestore_txc": {
>> "items": 11,
>> "bytes": 8184
>> },
>> "bluestore_writing_deferred": {
>> "items": 5047,
>> "bytes": 22673736
>> },
>> "bluestore_writing": {
>> "items": 91,
>> "bytes": 1662976
>> },
>> "bluefs": {
>> "items": 1907,
>> "bytes": 95600
>> },
>> "buffer_anon": {
>> "items": 19664,
>> "bytes": 25486050
>> },
>> "buffer_meta": {
>> "items": 46189,
>> "bytes": 2956096
>> },
>> "osd": {
>> "items": 243,
>> "bytes": 3089016
>> },
>> "osd_mapbl": {
>> "items": 17,
>> "bytes": 214366
>> },
>> "osd_pglog": {
>> "items": 889673,
>> "bytes": 367160400
>> },
>> "osdmap": {
>> "items": 3803,
>> "bytes": 224552
>> },
>> "osdmap_mapping": {
>> "items": 0,
>> "bytes": 0
>> },
>> "pgmap": {
>> "items": 0,
>> "bytes": 0
>> },
>> "mds_co": {
>> "items": 0,
>> "bytes": 0
>> },
>> "unittest_1": {
>> "items": 0,
>> "bytes": 0
>> },
>> "unittest_2": {
>> "items": 0,
>> "bytes": 0
>> }
>> },
>> "total": {
>> "items": 178515204,
>> "bytes": 2160630547
>> }
>> }
>> }
>>
>> ----- Mail original -----
>> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>> À: "Igor Fedotov" <ifedotov-l3A5Bk7waGM@public.gmane.org>
>> Cc: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>, "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Envoyé: Vendredi 8 Février 2019 16:14:54
>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>
>> I'm just seeing
>>
>> StupidAllocator::_aligned_len
>> and
>> btree::btree_iterator<btree::btree_node<btree::btree_map_params<unsigned long, unsigned long, std::less<unsigned long>, mempoo
>>
>> on 1 osd, both 10%.
>>
>> here the dump_mempools
>>
>> {
>> "mempool": {
>> "by_pool": {
>> "bloom_filter": {
>> "items": 0,
>> "bytes": 0
>> },
>> "bluestore_alloc": {
>> "items": 210243456,
>> "bytes": 210243456
>> },
>> "bluestore_cache_data": {
>> "items": 54,
>> "bytes": 643072
>> },
>> "bluestore_cache_onode": {
>> "items": 105637,
>> "bytes": 70988064
>> },
>> "bluestore_cache_other": {
>> "items": 48661920,
>> "bytes": 1539544228
>> },
>> "bluestore_fsck": {
>> "items": 0,
>> "bytes": 0
>> },
>> "bluestore_txc": {
>> "items": 12,
>> "bytes": 8928
>> },
>> "bluestore_writing_deferred": {
>> "items": 406,
>> "bytes": 4792868
>> },
>> "bluestore_writing": {
>> "items": 66,
>> "bytes": 1085440
>> },
>> "bluefs": {
>> "items": 1882,
>> "bytes": 93600
>> },
>> "buffer_anon": {
>> "items": 138986,
>> "bytes": 24983701
>> },
>> "buffer_meta": {
>> "items": 544,
>> "bytes": 34816
>> },
>> "osd": {
>> "items": 243,
>> "bytes": 3089016
>> },
>> "osd_mapbl": {
>> "items": 36,
>> "bytes": 179308
>> },
>> "osd_pglog": {
>> "items": 952564,
>> "bytes": 372459684
>> },
>> "osdmap": {
>> "items": 3639,
>> "bytes": 224664
>> },
>> "osdmap_mapping": {
>> "items": 0,
>> "bytes": 0
>> },
>> "pgmap": {
>> "items": 0,
>> "bytes": 0
>> },
>> "mds_co": {
>> "items": 0,
>> "bytes": 0
>> },
>> "unittest_1": {
>> "items": 0,
>> "bytes": 0
>> },
>> "unittest_2": {
>> "items": 0,
>> "bytes": 0
>> }
>> },
>> "total": {
>> "items": 260109445,
>> "bytes": 2228370845
>> }
>> }
>> }
>>
>>
>> and the perf dump
>>
>> root@ceph5-2:~# ceph daemon osd.4 perf dump
>> {
>> "AsyncMessenger::Worker-0": {
>> "msgr_recv_messages": 22948570,
>> "msgr_send_messages": 22561570,
>> "msgr_recv_bytes": 333085080271,
>> "msgr_send_bytes": 261798871204,
>> "msgr_created_connections": 6152,
>> "msgr_active_connections": 2701,
>> "msgr_running_total_time": 1055.197867330,
>> "msgr_running_send_time": 352.764480121,
>> "msgr_running_recv_time": 499.206831955,
>> "msgr_running_fast_dispatch_time": 130.982201607
>> },
>> "AsyncMessenger::Worker-1": {
>> "msgr_recv_messages": 18801593,
>> "msgr_send_messages": 18430264,
>> "msgr_recv_bytes": 306871760934,
>> "msgr_send_bytes": 192789048666,
>> "msgr_created_connections": 5773,
>> "msgr_active_connections": 2721,
>> "msgr_running_total_time": 816.821076305,
>> "msgr_running_send_time": 261.353228926,
>> "msgr_running_recv_time": 394.035587911,
>> "msgr_running_fast_dispatch_time": 104.012155720
>> },
>> "AsyncMessenger::Worker-2": {
>> "msgr_recv_messages": 18463400,
>> "msgr_send_messages": 18105856,
>> "msgr_recv_bytes": 187425453590,
>> "msgr_send_bytes": 220735102555,
>> "msgr_created_connections": 5897,
>> "msgr_active_connections": 2605,
>> "msgr_running_total_time": 807.186854324,
>> "msgr_running_send_time": 296.834435839,
>> "msgr_running_recv_time": 351.364389691,
>> "msgr_running_fast_dispatch_time": 101.215776792
>> },
>> "bluefs": {
>> "gift_bytes": 0,
>> "reclaim_bytes": 0,
>> "db_total_bytes": 256050724864,
>> "db_used_bytes": 12413042688,
>> "wal_total_bytes": 0,
>> "wal_used_bytes": 0,
>> "slow_total_bytes": 0,
>> "slow_used_bytes": 0,
>> "num_files": 209,
>> "log_bytes": 10383360,
>> "log_compactions": 14,
>> "logged_bytes": 336498688,
>> "files_written_wal": 2,
>> "files_written_sst": 4499,
>> "bytes_written_wal": 417989099783,
>> "bytes_written_sst": 213188750209
>> },
>> "bluestore": {
>> "kv_flush_lat": {
>> "avgcount": 26371957,
>> "sum": 26.734038497,
>> "avgtime": 0.000001013
>> },
>> "kv_commit_lat": {
>> "avgcount": 26371957,
>> "sum": 3397.491150603,
>> "avgtime": 0.000128829
>> },
>> "kv_lat": {
>> "avgcount": 26371957,
>> "sum": 3424.225189100,
>> "avgtime": 0.000129843
>> },
>> "state_prepare_lat": {
>> "avgcount": 30484924,
>> "sum": 3689.542105337,
>> "avgtime": 0.000121028
>> },
>> "state_aio_wait_lat": {
>> "avgcount": 30484924,
>> "sum": 509.864546111,
>> "avgtime": 0.000016725
>> },
>> "state_io_done_lat": {
>> "avgcount": 30484924,
>> "sum": 24.534052953,
>> "avgtime": 0.000000804
>> },
>> "state_kv_queued_lat": {
>> "avgcount": 30484924,
>> "sum": 3488.338424238,
>> "avgtime": 0.000114428
>> },
>> "state_kv_commiting_lat": {
>> "avgcount": 30484924,
>> "sum": 5660.437003432,
>> "avgtime": 0.000185679
>> },
>> "state_kv_done_lat": {
>> "avgcount": 30484924,
>> "sum": 7.763511500,
>> "avgtime": 0.000000254
>> },
>> "state_deferred_queued_lat": {
>> "avgcount": 26346134,
>> "sum": 666071.296856696,
>> "avgtime": 0.025281557
>> },
>> "state_deferred_aio_wait_lat": {
>> "avgcount": 26346134,
>> "sum": 1755.660547071,
>> "avgtime": 0.000066638
>> },
>> "state_deferred_cleanup_lat": {
>> "avgcount": 26346134,
>> "sum": 185465.151653703,
>> "avgtime": 0.007039558
>> },
>> "state_finishing_lat": {
>> "avgcount": 30484920,
>> "sum": 3.046847481,
>> "avgtime": 0.000000099
>> },
>> "state_done_lat": {
>> "avgcount": 30484920,
>> "sum": 13193.362685280,
>> "avgtime": 0.000432783
>> },
>> "throttle_lat": {
>> "avgcount": 30484924,
>> "sum": 14.634269979,
>> "avgtime": 0.000000480
>> },
>> "submit_lat": {
>> "avgcount": 30484924,
>> "sum": 3873.883076148,
>> "avgtime": 0.000127075
>> },
>> "commit_lat": {
>> "avgcount": 30484924,
>> "sum": 13376.492317331,
>> "avgtime": 0.000438790
>> },
>> "read_lat": {
>> "avgcount": 5873923,
>> "sum": 1817.167582057,
>> "avgtime": 0.000309361
>> },
>> "read_onode_meta_lat": {
>> "avgcount": 19608201,
>> "sum": 146.770464482,
>> "avgtime": 0.000007485
>> },
>> "read_wait_aio_lat": {
>> "avgcount": 13734278,
>> "sum": 2532.578077242,
>> "avgtime": 0.000184398
>> },
>> "compress_lat": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "decompress_lat": {
>> "avgcount": 1346945,
>> "sum": 26.227575896,
>> "avgtime": 0.000019471
>> },
>> "csum_lat": {
>> "avgcount": 28020392,
>> "sum": 149.587819041,
>> "avgtime": 0.000005338
>> },
>> "compress_success_count": 0,
>> "compress_rejected_count": 0,
>> "write_pad_bytes": 352923605,
>> "deferred_write_ops": 24373340,
>> "deferred_write_bytes": 216791842816,
>> "write_penalty_read_ops": 8062366,
>> "bluestore_allocated": 3765566013440,
>> "bluestore_stored": 4186255221852,
>> "bluestore_compressed": 39981379040,
>> "bluestore_compressed_allocated": 73748348928,
>> "bluestore_compressed_original": 165041381376,
>> "bluestore_onodes": 104232,
>> "bluestore_onode_hits": 71206874,
>> "bluestore_onode_misses": 1217914,
>> "bluestore_onode_shard_hits": 260183292,
>> "bluestore_onode_shard_misses": 22851573,
>> "bluestore_extents": 3394513,
>> "bluestore_blobs": 2773587,
>> "bluestore_buffers": 0,
>> "bluestore_buffer_bytes": 0,
>> "bluestore_buffer_hit_bytes": 62026011221,
>> "bluestore_buffer_miss_bytes": 995233669922,
>> "bluestore_write_big": 5648815,
>> "bluestore_write_big_bytes": 552502214656,
>> "bluestore_write_big_blobs": 12440992,
>> "bluestore_write_small": 35883770,
>> "bluestore_write_small_bytes": 223436965719,
>> "bluestore_write_small_unused": 408125,
>> "bluestore_write_small_deferred": 34961455,
>> "bluestore_write_small_pre_read": 34961455,
>> "bluestore_write_small_new": 514190,
>> "bluestore_txc": 30484924,
>> "bluestore_onode_reshard": 5144189,
>> "bluestore_blob_split": 60104,
>> "bluestore_extent_compress": 53347252,
>> "bluestore_gc_merged": 21142528,
>> "bluestore_read_eio": 0,
>> "bluestore_fragmentation_micros": 67
>> },
>> "finisher-defered_finisher": {
>> "queue_len": 0,
>> "complete_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "finisher-finisher-0": {
>> "queue_len": 0,
>> "complete_latency": {
>> "avgcount": 26625163,
>> "sum": 1057.506990951,
>> "avgtime": 0.000039718
>> }
>> },
>> "finisher-objecter-finisher-0": {
>> "queue_len": 0,
>> "complete_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.0::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.0::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.1::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.1::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.2::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.2::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.3::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.3::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.4::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.4::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.5::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.5::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.6::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.6::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.7::sdata_wait_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "mutex-OSDShard.7::shard_lock": {
>> "wait": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "objecter": {
>> "op_active": 0,
>> "op_laggy": 0,
>> "op_send": 0,
>> "op_send_bytes": 0,
>> "op_resend": 0,
>> "op_reply": 0,
>> "op": 0,
>> "op_r": 0,
>> "op_w": 0,
>> "op_rmw": 0,
>> "op_pg": 0,
>> "osdop_stat": 0,
>> "osdop_create": 0,
>> "osdop_read": 0,
>> "osdop_write": 0,
>> "osdop_writefull": 0,
>> "osdop_writesame": 0,
>> "osdop_append": 0,
>> "osdop_zero": 0,
>> "osdop_truncate": 0,
>> "osdop_delete": 0,
>> "osdop_mapext": 0,
>> "osdop_sparse_read": 0,
>> "osdop_clonerange": 0,
>> "osdop_getxattr": 0,
>> "osdop_setxattr": 0,
>> "osdop_cmpxattr": 0,
>> "osdop_rmxattr": 0,
>> "osdop_resetxattrs": 0,
>> "osdop_tmap_up": 0,
>> "osdop_tmap_put": 0,
>> "osdop_tmap_get": 0,
>> "osdop_call": 0,
>> "osdop_watch": 0,
>> "osdop_notify": 0,
>> "osdop_src_cmpxattr": 0,
>> "osdop_pgls": 0,
>> "osdop_pgls_filter": 0,
>> "osdop_other": 0,
>> "linger_active": 0,
>> "linger_send": 0,
>> "linger_resend": 0,
>> "linger_ping": 0,
>> "poolop_active": 0,
>> "poolop_send": 0,
>> "poolop_resend": 0,
>> "poolstat_active": 0,
>> "poolstat_send": 0,
>> "poolstat_resend": 0,
>> "statfs_active": 0,
>> "statfs_send": 0,
>> "statfs_resend": 0,
>> "command_active": 0,
>> "command_send": 0,
>> "command_resend": 0,
>> "map_epoch": 105913,
>> "map_full": 0,
>> "map_inc": 828,
>> "osd_sessions": 0,
>> "osd_session_open": 0,
>> "osd_session_close": 0,
>> "osd_laggy": 0,
>> "omap_wr": 0,
>> "omap_rd": 0,
>> "omap_del": 0
>> },
>> "osd": {
>> "op_wip": 0,
>> "op": 16758102,
>> "op_in_bytes": 238398820586,
>> "op_out_bytes": 165484999463,
>> "op_latency": {
>> "avgcount": 16758102,
>> "sum": 38242.481640842,
>> "avgtime": 0.002282029
>> },
>> "op_process_latency": {
>> "avgcount": 16758102,
>> "sum": 28644.906310687,
>> "avgtime": 0.001709316
>> },
>> "op_prepare_latency": {
>> "avgcount": 16761367,
>> "sum": 3489.856599934,
>> "avgtime": 0.000208208
>> },
>> "op_r": 6188565,
>> "op_r_out_bytes": 165484999463,
>> "op_r_latency": {
>> "avgcount": 6188565,
>> "sum": 4507.365756792,
>> "avgtime": 0.000728337
>> },
>> "op_r_process_latency": {
>> "avgcount": 6188565,
>> "sum": 942.363063429,
>> "avgtime": 0.000152274
>> },
>> "op_r_prepare_latency": {
>> "avgcount": 6188644,
>> "sum": 982.866710389,
>> "avgtime": 0.000158817
>> },
>> "op_w": 10546037,
>> "op_w_in_bytes": 238334329494,
>> "op_w_latency": {
>> "avgcount": 10546037,
>> "sum": 33160.719998316,
>> "avgtime": 0.003144377
>> },
>> "op_w_process_latency": {
>> "avgcount": 10546037,
>> "sum": 27668.702029030,
>> "avgtime": 0.002623611
>> },
>> "op_w_prepare_latency": {
>> "avgcount": 10548652,
>> "sum": 2499.688609173,
>> "avgtime": 0.000236967
>> },
>> "op_rw": 23500,
>> "op_rw_in_bytes": 64491092,
>> "op_rw_out_bytes": 0,
>> "op_rw_latency": {
>> "avgcount": 23500,
>> "sum": 574.395885734,
>> "avgtime": 0.024442378
>> },
>> "op_rw_process_latency": {
>> "avgcount": 23500,
>> "sum": 33.841218228,
>> "avgtime": 0.001440051
>> },
>> "op_rw_prepare_latency": {
>> "avgcount": 24071,
>> "sum": 7.301280372,
>> "avgtime": 0.000303322
>> },
>> "op_before_queue_op_lat": {
>> "avgcount": 57892986,
>> "sum": 1502.117718889,
>> "avgtime": 0.000025946
>> },
>> "op_before_dequeue_op_lat": {
>> "avgcount": 58091683,
>> "sum": 45194.453254037,
>> "avgtime": 0.000777984
>> },
>> "subop": 19784758,
>> "subop_in_bytes": 547174969754,
>> "subop_latency": {
>> "avgcount": 19784758,
>> "sum": 13019.714424060,
>> "avgtime": 0.000658067
>> },
>> "subop_w": 19784758,
>> "subop_w_in_bytes": 547174969754,
>> "subop_w_latency": {
>> "avgcount": 19784758,
>> "sum": 13019.714424060,
>> "avgtime": 0.000658067
>> },
>> "subop_pull": 0,
>> "subop_pull_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "subop_push": 0,
>> "subop_push_in_bytes": 0,
>> "subop_push_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "pull": 0,
>> "push": 2003,
>> "push_out_bytes": 5560009728,
>> "recovery_ops": 1940,
>> "loadavg": 118,
>> "buffer_bytes": 0,
>> "history_alloc_Mbytes": 0,
>> "history_alloc_num": 0,
>> "cached_crc": 0,
>> "cached_crc_adjusted": 0,
>> "missed_crc": 0,
>> "numpg": 243,
>> "numpg_primary": 82,
>> "numpg_replica": 161,
>> "numpg_stray": 0,
>> "numpg_removing": 0,
>> "heartbeat_to_peers": 10,
>> "map_messages": 7013,
>> "map_message_epochs": 7143,
>> "map_message_epoch_dups": 6315,
>> "messages_delayed_for_map": 0,
>> "osd_map_cache_hit": 203309,
>> "osd_map_cache_miss": 33,
>> "osd_map_cache_miss_low": 0,
>> "osd_map_cache_miss_low_avg": {
>> "avgcount": 0,
>> "sum": 0
>> },
>> "osd_map_bl_cache_hit": 47012,
>> "osd_map_bl_cache_miss": 1681,
>> "stat_bytes": 6401248198656,
>> "stat_bytes_used": 3777979072512,
>> "stat_bytes_avail": 2623269126144,
>> "copyfrom": 0,
>> "tier_promote": 0,
>> "tier_flush": 0,
>> "tier_flush_fail": 0,
>> "tier_try_flush": 0,
>> "tier_try_flush_fail": 0,
>> "tier_evict": 0,
>> "tier_whiteout": 1631,
>> "tier_dirty": 22360,
>> "tier_clean": 0,
>> "tier_delay": 0,
>> "tier_proxy_read": 0,
>> "tier_proxy_write": 0,
>> "agent_wake": 0,
>> "agent_skip": 0,
>> "agent_flush": 0,
>> "agent_evict": 0,
>> "object_ctx_cache_hit": 16311156,
>> "object_ctx_cache_total": 17426393,
>> "op_cache_hit": 0,
>> "osd_tier_flush_lat": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "osd_tier_promote_lat": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "osd_tier_r_lat": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "osd_pg_info": 30483113,
>> "osd_pg_fastinfo": 29619885,
>> "osd_pg_biginfo": 81703
>> },
>> "recoverystate_perf": {
>> "initial_latency": {
>> "avgcount": 243,
>> "sum": 6.869296500,
>> "avgtime": 0.028268709
>> },
>> "started_latency": {
>> "avgcount": 1125,
>> "sum": 13551384.917335850,
>> "avgtime": 12045.675482076
>> },
>> "reset_latency": {
>> "avgcount": 1368,
>> "sum": 1101.727799040,
>> "avgtime": 0.805356578
>> },
>> "start_latency": {
>> "avgcount": 1368,
>> "sum": 0.002014799,
>> "avgtime": 0.000001472
>> },
>> "primary_latency": {
>> "avgcount": 507,
>> "sum": 4575560.638823428,
>> "avgtime": 9024.774435549
>> },
>> "peering_latency": {
>> "avgcount": 550,
>> "sum": 499.372283616,
>> "avgtime": 0.907949606
>> },
>> "backfilling_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "waitremotebackfillreserved_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "waitlocalbackfillreserved_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "notbackfilling_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "repnotrecovering_latency": {
>> "avgcount": 1009,
>> "sum": 8975301.082274411,
>> "avgtime": 8895.243887288
>> },
>> "repwaitrecoveryreserved_latency": {
>> "avgcount": 420,
>> "sum": 99.846056520,
>> "avgtime": 0.237728706
>> },
>> "repwaitbackfillreserved_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "reprecovering_latency": {
>> "avgcount": 420,
>> "sum": 241.682764382,
>> "avgtime": 0.575435153
>> },
>> "activating_latency": {
>> "avgcount": 507,
>> "sum": 16.893347339,
>> "avgtime": 0.033320211
>> },
>> "waitlocalrecoveryreserved_latency": {
>> "avgcount": 199,
>> "sum": 672.335512769,
>> "avgtime": 3.378570415
>> },
>> "waitremoterecoveryreserved_latency": {
>> "avgcount": 199,
>> "sum": 213.536439363,
>> "avgtime": 1.073047433
>> },
>> "recovering_latency": {
>> "avgcount": 199,
>> "sum": 79.007696479,
>> "avgtime": 0.397023600
>> },
>> "recovered_latency": {
>> "avgcount": 507,
>> "sum": 14.000732748,
>> "avgtime": 0.027614857
>> },
>> "clean_latency": {
>> "avgcount": 395,
>> "sum": 4574325.900371083,
>> "avgtime": 11580.571899673
>> },
>> "active_latency": {
>> "avgcount": 425,
>> "sum": 4575107.630123680,
>> "avgtime": 10764.959129702
>> },
>> "replicaactive_latency": {
>> "avgcount": 589,
>> "sum": 8975184.499049954,
>> "avgtime": 15238.004242869
>> },
>> "stray_latency": {
>> "avgcount": 818,
>> "sum": 800.729455666,
>> "avgtime": 0.978886865
>> },
>> "getinfo_latency": {
>> "avgcount": 550,
>> "sum": 15.085667048,
>> "avgtime": 0.027428485
>> },
>> "getlog_latency": {
>> "avgcount": 546,
>> "sum": 3.482175693,
>> "avgtime": 0.006377611
>> },
>> "waitactingchange_latency": {
>> "avgcount": 39,
>> "sum": 35.444551284,
>> "avgtime": 0.908834648
>> },
>> "incomplete_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "down_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "getmissing_latency": {
>> "avgcount": 507,
>> "sum": 6.702129624,
>> "avgtime": 0.013219190
>> },
>> "waitupthru_latency": {
>> "avgcount": 507,
>> "sum": 474.098261727,
>> "avgtime": 0.935105052
>> },
>> "notrecovering_latency": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> },
>> "rocksdb": {
>> "get": 28320977,
>> "submit_transaction": 30484924,
>> "submit_transaction_sync": 26371957,
>> "get_latency": {
>> "avgcount": 28320977,
>> "sum": 325.900908733,
>> "avgtime": 0.000011507
>> },
>> "submit_latency": {
>> "avgcount": 30484924,
>> "sum": 1835.888692371,
>> "avgtime": 0.000060222
>> },
>> "submit_sync_latency": {
>> "avgcount": 26371957,
>> "sum": 1431.555230628,
>> "avgtime": 0.000054283
>> },
>> "compact": 0,
>> "compact_range": 0,
>> "compact_queue_merge": 0,
>> "compact_queue_len": 0,
>> "rocksdb_write_wal_time": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "rocksdb_write_memtable_time": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "rocksdb_write_delay_time": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> },
>> "rocksdb_write_pre_and_post_time": {
>> "avgcount": 0,
>> "sum": 0.000000000,
>> "avgtime": 0.000000000
>> }
>> }
>> }
>>
>> ----- Mail original -----
>> De: "Igor Fedotov" <ifedotov-l3A5Bk7waGM@public.gmane.org>
>> À: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>> Cc: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>, "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Envoyé: Mardi 5 Février 2019 18:56:51
>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>
>> On 2/4/2019 6:40 PM, Alexandre DERUMIER wrote:
>>>>> but I don't see l_bluestore_fragmentation counter.
>>>>> (but I have bluestore_fragmentation_micros)
>>> ok, this is the same
>>>
>>> b.add_u64(l_bluestore_fragmentation, "bluestore_fragmentation_micros",
>>> "How fragmented bluestore free space is (free extents / max possible number of free extents) * 1000");
>>>
>>>
>>> Here a graph on last month, with bluestore_fragmentation_micros and latency,
>>>
>>> http://odisoweb1.odiso.net/latency_vs_fragmentation_micros.png
>> hmm, so fragmentation grows eventually and drops on OSD restarts, isn't
>> it? The same for other OSDs?
>>
>> This proves some issue with the allocator - generally fragmentation
>> might grow but it shouldn't reset on restart. Looks like some intervals
>> aren't properly merged in run-time.
>>
>> On the other side I'm not completely sure that latency degradation is
>> caused by that - fragmentation growth is relatively small - I don't see
>> how this might impact performance that high.
>>
>> Wondering if you have OSD mempool monitoring (dump_mempools command
>> output on admin socket) reports? Do you have any historic data?
>>
>> If not may I have current output and say a couple more samples with
>> 8-12 hours interval?
>>
>>
>> Wrt to backporting bitmap allocator to mimic - we haven't had such plans
>> before that but I'll discuss this at BlueStore meeting shortly.
>>
>>
>> Thanks,
>>
>> Igor
>>
>>> ----- Mail original -----
>>> De: "Alexandre Derumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>> À: "Igor Fedotov" <ifedotov-l3A5Bk7waGM@public.gmane.org>
>>> Cc: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>, "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>> Envoyé: Lundi 4 Février 2019 16:04:38
>>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>>
>>> Thanks Igor,
>>>
>>>>> Could you please collect BlueStore performance counters right after OSD
>>>>> startup and once you get high latency.
>>>>>
>>>>> Specifically 'l_bluestore_fragmentation' parameter is of interest.
>>> I'm already monitoring with
>>> "ceph daemon osd.x perf dump ", (I have 2months history will all counters)
>>>
>>> but I don't see l_bluestore_fragmentation counter.
>>>
>>> (but I have bluestore_fragmentation_micros)
>>>
>>>
>>>>> Also if you're able to rebuild the code I can probably make a simple
>>>>> patch to track latency and some other internal allocator's paramter to
>>>>> make sure it's degraded and learn more details.
>>> Sorry, It's a critical production cluster, I can't test on it :(
>>> But I have a test cluster, maybe I can try to put some load on it, and try to reproduce.
>>>
>>>
>>>
>>>>> More vigorous fix would be to backport bitmap allocator from Nautilus
>>>>> and try the difference...
>>> Any plan to backport it to mimic ? (But I can wait for Nautilus)
>>> perf results of new bitmap allocator seem very promising from what I've seen in PR.
>>>
>>>
>>>
>>> ----- Mail original -----
>>> De: "Igor Fedotov" <ifedotov-l3A5Bk7waGM@public.gmane.org>
>>> À: "Alexandre Derumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>, "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> Cc: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>> Envoyé: Lundi 4 Février 2019 15:51:30
>>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>>
>>> Hi Alexandre,
>>>
>>> looks like a bug in StupidAllocator.
>>>
>>> Could you please collect BlueStore performance counters right after OSD
>>> startup and once you get high latency.
>>>
>>> Specifically 'l_bluestore_fragmentation' parameter is of interest.
>>>
>>> Also if you're able to rebuild the code I can probably make a simple
>>> patch to track latency and some other internal allocator's paramter to
>>> make sure it's degraded and learn more details.
>>>
>>>
>>> More vigorous fix would be to backport bitmap allocator from Nautilus
>>> and try the difference...
>>>
>>>
>>> Thanks,
>>>
>>> Igor
>>>
>>>
>>> On 2/4/2019 5:17 PM, Alexandre DERUMIER wrote:
>>>> Hi again,
>>>>
>>>> I speak too fast, the problem has occured again, so it's not tcmalloc cache size related.
>>>>
>>>>
>>>> I have notice something using a simple "perf top",
>>>>
>>>> each time I have this problem (I have seen exactly 4 times the same behaviour),
>>>>
>>>> when latency is bad, perf top give me :
>>>>
>>>> StupidAllocator::_aligned_len
>>>> and
>>>> btree::btree_iterator<btree::btree_node<btree::btree_map_params<unsigned long, unsigned long, std::less<unsigned long>, mempoo
>>>> l::pool_allocator<(mempool::pool_index_t)1, std::pair<unsigned long const, unsigned long> >, 256> >, std::pair<unsigned long const, unsigned long>&, std::pair<unsigned long
>>>> const, unsigned long>*>::increment_slow()
>>>>
>>>> (around 10-20% time for both)
>>>>
>>>>
>>>> when latency is good, I don't see them at all.
>>>>
>>>>
>>>> I have used the Mark wallclock profiler, here the results:
>>>>
>>>> http://odisoweb1.odiso.net/gdbpmp-ok.txt
>>>>
>>>> http://odisoweb1.odiso.net/gdbpmp-bad.txt
>>>>
>>>>
>>>> here an extract of the thread with btree::btree_iterator && StupidAllocator::_aligned_len
>>>>
>>>>
>>>> + 100.00% clone
>>>> + 100.00% start_thread
>>>> + 100.00% ShardedThreadPool::WorkThreadSharded::entry()
>>>> + 100.00% ShardedThreadPool::shardedthreadpool_worker(unsigned int)
>>>> + 100.00% OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)
>>>> + 70.00% PGOpItem::run(OSD*, OSDShard*, boost::intrusive_ptr<PG>&, ThreadPool::TPHandle&)
>>>> | + 70.00% OSD::dequeue_op(boost::intrusive_ptr<PG>, boost::intrusive_ptr<OpRequest>, ThreadPool::TPHandle&)
>>>> | + 70.00% PrimaryLogPG::do_request(boost::intrusive_ptr<OpRequest>&, ThreadPool::TPHandle&)
>>>> | + 68.00% PGBackend::handle_message(boost::intrusive_ptr<OpRequest>)
>>>> | | + 68.00% ReplicatedBackend::_handle_message(boost::intrusive_ptr<OpRequest>)
>>>> | | + 68.00% ReplicatedBackend::do_repop(boost::intrusive_ptr<OpRequest>)
>>>> | | + 67.00% non-virtual thunk to PrimaryLogPG::queue_transactions(std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, boost::intrusive_ptr<OpRequest>)
>>>> | | | + 67.00% BlueStore::queue_transactions(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, std::vector<ObjectStore::Transaction, std::allocator<ObjectStore::Transaction> >&, boost::intrusive_ptr<TrackedOp>, ThreadPool::TPHandle*)
>>>> | | | + 66.00% BlueStore::_txc_add_transaction(BlueStore::TransContext*, ObjectStore::Transaction*)
>>>> | | | | + 66.00% BlueStore::_write(BlueStore::TransContext*, boost::intrusive_ptr<BlueStore::Collection>&, boost::intrusive_ptr<BlueStore::Onode>&, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)
>>>> | | | | + 66.00% BlueStore::_do_write(BlueStore::TransContext*, boost::intrusive_ptr<BlueStore::Collection>&, boost::intrusive_ptr<BlueStore::Onode>, unsigned long, unsigned long, ceph::buffer::list&, unsigned int)
>>>> | | | | + 65.00% BlueStore::_do_alloc_write(BlueStore::TransContext*, boost::intrusive_ptr<BlueStore::Collection>, boost::intrusive_ptr<BlueStore::Onode>, BlueStore::WriteContext*)
>>>> | | | | | + 64.00% StupidAllocator::allocate(unsigned long, unsigned long, unsigned long, long, std::vector<bluestore_pextent_t, mempool::pool_allocator<(mempool::pool_index_t)4, bluestore_pextent_t> >*)
>>>> | | | | | | + 64.00% StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long*, unsigned int*)
>>>> | | | | | | + 34.00% btree::btree_iterator<btree::btree_node<btree::btree_map_params<unsigned long, unsigned long, std::less<unsigned long>, mempool::pool_allocator<(mempool::pool_index_t)1, std::pair<unsigned long const, unsigned long> >, 256> >, std::pair<unsigned long const, unsigned long>&, std::pair<unsigned long const, unsigned long>*>::increment_slow()
>>>> | | | | | | + 26.00% StupidAllocator::_aligned_len(interval_set<unsigned long, btree::btree_map<unsigned long, unsigned long, std::less<unsigned long>, mempool::pool_allocator<(mempool::pool_index_t)1, std::pair<unsigned long const, unsigned long> >, 256> >::iterator, unsigned long)
>>>>
>>>>
>>>>
>>>> ----- Mail original -----
>>>> De: "Alexandre Derumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>>> À: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
>>>> Cc: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>> Envoyé: Lundi 4 Février 2019 09:38:11
>>>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>>>
>>>> Hi,
>>>>
>>>> some news:
>>>>
>>>> I have tried with different transparent hugepage values (madvise, never) : no change
>>>>
>>>> I have tried to increase bluestore_cache_size_ssd to 8G: no change
>>>>
>>>> I have tried to increase TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES to 256mb : it seem to help, after 24h I'm still around 1,5ms. (need to wait some more days to be sure)
>>>>
>>>>
>>>> Note that this behaviour seem to happen really faster (< 2 days) on my big nvme drives (6TB),
>>>> my others clusters user 1,6TB ssd.
>>>>
>>>> Currently I'm using only 1 osd by nvme (I don't have more than 5000iops by osd), but I'll try this week with 2osd by nvme, to see if it's helping.
>>>>
>>>>
>>>> BTW, does somebody have already tested ceph without tcmalloc, with glibc >= 2.26 (which have also thread cache) ?
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Alexandre
>>>>
>>>>
>>>> ----- Mail original -----
>>>> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>>> À: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
>>>> Cc: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>> Envoyé: Mercredi 30 Janvier 2019 19:58:15
>>>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>>>
>>>>>> Thanks. Is there any reason you monitor op_w_latency but not
>>>>>> op_r_latency but instead op_latency?
>>>>>>
>>>>>> Also why do you monitor op_w_process_latency? but not op_r_process_latency?
>>>> I monitor read too. (I have all metrics for osd sockets, and a lot of graphs).
>>>>
>>>> I just don't see latency difference on reads. (or they are very very small vs the write latency increase)
>>>>
>>>>
>>>>
>>>> ----- Mail original -----
>>>> De: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
>>>> À: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>>> Cc: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>> Envoyé: Mercredi 30 Janvier 2019 19:50:20
>>>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>>>
>>>> Hi,
>>>>
>>>> Am 30.01.19 um 14:59 schrieb Alexandre DERUMIER:
>>>>> Hi Stefan,
>>>>>
>>>>>>> currently i'm in the process of switching back from jemalloc to tcmalloc
>>>>>>> like suggested. This report makes me a little nervous about my change.
>>>>> Well,I'm really not sure that it's a tcmalloc bug.
>>>>> maybe bluestore related (don't have filestore anymore to compare)
>>>>> I need to compare with bigger latencies
>>>>>
>>>>> here an example, when all osd at 20-50ms before restart, then after restart (at 21:15), 1ms
>>>>> http://odisoweb1.odiso.net/latencybad.png
>>>>>
>>>>> I observe the latency in my guest vm too, on disks iowait.
>>>>>
>>>>> http://odisoweb1.odiso.net/latencybadvm.png
>>>>>
>>>>>>> Also i'm currently only monitoring latency for filestore osds. Which
>>>>>>> exact values out of the daemon do you use for bluestore?
>>>>> here my influxdb queries:
>>>>>
>>>>> It take op_latency.sum/op_latency.avgcount on last second.
>>>>>
>>>>>
>>>>> SELECT non_negative_derivative(first("op_latency.sum"), 1s)/non_negative_derivative(first("op_latency.avgcount"),1s) FROM "ceph" WHERE "host" =~ /^([[host]])$/ AND "id" =~ /^([[osd]])$/ AND $timeFilter GROUP BY time($interval), "host", "id" fill(previous)
>>>>>
>>>>>
>>>>> SELECT non_negative_derivative(first("op_w_latency.sum"), 1s)/non_negative_derivative(first("op_w_latency.avgcount"),1s) FROM "ceph" WHERE "host" =~ /^([[host]])$/ AND collection='osd' AND "id" =~ /^([[osd]])$/ AND $timeFilter GROUP BY time($interval), "host", "id" fill(previous)
>>>>>
>>>>>
>>>>> SELECT non_negative_derivative(first("op_w_process_latency.sum"), 1s)/non_negative_derivative(first("op_w_process_latency.avgcount"),1s) FROM "ceph" WHERE "host" =~ /^([[host]])$/ AND collection='osd' AND "id" =~ /^([[osd]])$/ AND $timeFilter GROUP BY time($interval), "host", "id" fill(previous)
>>>> Thanks. Is there any reason you monitor op_w_latency but not
>>>> op_r_latency but instead op_latency?
>>>>
>>>> Also why do you monitor op_w_process_latency? but not op_r_process_latency?
>>>>
>>>> greets,
>>>> Stefan
>>>>
>>>>>
>>>>> ----- Mail original -----
>>>>> De: "Stefan Priebe, Profihost AG" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
>>>>> À: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
>>>>> Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>>> Envoyé: Mercredi 30 Janvier 2019 08:45:33
>>>>> Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart
>>>>>
>>>>> Hi,
>>>>>
>>>>> Am 30.01.19 um 08:33 schrieb Alexandre DERUMIER:
>>>>>> Hi,
>>>>>>
>>>>>> here some new results,
>>>>>> different osd/ different cluster
>>>>>>
>>>>>> before osd restart latency was between 2-5ms
>>>>>> after osd restart is around 1-1.5ms
>>>>>>
>>>>>> http://odisoweb1.odiso.net/cephperf2/bad.txt (2-5ms)
>>>>>> http://odisoweb1.odiso.net/cephperf2/ok.txt (1-1.5ms)
>>>>>> http://odisoweb1.odiso.net/cephperf2/diff.txt
>>>>>>
>>>>>>  From what I see in diff, the biggest difference is in tcmalloc, but maybe I'm wrong.
>>>>>> (I'm using tcmalloc 2.5-2.2)
>>>>> currently i'm in the process of switching back from jemalloc to tcmalloc
>>>>> like suggested. This report makes me a little nervous about my change.
>>>>>
>>>>> Also i'm currently only monitoring latency for filestore osds. Which
>>>>> exact values out of the daemon do you use for bluestore?
>>>>>
>>>>> I would like to check if i see the same behaviour.
>>>>>
>>>>> Greets,
>>>>> Stefan
>>>>>
>>>>>> ----- Mail original -----
>>>>>> De: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
>>>>>> À: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>>>>> Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>>>> Envoyé: Vendredi 25 Janvier 2019 10:49:02
>>>>>> Objet: Re: ceph osd commit latency increase over time, until restart
>>>>>>
>>>>>> Can you capture a perf top or perf record to see where teh CPU time is
>>>>>> going on one of the OSDs wth a high latency?
>>>>>>
>>>>>> Thanks!
>>>>>> sage
>>>>>>
>>>>>>
>>>>>> On Fri, 25 Jan 2019, Alexandre DERUMIER wrote:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I have a strange behaviour of my osd, on multiple clusters,
>>>>>>>
>>>>>>> All cluster are running mimic 13.2.1,bluestore, with ssd or nvme drivers,
>>>>>>> workload is rbd only, with qemu-kvm vms running with librbd + snapshot/rbd export-diff/snapshotdelete each day for backup
>>>>>>>
>>>>>>> When the osd are refreshly started, the commit latency is between 0,5-1ms.
>>>>>>>
>>>>>>> But overtime, this latency increase slowly (maybe around 1ms by day), until reaching crazy
>>>>>>> values like 20-200ms.
>>>>>>>
>>>>>>> Some example graphs:
>>>>>>>
>>>>>>> http://odisoweb1.odiso.net/osdlatency1.png
>>>>>>> http://odisoweb1.odiso.net/osdlatency2.png
>>>>>>>
>>>>>>> All osds have this behaviour, in all clusters.
>>>>>>>
>>>>>>> The latency of physical disks is ok. (Clusters are far to be full loaded)
>>>>>>>
>>>>>>> And if I restart the osd, the latency come back to 0,5-1ms.
>>>>>>>
>>>>>>> That's remember me old tcmalloc bug, but maybe could it be a bluestore memory bug ?
>>>>>>>
>>>>>>> Any Hints for counters/logs to check ?
>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Alexandre
>>>>>>>
>>>>>>>
>>>>>> _______________________________________________
>>>>>> ceph-users mailing list
>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>
>>
>
>
>

--------------80F1686A3EED05D79162FAF8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Alexander,</p>
    <p>I've read through your reports, nothing obvious so far.</p>
    <p>I can only see several times average latency increase for OSD
      write ops (in seconds)<br>
    </p>
    0.002040060 (first hour) vs.
    <pre style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; overflow-wrap: break-word; white-space: pre-wrap;">0.002483516 (last 24 hours) vs. 
0.008382087 (last hour)

subop_w_latency:
0.000478934 (first hour) vs.
0.000537956 (last 24 hours) vs. 
0.003073475 (last hour)

and OSD read ops, osd_r_latency:

0.000408595 (first hour)
0.000709031 (24 hours)
0.004979540 (last hour)
  
What's interesting is that such latency differences aren't observed at neither BlueStore level (any _lat params under "bluestore" section) nor rocksdb one.

Which probably means that the issue is rather somewhere above BlueStore.

Suggest to proceed with perf dumps collection to see if the picture stays the same.

W.r.t. memory usage you observed I see nothing suspicious so far - No decrease in RSS report is a known artifact that seems to be safe.

Thanks,
Igor
</pre>
    <div class="moz-cite-prefix">On 2/13/2019 11:42 AM, Alexandre
      DERUMIER wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1554220830.1076801.1550047328269.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">Hi Igor, 

Thanks again for helping !



I have upgrade to last mimic this weekend, and with new autotune memory,
I have setup osd_memory_target to 8G.  (my nvme are 6TB)


I have done a lot of perf dump and mempool dump and ps of process to see rss memory at different hours,
here the reports for osd.0:

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/">http://odisoweb1.odiso.net/perfanalysis/</a>


osd has been started the 12-02-2019 at 08:00

first report after 1h running
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.perf.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.perf.txt</a>
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.dump_mempools.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.dump_mempools.txt</a>
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.ps.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.09:30.ps.txt</a>



report  after 24 before counter resets

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.perf.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.perf.txt</a>
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.dump_mempools.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.dump_mempools.txt</a>
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.ps.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.08:00.ps.txt</a>

report 1h after counter reset
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.perf.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.perf.txt</a>
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.dump_mempools.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.dump_mempools.txt</a>
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.ps.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.13-02-2018.09:00.ps.txt</a>




I'm seeing the bluestore buffer bytes memory increasing up to 4G  around 12-02-2019 at 14:00
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/graphs2.png">http://odisoweb1.odiso.net/perfanalysis/graphs2.png</a>
Then after that, slowly decreasing.


Another strange thing,
I'm seeing total bytes at 5G at 12-02-2018.13:30
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.13:30.dump_mempools.txt">http://odisoweb1.odiso.net/perfanalysis/osd.0.12-02-2018.13:30.dump_mempools.txt</a>
Then is decreasing over time (around 3,7G this morning), but RSS is still at 8G


I'm graphing mempools counters too since yesterday, so I'll able to track them over time.

----- Mail original -----
De: "Igor Fedotov" <a class="moz-txt-link-rfc2396E" href="mailto:ifedotov-l3A5Bk7waGM@public.gmane.org">&lt;ifedotov-l3A5Bk7waGM@public.gmane.org&gt;</a>
À: "Alexandre Derumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a>
Cc: "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a>
Envoyé: Lundi 11 Février 2019 12:03:17
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart

On 2/8/2019 6:57 PM, Alexandre DERUMIER wrote: 
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">another mempool dump after 1h run. (latency ok) 

Biggest difference: 

before restart 
------------- 
"bluestore_cache_other": { 
"items": 48661920, 
"bytes": 1539544228 
}, 
"bluestore_cache_data": { 
"items": 54, 
"bytes": 643072 
}, 
(other caches seem to be quite low too, like bluestore_cache_other take all the memory) 


After restart 
------------- 
"bluestore_cache_other": { 
"items": 12432298, 
"bytes": 500834899 
}, 
"bluestore_cache_data": { 
"items": 40084, 
"bytes": 1056235520 
}, 

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">This is fine as cache is warming after restart and some rebalancing 
between data and metadata might occur. 

What relates to allocator and most probably to fragmentation growth is : 

"bluestore_alloc": { 
"items": 165053952, 
"bytes": 165053952 
}, 

which had been higher before the reset (if I got these dumps' order 
properly) 

"bluestore_alloc": { 
"items": 210243456, 
"bytes": 210243456 
}, 

But as I mentioned - I'm not 100% sure this might cause such a huge 
latency increase... 

Do you have perf counters dump after the restart? 

Could you collect some more dumps - for both mempool and perf counters? 

So ideally I'd like to have: 

1) mempool/perf counters dumps after the restart (1hour is OK) 

2) mempool/perf counters dumps in 24+ hours after restart 

3) reset perf counters after 2), wait for 1 hour (and without OSD 
restart) and dump mempool/perf counters again. 

So we'll be able to learn both allocator mem usage growth and operation 
latency distribution for the following periods: 

a) 1st hour after restart 

b) 25th hour. 


Thanks, 

Igor 


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">full mempool dump after restart 
------------------------------- 

{ 
"mempool": { 
"by_pool": { 
"bloom_filter": { 
"items": 0, 
"bytes": 0 
}, 
"bluestore_alloc": { 
"items": 165053952, 
"bytes": 165053952 
}, 
"bluestore_cache_data": { 
"items": 40084, 
"bytes": 1056235520 
}, 
"bluestore_cache_onode": { 
"items": 22225, 
"bytes": 14935200 
}, 
"bluestore_cache_other": { 
"items": 12432298, 
"bytes": 500834899 
}, 
"bluestore_fsck": { 
"items": 0, 
"bytes": 0 
}, 
"bluestore_txc": { 
"items": 11, 
"bytes": 8184 
}, 
"bluestore_writing_deferred": { 
"items": 5047, 
"bytes": 22673736 
}, 
"bluestore_writing": { 
"items": 91, 
"bytes": 1662976 
}, 
"bluefs": { 
"items": 1907, 
"bytes": 95600 
}, 
"buffer_anon": { 
"items": 19664, 
"bytes": 25486050 
}, 
"buffer_meta": { 
"items": 46189, 
"bytes": 2956096 
}, 
"osd": { 
"items": 243, 
"bytes": 3089016 
}, 
"osd_mapbl": { 
"items": 17, 
"bytes": 214366 
}, 
"osd_pglog": { 
"items": 889673, 
"bytes": 367160400 
}, 
"osdmap": { 
"items": 3803, 
"bytes": 224552 
}, 
"osdmap_mapping": { 
"items": 0, 
"bytes": 0 
}, 
"pgmap": { 
"items": 0, 
"bytes": 0 
}, 
"mds_co": { 
"items": 0, 
"bytes": 0 
}, 
"unittest_1": { 
"items": 0, 
"bytes": 0 
}, 
"unittest_2": { 
"items": 0, 
"bytes": 0 
} 
}, 
"total": { 
"items": 178515204, 
"bytes": 2160630547 
} 
} 
} 

----- Mail original ----- 
De: "aderumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
À: "Igor Fedotov" <a class="moz-txt-link-rfc2396E" href="mailto:ifedotov-l3A5Bk7waGM@public.gmane.org">&lt;ifedotov-l3A5Bk7waGM@public.gmane.org&gt;</a> 
Cc: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a>, "Mark Nelson" <a class="moz-txt-link-rfc2396E" href="mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">&lt;mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a>, "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Vendredi 8 Février 2019 16:14:54 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

I'm just seeing 

StupidAllocator::_aligned_len 
and 
btree::btree_iterator&lt;btree::btree_node&lt;btree::btree_map_params&lt;unsigned long, unsigned long, std::less&lt;unsigned long&gt;, mempoo 

on 1 osd, both 10%. 

here the dump_mempools 

{ 
"mempool": { 
"by_pool": { 
"bloom_filter": { 
"items": 0, 
"bytes": 0 
}, 
"bluestore_alloc": { 
"items": 210243456, 
"bytes": 210243456 
}, 
"bluestore_cache_data": { 
"items": 54, 
"bytes": 643072 
}, 
"bluestore_cache_onode": { 
"items": 105637, 
"bytes": 70988064 
}, 
"bluestore_cache_other": { 
"items": 48661920, 
"bytes": 1539544228 
}, 
"bluestore_fsck": { 
"items": 0, 
"bytes": 0 
}, 
"bluestore_txc": { 
"items": 12, 
"bytes": 8928 
}, 
"bluestore_writing_deferred": { 
"items": 406, 
"bytes": 4792868 
}, 
"bluestore_writing": { 
"items": 66, 
"bytes": 1085440 
}, 
"bluefs": { 
"items": 1882, 
"bytes": 93600 
}, 
"buffer_anon": { 
"items": 138986, 
"bytes": 24983701 
}, 
"buffer_meta": { 
"items": 544, 
"bytes": 34816 
}, 
"osd": { 
"items": 243, 
"bytes": 3089016 
}, 
"osd_mapbl": { 
"items": 36, 
"bytes": 179308 
}, 
"osd_pglog": { 
"items": 952564, 
"bytes": 372459684 
}, 
"osdmap": { 
"items": 3639, 
"bytes": 224664 
}, 
"osdmap_mapping": { 
"items": 0, 
"bytes": 0 
}, 
"pgmap": { 
"items": 0, 
"bytes": 0 
}, 
"mds_co": { 
"items": 0, 
"bytes": 0 
}, 
"unittest_1": { 
"items": 0, 
"bytes": 0 
}, 
"unittest_2": { 
"items": 0, 
"bytes": 0 
} 
}, 
"total": { 
"items": 260109445, 
"bytes": 2228370845 
} 
} 
} 


and the perf dump 

root@ceph5-2:~# ceph daemon osd.4 perf dump 
{ 
"AsyncMessenger::Worker-0": { 
"msgr_recv_messages": 22948570, 
"msgr_send_messages": 22561570, 
"msgr_recv_bytes": 333085080271, 
"msgr_send_bytes": 261798871204, 
"msgr_created_connections": 6152, 
"msgr_active_connections": 2701, 
"msgr_running_total_time": 1055.197867330, 
"msgr_running_send_time": 352.764480121, 
"msgr_running_recv_time": 499.206831955, 
"msgr_running_fast_dispatch_time": 130.982201607 
}, 
"AsyncMessenger::Worker-1": { 
"msgr_recv_messages": 18801593, 
"msgr_send_messages": 18430264, 
"msgr_recv_bytes": 306871760934, 
"msgr_send_bytes": 192789048666, 
"msgr_created_connections": 5773, 
"msgr_active_connections": 2721, 
"msgr_running_total_time": 816.821076305, 
"msgr_running_send_time": 261.353228926, 
"msgr_running_recv_time": 394.035587911, 
"msgr_running_fast_dispatch_time": 104.012155720 
}, 
"AsyncMessenger::Worker-2": { 
"msgr_recv_messages": 18463400, 
"msgr_send_messages": 18105856, 
"msgr_recv_bytes": 187425453590, 
"msgr_send_bytes": 220735102555, 
"msgr_created_connections": 5897, 
"msgr_active_connections": 2605, 
"msgr_running_total_time": 807.186854324, 
"msgr_running_send_time": 296.834435839, 
"msgr_running_recv_time": 351.364389691, 
"msgr_running_fast_dispatch_time": 101.215776792 
}, 
"bluefs": { 
"gift_bytes": 0, 
"reclaim_bytes": 0, 
"db_total_bytes": 256050724864, 
"db_used_bytes": 12413042688, 
"wal_total_bytes": 0, 
"wal_used_bytes": 0, 
"slow_total_bytes": 0, 
"slow_used_bytes": 0, 
"num_files": 209, 
"log_bytes": 10383360, 
"log_compactions": 14, 
"logged_bytes": 336498688, 
"files_written_wal": 2, 
"files_written_sst": 4499, 
"bytes_written_wal": 417989099783, 
"bytes_written_sst": 213188750209 
}, 
"bluestore": { 
"kv_flush_lat": { 
"avgcount": 26371957, 
"sum": 26.734038497, 
"avgtime": 0.000001013 
}, 
"kv_commit_lat": { 
"avgcount": 26371957, 
"sum": 3397.491150603, 
"avgtime": 0.000128829 
}, 
"kv_lat": { 
"avgcount": 26371957, 
"sum": 3424.225189100, 
"avgtime": 0.000129843 
}, 
"state_prepare_lat": { 
"avgcount": 30484924, 
"sum": 3689.542105337, 
"avgtime": 0.000121028 
}, 
"state_aio_wait_lat": { 
"avgcount": 30484924, 
"sum": 509.864546111, 
"avgtime": 0.000016725 
}, 
"state_io_done_lat": { 
"avgcount": 30484924, 
"sum": 24.534052953, 
"avgtime": 0.000000804 
}, 
"state_kv_queued_lat": { 
"avgcount": 30484924, 
"sum": 3488.338424238, 
"avgtime": 0.000114428 
}, 
"state_kv_commiting_lat": { 
"avgcount": 30484924, 
"sum": 5660.437003432, 
"avgtime": 0.000185679 
}, 
"state_kv_done_lat": { 
"avgcount": 30484924, 
"sum": 7.763511500, 
"avgtime": 0.000000254 
}, 
"state_deferred_queued_lat": { 
"avgcount": 26346134, 
"sum": 666071.296856696, 
"avgtime": 0.025281557 
}, 
"state_deferred_aio_wait_lat": { 
"avgcount": 26346134, 
"sum": 1755.660547071, 
"avgtime": 0.000066638 
}, 
"state_deferred_cleanup_lat": { 
"avgcount": 26346134, 
"sum": 185465.151653703, 
"avgtime": 0.007039558 
}, 
"state_finishing_lat": { 
"avgcount": 30484920, 
"sum": 3.046847481, 
"avgtime": 0.000000099 
}, 
"state_done_lat": { 
"avgcount": 30484920, 
"sum": 13193.362685280, 
"avgtime": 0.000432783 
}, 
"throttle_lat": { 
"avgcount": 30484924, 
"sum": 14.634269979, 
"avgtime": 0.000000480 
}, 
"submit_lat": { 
"avgcount": 30484924, 
"sum": 3873.883076148, 
"avgtime": 0.000127075 
}, 
"commit_lat": { 
"avgcount": 30484924, 
"sum": 13376.492317331, 
"avgtime": 0.000438790 
}, 
"read_lat": { 
"avgcount": 5873923, 
"sum": 1817.167582057, 
"avgtime": 0.000309361 
}, 
"read_onode_meta_lat": { 
"avgcount": 19608201, 
"sum": 146.770464482, 
"avgtime": 0.000007485 
}, 
"read_wait_aio_lat": { 
"avgcount": 13734278, 
"sum": 2532.578077242, 
"avgtime": 0.000184398 
}, 
"compress_lat": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"decompress_lat": { 
"avgcount": 1346945, 
"sum": 26.227575896, 
"avgtime": 0.000019471 
}, 
"csum_lat": { 
"avgcount": 28020392, 
"sum": 149.587819041, 
"avgtime": 0.000005338 
}, 
"compress_success_count": 0, 
"compress_rejected_count": 0, 
"write_pad_bytes": 352923605, 
"deferred_write_ops": 24373340, 
"deferred_write_bytes": 216791842816, 
"write_penalty_read_ops": 8062366, 
"bluestore_allocated": 3765566013440, 
"bluestore_stored": 4186255221852, 
"bluestore_compressed": 39981379040, 
"bluestore_compressed_allocated": 73748348928, 
"bluestore_compressed_original": 165041381376, 
"bluestore_onodes": 104232, 
"bluestore_onode_hits": 71206874, 
"bluestore_onode_misses": 1217914, 
"bluestore_onode_shard_hits": 260183292, 
"bluestore_onode_shard_misses": 22851573, 
"bluestore_extents": 3394513, 
"bluestore_blobs": 2773587, 
"bluestore_buffers": 0, 
"bluestore_buffer_bytes": 0, 
"bluestore_buffer_hit_bytes": 62026011221, 
"bluestore_buffer_miss_bytes": 995233669922, 
"bluestore_write_big": 5648815, 
"bluestore_write_big_bytes": 552502214656, 
"bluestore_write_big_blobs": 12440992, 
"bluestore_write_small": 35883770, 
"bluestore_write_small_bytes": 223436965719, 
"bluestore_write_small_unused": 408125, 
"bluestore_write_small_deferred": 34961455, 
"bluestore_write_small_pre_read": 34961455, 
"bluestore_write_small_new": 514190, 
"bluestore_txc": 30484924, 
"bluestore_onode_reshard": 5144189, 
"bluestore_blob_split": 60104, 
"bluestore_extent_compress": 53347252, 
"bluestore_gc_merged": 21142528, 
"bluestore_read_eio": 0, 
"bluestore_fragmentation_micros": 67 
}, 
"finisher-defered_finisher": { 
"queue_len": 0, 
"complete_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"finisher-finisher-0": { 
"queue_len": 0, 
"complete_latency": { 
"avgcount": 26625163, 
"sum": 1057.506990951, 
"avgtime": 0.000039718 
} 
}, 
"finisher-objecter-finisher-0": { 
"queue_len": 0, 
"complete_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.0::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.0::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.1::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.1::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.2::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.2::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.3::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.3::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.4::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.4::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.5::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.5::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.6::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.6::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.7::sdata_wait_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"mutex-OSDShard.7::shard_lock": { 
"wait": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"objecter": { 
"op_active": 0, 
"op_laggy": 0, 
"op_send": 0, 
"op_send_bytes": 0, 
"op_resend": 0, 
"op_reply": 0, 
"op": 0, 
"op_r": 0, 
"op_w": 0, 
"op_rmw": 0, 
"op_pg": 0, 
"osdop_stat": 0, 
"osdop_create": 0, 
"osdop_read": 0, 
"osdop_write": 0, 
"osdop_writefull": 0, 
"osdop_writesame": 0, 
"osdop_append": 0, 
"osdop_zero": 0, 
"osdop_truncate": 0, 
"osdop_delete": 0, 
"osdop_mapext": 0, 
"osdop_sparse_read": 0, 
"osdop_clonerange": 0, 
"osdop_getxattr": 0, 
"osdop_setxattr": 0, 
"osdop_cmpxattr": 0, 
"osdop_rmxattr": 0, 
"osdop_resetxattrs": 0, 
"osdop_tmap_up": 0, 
"osdop_tmap_put": 0, 
"osdop_tmap_get": 0, 
"osdop_call": 0, 
"osdop_watch": 0, 
"osdop_notify": 0, 
"osdop_src_cmpxattr": 0, 
"osdop_pgls": 0, 
"osdop_pgls_filter": 0, 
"osdop_other": 0, 
"linger_active": 0, 
"linger_send": 0, 
"linger_resend": 0, 
"linger_ping": 0, 
"poolop_active": 0, 
"poolop_send": 0, 
"poolop_resend": 0, 
"poolstat_active": 0, 
"poolstat_send": 0, 
"poolstat_resend": 0, 
"statfs_active": 0, 
"statfs_send": 0, 
"statfs_resend": 0, 
"command_active": 0, 
"command_send": 0, 
"command_resend": 0, 
"map_epoch": 105913, 
"map_full": 0, 
"map_inc": 828, 
"osd_sessions": 0, 
"osd_session_open": 0, 
"osd_session_close": 0, 
"osd_laggy": 0, 
"omap_wr": 0, 
"omap_rd": 0, 
"omap_del": 0 
}, 
"osd": { 
"op_wip": 0, 
"op": 16758102, 
"op_in_bytes": 238398820586, 
"op_out_bytes": 165484999463, 
"op_latency": { 
"avgcount": 16758102, 
"sum": 38242.481640842, 
"avgtime": 0.002282029 
}, 
"op_process_latency": { 
"avgcount": 16758102, 
"sum": 28644.906310687, 
"avgtime": 0.001709316 
}, 
"op_prepare_latency": { 
"avgcount": 16761367, 
"sum": 3489.856599934, 
"avgtime": 0.000208208 
}, 
"op_r": 6188565, 
"op_r_out_bytes": 165484999463, 
"op_r_latency": { 
"avgcount": 6188565, 
"sum": 4507.365756792, 
"avgtime": 0.000728337 
}, 
"op_r_process_latency": { 
"avgcount": 6188565, 
"sum": 942.363063429, 
"avgtime": 0.000152274 
}, 
"op_r_prepare_latency": { 
"avgcount": 6188644, 
"sum": 982.866710389, 
"avgtime": 0.000158817 
}, 
"op_w": 10546037, 
"op_w_in_bytes": 238334329494, 
"op_w_latency": { 
"avgcount": 10546037, 
"sum": 33160.719998316, 
"avgtime": 0.003144377 
}, 
"op_w_process_latency": { 
"avgcount": 10546037, 
"sum": 27668.702029030, 
"avgtime": 0.002623611 
}, 
"op_w_prepare_latency": { 
"avgcount": 10548652, 
"sum": 2499.688609173, 
"avgtime": 0.000236967 
}, 
"op_rw": 23500, 
"op_rw_in_bytes": 64491092, 
"op_rw_out_bytes": 0, 
"op_rw_latency": { 
"avgcount": 23500, 
"sum": 574.395885734, 
"avgtime": 0.024442378 
}, 
"op_rw_process_latency": { 
"avgcount": 23500, 
"sum": 33.841218228, 
"avgtime": 0.001440051 
}, 
"op_rw_prepare_latency": { 
"avgcount": 24071, 
"sum": 7.301280372, 
"avgtime": 0.000303322 
}, 
"op_before_queue_op_lat": { 
"avgcount": 57892986, 
"sum": 1502.117718889, 
"avgtime": 0.000025946 
}, 
"op_before_dequeue_op_lat": { 
"avgcount": 58091683, 
"sum": 45194.453254037, 
"avgtime": 0.000777984 
}, 
"subop": 19784758, 
"subop_in_bytes": 547174969754, 
"subop_latency": { 
"avgcount": 19784758, 
"sum": 13019.714424060, 
"avgtime": 0.000658067 
}, 
"subop_w": 19784758, 
"subop_w_in_bytes": 547174969754, 
"subop_w_latency": { 
"avgcount": 19784758, 
"sum": 13019.714424060, 
"avgtime": 0.000658067 
}, 
"subop_pull": 0, 
"subop_pull_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"subop_push": 0, 
"subop_push_in_bytes": 0, 
"subop_push_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"pull": 0, 
"push": 2003, 
"push_out_bytes": 5560009728, 
"recovery_ops": 1940, 
"loadavg": 118, 
"buffer_bytes": 0, 
"history_alloc_Mbytes": 0, 
"history_alloc_num": 0, 
"cached_crc": 0, 
"cached_crc_adjusted": 0, 
"missed_crc": 0, 
"numpg": 243, 
"numpg_primary": 82, 
"numpg_replica": 161, 
"numpg_stray": 0, 
"numpg_removing": 0, 
"heartbeat_to_peers": 10, 
"map_messages": 7013, 
"map_message_epochs": 7143, 
"map_message_epoch_dups": 6315, 
"messages_delayed_for_map": 0, 
"osd_map_cache_hit": 203309, 
"osd_map_cache_miss": 33, 
"osd_map_cache_miss_low": 0, 
"osd_map_cache_miss_low_avg": { 
"avgcount": 0, 
"sum": 0 
}, 
"osd_map_bl_cache_hit": 47012, 
"osd_map_bl_cache_miss": 1681, 
"stat_bytes": 6401248198656, 
"stat_bytes_used": 3777979072512, 
"stat_bytes_avail": 2623269126144, 
"copyfrom": 0, 
"tier_promote": 0, 
"tier_flush": 0, 
"tier_flush_fail": 0, 
"tier_try_flush": 0, 
"tier_try_flush_fail": 0, 
"tier_evict": 0, 
"tier_whiteout": 1631, 
"tier_dirty": 22360, 
"tier_clean": 0, 
"tier_delay": 0, 
"tier_proxy_read": 0, 
"tier_proxy_write": 0, 
"agent_wake": 0, 
"agent_skip": 0, 
"agent_flush": 0, 
"agent_evict": 0, 
"object_ctx_cache_hit": 16311156, 
"object_ctx_cache_total": 17426393, 
"op_cache_hit": 0, 
"osd_tier_flush_lat": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"osd_tier_promote_lat": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"osd_tier_r_lat": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"osd_pg_info": 30483113, 
"osd_pg_fastinfo": 29619885, 
"osd_pg_biginfo": 81703 
}, 
"recoverystate_perf": { 
"initial_latency": { 
"avgcount": 243, 
"sum": 6.869296500, 
"avgtime": 0.028268709 
}, 
"started_latency": { 
"avgcount": 1125, 
"sum": 13551384.917335850, 
"avgtime": 12045.675482076 
}, 
"reset_latency": { 
"avgcount": 1368, 
"sum": 1101.727799040, 
"avgtime": 0.805356578 
}, 
"start_latency": { 
"avgcount": 1368, 
"sum": 0.002014799, 
"avgtime": 0.000001472 
}, 
"primary_latency": { 
"avgcount": 507, 
"sum": 4575560.638823428, 
"avgtime": 9024.774435549 
}, 
"peering_latency": { 
"avgcount": 550, 
"sum": 499.372283616, 
"avgtime": 0.907949606 
}, 
"backfilling_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"waitremotebackfillreserved_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"waitlocalbackfillreserved_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"notbackfilling_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"repnotrecovering_latency": { 
"avgcount": 1009, 
"sum": 8975301.082274411, 
"avgtime": 8895.243887288 
}, 
"repwaitrecoveryreserved_latency": { 
"avgcount": 420, 
"sum": 99.846056520, 
"avgtime": 0.237728706 
}, 
"repwaitbackfillreserved_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"reprecovering_latency": { 
"avgcount": 420, 
"sum": 241.682764382, 
"avgtime": 0.575435153 
}, 
"activating_latency": { 
"avgcount": 507, 
"sum": 16.893347339, 
"avgtime": 0.033320211 
}, 
"waitlocalrecoveryreserved_latency": { 
"avgcount": 199, 
"sum": 672.335512769, 
"avgtime": 3.378570415 
}, 
"waitremoterecoveryreserved_latency": { 
"avgcount": 199, 
"sum": 213.536439363, 
"avgtime": 1.073047433 
}, 
"recovering_latency": { 
"avgcount": 199, 
"sum": 79.007696479, 
"avgtime": 0.397023600 
}, 
"recovered_latency": { 
"avgcount": 507, 
"sum": 14.000732748, 
"avgtime": 0.027614857 
}, 
"clean_latency": { 
"avgcount": 395, 
"sum": 4574325.900371083, 
"avgtime": 11580.571899673 
}, 
"active_latency": { 
"avgcount": 425, 
"sum": 4575107.630123680, 
"avgtime": 10764.959129702 
}, 
"replicaactive_latency": { 
"avgcount": 589, 
"sum": 8975184.499049954, 
"avgtime": 15238.004242869 
}, 
"stray_latency": { 
"avgcount": 818, 
"sum": 800.729455666, 
"avgtime": 0.978886865 
}, 
"getinfo_latency": { 
"avgcount": 550, 
"sum": 15.085667048, 
"avgtime": 0.027428485 
}, 
"getlog_latency": { 
"avgcount": 546, 
"sum": 3.482175693, 
"avgtime": 0.006377611 
}, 
"waitactingchange_latency": { 
"avgcount": 39, 
"sum": 35.444551284, 
"avgtime": 0.908834648 
}, 
"incomplete_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"down_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"getmissing_latency": { 
"avgcount": 507, 
"sum": 6.702129624, 
"avgtime": 0.013219190 
}, 
"waitupthru_latency": { 
"avgcount": 507, 
"sum": 474.098261727, 
"avgtime": 0.935105052 
}, 
"notrecovering_latency": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
}, 
"rocksdb": { 
"get": 28320977, 
"submit_transaction": 30484924, 
"submit_transaction_sync": 26371957, 
"get_latency": { 
"avgcount": 28320977, 
"sum": 325.900908733, 
"avgtime": 0.000011507 
}, 
"submit_latency": { 
"avgcount": 30484924, 
"sum": 1835.888692371, 
"avgtime": 0.000060222 
}, 
"submit_sync_latency": { 
"avgcount": 26371957, 
"sum": 1431.555230628, 
"avgtime": 0.000054283 
}, 
"compact": 0, 
"compact_range": 0, 
"compact_queue_merge": 0, 
"compact_queue_len": 0, 
"rocksdb_write_wal_time": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"rocksdb_write_memtable_time": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"rocksdb_write_delay_time": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
}, 
"rocksdb_write_pre_and_post_time": { 
"avgcount": 0, 
"sum": 0.000000000, 
"avgtime": 0.000000000 
} 
} 
} 

----- Mail original ----- 
De: "Igor Fedotov" <a class="moz-txt-link-rfc2396E" href="mailto:ifedotov-l3A5Bk7waGM@public.gmane.org">&lt;ifedotov-l3A5Bk7waGM@public.gmane.org&gt;</a> 
À: "aderumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
Cc: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a>, "Mark Nelson" <a class="moz-txt-link-rfc2396E" href="mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">&lt;mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a>, "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Mardi 5 Février 2019 18:56:51 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

On 2/4/2019 6:40 PM, Alexandre DERUMIER wrote: 
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">but I don't see l_bluestore_fragmentation counter. 
(but I have bluestore_fragmentation_micros) 
</pre>
            </blockquote>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">ok, this is the same 

b.add_u64(l_bluestore_fragmentation, "bluestore_fragmentation_micros", 
"How fragmented bluestore free space is (free extents / max possible number of free extents) * 1000"); 


Here a graph on last month, with bluestore_fragmentation_micros and latency, 

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/latency_vs_fragmentation_micros.png">http://odisoweb1.odiso.net/latency_vs_fragmentation_micros.png</a> 
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">hmm, so fragmentation grows eventually and drops on OSD restarts, isn't 
it? The same for other OSDs? 

This proves some issue with the allocator - generally fragmentation 
might grow but it shouldn't reset on restart. Looks like some intervals 
aren't properly merged in run-time. 

On the other side I'm not completely sure that latency degradation is 
caused by that - fragmentation growth is relatively small - I don't see 
how this might impact performance that high. 

Wondering if you have OSD mempool monitoring (dump_mempools command 
output on admin socket) reports? Do you have any historic data? 

If not may I have current output and say a couple more samples with 
8-12 hours interval? 


Wrt to backporting bitmap allocator to mimic - we haven't had such plans 
before that but I'll discuss this at BlueStore meeting shortly. 


Thanks, 

Igor 

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">----- Mail original ----- 
De: "Alexandre Derumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
À: "Igor Fedotov" <a class="moz-txt-link-rfc2396E" href="mailto:ifedotov-l3A5Bk7waGM@public.gmane.org">&lt;ifedotov-l3A5Bk7waGM@public.gmane.org&gt;</a> 
Cc: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a>, "Mark Nelson" <a class="moz-txt-link-rfc2396E" href="mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">&lt;mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a>, "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Lundi 4 Février 2019 16:04:38 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

Thanks Igor, 

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Could you please collect BlueStore performance counters right after OSD 
startup and once you get high latency. 

Specifically 'l_bluestore_fragmentation' parameter is of interest. 
</pre>
            </blockquote>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I'm already monitoring with 
"ceph daemon osd.x perf dump ", (I have 2months history will all counters) 

but I don't see l_bluestore_fragmentation counter. 

(but I have bluestore_fragmentation_micros) 


</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Also if you're able to rebuild the code I can probably make a simple 
patch to track latency and some other internal allocator's paramter to 
make sure it's degraded and learn more details. 
</pre>
            </blockquote>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Sorry, It's a critical production cluster, I can't test on it :( 
But I have a test cluster, maybe I can try to put some load on it, and try to reproduce. 



</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">More vigorous fix would be to backport bitmap allocator from Nautilus 
and try the difference... 
</pre>
            </blockquote>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Any plan to backport it to mimic ? (But I can wait for Nautilus) 
perf results of new bitmap allocator seem very promising from what I've seen in PR. 



----- Mail original ----- 
De: "Igor Fedotov" <a class="moz-txt-link-rfc2396E" href="mailto:ifedotov-l3A5Bk7waGM@public.gmane.org">&lt;ifedotov-l3A5Bk7waGM@public.gmane.org&gt;</a> 
À: "Alexandre Derumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a>, "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a>, "Mark Nelson" <a class="moz-txt-link-rfc2396E" href="mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">&lt;mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a> 
Cc: "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Lundi 4 Février 2019 15:51:30 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

Hi Alexandre, 

looks like a bug in StupidAllocator. 

Could you please collect BlueStore performance counters right after OSD 
startup and once you get high latency. 

Specifically 'l_bluestore_fragmentation' parameter is of interest. 

Also if you're able to rebuild the code I can probably make a simple 
patch to track latency and some other internal allocator's paramter to 
make sure it's degraded and learn more details. 


More vigorous fix would be to backport bitmap allocator from Nautilus 
and try the difference... 


Thanks, 

Igor 


On 2/4/2019 5:17 PM, Alexandre DERUMIER wrote: 
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Hi again, 

I speak too fast, the problem has occured again, so it's not tcmalloc cache size related. 


I have notice something using a simple "perf top", 

each time I have this problem (I have seen exactly 4 times the same behaviour), 

when latency is bad, perf top give me : 

StupidAllocator::_aligned_len 
and 
btree::btree_iterator&lt;btree::btree_node&lt;btree::btree_map_params&lt;unsigned long, unsigned long, std::less&lt;unsigned long&gt;, mempoo 
l::pool_allocator&lt;(mempool::pool_index_t)1, std::pair&lt;unsigned long const, unsigned long&gt; &gt;, 256&gt; &gt;, std::pair&lt;unsigned long const, unsigned long&gt;&amp;, std::pair&lt;unsigned long 
const, unsigned long&gt;*&gt;::increment_slow() 

(around 10-20% time for both) 


when latency is good, I don't see them at all. 


I have used the Mark wallclock profiler, here the results: 

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/gdbpmp-ok.txt">http://odisoweb1.odiso.net/gdbpmp-ok.txt</a> 

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/gdbpmp-bad.txt">http://odisoweb1.odiso.net/gdbpmp-bad.txt</a> 


here an extract of the thread with btree::btree_iterator &amp;&amp; StupidAllocator::_aligned_len 


+ 100.00% clone 
+ 100.00% start_thread 
+ 100.00% ShardedThreadPool::WorkThreadSharded::entry() 
+ 100.00% ShardedThreadPool::shardedthreadpool_worker(unsigned int) 
+ 100.00% OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*) 
+ 70.00% PGOpItem::run(OSD*, OSDShard*, boost::intrusive_ptr&lt;PG&gt;&amp;, ThreadPool::TPHandle&amp;) 
| + 70.00% OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, boost::intrusive_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&amp;) 
| + 70.00% PrimaryLogPG::do_request(boost::intrusive_ptr&lt;OpRequest&gt;&amp;, ThreadPool::TPHandle&amp;) 
| + 68.00% PGBackend::handle_message(boost::intrusive_ptr&lt;OpRequest&gt;) 
| | + 68.00% ReplicatedBackend::_handle_message(boost::intrusive_ptr&lt;OpRequest&gt;) 
| | + 68.00% ReplicatedBackend::do_repop(boost::intrusive_ptr&lt;OpRequest&gt;) 
| | + 67.00% non-virtual thunk to PrimaryLogPG::queue_transactions(std::vector&lt;ObjectStore::Transaction, std::allocator&lt;ObjectStore::Transaction&gt; &gt;&amp;, boost::intrusive_ptr&lt;OpRequest&gt;) 
| | | + 67.00% BlueStore::queue_transactions(boost::intrusive_ptr&lt;ObjectStore::CollectionImpl&gt;&amp;, std::vector&lt;ObjectStore::Transaction, std::allocator&lt;ObjectStore::Transaction&gt; &gt;&amp;, boost::intrusive_ptr&lt;TrackedOp&gt;, ThreadPool::TPHandle*) 
| | | + 66.00% BlueStore::_txc_add_transaction(BlueStore::TransContext*, ObjectStore::Transaction*) 
| | | | + 66.00% BlueStore::_write(BlueStore::TransContext*, boost::intrusive_ptr&lt;BlueStore::Collection&gt;&amp;, boost::intrusive_ptr&lt;BlueStore::Onode&gt;&amp;, unsigned long, unsigned long, ceph::buffer::list&amp;, unsigned int) 
| | | | + 66.00% BlueStore::_do_write(BlueStore::TransContext*, boost::intrusive_ptr&lt;BlueStore::Collection&gt;&amp;, boost::intrusive_ptr&lt;BlueStore::Onode&gt;, unsigned long, unsigned long, ceph::buffer::list&amp;, unsigned int) 
| | | | + 65.00% BlueStore::_do_alloc_write(BlueStore::TransContext*, boost::intrusive_ptr&lt;BlueStore::Collection&gt;, boost::intrusive_ptr&lt;BlueStore::Onode&gt;, BlueStore::WriteContext*) 
| | | | | + 64.00% StupidAllocator::allocate(unsigned long, unsigned long, unsigned long, long, std::vector&lt;bluestore_pextent_t, mempool::pool_allocator&lt;(mempool::pool_index_t)4, bluestore_pextent_t&gt; &gt;*) 
| | | | | | + 64.00% StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long*, unsigned int*) 
| | | | | | + 34.00% btree::btree_iterator&lt;btree::btree_node&lt;btree::btree_map_params&lt;unsigned long, unsigned long, std::less&lt;unsigned long&gt;, mempool::pool_allocator&lt;(mempool::pool_index_t)1, std::pair&lt;unsigned long const, unsigned long&gt; &gt;, 256&gt; &gt;, std::pair&lt;unsigned long const, unsigned long&gt;&amp;, std::pair&lt;unsigned long const, unsigned long&gt;*&gt;::increment_slow() 
| | | | | | + 26.00% StupidAllocator::_aligned_len(interval_set&lt;unsigned long, btree::btree_map&lt;unsigned long, unsigned long, std::less&lt;unsigned long&gt;, mempool::pool_allocator&lt;(mempool::pool_index_t)1, std::pair&lt;unsigned long const, unsigned long&gt; &gt;, 256&gt; &gt;::iterator, unsigned long) 



----- Mail original ----- 
De: "Alexandre Derumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
À: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a> 
Cc: "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Lundi 4 Février 2019 09:38:11 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

Hi, 

some news: 

I have tried with different transparent hugepage values (madvise, never) : no change 

I have tried to increase bluestore_cache_size_ssd to 8G: no change 

I have tried to increase TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES to 256mb : it seem to help, after 24h I'm still around 1,5ms. (need to wait some more days to be sure) 


Note that this behaviour seem to happen really faster (&lt; 2 days) on my big nvme drives (6TB), 
my others clusters user 1,6TB ssd. 

Currently I'm using only 1 osd by nvme (I don't have more than 5000iops by osd), but I'll try this week with 2osd by nvme, to see if it's helping. 


BTW, does somebody have already tested ceph without tcmalloc, with glibc &gt;= 2.26 (which have also thread cache) ? 


Regards, 

Alexandre 


----- Mail original ----- 
De: "aderumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
À: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a> 
Cc: "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Mercredi 30 Janvier 2019 19:58:15 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

</pre>
            <blockquote type="cite">
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Thanks. Is there any reason you monitor op_w_latency but not 
op_r_latency but instead op_latency? 

Also why do you monitor op_w_process_latency? but not op_r_process_latency? 
</pre>
              </blockquote>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I monitor read too. (I have all metrics for osd sockets, and a lot of graphs). 

I just don't see latency difference on reads. (or they are very very small vs the write latency increase) 



----- Mail original ----- 
De: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a> 
À: "aderumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
Cc: "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a>, "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Mercredi 30 Janvier 2019 19:50:20 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

Hi, 

Am 30.01.19 um 14:59 schrieb Alexandre DERUMIER: 
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Hi Stefan, 

</pre>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">currently i'm in the process of switching back from jemalloc to tcmalloc 
like suggested. This report makes me a little nervous about my change. 
</pre>
                </blockquote>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Well,I'm really not sure that it's a tcmalloc bug. 
maybe bluestore related (don't have filestore anymore to compare) 
I need to compare with bigger latencies 

here an example, when all osd at 20-50ms before restart, then after restart (at 21:15), 1ms 
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/latencybad.png">http://odisoweb1.odiso.net/latencybad.png</a> 

I observe the latency in my guest vm too, on disks iowait. 

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/latencybadvm.png">http://odisoweb1.odiso.net/latencybadvm.png</a> 

</pre>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">Also i'm currently only monitoring latency for filestore osds. Which 
exact values out of the daemon do you use for bluestore? 
</pre>
                </blockquote>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">here my influxdb queries: 

It take op_latency.sum/op_latency.avgcount on last second. 


SELECT non_negative_derivative(first("op_latency.sum"), 1s)/non_negative_derivative(first("op_latency.avgcount"),1s) FROM "ceph" WHERE "host" =~ /^([[host]])$/ AND "id" =~ /^([[osd]])$/ AND $timeFilter GROUP BY time($interval), "host", "id" fill(previous) 


SELECT non_negative_derivative(first("op_w_latency.sum"), 1s)/non_negative_derivative(first("op_w_latency.avgcount"),1s) FROM "ceph" WHERE "host" =~ /^([[host]])$/ AND collection='osd' AND "id" =~ /^([[osd]])$/ AND $timeFilter GROUP BY time($interval), "host", "id" fill(previous) 


SELECT non_negative_derivative(first("op_w_process_latency.sum"), 1s)/non_negative_derivative(first("op_w_process_latency.avgcount"),1s) FROM "ceph" WHERE "host" =~ /^([[host]])$/ AND collection='osd' AND "id" =~ /^([[osd]])$/ AND $timeFilter GROUP BY time($interval), "host", "id" fill(previous) 
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Thanks. Is there any reason you monitor op_w_latency but not 
op_r_latency but instead op_latency? 

Also why do you monitor op_w_process_latency? but not op_r_process_latency? 

greets, 
Stefan 

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">

----- Mail original ----- 
De: "Stefan Priebe, Profihost AG" <a class="moz-txt-link-rfc2396E" href="mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">&lt;s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org&gt;</a> 
À: "aderumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a>, "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a> 
Cc: "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Mercredi 30 Janvier 2019 08:45:33 
Objet: Re: [ceph-users] ceph osd commit latency increase over time, until restart 

Hi, 

Am 30.01.19 um 08:33 schrieb Alexandre DERUMIER: 
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Hi, 

here some new results, 
different osd/ different cluster 

before osd restart latency was between 2-5ms 
after osd restart is around 1-1.5ms 

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/cephperf2/bad.txt">http://odisoweb1.odiso.net/cephperf2/bad.txt</a> (2-5ms) 
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/cephperf2/ok.txt">http://odisoweb1.odiso.net/cephperf2/ok.txt</a> (1-1.5ms) 
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/cephperf2/diff.txt">http://odisoweb1.odiso.net/cephperf2/diff.txt</a> 

From what I see in diff, the biggest difference is in tcmalloc, but maybe I'm wrong. 
(I'm using tcmalloc 2.5-2.2) 
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">currently i'm in the process of switching back from jemalloc to tcmalloc 
like suggested. This report makes me a little nervous about my change. 

Also i'm currently only monitoring latency for filestore osds. Which 
exact values out of the daemon do you use for bluestore? 

I would like to check if i see the same behaviour. 

Greets, 
Stefan 

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">----- Mail original ----- 
De: "Sage Weil" <a class="moz-txt-link-rfc2396E" href="mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">&lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt;</a> 
À: "aderumier" <a class="moz-txt-link-rfc2396E" href="mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">&lt;aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org&gt;</a> 
Cc: "ceph-users" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">&lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;</a>, "ceph-devel" <a class="moz-txt-link-rfc2396E" href="mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">&lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;</a> 
Envoyé: Vendredi 25 Janvier 2019 10:49:02 
Objet: Re: ceph osd commit latency increase over time, until restart 

Can you capture a perf top or perf record to see where teh CPU time is 
going on one of the OSDs wth a high latency? 

Thanks! 
sage 


On Fri, 25 Jan 2019, Alexandre DERUMIER wrote: 

</pre>
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">Hi, 

I have a strange behaviour of my osd, on multiple clusters, 

All cluster are running mimic 13.2.1,bluestore, with ssd or nvme drivers, 
workload is rbd only, with qemu-kvm vms running with librbd + snapshot/rbd export-diff/snapshotdelete each day for backup 

When the osd are refreshly started, the commit latency is between 0,5-1ms. 

But overtime, this latency increase slowly (maybe around 1ms by day), until reaching crazy 
values like 20-200ms. 

Some example graphs: 

<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/osdlatency1.png">http://odisoweb1.odiso.net/osdlatency1.png</a> 
<a class="moz-txt-link-freetext" href="http://odisoweb1.odiso.net/osdlatency2.png">http://odisoweb1.odiso.net/osdlatency2.png</a> 

All osds have this behaviour, in all clusters. 

The latency of physical disks is ok. (Clusters are far to be full loaded) 

And if I restart the osd, the latency come back to 0,5-1ms. 

That's remember me old tcmalloc bug, but maybe could it be a bluestore memory bug ? 

Any Hints for counters/logs to check ? 


Regards, 

Alexandre 


</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">_______________________________________________ 
ceph-users mailing list 
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> 
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> 

</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">



</pre>
    </blockquote>
  </body>
</html>

--------------80F1686A3EED05D79162FAF8--

--===============4897656043153500787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4897656043153500787==--
