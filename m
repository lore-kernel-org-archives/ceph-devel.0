From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: MonClient hunt interval
Date: Mon, 25 Jan 2016 07:20:16 -0800
Message-ID: <CAJ4mKGYeQ_zZUib-v8F9JH2cpfe-fpKLSTAeyL2+cVwj_kii5w@mail.gmail.com>
References: <CAOi1vP8PzDg6Hcf2Nck4_qXO1FHvJnqpE=uwF3jwp36FRLY6rQ@mail.gmail.com>
	<CAJ4mKGYs07FarHtvRHtZPXmY20KZCzFE2CVi3P2Gj7FQF5ESNQ@mail.gmail.com>
	<CAOi1vP8Q0oQSnG_OUbvcYZwy32o-EpCHzFFGc29cjDQe9O_5Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34491 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291AbcAYPUS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 10:20:18 -0500
Received: by mail-wm0-f45.google.com with SMTP id u188so70116186wmu.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 07:20:17 -0800 (PST)
In-Reply-To: <CAOi1vP8Q0oQSnG_OUbvcYZwy32o-EpCHzFFGc29cjDQe9O_5Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 25, 2016 at 7:03 AM, Ilya Dryomov <idryomov@gmail.com> wrot=
e:
> On Mon, Jan 25, 2016 at 3:45 PM, Gregory Farnum <gfarnum@redhat.com> =
wrote:
>> On Mon, Jan 25, 2016 at 5:14 AM, Ilya Dryomov <idryomov@gmail.com> w=
rote:
>>> Hi Greg,
>>>
>>> With 794c86fd289b ("monc: backoff the timeout period when
>>> reconnecting") you made it so that the backoff is applied to the hu=
nt
>>> interval.  When the session is established, the multiplier is reduc=
ed
>>> by 50% and that's it - I don't see any per-tick reduction or anythi=
ng
>>> like that.
>>>
>>> If a client had some bad luck and couldn't establish the session fo=
r
>>> a while (so that the multiplier went all the way up to 10), its ini=
tial
>>> timeout upon the next connection break is going to be 15 seconds no
>>> matter how much time has passed in the interim.  Was that your inte=
nt?
>>
>> I don't remember this, but looking at the sha I logged that behavior
>> in the commit message, so I'd have to say "yes". As it says, we're
>> trying to respond to monitor load; if they're doing so badly that we
>> had to increase our timeout when re-establishing a session, there's
>> every chance it will continue to be slow. If we reset the timeout ba=
ck
>> to default, we'd have to go through a lot more monitor-punishing
>> timeout rounds on the next failure than just cutting it in half woul=
d
>> take.
>
> The timeout could have been increased due to intermittent networking
> issues between the client and the monitor cluster.  The problem I see
> here is that once it's increased to 30s, it's effectively never
> decreased - since it's cut in half only once, that MonClient instance
> is stuck with 15s as its initial timeout forever.
>
> I'm not advocating resetting it back to default right away, it's just
> I expected to see some kind of slow backoff back to default.

Mmm, that might make sense. There's just also a limit to how much this
is worth worrying about =E2=80=94 longer timeouts are bad only in the p=
resence
of actually-dead monitors, and only when your connection to one of the
monitors dies. Any sort of gradual decay here would require more
complicated state and some mechanism for determining the monitors have
gotten happy now. Maybe you could feed it in based on response times
of other requests...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
