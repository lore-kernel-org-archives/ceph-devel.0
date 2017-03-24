From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: [GSoC] Queries regarding the Project
Date: Fri, 24 Mar 2017 17:38:42 +0530
Message-ID: <CAAXqJ+pou7Fk9r8hm9FQqQOy+bFnjzLVyUXPpOZxr++U3apqkg@mail.gmail.com>
References: <CAAXqJ+omQh-sSv06i0Wo50JEVzGsin7Zoe4zKYTW9q=Eu_QUUw@mail.gmail.com>
 <CAJE9aOMqs+KiNqq-HWp3rhahZc37664o9L0JymJANBKGOdVAwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36395 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdCXMIn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Mar 2017 08:08:43 -0400
Received: by mail-oi0-f43.google.com with SMTP id r203so160928oib.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Mar 2017 05:08:42 -0700 (PDT)
In-Reply-To: <CAJE9aOMqs+KiNqq-HWp3rhahZc37664o9L0JymJANBKGOdVAwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I understand that, we can't write to objects which belong to the
particular PG (the one having at least one full OSD). But a storage
pool can have multiple PGs, and some of them must have only non-full
OSDs. Through those PGs, we can write to the OSDs which are not full.

Did I understand it correctly?


On Fri, Mar 24, 2017 at 1:01 PM, kefu chai <tchaikov@gmail.com> wrote:
> Hi Spandan,
>
> Please do not email me privately, instead use the public mailing list,
> which allows other developers to provide you help if I am unable to do
> so. it also means that you can start interacting with the rest of the
> community instead of only me (barely useful).
>
> On Fri, Mar 24, 2017 at 2:38 PM, Spandan Kumar Sahu
> <spandankumarsahu@gmail.com> wrote:
>> Hi
>>
>> I couldn't figure out, why is this happening,
>>
>> "...Because once any of the storage device assigned to a storage pool is
>> full, the whole pool is not writeable anymore, even there is abundant space
>> in other devices."
>> -- Ceph GSoC Project Ideas (Smarter reweight-by-utilisation)
>>
>> I went through this[1] paper on CRUSH, and according to what I understand,
>> CRUSH pseudo-randomly chooses a device based on weights which can reflect
>> various parameters like the amount of space available.
>
> CRUSH is a variant of consistent hashing. Ceph cannot automatically
> choose *another* OSD which is not chosen by CRUSH, even if that OSD is
> not full and has abundant space.
>
>>
>> What I don't understand is, how will it stop a pool having abundant space on
>> other devices, from getting selected, if one of its devices is full? Sure,
>> the chances of getting selected might decrease, if one device is full, but
>> how does it completely prevent writing to the pool?
>
> if a PG are served by three OSDs. if any of them is full, how can we
> continue creating/writing to objects which belong to that PG?
>
>
> --
> Regards
> Kefu Chai



-- 
Spandan Kumar Sahu
IIT Kharagpur
