From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ec overwrite issue
Date: Fri, 29 Sep 2017 11:27:04 -0700
Message-ID: <CAJ4mKGZ0GX-FXKsVGTkdSJTUNr5J26=+EcYKRxxYuOWSM-TBXA@mail.gmail.com>
References: <CANE=7sUPY=qoJSpprXc5QHo+3eiUbK=Qjp9MAE7Oze33Kg-sQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:45994 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdI2S1G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2017 14:27:06 -0400
Received: by mail-it0-f48.google.com with SMTP id x15so798752itb.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 11:27:06 -0700 (PDT)
In-Reply-To: <CANE=7sUPY=qoJSpprXc5QHo+3eiUbK=Qjp9MAE7Oze33Kg-sQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 29, 2017 at 3:02 AM, Xinze Chi (信泽) <xmdxcxz@gmail.com> wrote:
> hi, all
>
>     I confuse the roll_forward logic in the PG::append_log. The
> pg_log.roll_forward func may roll forward the all inflight
> transactions which maybe not be completed by all shards.
>
>     The comment also makes me wonder. so could anyone explain it in
> detail. thanks.
>
>
>   if (!transaction_applied) {
>      /* We must be a backfill peer, so it's ok if we apply
>       * out-of-turn since we won't be considered when
>       * determining a min possible last_update.
>       */
>     pg_log.roll_forward(&handler);
>   }
>
>     /* We don't want to leave the rollforward artifacts around
>      * here past last_backfill.  It's ok for the same reason as
>      * above */
>     if (transaction_applied &&
>        p->soid > info.last_backfill) {
>       pg_log.roll_forward(&handler);
>     }

transaction_applied can only be false if we are being backfilled. If
we are being backfilled, we may not *have* the older data that we
would rollback to, and our peers don't rely on us having that data. So
there's no point in our trying to keep rollback data around, and
keeping it around would mean finding a way to clean it up later. Thus,
delete it now.
-Greg
