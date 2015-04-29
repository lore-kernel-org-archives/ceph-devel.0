From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: newstore performance update
Date: Tue, 28 Apr 2015 19:59:55 -0700
Message-ID: <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com>
References: <554016E2.3000104@redhat.com>
	<CAKKTCLX31EBc8oOs6tVVRu4c5prUYD=3G=8fK3pMvLQTM+1iSQ@mail.gmail.com>
	<554020DC.6020009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36519 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031345AbbD2C74 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Apr 2015 22:59:56 -0400
Received: by pdea3 with SMTP id a3so14531334pde.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 19:59:55 -0700 (PDT)
In-Reply-To: <554020DC.6020009@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

I am trying to measure 4k RW performance on Newstore, and I am not
anywhere close to the numbers you are getting!

Could you share your ceph.conf for these test ?

-Neo

On Tue, Apr 28, 2015 at 5:07 PM, Mark Nelson <mnelson@redhat.com> wrote:
> Nothing official, though roughly from memory:
>
> ~1.7GB/s and something crazy like 100K IOPS for the SSD.
>
> ~150MB/s and ~125-150 IOPS for the spinning disk.
>
> Mark
>
>
> On 04/28/2015 07:00 PM, Venkateswara Rao Jujjuri wrote:
>>
>> Thanks for sharing; newstore numbers look lot better;
>>
>> Wondering if we have any base line numbers to put things into perspective.
>> like what is it on XFS or on librados?
>>
>> JV
>>
>> On Tue, Apr 28, 2015 at 4:25 PM, Mark Nelson <mnelson@redhat.com> wrote:
>>>
>>> Hi Guys,
>>>
>>> Sage has been furiously working away at fixing bugs in newstore and
>>> improving performance.  Specifically we've been focused on write
>>> performance
>>> as newstore was lagging filestore but quite a bit previously.  A lot of
>>> work
>>> has gone into implementing libaio behind the scenes and as a result
>>> performance on spinning disks with SSD WAL (and SSD backed rocksdb) has
>>> improved pretty dramatically. It's now often beating filestore:
>>>
>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>
>>> On the other hand, sequential writes are slower than random writes when
>>> the
>>> OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
>>> In this situation newstore does better with random writes and sometimes
>>> beats filestore (such as in the everything-on-spinning disk tests, and
>>> when
>>> IO sizes are small in the everything-on-ssd tests).
>>>
>>> Newstore is changing daily so keep in mind that these results are almost
>>> assuredly going to change.  An interesting area of investigation will be
>>> why
>>> sequential writes are slower than random writes, and whether or not we
>>> are
>>> being limited by rocksdb ingest speed and how.
>>>
>>> I've also uploaded a quick perf call-graph I grabbed during the "all-SSD"
>>> 32KB sequential write test to see if rocksdb was starving one of the
>>> cores,
>>> but found something that looks quite a bit different:
>>>
>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>
>>> Mark
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
