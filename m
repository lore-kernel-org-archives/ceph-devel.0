From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: Ceph Bluestore OSD CPU utilization
Date: Tue, 11 Jul 2017 10:46:33 -0500
Message-ID: <e09c864a-fb65-a68a-4802-f8b4d29f88fc@gmail.com>
References: <694B98CBCEF42547AE4CD1A693225B5D085533EA@CNMAILEX04.lenovo.com>
 <5f6e1242-f0ec-62f2-9778-eb0a28406838@redhat.com>
 <6929185c-7c88-83ee-9e12-62db1cd23ec5@redhat.com>
 <694B98CBCEF42547AE4CD1A693225B5D085544B4@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35655 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933520AbdGKPqf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 11:46:35 -0400
Received: by mail-it0-f49.google.com with SMTP id v202so67204934itb.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 08:46:35 -0700 (PDT)
In-Reply-To: <694B98CBCEF42547AE4CD1A693225B5D085544B4@CNMAILEX04.lenovo.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junqin JQ7 Zhang <zhangjq7@lenovo.com>, Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 07/11/2017 10:31 AM, Junqin JQ7 Zhang wrote:
> Hi Mark,
> 
> Thanks for your reply.
> 
> The hardware is as below for each 3 hosts.
> 2 SATA SSD and 8 HDD

The model of SSD potentially could be very important here.  The devices 
we test in our lab are enterprise grade SSDs with power loss protection. 
  That means they don't have to flush data on sync requests.  O_DSYNC 
writes are much faster as a result.  I don't know how bad of an impact 
this has on rocksdb wal/db, but it definitely hurts with filestore journals.

> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
> Network: 20000Mb/s
> 
> I configured OSD like
> [osd.0]
> host = ceph-1
> osd data = /var/lib/ceph/osd/ceph-0        # a 100M partition of SSD
> bluestore block db path = /dev/sda5         # a 10G partition of SSD

Bluestore automatically roles rocksdb data over to the HDD with the db 
gets full.  I bet with 10GB you'll see good performance at first and 
then you'll start seeing lots of extra reads/writes on the HDD once it 
fills up with metadata (the more extents that are written out the more 
likely you'll hit this boundary).  You'll want to make the db partitions 
use the majority of the SSD(s).

> bluestore block wal path = /dev/sda6       # a 10G partition of SSD

The WAL can be smaller.  1-2GB is enough (potentially even less if you 
adjust the rocksdb buffer settings, but 1-2GB should be small enough to 
devote most of your SSDs to DB storage).

> bluestore block path = /dev/sdd                # a HDD disk
> 
> We use fio to test one or more 100G RBDs, an example of our fio config
> [global]
> ioengine=rbd
> clientname=admin
> pool=rbd
> rw=randrw
> bs=8k
> runtime=120
> iodepth=16
> numjobs=4

with the rbd engine I try to avoid numjobs as it can give erroneous 
results in some cases.  it's probably better generally to stick with 
multiple independent fio processes (though in this case for a randrw 
workload it might not matter).

> direct=1
> rwmixread=0
> new_group
> group_reporting
> [rbd_image0]
> rbdname=testimage_100GB_0
> 
> Any suggestion?

What kind of performance are you seeing and what do you expect to get?

Mark

> Thanks.
> 
> B.R.
> Junqin zhang
> 
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Tuesday, July 11, 2017 7:32 PM
> To: Junqin JQ7 Zhang; Ceph Development
> Subject: Re: Ceph Bluestore OSD CPU utilization
> 
> Ugh, small sequential *reads* I meant to say.  :)
> 
> Mark
> 
> On 07/11/2017 06:31 AM, Mark Nelson wrote:
>> Hi Junqin,
>>
>> Can you tell us your hardware configuration (models and quantities of
>> cpus, network cards, disks, ssds, etc) and the command and options you
>> used to measure performance?
>>
>> In many cases bluestore is faster than filestore, but there are a
>> couple of cases where it is notably slower, the big one being when
>> doing small sequential writes without client-side readahead.
>>
>> Mark
>>
>> On 07/11/2017 05:34 AM, Junqin JQ7 Zhang wrote:
>>> Hi,
>>>
>>> I installed Ceph luminous v12.1.0 in 3 nodes cluster with BlueStore
>>> and did some fio test.
>>> During test,  I found the each OSD CPU utilization rate was only
>>> aroud 30%.
>>> And the performance seems not good to me.
>>> Is  there any configuration to help increase OSD CPU utilization to
>>> improve performance?
>>> Change kernel.pid_max? Any BlueStore specific configuration?
>>>
>>> Thanks a lot!
>>>
>>> B.R.
>>> Junqin Zhang
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
