From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 23:00:55 +0100
Message-ID: <50C8FE97.4020302@profihost.ag>
References: <50C8F7AC.9070600@profihost.ag> <CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com> <50C8F939.6080400@profihost.ag> <CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com> <50C8FA80.7060808@profihost.ag> <CAPYLRzifpCB77z=YjbcxAPJ2TRF-NfH+MzgCbnGhFxrBLLs17Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52859 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2LLWA4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 17:00:56 -0500
In-Reply-To: <CAPYLRzifpCB77z=YjbcxAPJ2TRF-NfH+MzgCbnGhFxrBLLs17Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: John Wilkins <john.wilkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

thanks for explanation. I'm using current next branch.

I'm using:
host1:
osd 11 .. 14
host2:
osd 21 .. 24
host3:
osd 31 .. 34
host4:
osd 41 .. 44
host5:
osd 51 .. 54

Right now i want to add host6. But i still don't know even with your=20
explanation how to add osd 61-64 to osdmap.

Greets Stefan
Am 12.12.2012 22:57, schrieb Gregory Farnum:
> On Wed, Dec 12, 2012 at 1:43 PM, Stefan Priebe <s.priebe@profihost.ag=
> wrote:
>> Hi Greg,
>>
>> i don't get it. I was using this doc:
>> http://ceph.com/docs/master/rados/operations/add-or-rm-osds/
>>
>> There is written that i have to use the osd-num for ceph osd create.=
 Which
>> UUID is now meant?
>
> Ah, you're right =97 I don't think that doc has been correct since
> before argonaut, but prior to ~v0.55 it wouldn't complain on non-UUID
> values.
>
> The basic "ceph osd create" call simply allocates a new OSD ID and
> bumps the max allowed, and returns the new ID back to the caller. If
> you also specify the UUID, then it will check and see if that UUID
> already exists and simply return the allocated ID if it does
> (otherwise, create a new one as before). In argonaut, there's a bug
> that will silently ignore any non-UUID extra arguments, which is what
> was happening with those IDs.
>
> John, can you fix this in the docs please? :)
> -Greg
>
> (All this is assuming I've got my commit dates right; if not there
> might be a bit of variation about when which version took effect.)
>
>
>> I've already added osd.61,62,63 and 64 to ceph.conf
>>
>> Greets,
>> Stefan
>> Am 12.12.2012 22:41, schrieb Gregory Farnum:
>>>
>>> Yeah; 61 is not a valid UUID and you can't specify anything else on=
 that
>>> line.
>>>
>>> On Wed, Dec 12, 2012 at 1:38 PM, Stefan Priebe <s.priebe@profihost.=
ag>
>>> wrote:
>>>>
>>>> HI Greg,
>>>>
>>>> sorry just a copy & paste error.
>>>>
>>>> [cloud1-ceph1: ~]# ceph osd create 61
>>>> (22) Invalid argument
>>>>
>>>>
>>>>> Read those two lines again. Very slowly. :)
>>>>>
>>>>> The correct syntax is
>>>>> ceph osd create <uuid>
>>>>>
>>>>> The uuid is optional, but you don't specify IDs; it gives you an =
ID
>>>>> back.
>>>>
>>>>
>>>>
>>>> Stefan
>>>
>>> --
>>>
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
