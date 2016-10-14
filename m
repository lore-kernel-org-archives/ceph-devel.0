From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Possible corruption with MSSQL on RBD
Date: Fri, 14 Oct 2016 14:58:06 +0200
Message-ID: <7f91cd62-987d-6fa4-ea2f-f3bfa26c15e7@profihost.ag>
References: <262972897.5995.1476280634060@ox.pcextreme.nl>
 <CAJ4mKGZx+PgcqAPVB0LSFxp1z=aZiKWt-H1hjnKJU5_hxAoxWg@mail.gmail.com>
 <439702971.6004.1476287822395@ox.pcextreme.nl>
 <2126451990.6086.1476439471715@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:41303 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753207AbcJNNEX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Oct 2016 09:04:23 -0400
In-Reply-To: <2126451990.6086.1476439471715@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

Am 14.10.2016 um 12:04 schrieb Wido den Hollander:
> 
>> Op 12 oktober 2016 om 17:57 schreef Wido den Hollander <wido@42on.com>:
>>
>>
>>
>>> Op 12 oktober 2016 om 17:01 schreef Gregory Farnum <gfarnum@redhat.com>:
>>>
>>>
>>> On Wed, Oct 12, 2016 at 7:57 AM, Wido den Hollander <wido@42on.com> wrote:
>>>> Hi,
>>>>
>>>> I filed a issue in the tracker, but I'm looking for some feedback to diagnose this a bit further: http://tracker.ceph.com/issues/17545
>>>>
>>>> The situation is that with a Firefly or Hammer (haven't tested Jewel yet) a MSSQL server running on RBD will sometimes complain about corruption.
>>>>
>>>> Using SQLioSim we can reproduce the issue on a small Proxmox + Ceph cluster and after an hour or so it will yield:
>>>>
>>>> Expected FileId: 0x0
>>>> Received FileId: 0x0
>>>> Expected PageId: 0xCB19C
>>>> Received PageId: 0xCB19A (does not match expected)
>>>> Received CheckSum: 0x9F444071
>>>> Calculated CheckSum: 0x89603EC9 (does not match expected)
>>>> Received Buffer Length: 0x2000
>>>>
>>>> The issue only seems to happen with RBD caching enabled. When disabling the RBD cache or using cache=directsync we were not able to reproduce the issue.
>>>>
>>>> When using LVM/file based backends for Qemu the problem also didn't pop up.
>>>>
>>>> So this seems to be either a librbd issue or the RBD driver inside Qemu.
>>>>
>>>> Any hints on how to debug this further to find the root cause?
>>>
>>> If you've got control over the clients, try building with commit
>>> 9ec6e7f608608088d51e449c9d375844631dcdde backported to them (I believe
>>> it's also in the latest Hammer release, but maybe there hasn't been
>>> one cut since the backport?); tracked at
>>> http://tracker.ceph.com/issues/16002 but of course the web site is
>>> dead so you can't look at that right now. :(
>>
>> I verified, but 9ec6e7 is not in v0.94.9, but it is in the Jewel release.
>>
>> Tests are running with Jewel now and I will probably have the results tomorrow. If Jewel doesn't break the commit you send might indeed resolve it.
>>

i've seen several reports in the last month about missing backport even
they were marked as to be backported. Is there a generall problem with that?

Greets,
Stefan

> 
> The tests have been running for over 24 hours and all still looks good. We will let it run for over the weekend to make sure it has been fixed.
> 
> Wido
> 
>> Wido
>>
>>> -Greg
>>>
>>>>
>>>> Wido
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
