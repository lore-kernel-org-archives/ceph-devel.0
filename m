From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: ec overwrite issue
Date: Fri, 6 Oct 2017 20:58:14 +0800
Message-ID: <CANE=7sW3Mi5RQCTCsqyTpot3_DgG-gpXh1Fokss66KLCR2vRqA@mail.gmail.com>
References: <CANE=7sUPY=qoJSpprXc5QHo+3eiUbK=Qjp9MAE7Oze33Kg-sQQ@mail.gmail.com>
 <CAJ4mKGZ0GX-FXKsVGTkdSJTUNr5J26=+EcYKRxxYuOWSM-TBXA@mail.gmail.com>
 <CANE=7sVXHsM40i5aWTgzErKRbUeL2AEOKDa0mkuih_3Uyaxq_Q@mail.gmail.com>
 <CAJ4mKGbVTYUSMO2tQ8PQfrpXO6=eTHxK6Agn=C+dxU4XOvuk5A@mail.gmail.com>
 <CANE=7sVZj5SioT30AtW9OiatBcV51n5pnSE2EX1wdDFYDmQR6A@mail.gmail.com> <CAJ4mKGY6by1mPOwka0OF-YuOKbyzw9GosyK90zMLPW276Whc6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:54465 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbdJFM6Q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Oct 2017 08:58:16 -0400
Received: by mail-pf0-f176.google.com with SMTP id m28so4582472pfi.11
        for <ceph-devel@vger.kernel.org>; Fri, 06 Oct 2017 05:58:15 -0700 (PDT)
In-Reply-To: <CAJ4mKGY6by1mPOwka0OF-YuOKbyzw9GosyK90zMLPW276Whc6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I just wonder why we set backfill in ECSubWrite base on should_send_op func=
.:-)

2017-10-06 1:35 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> I...think so? Did you have a specific purpose in mind, though? I might
> have missed something when I was going through it. ;)
> -Greg
>
> On Thu, Oct 5, 2017 at 7:11 AM, Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@g=
mail.com> wrote:
>> so we could roll forward no matter object > last_backfill or <
>> last_backfill,  as long as it is backfill target?
>> If so, we could set backfill in ECSubWrite true if it is backfill target=
?
>>
>> 2017-10-05 2:11 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>>> On Fri, Sep 29, 2017 at 5:19 PM, Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcx=
z@gmail.com> wrote:
>>>> such as transaction a would modify the object a < last_backfill, so
>>>> transaction_applied would be true. Before transaction a is completed,
>>>> the transaction b which modify the object b > last_backfill,
>>>> so transaction_applied would be false, the current logic would
>>>> roll_forward which including object a and b? is it right?
>>>
>>> Yes, I believe that's the case. It's just that we don't care very much
>>> =E2=80=94 if we copied the data while backfilling, we know that our sou=
rce
>>> peer has the rollback state. Keep in mind that we only have rollback
>>> so that we can avoid the "RAID write hole" =E2=80=94 eg, if we manage t=
o write
>>> down an update on 4 nodes in a 5+3 erasure code, we can recover
>>> neither the old nor new data if it was written in-place. So we keep
>>> rollback data in that case and everybody goes back to the previous
>>> state.
>>>
>>> I *think* that if we manage to backfill an object for a particular
>>> shard, then we know that we can roll forward on it anyway or the read
>>> would have failed and the OSDs would have already rolled back. But I
>>> didn't check that. Certainly doing something other than this automatic
>>> roll forward would require a lot more bookkeeping that would make
>>> everything else going on more difficult.
>>> -Greg
>>>
>>>>
>>>>
>>>> 2017-09-30 2:27 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>>>>> On Fri, Sep 29, 2017 at 3:02 AM, Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdx=
cxz@gmail.com> wrote:
>>>>>> hi, all
>>>>>>
>>>>>>     I confuse the roll_forward logic in the PG::append_log. The
>>>>>> pg_log.roll_forward func may roll forward the all inflight
>>>>>> transactions which maybe not be completed by all shards.
>>>>>>
>>>>>>     The comment also makes me wonder. so could anyone explain it in
>>>>>> detail. thanks.
>>>>>>
>>>>>>
>>>>>>   if (!transaction_applied) {
>>>>>>      /* We must be a backfill peer, so it's ok if we apply
>>>>>>       * out-of-turn since we won't be considered when
>>>>>>       * determining a min possible last_update.
>>>>>>       */
>>>>>>     pg_log.roll_forward(&handler);
>>>>>>   }
>>>>>>
>>>>>>     /* We don't want to leave the rollforward artifacts around
>>>>>>      * here past last_backfill.  It's ok for the same reason as
>>>>>>      * above */
>>>>>>     if (transaction_applied &&
>>>>>>        p->soid > info.last_backfill) {
>>>>>>       pg_log.roll_forward(&handler);
>>>>>>     }
>>>>>
>>>>> transaction_applied can only be false if we are being backfilled. If
>>>>> we are being backfilled, we may not *have* the older data that we
>>>>> would rollback to, and our peers don't rely on us having that data. S=
o
>>>>> there's no point in our trying to keep rollback data around, and
>>>>> keeping it around would mean finding a way to clean it up later. Thus=
,
>>>>> delete it now.
>>>>> -Greg
>>>>
>>>>
>>>>
>>>> --
>>>> Regards,
>>>> Xinze Chi
>>
>>
>>
>> --
>> Regards,
>> Xinze Chi



--=20
Regards,
Xinze Chi
