From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: rocksdb optimization regression (bluestore perf regression)
Date: Thu, 3 Nov 2016 23:15:09 +0300
Message-ID: <087d9a02-d4ed-869e-0d81-6b7116268499@mirantis.com>
References: <ea832d2a-96f4-7334-9d34-40d21740df6f@redhat.com>
 <25965474-3493-53f7-26f8-6d0686abe8f1@mirantis.com>
 <6d41b47b-b666-7753-4f97-e73f432acda8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36832 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbcKCUPO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 16:15:14 -0400
Received: by mail-lf0-f43.google.com with SMTP id t196so48741023lff.3
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 13:15:13 -0700 (PDT)
In-Reply-To: <6d41b47b-b666-7753-4f97-e73f432acda8@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Mark.

No, this patch isn't the root cause for performance drop.

I don`t see much benefit from it in my scenario but it definitely brings 
no degradation.

Thanks,

Igor


On 11/3/2016 7:40 PM, Mark Nelson wrote:
> On 11/03/2016 11:01 AM, Igor Fedotov wrote:
>> Mark,
>>
>> thanks for update.
>>
>> I've Just made a brief try.
>>
>> Performance is much better now but numbers I can see with my old branch
>> are still unreachable.
>>
>> Approx х2 times slower ( it was ~10х slower before) for random 4K r/w
>> using FIO against standalone bluestore instance.
>
> Can you check and see if https://github.com/ceph/ceph/pull/11530 is 
> impacting you vs old defaults?  So far this appears to be a win on our 
> NVMe setup, but it's one of the big changes that might impact small 
> random write performance.
>
> If this is impacting you, it would be really interesting to save one 
> or more of the OSD logs in each case and run:
>
> https://github.com/ceph/cbt/blob/master/tools/ceph_rocksdb_log_parser.py
>
> Mark
>
>>
>>
>> Thanks,
>>
>> Igor
>>
>>
>> On 03.11.2016 17:59, Mark Nelson wrote:
>>> Mostly this is for Igor and Somnath:
>>>
>>> It looks like the regression was indeed caused by lack of O2
>>> optimization for rocksdb in master after 418bfd7.  The following PR
>>> appears to resolve the performance regression in my tests:
>>>
>>> https://github.com/ceph/ceph/pull/11767
>>>
>>> Mark
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>

