From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: ec overwrite issue
Date: Sat, 30 Sep 2017 08:19:08 +0800
Message-ID: <CANE=7sVXHsM40i5aWTgzErKRbUeL2AEOKDa0mkuih_3Uyaxq_Q@mail.gmail.com>
References: <CANE=7sUPY=qoJSpprXc5QHo+3eiUbK=Qjp9MAE7Oze33Kg-sQQ@mail.gmail.com>
 <CAJ4mKGZ0GX-FXKsVGTkdSJTUNr5J26=+EcYKRxxYuOWSM-TBXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:44236 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdI3ATJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2017 20:19:09 -0400
Received: by mail-pg0-f53.google.com with SMTP id j16so588223pga.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 17:19:09 -0700 (PDT)
In-Reply-To: <CAJ4mKGZ0GX-FXKsVGTkdSJTUNr5J26=+EcYKRxxYuOWSM-TBXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

such as transaction a would modify the object a < last_backfill, so
transaction_applied would be true. Before transaction a is completed,
the transaction b which modify the object b > last_backfill,
so transaction_applied would be false, the current logic would
roll_forward which including object a and b? is it right?


2017-09-30 2:27 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Fri, Sep 29, 2017 at 3:02 AM, Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@=
gmail.com> wrote:
>> hi, all
>>
>>     I confuse the roll_forward logic in the PG::append_log. The
>> pg_log.roll_forward func may roll forward the all inflight
>> transactions which maybe not be completed by all shards.
>>
>>     The comment also makes me wonder. so could anyone explain it in
>> detail. thanks.
>>
>>
>>   if (!transaction_applied) {
>>      /* We must be a backfill peer, so it's ok if we apply
>>       * out-of-turn since we won't be considered when
>>       * determining a min possible last_update.
>>       */
>>     pg_log.roll_forward(&handler);
>>   }
>>
>>     /* We don't want to leave the rollforward artifacts around
>>      * here past last_backfill.  It's ok for the same reason as
>>      * above */
>>     if (transaction_applied &&
>>        p->soid > info.last_backfill) {
>>       pg_log.roll_forward(&handler);
>>     }
>
> transaction_applied can only be false if we are being backfilled. If
> we are being backfilled, we may not *have* the older data that we
> would rollback to, and our peers don't rely on us having that data. So
> there's no point in our trying to keep rollback data around, and
> keeping it around would mean finding a way to clean it up later. Thus,
> delete it now.
> -Greg



--=20
Regards,
Xinze Chi
