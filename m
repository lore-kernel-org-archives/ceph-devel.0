From: kefu chai <tchaikov@gmail.com>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Fri, 9 Dec 2016 16:59:40 +0800
Message-ID: <CAJE9aONPZGj0ZXZRMiVnzW3RYGoOi8K5bW1caxa5vy=FJQV-ig@mail.gmail.com>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl> <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
 <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl> <CAJ4mKGa+wydRuMtvCYiOe823v9UkN2Qk0FkViqHhLAPmGeFoGA@mail.gmail.com>
 <89a9ee77-21db-e955-7bb3-c4adc3bb94bf@digiware.nl> <CAJ4mKGboUvhJhf1=bUD=unSAc4Z+1nQPmYXRFb=CfmA-Wk6GEQ@mail.gmail.com>
 <e467d1f1-8a29-1a32-b113-0d71e00d5ec5@digiware.nl> <CAJE9aOO5N4w=EZer310DYa9+rnszwR-afTx7M_dRjOtyS78pWw@mail.gmail.com>
 <ced59373-1ebf-554e-a383-bfe266067a22@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33348 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbcLII7m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2016 03:59:42 -0500
Received: by mail-qk0-f182.google.com with SMTP id x190so11308589qkb.0
        for <ceph-devel@vger.kernel.org>; Fri, 09 Dec 2016 00:59:42 -0800 (PST)
In-Reply-To: <ced59373-1ebf-554e-a383-bfe266067a22@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 8, 2016 at 8:30 PM, Willem Jan Withagen <wjw@digiware.nl> wrote=
:
> On 8-12-2016 11:03, kefu chai wrote:
>> On Tue, Oct 4, 2016 at 7:57 PM, Willem Jan Withagen <wjw@digiware.nl> wr=
ote:
>>> On 3-10-2016 19:50, Gregory Farnum wrote:
>>>>> Question here is:
>>>>>   If I ask 'ceph osd dump', I'm actually asking ceph-mon.
>>>>>   And cehp-mon has learned this from (crush?)maps being sent to it by
>>>>>   ceph-osd.
>>>>
>>>> The monitor has learned about specific IP addresses/nonces/etc via
>>>> MOSDBoot messages from the OSDs. The crush locations are set via
>>>> monitor command messages, generally invoked as part of the init
>>>> scripts. Maps are generated entirely on the monitor. :)
>>>>
>>>>> Is there an easy way to debug/monitor the content of what ceph-osd se=
nds
>>>>> and ceph-mon receives in the maps?
>>>>> Just to make sure that it is clear where the problem occurs.
>>>>
>>>> You should be able to see the info going in and out by bumping the
>>>> debug levels up =E2=80=94 every message's "print" function is invoked =
when
>>>> it's sent/received as long as you have "debug ms =3D 1". It looks like
>>>> the MOSDBoot message doesn't natively dump its addresses but you can
>>>> add them easily if you need to.
>>>
>>> Hi Greg,
>>>
>>> Thanx for the answer....
>>>
>>> I've got debug_ms already pumped up all the way to 20.
>>> So I do get to see what addresses are selected during bind. But still
>>> they do not end up at the MON, and 'ceph osd dump' reports:
>>>         :/0
>>> as bind address.
>>>
>>> I'm going to add some more debugs to actually see what MOSDBoot is doin=
g....
>>
>> there are multiple messengers used by ceph-osd, the one connected by
>> rados client is the external/public messenger. it is also used by osd
>> to talk with the monitor.
>>
>> the nonce of the external address of an OSD does not change after it's
>> up: it's always the pid of ceph-osd process. and the (peer) address of
>> the booting OSD collected by monitor comes from the connection's
>> peer_addr field, which is set when the monitor accepts the connection
>> from OSD. see STATE_ACCEPTING_WAIT_BANNER_ADDR case block in
>> AsyncConnection::_process_connection().
>>
>> but there are chances that an OSD is restarted and fail to bind its
>> external messenger to the specified the port. in that case, ceph-osd
>> will try with another port, but keep the nonce the same. but when it
>> comes to other messengers used by ceph-osd, their nonces increase by
>> 1000000 every time they rebind. that's why "ceph osd thrash" can
>> change the nonces of the cluster_addr, heartbeat_back_addr and
>> heartbeat_front_addr. the PR of
>> https://github.com/ceph/ceph/pull/11706 actually changes the behavior
>> of the messengers of these three messengers. and it has nothing to do
>> with the external messenger to which the ceph cli client is
>> connecting.
>>
>> so you might want to check
>> 1) how/why the nonce of the messenger in MonClient is 1000000 + $pid
>> 2) while the nonce of the same messenger is $pid when the ceph cli
>> connects to it.
>>
>> my PR of https://github.com/ceph/ceph/pull/11804 is more of a cleanup.
>> it avoids setting the nonce before the rebind finishes. and i tried
>> with your producer on my linux box, no luck =3D(
>
> Right,
>
> You gave me a lot of things to think about, and to start figuring out.
>
> And you are right that something really bad needs to happen to an OSD to
> get in this state. But that is what the tests actually do: They just
> down/up or kill OSDs and restart.
>
> And from previous discussions I "learned" that if the process doesn't
> die but needs to rebind on the port, the OSD stays at the same port but
> increments the nonce to indicate that it is a fresh connection. And log

the external messenger should *not* increment its nonce.

> printing actually shows that the code is going thru a rebind.

and it should *not* go through rebind().

>
> Now the bad thing is that the Linux and FreeBSD log do comparable things
> with my (small) change to the setting of addr. And the nonce is indeed
> incremented, which increment is actually picked up by all ceph components=
.
>
> But if I keep the old code, the nonces are running out of sync.
> Your patch doesn't hurt, but it also doesn't help: I still get
> mismatched nonces.

yeah, that's expected.

>
> But like I started: lots of things again to consider.
>
> --WjW
>
>



--=20
Regards
Kefu Chai
