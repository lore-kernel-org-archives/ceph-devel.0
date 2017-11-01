From: Ning Yao <zay11022@gmail.com>
Subject: Re: some issue about peering progress
Date: Thu, 2 Nov 2017 00:42:02 +0800
Message-ID: <CALZt5jzHVy3x28fV8ix8oEU1NRonUbs5G289z=FjUToT-vRUJQ@mail.gmail.com>
References: <CANE=7sWZ9sBTdqbNZ_UuUZ=K5UJDB=kZbrXh3u09dNaGeUzXRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:53020 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdKAQmD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 12:42:03 -0400
Received: by mail-io0-f175.google.com with SMTP id f20so7346445ioj.9
        for <ceph-devel@vger.kernel.org>; Wed, 01 Nov 2017 09:42:03 -0700 (PDT)
In-Reply-To: <CANE=7sWZ9sBTdqbNZ_UuUZ=K5UJDB=kZbrXh3u09dNaGeUzXRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can anyone take a look?

If anything will go wrong when divergent occurs and peer_info is reset
in Primary::react(const
MNotifyRec& notevt)?

@Sage  do you think so?
Regards
Ning Yao


2017-10-27 15:45 GMT+08:00 Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@gmail.co=
m>:
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
>
>     When the primary receive the notify, Primary::react(const
> MNotifyRec& notevt), so it call the func proc_replica_info.
>
>     In the func, we update the pg info including last_complete and
> last_update which modified in proc_replica_log.
>
>     When the primary call the func activate, the primary osd  process
> recovering based on pg info got by notify instead of proc_replica_log.
>
>     so it is a bug?
>
> --
> Regards,
> Xinze Chi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
