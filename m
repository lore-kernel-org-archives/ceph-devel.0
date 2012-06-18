From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph performance on Ubuntu Oneiric vs Ubuntu Precise
Date: Mon, 18 Jun 2012 13:07:53 -0500
Message-ID: <4FDF6E79.6080203@inktank.com>
References: <4FDF6BB8.4080401@inktank.com> <CAPYLRzgM=_1CpXB3Kr+=RFdaC3KPiVHGQyRurmTZJ=Zopsx=QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51379 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2FRSIB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 14:08:01 -0400
Received: by yhmm54 with SMTP id m54so4074382yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 11:08:00 -0700 (PDT)
In-Reply-To: <CAPYLRzgM=_1CpXB3Kr+=RFdaC3KPiVHGQyRurmTZJ=Zopsx=QA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

Yep, 3 monitors each on their own node.

Mark

On 06/18/2012 01:04 PM, Gregory Farnum wrote:
> Do I correctly assume that these nodes hosted only the OSDs, and the
> monitors were on a separate node?
>
> On Mon, Jun 18, 2012 at 10:56 AM, Mark Nelson<mark.nelson@inktank.com>  wrote:
>> Hi Guys,
>>
>> I've been tracking down some performance issues over the past month with our
>> internal test nodes and believe I have narrowed it down to something related
>> to Ubuntu Oneiric.  Tests done on nodes running Ubuntu Precise are
>> significantly faster.
>>
>> One of the major differences between the releases is the support for syncfs
>> in libc.  Theoretically this shouldn't have a big effect on btrfs so I'm not
>> totally sure that this is the culprit.  Having said that, previous tests
>> showed good SSD performance on Oneiric leading me to believe the lower
>> latency mitigates the effect.  Some of spinning disk seekwatcher results for
>> Oneiric are quite strange with long periods of inactivity on the OSD data
>> disks.
>>
>> I wanted to post these results for those of you who have had performance
>> problems in the past.  If you are continuing to have issues, you may want to
>> try testing on precise and see if you notice any changes.  It is possible
>> that all of this could be specific to our internal testing nodes, so I
>> wouldn't mind hearing if other people have seen similar behavior.
>>
>> These tests were done using rados bench with 16 concurrent requests. There
>> are two nodes that each have a single 7200rpm OSD data disk and journal on a
>> second 7200rpm disk.  Replication is set at the default level (2).  Kernel
>> is 3.4 in all cases.
>>
>> Here's a run down (Numbers are MB/s)
>>
>> 4KB Requests
>>
>>                         BTRFS   EXT4    XFS
>> Ceph 0.46/Oneiric:      0.073   0.694   0.723
>> Ceph 0.46/Precise:      2.15    2.031   1.546
>> Ceph 0.47.2/Oneiric:    1.072   0.836   0.749
>> Ceph 0.47.2/Precise:    2.566   2.579   1.498
>>
>> 128KB Requests:
>>
>>                         BTRFS   EXT4    XFS
>> Ceph 0.46/Oneiric:      11.874  20.066  12.641
>> Ceph 0.46/Precise:      49.304  39.736  38.982
>> Ceph 0.47.2/Oneiric:    13.81   19.05   12.739
>> Ceph 0.47.2/Precise:    47.943  49.655  36.764
>>
>>
>> 4MB Requests:
>>
>>                         BTRFS   EXT4    XFS
>> Ceph 0.46/Oneiric:      110.202 26.58   15.445
>> Ceph 0.46/Precise:      135.975 128.759 106.426
>> Ceph 0.47.2/Oneiric:    91.337  46.277  23.897
>> Ceph 0.47.2/Precise:    136.906 134.955 106.545
>>
>> I've posted seekwatcher results for all of the tests:
>>
>> Ceph 0.46/Oneiric:      http://nhm.ceph.com/movies/sprint/test2
>> Ceph 0.46/Precise:      http://nhm.ceph.com/movies/sprint/test3
>> Ceph 0.47.2/Oneiric:    http://nhm.ceph.com/movies/sprint/test4
>> Ceph 0.47.2/Precise:    http://nhm.ceph.com/movies/sprint/test5
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

