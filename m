From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: Ceph Bluestore OSD CPU utilization
Date: Wed, 12 Jul 2017 10:29:08 -0500
Message-ID: <f367fa53-1d0c-3a81-0769-e0a46adb9cdb@gmail.com>
References: <694B98CBCEF42547AE4CD1A693225B5D085533EA@CNMAILEX04.lenovo.com>
 <5f6e1242-f0ec-62f2-9778-eb0a28406838@redhat.com>
 <6929185c-7c88-83ee-9e12-62db1cd23ec5@redhat.com>
 <694B98CBCEF42547AE4CD1A693225B5D085544B4@CNMAILEX04.lenovo.com>
 <e09c864a-fb65-a68a-4802-f8b4d29f88fc@gmail.com>
 <694B98CBCEF42547AE4CD1A693225B5D085546CF@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34083 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbdGLP3L (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 11:29:11 -0400
Received: by mail-it0-f67.google.com with SMTP id o202so2446718itc.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 08:29:10 -0700 (PDT)
In-Reply-To: <694B98CBCEF42547AE4CD1A693225B5D085546CF@CNMAILEX04.lenovo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junqin JQ7 Zhang <zhangjq7@lenovo.com>, Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Junqin

On 07/12/2017 05:21 AM, Junqin JQ7 Zhang wrote:
> Hi Mark,
>
> We also compared iostat of filestore and bluestore.
> Disk write rate of bluestore is only around 10% of filestore in same test case.
>
> Here is FileStore iostat during write
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>           13.06    0.00    9.84   11.52    0.00   65.58
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    0.00 8196.00     0.00 73588.00    17.96     0.52    0.06    0.00    0.06   0.04  31.90
> sdb               0.00     0.00    0.00 8298.00     0.00 75572.00    18.21     0.54    0.07    0.00    0.07   0.04  33.00
> sdh               0.00  4894.00    0.00  741.00     0.00 30504.00    82.33   207.60  314.51    0.00  314.51   1.35 100.10
> sdj               0.00  1282.00    0.00  938.00     0.00 15652.00    33.37    14.40   16.04    0.00   16.04   0.90  84.10
> sdk               0.00  5156.00    0.00  847.00     0.00 34560.00    81.61   199.04  283.83    0.00  283.83   1.18 100.10
> sdd               0.00  6889.00    0.00  729.00     0.00 38216.00   104.84   138.60  198.14    0.00  198.14   1.37 100.00
> sde               0.00  6909.00    0.00  763.00     0.00 38608.00   101.20   139.16  190.55    0.00  190.55   1.31 100.00
> sdf               0.00  3237.00    0.00  708.00     0.00 30548.00    86.29   175.15  310.36    0.00  310.36   1.41  99.80
> sdg               0.00  4875.00    0.00  745.00     0.00 32312.00    86.74   207.70  291.26    0.00  291.26   1.34 100.00
> sdi               0.00  7732.00    0.00  812.00     0.00 42136.00   103.78   140.94  181.96    0.00  181.96   1.23 100.00
>
> Here is BlueStore iostat during write
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            6.50    0.00    3.22    2.36    0.00   87.91
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    0.00 2938.00     0.00 25072.00    17.07     0.14    0.05    0.00    0.05   0.04  12.70
> sdb               0.00     0.00    0.00 2821.00     0.00 26112.00    18.51     0.15    0.05    0.00    0.05   0.05  12.90
> sdh               0.00     1.00    0.00  510.00     0.00  3600.00    14.12     5.45   10.68    0.00   10.68   0.24  12.00
> sdj               0.00     0.00    0.00  424.00     0.00  3072.00    14.49     4.24   10.00    0.00   10.00   0.22   9.30
> sdk               0.00     0.00    0.00  496.00     0.00  3584.00    14.45     4.10    8.26    0.00    8.26   0.18   9.10
> sdd               0.00     0.00    0.00  419.00     0.00  3080.00    14.70     3.60    8.60    0.00    8.60   0.19   7.80
> sde               0.00     0.00    0.00  650.00     0.00  3784.00    11.64    24.39   40.19    0.00   40.19   1.15  74.60
> sdf               0.00     0.00    0.00  494.00     0.00  3584.00    14.51     5.92   11.98    0.00   11.98   0.26  12.90
> sdg               0.00     0.00    0.00  493.00     0.00  3584.00    14.54     5.11   10.37    0.00   10.37   0.23  11.20
> sdi               0.00     0.00    0.00  744.00     0.00  4664.00    12.54   121.41  177.66    0.00  177.66   1.35 100.10
>
> sda and sdb are SSD, other are HDD.

earlier it looked like you were posting the configuration for an 8k 
randrw test, but this is a pure write test?  Can you provide the test 
configuration for these results?  Also, the SSD model would be useful to 
know.

Having said that, these results look pretty different than what I 
typically see in the lab.  A big clue is the avgrq-sz.  On filestore you 
are seeing much larger write requests than with bluestore.  That might 
indicate that metadata writes are going to the HDD.  Is this still with 
the 10GB DB partition?

Mark

>
> -----Original Message-----
> From: Junqin JQ7 Zhang
> Sent: Wednesday, July 12, 2017 10:45 AM
> To: 'Mark Nelson'; Mark Nelson; Ceph Development
> Subject: RE: Ceph Bluestore OSD CPU utilization
>
> Hi Mark,
>
> Actually, we tested filestore on same Ceph version v12.1.0 and same cluster.
> # ceph -v
> ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)
>
> CPU utilization of each OSD on filestore can reach max to around 200%, but CPU utilization of OSD on bluestore is only around 30%.
> Then, BlueStore's performance is only about 20% of filestore.
> We think there must be something wrong with our configuration.
>
> I tried to change ceph config, like
> osd op threads = 8
> osd disk threads = 4
>
> but still can't get a good result.
>
> Any idea of this?
>
> BTW. We changed some filestore related configured during test filestore fd cache size = 2048576000 filestore fd cache shards = 16 filestore async threads = 0 filestore max sync interval = 15 filestore wbthrottle enable = false filestore commit timeout = 1200 filestore_op_thread_suicide_timeout = 0 filestore queue max ops = 1048576 filestore queue max bytes = 17179869184 max open files = 262144 filestore fadvise = false filestore ondisk finisher threads = 4 filestore op threads = 8
>
> Thanks a lot!
>
> B.R.
> Junqin Zhang
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, July 11, 2017 11:47 PM
> To: Junqin JQ7 Zhang; Mark Nelson; Ceph Development
> Subject: Re: Ceph Bluestore OSD CPU utilization
>
>
>
> On 07/11/2017 10:31 AM, Junqin JQ7 Zhang wrote:
>> Hi Mark,
>>
>> Thanks for your reply.
>>
>> The hardware is as below for each 3 hosts.
>> 2 SATA SSD and 8 HDD
>
> The model of SSD potentially could be very important here.  The devices we test in our lab are enterprise grade SSDs with power loss protection.
>   That means they don't have to flush data on sync requests.  O_DSYNC writes are much faster as a result.  I don't know how bad of an impact this has on rocksdb wal/db, but it definitely hurts with filestore journals.
>
>> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
>> Network: 20000Mb/s
>>
>> I configured OSD like
>> [osd.0]
>> host = ceph-1
>> osd data = /var/lib/ceph/osd/ceph-0        # a 100M partition of SSD
>> bluestore block db path = /dev/sda5         # a 10G partition of SSD
>
> Bluestore automatically roles rocksdb data over to the HDD with the db gets full.  I bet with 10GB you'll see good performance at first and then you'll start seeing lots of extra reads/writes on the HDD once it fills up with metadata (the more extents that are written out the more likely you'll hit this boundary).  You'll want to make the db partitions use the majority of the SSD(s).
>
>> bluestore block wal path = /dev/sda6       # a 10G partition of SSD
>
> The WAL can be smaller.  1-2GB is enough (potentially even less if you adjust the rocksdb buffer settings, but 1-2GB should be small enough to devote most of your SSDs to DB storage).
>
>> bluestore block path = /dev/sdd                # a HDD disk
>>
>> We use fio to test one or more 100G RBDs, an example of our fio config
>> [global] ioengine=rbd clientname=admin pool=rbd rw=randrw bs=8k
>> runtime=120
>> iodepth=16
>> numjobs=4
>
> with the rbd engine I try to avoid numjobs as it can give erroneous results in some cases.  it's probably better generally to stick with multiple independent fio processes (though in this case for a randrw workload it might not matter).
>
>> direct=1
>> rwmixread=0
>> new_group
>> group_reporting
>> [rbd_image0]
>> rbdname=testimage_100GB_0
>>
>> Any suggestion?
>
> What kind of performance are you seeing and what do you expect to get?
>
> Mark
>
>> Thanks.
>>
>> B.R.
>> Junqin zhang
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Tuesday, July 11, 2017 7:32 PM
>> To: Junqin JQ7 Zhang; Ceph Development
>> Subject: Re: Ceph Bluestore OSD CPU utilization
>>
>> Ugh, small sequential *reads* I meant to say.  :)
>>
>> Mark
>>
>> On 07/11/2017 06:31 AM, Mark Nelson wrote:
>>> Hi Junqin,
>>>
>>> Can you tell us your hardware configuration (models and quantities of
>>> cpus, network cards, disks, ssds, etc) and the command and options
>>> you used to measure performance?
>>>
>>> In many cases bluestore is faster than filestore, but there are a
>>> couple of cases where it is notably slower, the big one being when
>>> doing small sequential writes without client-side readahead.
>>>
>>> Mark
>>>
>>> On 07/11/2017 05:34 AM, Junqin JQ7 Zhang wrote:
>>>> Hi,
>>>>
>>>> I installed Ceph luminous v12.1.0 in 3 nodes cluster with BlueStore
>>>> and did some fio test.
>>>> During test,  I found the each OSD CPU utilization rate was only
>>>> aroud 30%.
>>>> And the performance seems not good to me.
>>>> Is  there any configuration to help increase OSD CPU utilization to
>>>> improve performance?
>>>> Change kernel.pid_max? Any BlueStore specific configuration?
>>>>
>>>> Thanks a lot!
>>>>
>>>> B.R.
>>>> Junqin Zhang
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
