From: Mark Nelson <mnelson@redhat.com>
Subject: Re: async messenger random read performance on NVMe
Date: Wed, 21 Sep 2016 14:41:27 -0500
Message-ID: <08bad1a0-e12d-825e-489d-9b44400cb57f@redhat.com>
References: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
 <CY1PR02MB21236DC2DEDA1C4577FED95BF4F60@CY1PR02MB2123.namprd02.prod.outlook.com>
 <61672ba0-fadc-2f25-dcf2-090129bd1c53@redhat.com>
 <CY1PR02MB2123F1C1AC9EC34A04ED3017F4F60@CY1PR02MB2123.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933900AbcIUTla (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 15:41:30 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7288CC056819
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 19:41:29 +0000 (UTC)
Received: from [10.3.112.71] (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8LJfR4q017145
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 15:41:28 -0400
In-Reply-To: <CY1PR02MB2123F1C1AC9EC34A04ED3017F4F60@CY1PR02MB2123.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

FWIW, in these tests I have 4 NVMe cards split into 4 OSDs each, so your 
setup with 32 OSDs on SSD probably has more raw randread throughput 
potential than mine does.

Mark

On 09/21/2016 02:27 PM, Somnath Roy wrote:
> We have the following data from our lab which is all SSD setup and since yours is with NvMe , the result should be much superior than ours unless you are cpu saturated at the OSD hosts.
>
> Setup :
> -------
> 3 pools, 1024 PGs/pool
> One 2TB rbd image per pool , 3 physical clients running single fio/client with very high QD/jobs.
> 16 OSDs each with 4TB.
> Two OSD hosts with 48 cpu cores each.
> Replication : 2
>
> Result :
> -------
>
> 4K RR ~*374K IOPs*. With simple.
>
> I think we are using 25 shards per OSD and 2 threads/shard.
> If you are not cpu saturated, try with increased shards and it should give you better 4K RR results. We need to see aync is able to give similar throughput at that level or not.
> I will also try measuring if I am able to squeeze some time out of my BlueStore activities :-)
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Wednesday, September 21, 2016 12:11 PM
> To: Somnath Roy; ceph-devel
> Subject: Re: async messenger random read performance on NVMe
>
> Yes to multiple physical clients (2 fio processes per client using librbd with io depth = 32 each).  No to increased OSD shards, this is just default.  Can you explain a bit more why Simple should go faster with a similar config?  Did you mean async?  I'm going to try to dig in with perf and see how they compare.  I wish I had a better way to profile lock contention rather than poorman's profiling via gdb.  I suppose lttng is the answer.
>
> Mark
>
> On 09/21/2016 02:02 PM, Somnath Roy wrote:
>> Mark,
>> Are you trying with multiple physical clients and with increased OSD shards?
>> Simple should go way more with the similar config for 4K RR based on the result we were getting earlier unless your cpu is getting saturated at the OSD nodes.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Wednesday, September 21, 2016 11:50 AM
>> To: ceph-devel
>> Subject: async messenger random read performance on NVMe
>>
>> Recently in master we made async messenger default.  After doing a bunch of bisection, it turns out that this caused a fairly dramatic decrease in bluestore random read performance.  This is on a cluster with fairly fast NVMe cards, 16 OSDs across 4 OSD hosts.  There are 8 fio client processes with 32 concurrent threads each.
>>
>> Ceph master using bluestore
>>
>> Parameters tweaked:
>>
>> ms_async_send_inline
>> ms_async_op_threads
>> ms_async_max_op_threads
>>
>> simple: 168K IOPS
>>
>> send_inline: true
>> async 3/5   threads: 111K IOPS
>> async 4/8   threads: 125K IOPS
>> async 8/16  threads: 128K IOPS
>> async 16/32 threads: 128K IOPS
>> async 24/48 threads: 128K IOPS
>> async 25/50 threads: segfault
>> async 26/52 threads: segfault
>> async 32/64 threads: segfault
>>
>> send_inline: false
>> async 3/5   threads: 153K IOPS
>> async 4/8   threads: 153K IOPS
>> async 8/16  threads: 152K IOPS
>>
>> So definitely setting send_inline to false helps pretty dramatically, though we're still a little slower for small random reads than simple messenger.  Haomai, regarding the segfaults, I took a quick look with gdb at the core file but didn't see anything immediately obvious.  It might be worth seeing if you can reproduce.
>>
>> On the performance front, I'll try to see if I can see anything obvious in perf.
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!tml=
>
