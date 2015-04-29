From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Wed, 29 Apr 2015 14:06:21 -0500
Message-ID: <55412BAD.8000400@redhat.com>
References: <554016E2.3000104@redhat.com>	<CAKKTCLX31EBc8oOs6tVVRu4c5prUYD=3G=8fK3pMvLQTM+1iSQ@mail.gmail.com>	<554020DC.6020009@redhat.com> <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com> <5540D7DA.2000503@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4AEC@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbbD2TG2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 15:06:28 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC021E4AEC@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, kernel neophyte <neophyte.hacker001@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

I just tried setting newstore_sync_wal_apply to false, but it seemed to 
make very little difference for me.  How much improvement were you 
seeing with it?

Mark

On 04/29/2015 10:55 AM, Chen, Xiaoxi wrote:
> Hi Mark,
>         You may miss this tunable:   newstore_sync_wal_apply, which is default to true, but would be better to make if false.
>         If sync_wal_apply is true, WAL apply will be don synchronize (in kv_sync_thread) instead of WAL thread. See
> 	if (g_conf->newstore_sync_wal_apply) {
> 	  _wal_apply(txc);
> 	} else {
> 	  wal_wq.queue(txc);
> 	}
>          Tweaking this to false helps a lot in my setup. All other looks good.
>
>           And, could you make WAL in a different partition but same SSD as DB? Then from IOSTAT -p , we can identify how much writes to DB and how much write to WAL. I am always seeing zero in my setup.
>
> 												Xiaoxi.
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Wednesday, April 29, 2015 9:09 PM
>> To: kernel neophyte
>> Cc: ceph-devel
>> Subject: Re: newstore performance update
>>
>> Hi,
>>
>> ceph.conf file attached.  It's a little ugly because I've been playing with
>> various parameters.  You'll probably want to enable debug newstore = 30 if
>> you plan to do any debugging.  Also, the code has been changing quickly so
>> performance may have changed if you haven't tested within the last week.
>>
>> Mark
>>
>> On 04/28/2015 09:59 PM, kernel neophyte wrote:
>>> Hi Mark,
>>>
>>> I am trying to measure 4k RW performance on Newstore, and I am not
>>> anywhere close to the numbers you are getting!
>>>
>>> Could you share your ceph.conf for these test ?
>>>
>>> -Neo
>>>
>>> On Tue, Apr 28, 2015 at 5:07 PM, Mark Nelson <mnelson@redhat.com>
>> wrote:
>>>> Nothing official, though roughly from memory:
>>>>
>>>> ~1.7GB/s and something crazy like 100K IOPS for the SSD.
>>>>
>>>> ~150MB/s and ~125-150 IOPS for the spinning disk.
>>>>
>>>> Mark
>>>>
>>>>
>>>> On 04/28/2015 07:00 PM, Venkateswara Rao Jujjuri wrote:
>>>>>
>>>>> Thanks for sharing; newstore numbers look lot better;
>>>>>
>>>>> Wondering if we have any base line numbers to put things into
>> perspective.
>>>>> like what is it on XFS or on librados?
>>>>>
>>>>> JV
>>>>>
>>>>> On Tue, Apr 28, 2015 at 4:25 PM, Mark Nelson <mnelson@redhat.com>
>> wrote:
>>>>>>
>>>>>> Hi Guys,
>>>>>>
>>>>>> Sage has been furiously working away at fixing bugs in newstore and
>>>>>> improving performance.  Specifically we've been focused on write
>>>>>> performance as newstore was lagging filestore but quite a bit
>>>>>> previously.  A lot of work has gone into implementing libaio behind
>>>>>> the scenes and as a result performance on spinning disks with SSD
>>>>>> WAL (and SSD backed rocksdb) has improved pretty dramatically. It's
>>>>>> now often beating filestore:
>>>>>>
>>>>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>>>>
>>>>>> On the other hand, sequential writes are slower than random writes
>>>>>> when the OSD, DB, and WAL are all on the same device be it a
>>>>>> spinning disk or SSD.
>>>>>> In this situation newstore does better with random writes and
>>>>>> sometimes beats filestore (such as in the everything-on-spinning
>>>>>> disk tests, and when IO sizes are small in the everything-on-ssd
>>>>>> tests).
>>>>>>
>>>>>> Newstore is changing daily so keep in mind that these results are
>>>>>> almost assuredly going to change.  An interesting area of
>>>>>> investigation will be why sequential writes are slower than random
>>>>>> writes, and whether or not we are being limited by rocksdb ingest
>>>>>> speed and how.
>>>>>>
>>>>>> I've also uploaded a quick perf call-graph I grabbed during the "all-SSD"
>>>>>> 32KB sequential write test to see if rocksdb was starving one of
>>>>>> the cores, but found something that looks quite a bit different:
>>>>>>
>>>>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>>>>
>>>>>> Mark
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
