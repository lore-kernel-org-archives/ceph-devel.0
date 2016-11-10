From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bluestore with rocksdb vs ZS
Date: Thu, 10 Nov 2016 03:26:26 +0300
Message-ID: <ead268ca-c8e0-c61c-3df0-519383b19284@mirantis.com>
References: <BY2PR02MB39674DF9B9B8848C6A17C8AF4B90@BY2PR02MB396.namprd02.prod.outlook.com>
 <fe4d4d36-693b-76b5-6cc2-a2b57a24173f@mirantis.com>
 <BY2PR02MB396475AD2EA210858957AD8F4B90@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33175 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbcKJA0a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 19:26:30 -0500
Received: by mail-lf0-f54.google.com with SMTP id c13so177156549lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2016 16:26:29 -0800 (PST)
In-Reply-To: <BY2PR02MB396475AD2EA210858957AD8F4B90@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Somnath,

thanks a lot for your update.

The numbers in your response are for non-ceph case, right?

And for "single osd - steady state" case you observed (as per slide 5) 
2K IOPS * 4K = 8Mb/s BW (and even less)? Comparing to 80Mb/s = 20K IOPS 
* 4K  your hardware can provide for 4K random write.

Is that correct or I missed something? Then if my calculations are 
correct I can easily explain why you're not getting steady state - one 
needs 4Tb / 8 Mb = 512K seconds to reach that state, i.e. the state when 
onodes are completely filled and not growing any more.

Again if I'm correct - could you please share your ceph config & fio job 
files (ones for slide 5 are enough for the first look) - probably you 
should tune bluestore onode cache and collection/cache shards counts. I 
experienced similar degradation due to bluestore misconfiguration.

And one more questions - againsе what ceph interface did you run FIO 
tests. Recently added ObjectStore one? Or RBD?


Thanks,

Igor



On 11/10/2016 2:39 AM, Somnath Roy wrote:
> Sure, it is running on SanDisk Infiniflash HW. Each Drive BW while test is running was ~400 MB/s and iops is ~20K , 100% 4K random write.
> In case of 16 OSD test, it was 16 drive Infiniflash JBOF with 2 hosts attached to it. The hosts were HW zoned to 8 drives each.
> The entire box BW is limited to max 12GB/s read/write, when it is fully populated i.e 64 drives . Since it is 16 drives , box will give 16 X 400 MB/s = ~6.4 GB/s.
> 100% Read iops for this 16 drive box is ~800K and 100% write iops is ~300K iops.
> Drives were having separate partition for Bluestore data/wal/db.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Wednesday, November 09, 2016 3:26 PM
> To: Somnath Roy; ceph-devel@vger.kernel.org
> Subject: Re: Bluestore with rocksdb vs ZS
>
> Hi Somnath,
>
> could you please describe the storage hardware used in your
> benchmarking: what drives, how are they organized, etc... What are the performance characteristics of the storage subsystem without Ceph?
>
> Thanks in advance,
>
> Igor
>
>
> On 11/10/2016 1:57 AM, Somnath Roy wrote:
>> Hi,
>> Here is the slide we presented in today's performance meeting.
>>
>> https://drive.google.com/file/d/0B7W-S0z_ymMJZXI3bkZLX3Z2U0E/view?usp=
>> sharing
>>
>> Feel free to come back if anybody has any query.
>>
>> Thanks & Regards
>> Somnath
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html

