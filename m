From: Wade Holler <wade.holler@gmail.com>
Subject: Re: Dramatic performance drop at certain number of objects in pool
Date: Thu, 16 Jun 2016 10:47:17 -0400
Message-ID: <CA+e22Seqy-0rQTDt7PhYmYBsUrqqdWiN2QcyBt1RYz6QrBRtPg@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35921 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbcFPOrT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 10:47:19 -0400
Received: by mail-oi0-f41.google.com with SMTP id p204so72684294oih.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 07:47:19 -0700 (PDT)
In-Reply-To: <1450235390.2134.1466084299677@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Wido,

I am walking an Example OSD now and counting the files. 3096 PGs for this pool.
So far file counts inside the pool.pg_head directories are all coming
in around ~80k.

Is this an issue ?

I will report back with all pg_head file counts in this example OSD
once it finishes.

Best Regards,
Wade


On Thu, Jun 16, 2016 at 9:38 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 16 juni 2016 om 14:14 schreef Wade Holler <wade.holler@gmail.com>:
>>
>>
>> Hi All,
>>
>> I have a repeatable condition when the object count in a pool gets to
>> 320-330 million the object write time dramatically and almost
>> instantly increases as much as 10X, exhibited by fs_apply_latency
>> going from 10ms to 100s of ms.
>>
>
> My first guess is the filestore splitting and the amount of files per directory.
>
> You have 3*16=48 OSDs, is that correct? With roughly 100 PGs per OSD you have let's say 4800 PGs in total?
>
> That means you have ~66k objects per PG.
>
>> Can someone point me in a direction / have an explanation ?
>
> If you take a look at one of the OSDs, are there a huge amount of files in a single directory? Look inside the 'current' directory on that OSDs.
>
> Wido
>
>>
>> I can add a new pool and it performs normally.
>>
>> Config is generally
>> 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
>> with NVME for journals. Centos 7.2, XFS
>>
>> Jewell is the release; inserting objects with librados via some Python
>> test code.
>>
>> Best Regards
>> Wade
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
