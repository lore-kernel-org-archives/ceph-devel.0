From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: some issue about peering progress
Date: Thu, 2 Nov 2017 11:35:15 +0800
Message-ID: <CANE=7sVop6coM0oTppBxK=CWH5B1XQQ9AHpd-MpAoxrb-Q1gFQ@mail.gmail.com>
References: <CANE=7sWZ9sBTdqbNZ_UuUZ=K5UJDB=kZbrXh3u09dNaGeUzXRQ@mail.gmail.com>
 <CAJ4mKGa8+5xa-FJb+XuTn3A3p5quYkmOQZixa11tYEW78nLQKQ@mail.gmail.com>
 <CANE=7sXWMXTpTfgG6NmwxYYyjYA2_UZ3oNun4eAw+QNiht2nkg@mail.gmail.com> <CAJ4mKGaFP+5vePBNzm0fk3pqONirfCyGhrGynZ4BTD3AwfNMuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:52414 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934099AbdKBDfQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 23:35:16 -0400
Received: by mail-pg0-f45.google.com with SMTP id a192so3882118pge.9
        for <ceph-devel@vger.kernel.org>; Wed, 01 Nov 2017 20:35:16 -0700 (PDT)
In-Reply-To: <CAJ4mKGaFP+5vePBNzm0fk3pqONirfCyGhrGynZ4BTD3AwfNMuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The Stray set send_notify false only if go to activate?

2017-11-02 10:27 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Wed, Nov 1, 2017 at 5:27 PM Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@gm=
ail.com> wrote:
>>
>> 2017-11-02 4:26 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>> > On Fri, Oct 27, 2017 at 12:46 AM Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxc=
xz@gmail.com> wrote:
>> >>
>> >> hi, all:
>> >>
>> >>      I confuse about the notify message during peering. Such as:
>> >>
>> >>     epoch 1, primary osd do Pering , GetInfo and GetMissing, it
>> >> calling the func  proc_replica_log. in this func the last_complete an=
d
>> >> last_update maybe reset.
>> >>
>> >>     Before go to Activate. the OSDMap change (the new osdmap do not
>> >> lead to restart peering), the non-primary osd send the notify to
>> >> primary.
>> >
>> >
>> > I don't think this can happen. The OSD won't re-send a notify during
>> > the same peering interval, and even if it did the message would be
>> > tagged with a new (higher) epoch so the PG wouldn't process it until
>> > after it had switched states, right?
>> >
>>
>>    I just want to understand this algorithm. When the Stray osd received=
 ActMap
>>
>> it would send_notity even if during the same peering interval. see
>> Stray::react(const ActMap&).
>
> Note the
>
> if (pg->should_send_notify()
>
> check preceding that block. It checks a boolean send_notify value that
> is set true only when it enters a new peering interval, and is set
> false as soon as it shares its info. So I don't think the primary's
> behavior matters at all (other than from a security perspective,
> anyway).
>
>
>>   You say the priamry osd wouldn't process the notify msg, I do not
>> find out the code. The primary
>>
>> call handle_pg_notify and process it.
>
> I didn't actually track the order of the state machine here; I just
> saw that PG::RecoveryState::Active::react(const MNotifyRec& notevt)
> will throw them out if it's already seen the info. You're right
> PG::RecoveryState::Primary::react(const MNotifyRec& notevt) will
> process it unconditionally. I'm not sure if those are the replica and
> primary states, or if you move from Primary to Active (or vice versa).
> -Greg
>
>>
>>
>> >>
>> >>
>> >>     When the primary receive the notify, Primary::react(const
>> >> MNotifyRec& notevt), so it call the func proc_replica_info.
>> >>
>> >>     In the func, we update the pg info including last_complete and
>> >> last_update which modified in proc_replica_log.
>> >
>> > Note also that "PG::RecoveryState::Active::react(const MNotifyRec&
>> > notevt)" does *not* unconditionally invoke proc_replica_info(). I
>> > think you were trying to say we hadn't reached this state on receipt
>> > of the message? But as I mentioned above, I think we block so that's
>> > not actually possible either.
>> >
>> >>
>> >>     When the primary call the func activate, the primary osd  process
>> >> recovering based on pg info got by notify instead of proc_replica_log=
.
>> >>
>> >>     so it is a bug?
>> >
>> > Have you seen issues in the wild, or just trying to understand this
>> > code/algorithm? I would be surprised if we had undiscovered issues
>> > here just because our tests exercise peering quite vigorously, but I
>> > might be missing what's happening in my own code skims.
>> > -Greg
>>
>>
>>
>> --
>> Regards,
>> Xinze Chi



--=20
Regards,
Xinze Chi
