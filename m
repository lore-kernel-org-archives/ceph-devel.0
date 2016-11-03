From: Mark Nelson <mnelson@redhat.com>
Subject: Re: rocksdb optimization regression (bluestore perf regression)
Date: Thu, 3 Nov 2016 11:40:38 -0500
Message-ID: <6d41b47b-b666-7753-4f97-e73f432acda8@redhat.com>
References: <ea832d2a-96f4-7334-9d34-40d21740df6f@redhat.com>
 <25965474-3493-53f7-26f8-6d0686abe8f1@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757606AbcKCQkl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Nov 2016 12:40:41 -0400
In-Reply-To: <25965474-3493-53f7-26f8-6d0686abe8f1@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/03/2016 11:01 AM, Igor Fedotov wrote:
> Mark,
>
> thanks for update.
>
> I've Just made a brief try.
>
> Performance is much better now but numbers I can see with my old branch
> are still unreachable.
>
> Approx х2 times slower ( it was ~10х slower before) for random 4K r/w
> using FIO against standalone bluestore instance.

Can you check and see if https://github.com/ceph/ceph/pull/11530 is 
impacting you vs old defaults?  So far this appears to be a win on our 
NVMe setup, but it's one of the big changes that might impact small 
random write performance.

If this is impacting you, it would be really interesting to save one or 
more of the OSD logs in each case and run:

https://github.com/ceph/cbt/blob/master/tools/ceph_rocksdb_log_parser.py

Mark

>
>
> Thanks,
>
> Igor
>
>
> On 03.11.2016 17:59, Mark Nelson wrote:
>> Mostly this is for Igor and Somnath:
>>
>> It looks like the regression was indeed caused by lack of O2
>> optimization for rocksdb in master after 418bfd7.  The following PR
>> appears to resolve the performance regression in my tests:
>>
>> https://github.com/ceph/ceph/pull/11767
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
