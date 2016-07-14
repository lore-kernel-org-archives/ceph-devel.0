From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore read performance
Date: Thu, 14 Jul 2016 12:41:46 -0500
Message-ID: <a3c41f99-b41b-ef82-b2fe-3b44c2990f14@redhat.com>
References: <BL2PR02MB2115F97A4A7B2362E214816CF4320@BL2PR02MB2115.namprd02.prod.outlook.com>
 <40b656c1-4e91-cfc2-aa41-fb8d6f2a4dd1@mirantis.com>
 <9c0bc712-6cce-2275-3a7a-cb6167a60818@redhat.com>
 <1e1aa6b7-fcf6-b2a9-1686-63424e70fb66@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcGNRlt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jul 2016 13:41:49 -0400
In-Reply-To: <1e1aa6b7-fcf6-b2a9-1686-63424e70fb66@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Default, so 5 I think as of forever.

Mark

On 07/14/2016 12:37 PM, Igor Fedotov wrote:
> Mark,
>
> and what's your setting for osd op num shards?
>
>
> On 14.07.2016 20:28, Mark Nelson wrote:
>> We are leaking or at least spiking memory much higher than than in
>> some cases.  In my tests I can get them up to about 9GB RSS per OSD.
>> I only have 4 nodes per OSD and 64GB of RAM though so I'm not hitting
>> swap (in fact these nodes don't have swap).
>>
>> Mark
>>
>> On 07/14/2016 12:17 PM, Igor Fedotov wrote:
>>> Somnath, Mark
>>>
>>> I have a question and some comments w.r.t. memory swapping.
>>>
>>> What's amount of RAM do you have at your nodes? How many of it is taken
>>> by OSDs?
>>>
>>> I can see that each BlueStore OSD may occupy
>>> bluestore_buffer_cache_size  *  osd_op_num_shards = 512M * 5 = 2.5G (by
>>> default) for buffer cache.
>>>
>>> Hence in Somnath's environment one might expect up to 20G taken for the
>>> cache. Does that estimation correlate with the real life?
>>>
>>>
>>> Thanks,
>>>
>>> Igor
>>>
>>>
>>> On 14.07.2016 19:50, Somnath Roy wrote:
>>>> Mark,
>>>> As we discussed in today's meeting , I ran 100% RR with the following
>>>> fio profile on a single image of 4TB. Did precondition the entire
>>>> image with 1M seq write. I have total of 16 OSDs over 2 nodes.
>>>>
>>>> [global]
>>>> ioengine=rbd
>>>> clientname=admin
>>>> pool=recovery_test
>>>> rbdname=recovery_image
>>>> invalidate=0    # mandatory
>>>> rw=randread
>>>> bs=4k
>>>> direct=1
>>>> time_based
>>>> runtime=30m
>>>> numjobs=8
>>>> group_reporting
>>>>
>>>> [rbd_iodepth32]
>>>> iodepth=128
>>>>
>>>> Here is the ceph.conf option I used for Bluestore.
>>>>
>>>>         osd_op_num_threads_per_shard = 2
>>>>          osd_op_num_shards = 25
>>>>
>>>>          bluestore_rocksdb_options =
>>>> "max_write_buffer_number=16,min_write_buffer_number_to_merge=16,recycle_log_file_num=16,compaction_threads=32,flusher_threads=4,
>>>>
>>>>
>>>>
>>>> max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"
>>>>
>>>>
>>>>          rocksdb_cache_size = 4294967296
>>>>          #bluestore_min_alloc_size = 16384
>>>>          bluestore_min_alloc_size = 4096
>>>>          bluestore_csum = false
>>>>          bluestore_csum_type = none
>>>>          bluestore_bluefs_buffered_io = false
>>>>          bluestore_max_ops = 30000
>>>>          bluestore_max_bytes = 629145600
>>>>
>>>> Here is the output I got.
>>>>
>>>> rbd_iodepth32: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
>>>> iodepth=128
>>>> ...
>>>> fio-2.1.11
>>>> Starting 8 processes
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> rbd engine: RBD version: 0.1.10
>>>> ^Cbs: 8 (f=8): [r(8)] [9.4% done] [179.5MB/0KB/0KB /s] [45.1K/0/0
>>>> iops] [eta 27m:12s]
>>>> fio: terminating on signal 2
>>>>
>>>> rbd_iodepth32: (groupid=0, jobs=8): err= 0: pid=1266211: Thu Jul 14
>>>> 09:42:28 2016
>>>>    read : io=95898MB, bw=583425KB/s, iops=145856, runt=168316msec
>>>>      slat (usec): min=0, max=13967, avg= 4.56, stdev=38.79
>>>>      clat (usec): min=15, max=1949.3K, avg=6941.73, stdev=16018.84
>>>>       lat (usec): min=225, max=1949.3K, avg=6946.30, stdev=16018.92
>>>>      clat percentiles (usec):
>>>>       |  1.00th=[  876],  5.00th=[ 2024], 10.00th=[ 2672], 20.00th=[
>>>> 3312],
>>>>       | 30.00th=[ 3824], 40.00th=[ 4320], 50.00th=[ 5024], 60.00th=[
>>>> 5920],
>>>>       | 70.00th=[ 7072], 80.00th=[ 8768], 90.00th=[11840],
>>>> 95.00th=[15040],
>>>>       | 99.00th=[22400], 99.50th=[27264], 99.90th=[248832],
>>>> 99.95th=[366592],
>>>>       | 99.99th=[602112]
>>>>
>>>>
>>>> I was getting > 600MB/s  before memory started swapping for me and the
>>>> fio output came down.
>>>> I never tested Bluestore read before, but, it is definitely lower than
>>>> Filestore for me.
>>>> But, it is far better than you are getting it seems (?). Do you mind
>>>> trying with the above ceph.conf option as well ?
>>>>
>>>> My ceph version :
>>>> ceph version 11.0.0-536-g8df0c5b
>>>> (8df0c5bcd90d80e9b309b2a9007b778f7b829edf)
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>>
>>>> PLEASE NOTE: The information contained in this electronic mail message
>>>> is intended only for the use of the designated recipient(s) named
>>>> above. If the reader of this message is not the intended recipient,
>>>> you are hereby notified that you have received this message in error
>>>> and that any review, dissemination, distribution, or copying of this
>>>> message is strictly prohibited. If you have received this
>>>> communication in error, please notify the sender by telephone or
>>>> e-mail (as shown above) immediately and destroy any and all copies of
>>>> this message in your possession (whether hard copies or electronically
>>>> stored copies).
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
