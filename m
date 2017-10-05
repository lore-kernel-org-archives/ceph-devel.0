From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ec overwrite issue
Date: Thu, 5 Oct 2017 10:35:39 -0700
Message-ID: <CAJ4mKGY6by1mPOwka0OF-YuOKbyzw9GosyK90zMLPW276Whc6Q@mail.gmail.com>
References: <CANE=7sUPY=qoJSpprXc5QHo+3eiUbK=Qjp9MAE7Oze33Kg-sQQ@mail.gmail.com>
 <CAJ4mKGZ0GX-FXKsVGTkdSJTUNr5J26=+EcYKRxxYuOWSM-TBXA@mail.gmail.com>
 <CANE=7sVXHsM40i5aWTgzErKRbUeL2AEOKDa0mkuih_3Uyaxq_Q@mail.gmail.com>
 <CAJ4mKGbVTYUSMO2tQ8PQfrpXO6=eTHxK6Agn=C+dxU4XOvuk5A@mail.gmail.com> <CANE=7sVZj5SioT30AtW9OiatBcV51n5pnSE2EX1wdDFYDmQR6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:52384 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdJERfk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Oct 2017 13:35:40 -0400
Received: by mail-io0-f180.google.com with SMTP id i197so14034347ioe.9
        for <ceph-devel@vger.kernel.org>; Thu, 05 Oct 2017 10:35:40 -0700 (PDT)
In-Reply-To: <CANE=7sVZj5SioT30AtW9OiatBcV51n5pnSE2EX1wdDFYDmQR6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I...think so? Did you have a specific purpose in mind, though? I might
have missed something when I was going through it. ;)
-Greg

On Thu, Oct 5, 2017 at 7:11 AM, Xinze Chi (信泽) <xmdxcxz@gmail.com> wrote:
> so we could roll forward no matter object > last_backfill or <
> last_backfill,  as long as it is backfill target?
> If so, we could set backfill in ECSubWrite true if it is backfill target?
>
> 2017-10-05 2:11 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>> On Fri, Sep 29, 2017 at 5:19 PM, Xinze Chi (信泽) <xmdxcxz@gmail.com> wrote:
>>> such as transaction a would modify the object a < last_backfill, so
>>> transaction_applied would be true. Before transaction a is completed,
>>> the transaction b which modify the object b > last_backfill,
>>> so transaction_applied would be false, the current logic would
>>> roll_forward which including object a and b? is it right?
>>
>> Yes, I believe that's the case. It's just that we don't care very much
>> — if we copied the data while backfilling, we know that our source
>> peer has the rollback state. Keep in mind that we only have rollback
>> so that we can avoid the "RAID write hole" — eg, if we manage to write
>> down an update on 4 nodes in a 5+3 erasure code, we can recover
>> neither the old nor new data if it was written in-place. So we keep
>> rollback data in that case and everybody goes back to the previous
>> state.
>>
>> I *think* that if we manage to backfill an object for a particular
>> shard, then we know that we can roll forward on it anyway or the read
>> would have failed and the OSDs would have already rolled back. But I
>> didn't check that. Certainly doing something other than this automatic
>> roll forward would require a lot more bookkeeping that would make
>> everything else going on more difficult.
>> -Greg
>>
>>>
>>>
>>> 2017-09-30 2:27 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>>>> On Fri, Sep 29, 2017 at 3:02 AM, Xinze Chi (信泽) <xmdxcxz@gmail.com> wrote:
>>>>> hi, all
>>>>>
>>>>>     I confuse the roll_forward logic in the PG::append_log. The
>>>>> pg_log.roll_forward func may roll forward the all inflight
>>>>> transactions which maybe not be completed by all shards.
>>>>>
>>>>>     The comment also makes me wonder. so could anyone explain it in
>>>>> detail. thanks.
>>>>>
>>>>>
>>>>>   if (!transaction_applied) {
>>>>>      /* We must be a backfill peer, so it's ok if we apply
>>>>>       * out-of-turn since we won't be considered when
>>>>>       * determining a min possible last_update.
>>>>>       */
>>>>>     pg_log.roll_forward(&handler);
>>>>>   }
>>>>>
>>>>>     /* We don't want to leave the rollforward artifacts around
>>>>>      * here past last_backfill.  It's ok for the same reason as
>>>>>      * above */
>>>>>     if (transaction_applied &&
>>>>>        p->soid > info.last_backfill) {
>>>>>       pg_log.roll_forward(&handler);
>>>>>     }
>>>>
>>>> transaction_applied can only be false if we are being backfilled. If
>>>> we are being backfilled, we may not *have* the older data that we
>>>> would rollback to, and our peers don't rely on us having that data. So
>>>> there's no point in our trying to keep rollback data around, and
>>>> keeping it around would mean finding a way to clean it up later. Thus,
>>>> delete it now.
>>>> -Greg
>>>
>>>
>>>
>>> --
>>> Regards,
>>> Xinze Chi
>
>
>
> --
> Regards,
> Xinze Chi
