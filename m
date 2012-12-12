From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 13:57:57 -0800
Message-ID: <CAPYLRzifpCB77z=YjbcxAPJ2TRF-NfH+MzgCbnGhFxrBLLs17Q@mail.gmail.com>
References: <50C8F7AC.9070600@profihost.ag>
	<CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com>
	<50C8F939.6080400@profihost.ag>
	<CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com>
	<50C8FA80.7060808@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45158 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab2LLV55 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:57:57 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so2784901iea.24
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 13:57:57 -0800 (PST)
In-Reply-To: <50C8FA80.7060808@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, John Wilkins <john.wilkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 12, 2012 at 1:43 PM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
> Hi Greg,
>
> i don't get it. I was using this doc:
> http://ceph.com/docs/master/rados/operations/add-or-rm-osds/
>
> There is written that i have to use the osd-num for ceph osd create. =
Which
> UUID is now meant?

Ah, you're right =97 I don't think that doc has been correct since
before argonaut, but prior to ~v0.55 it wouldn't complain on non-UUID
values.

The basic "ceph osd create" call simply allocates a new OSD ID and
bumps the max allowed, and returns the new ID back to the caller. If
you also specify the UUID, then it will check and see if that UUID
already exists and simply return the allocated ID if it does
(otherwise, create a new one as before). In argonaut, there's a bug
that will silently ignore any non-UUID extra arguments, which is what
was happening with those IDs.

John, can you fix this in the docs please? :)
-Greg

(All this is assuming I've got my commit dates right; if not there
might be a bit of variation about when which version took effect.)


> I've already added osd.61,62,63 and 64 to ceph.conf
>
> Greets,
> Stefan
> Am 12.12.2012 22:41, schrieb Gregory Farnum:
>>
>> Yeah; 61 is not a valid UUID and you can't specify anything else on =
that
>> line.
>>
>> On Wed, Dec 12, 2012 at 1:38 PM, Stefan Priebe <s.priebe@profihost.a=
g>
>> wrote:
>>>
>>> HI Greg,
>>>
>>> sorry just a copy & paste error.
>>>
>>> [cloud1-ceph1: ~]# ceph osd create 61
>>> (22) Invalid argument
>>>
>>>
>>>> Read those two lines again. Very slowly. :)
>>>>
>>>> The correct syntax is
>>>> ceph osd create <uuid>
>>>>
>>>> The uuid is optional, but you don't specify IDs; it gives you an I=
D
>>>> back.
>>>
>>>
>>>
>>> Stefan
>>
>> --
>>
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
