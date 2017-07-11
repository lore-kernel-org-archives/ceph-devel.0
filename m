From: Junqin JQ7 Zhang <zhangjq7@lenovo.com>
Subject: RE: Ceph Bluestore OSD CPU utilization
Date: Tue, 11 Jul 2017 15:31:39 +0000
Message-ID: <694B98CBCEF42547AE4CD1A693225B5D085544B4@CNMAILEX04.lenovo.com>
References: <694B98CBCEF42547AE4CD1A693225B5D085533EA@CNMAILEX04.lenovo.com>
 <5f6e1242-f0ec-62f2-9778-eb0a28406838@redhat.com>
 <6929185c-7c88-83ee-9e12-62db1cd23ec5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.8]:14012 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932598AbdGKPbr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Jul 2017 11:31:47 -0400
In-Reply-To: <6929185c-7c88-83ee-9e12-62db1cd23ec5@redhat.com>
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Mark,

Thanks for your reply.

The hardware is as below for each 3 hosts.
2 SATA SSD and 8 HDD
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
Network: 20000Mb/s

I configured OSD like
[osd.0]
host = ceph-1
osd data = /var/lib/ceph/osd/ceph-0        # a 100M partition of SSD
bluestore block db path = /dev/sda5         # a 10G partition of SSD
bluestore block wal path = /dev/sda6       # a 10G partition of SSD
bluestore block path = /dev/sdd                # a HDD disk

We use fio to test one or more 100G RBDs, an example of our fio config
[global]
ioengine=rbd
clientname=admin
pool=rbd
rw=randrw
bs=8k
runtime=120
iodepth=16
numjobs=4
direct=1
rwmixread=0
new_group
group_reporting
[rbd_image0]
rbdname=testimage_100GB_0

Any suggestion?
Thanks.

B.R.
Junqin zhang

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com] 
Sent: Tuesday, July 11, 2017 7:32 PM
To: Junqin JQ7 Zhang; Ceph Development
Subject: Re: Ceph Bluestore OSD CPU utilization

Ugh, small sequential *reads* I meant to say.  :)

Mark

On 07/11/2017 06:31 AM, Mark Nelson wrote:
> Hi Junqin,
>
> Can you tell us your hardware configuration (models and quantities of 
> cpus, network cards, disks, ssds, etc) and the command and options you 
> used to measure performance?
>
> In many cases bluestore is faster than filestore, but there are a 
> couple of cases where it is notably slower, the big one being when 
> doing small sequential writes without client-side readahead.
>
> Mark
>
> On 07/11/2017 05:34 AM, Junqin JQ7 Zhang wrote:
>> Hi,
>>
>> I installed Ceph luminous v12.1.0 in 3 nodes cluster with BlueStore 
>> and did some fio test.
>> During test,  I found the each OSD CPU utilization rate was only 
>> aroud 30%.
>> And the performance seems not good to me.
>> Is  there any configuration to help increase OSD CPU utilization to 
>> improve performance?
>> Change kernel.pid_max? Any BlueStore specific configuration?
>>
>> Thanks a lot!
>>
>> B.R.
>> Junqin Zhang
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
