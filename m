From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: MonClient hunt interval
Date: Mon, 25 Jan 2016 16:29:39 +0100
Message-ID: <CAOi1vP9DLiCijB9cJUdC-emC3FfbNvG+ToAExHCMgTpnw1sH9g@mail.gmail.com>
References: <CAOi1vP8PzDg6Hcf2Nck4_qXO1FHvJnqpE=uwF3jwp36FRLY6rQ@mail.gmail.com>
	<CAJ4mKGYs07FarHtvRHtZPXmY20KZCzFE2CVi3P2Gj7FQF5ESNQ@mail.gmail.com>
	<CAOi1vP8Q0oQSnG_OUbvcYZwy32o-EpCHzFFGc29cjDQe9O_5Jw@mail.gmail.com>
	<CAJ4mKGYeQ_zZUib-v8F9JH2cpfe-fpKLSTAeyL2+cVwj_kii5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35061 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291AbcAYP3k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 10:29:40 -0500
Received: by mail-wm0-f52.google.com with SMTP id r129so68794814wmr.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 07:29:40 -0800 (PST)
In-Reply-To: <CAJ4mKGYeQ_zZUib-v8F9JH2cpfe-fpKLSTAeyL2+cVwj_kii5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 25, 2016 at 4:20 PM, Gregory Farnum <gfarnum@redhat.com> wr=
ote:
> On Mon, Jan 25, 2016 at 7:03 AM, Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>> On Mon, Jan 25, 2016 at 3:45 PM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
>>> On Mon, Jan 25, 2016 at 5:14 AM, Ilya Dryomov <idryomov@gmail.com> =
wrote:
>>>> Hi Greg,
>>>>
>>>> With 794c86fd289b ("monc: backoff the timeout period when
>>>> reconnecting") you made it so that the backoff is applied to the h=
unt
>>>> interval.  When the session is established, the multiplier is redu=
ced
>>>> by 50% and that's it - I don't see any per-tick reduction or anyth=
ing
>>>> like that.
>>>>
>>>> If a client had some bad luck and couldn't establish the session f=
or
>>>> a while (so that the multiplier went all the way up to 10), its in=
itial
>>>> timeout upon the next connection break is going to be 15 seconds n=
o
>>>> matter how much time has passed in the interim.  Was that your int=
ent?
>>>
>>> I don't remember this, but looking at the sha I logged that behavio=
r
>>> in the commit message, so I'd have to say "yes". As it says, we're
>>> trying to respond to monitor load; if they're doing so badly that w=
e
>>> had to increase our timeout when re-establishing a session, there's
>>> every chance it will continue to be slow. If we reset the timeout b=
ack
>>> to default, we'd have to go through a lot more monitor-punishing
>>> timeout rounds on the next failure than just cutting it in half wou=
ld
>>> take.
>>
>> The timeout could have been increased due to intermittent networking
>> issues between the client and the monitor cluster.  The problem I se=
e
>> here is that once it's increased to 30s, it's effectively never
>> decreased - since it's cut in half only once, that MonClient instanc=
e
>> is stuck with 15s as its initial timeout forever.
>>
>> I'm not advocating resetting it back to default right away, it's jus=
t
>> I expected to see some kind of slow backoff back to default.
>
> Mmm, that might make sense. There's just also a limit to how much thi=
s
> is worth worrying about =E2=80=94 longer timeouts are bad only in the=
 presence
> of actually-dead monitors, and only when your connection to one of th=
e
> monitors dies. Any sort of gradual decay here would require more
> complicated state and some mechanism for determining the monitors hav=
e
> gotten happy now. Maybe you could feed it in based on response times
> of other requests...

Well, a *really* slow decay might not need to check for whether the
monitors are happy or not and so won't require any additional state.
Anyway, I'm not super worried about this either - I'm bringing it into
the kernel client and just wanted to make sure it behaves as intended
before I merge it in.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
