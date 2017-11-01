From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: some issue about peering progress
Date: Wed, 1 Nov 2017 13:26:59 -0700
Message-ID: <CAJ4mKGa8+5xa-FJb+XuTn3A3p5quYkmOQZixa11tYEW78nLQKQ@mail.gmail.com>
References: <CANE=7sWZ9sBTdqbNZ_UuUZ=K5UJDB=kZbrXh3u09dNaGeUzXRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:48605 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbdKAU1A (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 16:27:00 -0400
Received: by mail-io0-f169.google.com with SMTP id d66so8016388ioe.5
        for <ceph-devel@vger.kernel.org>; Wed, 01 Nov 2017 13:27:00 -0700 (PDT)
In-Reply-To: <CANE=7sWZ9sBTdqbNZ_UuUZ=K5UJDB=kZbrXh3u09dNaGeUzXRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Oct 27, 2017 at 12:46 AM Xinze Chi (信泽) <xmdxcxz@gmail.com> wrote:
>
> hi, all:
>
>      I confuse about the notify message during peering. Such as:
>
>     epoch 1, primary osd do Pering , GetInfo and GetMissing, it
> calling the func  proc_replica_log. in this func the last_complete and
> last_update maybe reset.
>
>     Before go to Activate. the OSDMap change (the new osdmap do not
> lead to restart peering), the non-primary osd send the notify to
> primary.


I don't think this can happen. The OSD won't re-send a notify during
the same peering interval, and even if it did the message would be
tagged with a new (higher) epoch so the PG wouldn't process it until
after it had switched states, right?

>
>
>     When the primary receive the notify, Primary::react(const
> MNotifyRec& notevt), so it call the func proc_replica_info.
>
>     In the func, we update the pg info including last_complete and
> last_update which modified in proc_replica_log.

Note also that "PG::RecoveryState::Active::react(const MNotifyRec&
notevt)" does *not* unconditionally invoke proc_replica_info(). I
think you were trying to say we hadn't reached this state on receipt
of the message? But as I mentioned above, I think we block so that's
not actually possible either.

>
>     When the primary call the func activate, the primary osd  process
> recovering based on pg info got by notify instead of proc_replica_log.
>
>     so it is a bug?

Have you seen issues in the wild, or just trying to understand this
code/algorithm? I would be surprised if we had undiscovered issues
here just because our tests exercise peering quite vigorously, but I
might be missing what's happening in my own code skims.
-Greg
