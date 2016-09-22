From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: async messenger random read performance on NVMe
Date: Thu, 22 Sep 2016 19:04:24 +0200 (CEST)
Message-ID: <144746022.249080.1474563864079.JavaMail.zimbra@oxygem.tv>
References: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com> <CY1PR02MB21236DC2DEDA1C4577FED95BF4F60@CY1PR02MB2123.namprd02.prod.outlook.com> <61672ba0-fadc-2f25-dcf2-090129bd1c53@redhat.com> <CY1PR02MB2123F1C1AC9EC34A04ED3017F4F60@CY1PR02MB2123.namprd02.prod.outlook.com> <08bad1a0-e12d-825e-489d-9b44400cb57f@redhat.com> <CY1PR02MB2123377EE95BCDB36BC763CDF4F60@CY1PR02MB2123.namprd02.prod.outlook.com> <011585e9-6e13-5920-b347-85a8539b7f1a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:47414 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934155AbcIVRE1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 13:04:27 -0400
In-Reply-To: <011585e9-6e13-5920-b347-85a8539b7f1a@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

my last jewel benchmark show me around 300-350k iops 4k randread with simple messenger
But I was cpu saturated client side (40 cores 3,1ghz)


cluster was 3 nodes (40 cores 3,1ghz), with 18ssd intel s3610.


With 2 clients node, I have able to reach 600kiops easily.
3 clients node, I think it was the limited to 850kiops. (osd nodes was cpu saturated)


(note that it was with a small 100GB RBD device, fitting in buffer memory of osd nodes)
cephx && debug was disabled


As far I remember, async messenger was slower (maybe 250k, don't remember exactly)

I'll have a new similar cluster in some weeks for testing, so I'll try to compare bluestore vs filestore, simple vs async.


BTW, I remember when I was doing my first benchmark, that I was limited to around 150k iops. 
The bottleneck was interrupts on client side. a simple irqbalance on client have fixed it.
(It was with mellanox connect-x3 nic)




ceph.conf
---------
auth_cluster_required = none
auth_service_required = none
auth_client_required = none

debug paxos = 0/0
debug journal = 0/0
debug mds_balancer = 0/0
debug mds = 0/0

debug lockdep = 0/0
debug auth = 0/0
debug mds_log = 0/0
debug mon = 0/0
debug perfcounter = 0/0
debug monc = 0/0
debug rbd = 0/0
debug throttle = 0/0
debug mds_migrator = 0/0
debug client = 0/0
debug rgw = 0/0
debug finisher = 0/0
debug journaler = 0/0
debug ms = 0/0
debug hadoop = 0/0
debug mds_locker = 0/0
debug tp = 0/0
debug context = 0/0
debug osd = 0/0
debug bluestore = 0/0
debug objclass = 0/0
debug objecter = 0/0

filestore_queue_max_ops = 5000
osd_client_message_size_cap = 0
objecter_infilght_op_bytes = 1048576000
ms_dispatch_throttle_bytes = 1048576000
filestore_wbthrottle_enable = true
filestore_fd_cache_shards = 64
objecter_inflight_ops = 1024000
filestore_queue_committing_max_bytes = 1048576000
osd_op_num_threads_per_shard = 2
filestore_queue_max_bytes = 10485760000
osd_op_threads = 20
osd_op_num_shards = 10
filestore_max_sync_interval = 10
filestore_op_threads = 16
osd_pg_object_context_cache_count = 10240
journal_queue_max_ops = 3000
journal_queue_max_bytes = 10485760000
journal_max_write_entries = 1000
filestore_queue_committing_max_ops = 5000
journal_max_write_bytes = 1048576000
osd_enable_op_tracker = False
filestore_fd_cache_size = 10240
osd_client_message_cap = 0



----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
À: "Somnath Roy" <Somnath.Roy@sandisk.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Envoyé: Jeudi 22 Septembre 2016 15:29:21
Objet: Re: async messenger random read performance on NVMe

I ran a couple of quick 4k randread tests with double the osd op 
threads/shards: 

simple msgr: 

2/5 threads/shards: 168K IOPS 
4/10 threads/shards: 164K IOPS 

async msgr (send inline false): 

2/5 threads/shards: 153K IOPS 
4/10 threads/shards: 154K IOPS 

At least in this setup there doesn't seem to be much benefit to 
increasing the osd op threads/shards. 

Mark 

On 09/21/2016 02:47 PM, Somnath Roy wrote: 
> I have 16 OSDs total (16 SSds) , if you are using 4 NvMe cards , the result make sense probably. Sorry for the noise. 
> But, in general we have seen significant performance difference by increasing shards if you have high end cpus with high cores. 
> 
> Thanks & Regards 
> Somnath 
> -----Original Message----- 
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson 
> Sent: Wednesday, September 21, 2016 12:41 PM 
> To: ceph-devel 
> Subject: Re: async messenger random read performance on NVMe 
> 
> FWIW, in these tests I have 4 NVMe cards split into 4 OSDs each, so your setup with 32 OSDs on SSD probably has more raw randread throughput potential than mine does. 
> 
> Mark 
> 
> On 09/21/2016 02:27 PM, Somnath Roy wrote: 
>> We have the following data from our lab which is all SSD setup and since yours is with NvMe , the result should be much superior than ours unless you are cpu saturated at the OSD hosts. 
>> 
>> Setup : 
>> ------- 
>> 3 pools, 1024 PGs/pool 
>> One 2TB rbd image per pool , 3 physical clients running single fio/client with very high QD/jobs. 
>> 16 OSDs each with 4TB. 
>> Two OSD hosts with 48 cpu cores each. 
>> Replication : 2 
>> 
>> Result : 
>> ------- 
>> 
>> 4K RR ~*374K IOPs*. With simple. 
>> 
>> I think we are using 25 shards per OSD and 2 threads/shard. 
>> If you are not cpu saturated, try with increased shards and it should give you better 4K RR results. We need to see aync is able to give similar throughput at that level or not. 
>> I will also try measuring if I am able to squeeze some time out of my 
>> BlueStore activities :-) 
>> 
>> Thanks & Regards 
>> Somnath 
>> 
>> -----Original Message----- 
>> From: Mark Nelson [mailto:mnelson@redhat.com] 
>> Sent: Wednesday, September 21, 2016 12:11 PM 
>> To: Somnath Roy; ceph-devel 
>> Subject: Re: async messenger random read performance on NVMe 
>> 
>> Yes to multiple physical clients (2 fio processes per client using librbd with io depth = 32 each). No to increased OSD shards, this is just default. Can you explain a bit more why Simple should go faster with a similar config? Did you mean async? I'm going to try to dig in with perf and see how they compare. I wish I had a better way to profile lock contention rather than poorman's profiling via gdb. I suppose lttng is the answer. 
>> 
>> Mark 
>> 
>> On 09/21/2016 02:02 PM, Somnath Roy wrote: 
>>> Mark, 
>>> Are you trying with multiple physical clients and with increased OSD shards? 
>>> Simple should go way more with the similar config for 4K RR based on the result we were getting earlier unless your cpu is getting saturated at the OSD nodes. 
>>> 
>>> Thanks & Regards 
>>> Somnath 
>>> 
>>> -----Original Message----- 
>>> From: ceph-devel-owner@vger.kernel.org 
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson 
>>> Sent: Wednesday, September 21, 2016 11:50 AM 
>>> To: ceph-devel 
>>> Subject: async messenger random read performance on NVMe 
>>> 
>>> Recently in master we made async messenger default. After doing a bunch of bisection, it turns out that this caused a fairly dramatic decrease in bluestore random read performance. This is on a cluster with fairly fast NVMe cards, 16 OSDs across 4 OSD hosts. There are 8 fio client processes with 32 concurrent threads each. 
>>> 
>>> Ceph master using bluestore 
>>> 
>>> Parameters tweaked: 
>>> 
>>> ms_async_send_inline 
>>> ms_async_op_threads 
>>> ms_async_max_op_threads 
>>> 
>>> simple: 168K IOPS 
>>> 
>>> send_inline: true 
>>> async 3/5 threads: 111K IOPS 
>>> async 4/8 threads: 125K IOPS 
>>> async 8/16 threads: 128K IOPS 
>>> async 16/32 threads: 128K IOPS 
>>> async 24/48 threads: 128K IOPS 
>>> async 25/50 threads: segfault 
>>> async 26/52 threads: segfault 
>>> async 32/64 threads: segfault 
>>> 
>>> send_inline: false 
>>> async 3/5 threads: 153K IOPS 
>>> async 4/8 threads: 153K IOPS 
>>> async 8/16 threads: 152K IOPS 
>>> 
>>> So definitely setting send_inline to false helps pretty dramatically, though we're still a little slower for small random reads than simple messenger. Haomai, regarding the segfaults, I took a quick look with gdb at the core file but didn't see anything immediately obvious. It might be worth seeing if you can reproduce. 
>>> 
>>> On the performance front, I'll try to see if I can see anything obvious in perf. 
>>> 
>>> Mark 
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>>> info at http://vger.kernel.org/majordomo-info.html 
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies). 
>>> 
>> N r y b X ǧv ^ )޺{.n + z ]z {ay ʇڙ ,j f h z w 
> j:+v w j m zZ+ ݢj" !tml= 
>> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at http://vger.kernel.org/majordomo-info.html 
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!tml= 
> 
-- 
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 

