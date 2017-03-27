From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: [GSoC] Queries regarding the Project
Date: Mon, 27 Mar 2017 18:55:12 +0530
Message-ID: <CAAXqJ+r-vcRmxOtJbwZDnv72M=q9+D-Wy2w2zeDXSk=TB2zYXA@mail.gmail.com>
References: <CAAXqJ+omQh-sSv06i0Wo50JEVzGsin7Zoe4zKYTW9q=Eu_QUUw@mail.gmail.com>
 <CAJE9aOMqs+KiNqq-HWp3rhahZc37664o9L0JymJANBKGOdVAwg@mail.gmail.com>
 <CAAXqJ+pou7Fk9r8hm9FQqQOy+bFnjzLVyUXPpOZxr++U3apqkg@mail.gmail.com> <CAJE9aOOxuhHXCveDY71tdB2RGkotx=Gm-=jDEdSDLcWQffN7Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35899 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdC0N0H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Mar 2017 09:26:07 -0400
Received: by mail-ot0-f169.google.com with SMTP id t8so25623281otf.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Mar 2017 06:25:42 -0700 (PDT)
In-Reply-To: <CAJE9aOOxuhHXCveDY71tdB2RGkotx=Gm-=jDEdSDLcWQffN7Rw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When CRUSH algorithm detects, that an object cannot be placed in a PG
that came through the draw, does CRUSH not draw another PG, until the
PG drawn can be written to?

On Mon, Mar 27, 2017 at 2:34 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Fri, Mar 24, 2017 at 8:08 PM, Spandan Kumar Sahu
> <spandankumarsahu@gmail.com> wrote:
>> I understand that, we can't write to objects which belong to the
>> particular PG (the one having at least one full OSD). But a storage
>> pool can have multiple PGs, and some of them must have only non-full
>> OSDs. Through those PGs, we can write to the OSDs which are not full.
>
> but we cannot impose the restriction on the client that only a subset
> of PGs of the given pool can be written.
>
>>
>> Did I understand it correctly?
>>
>>
>> On Fri, Mar 24, 2017 at 1:01 PM, kefu chai <tchaikov@gmail.com> wrote:
>>> Hi Spandan,
>>>
>>> Please do not email me privately, instead use the public mailing list,
>>> which allows other developers to provide you help if I am unable to do
>>> so. it also means that you can start interacting with the rest of the
>>> community instead of only me (barely useful).
>>>
>>> On Fri, Mar 24, 2017 at 2:38 PM, Spandan Kumar Sahu
>>> <spandankumarsahu@gmail.com> wrote:
>>>> Hi
>>>>
>>>> I couldn't figure out, why is this happening,
>>>>
>>>> "...Because once any of the storage device assigned to a storage pool is
>>>> full, the whole pool is not writeable anymore, even there is abundant space
>>>> in other devices."
>>>> -- Ceph GSoC Project Ideas (Smarter reweight-by-utilisation)
>>>>
>>>> I went through this[1] paper on CRUSH, and according to what I understand,
>>>> CRUSH pseudo-randomly chooses a device based on weights which can reflect
>>>> various parameters like the amount of space available.
>>>
>>> CRUSH is a variant of consistent hashing. Ceph cannot automatically
>>> choose *another* OSD which is not chosen by CRUSH, even if that OSD is
>>> not full and has abundant space.
>>>
>>>>
>>>> What I don't understand is, how will it stop a pool having abundant space on
>>>> other devices, from getting selected, if one of its devices is full? Sure,
>>>> the chances of getting selected might decrease, if one device is full, but
>>>> how does it completely prevent writing to the pool?
>>>
>>> if a PG are served by three OSDs. if any of them is full, how can we
>>> continue creating/writing to objects which belong to that PG?
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>
>>
>>
>> --
>> Spandan Kumar Sahu
>> IIT Kharagpur
>
>
>
> --
> Regards
> Kefu Chai



-- 
Spandan Kumar Sahu
IIT Kharagpur
