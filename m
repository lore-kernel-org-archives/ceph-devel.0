From: sridhar basam <sri@basam.org>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Thu, 9 Feb 2012 17:40:35 -0500
Message-ID: <CAGnVnB=beb2XMB55FfG7TgBeqa4gmb=O1S54=s+V6rANeoq3ug@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
	<4F29CDAA.408@sandia.gov>
	<CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
	<4F2AABF5.6050803@sandia.gov>
	<CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
	<4F2ADEAE.8010403@sandia.gov>
	<CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
	<4F2AF085.6000405@sandia.gov>
	<CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
	<4F2C08A7.2050507@sandia.gov>
	<3032884323297001561@unknownmsgid>
	<4F2C6EE6.4050008@sandia.gov>
	<CAC-hyiHSNv_VgLcyVCrJ66HxTGFNBONrmmBddJk5326dLTKgkw@mail.gmail.com>
	<4F2FFDD3.1010100@sandia.gov>
	<CAC-hyiEdAd++dQFBjPDutqipQcMXZqh4RdEEyA=v12vs6ueDxA@mail.gmail.com>
	<4F3019E9.80607@sandia.gov>
	<CAF3hT9CW7_CF4iT0cY858kgkke7Wu=TK7ULzPhFj-AW9jycyZA@mail.gmail.com>
	<4F343239.2010907@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37644 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab2BIWkg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2012 17:40:36 -0500
Received: by vbjk17 with SMTP id k17so1420215vbj.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2012 14:40:35 -0800 (PST)
In-Reply-To: <4F343239.2010907@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 9, 2012 at 3:53 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 02/06/2012 11:35 AM, Gregory Farnum wrote:
>>
>> On Mon, Feb 6, 2012 at 10:20 AM, Jim Schutt<jaschut@sandia.gov> =A0w=
rote:
>>>
>>> On 02/06/2012 10:22 AM, Yehuda Sadeh Weinraub wrote:
>>>>
>>>>
>>>> On Mon, Feb 6, 2012 at 8:20 AM, Jim Schutt<jaschut@sandia.gov> =A0=
 =A0wrote:
>>>
>>>
>>>
>>>>>
>>>>> The above suggests to me that the slowdown is a result
>>>>> of requests not getting submitted at the same rate as
>>>>> when things are running well.
>>>>>
>>>>
>>>> Yeah, it really looks like that. My suggestions wouldn't help ther=
e.
>>>>
>>>> I do see that when things go well the number of writes per device =
is
>>>> capped at ~200 writes per second and the throughput per device is
>>>> ~100MB/sec. Is 100MB/sec the expected device throughput?
>>>
>>>
>>>
>>> Pretty much, at least for the outer tracks on a drive. =A0I've seen
>>> ~108 MB/s with dd to a block device. =A0Also, I've got 8 drives per
>>> SAS adapter with 6 Gb/s links, so it seems unlikely to me that my
>>> disk subsystem is any sort of significant bottleneck.
>>
>>
>> Well, you might try changing your throttling settings on the OSDs.
>> ms_dispatch_throttle_bytes defaults to 100<<20 (100MB) and is used f=
or
>> throttling dispatch; osd_max_client_bytes defaults to 500<<20 (500MB=
)
>> and is used to limit the amount of client data in memory (ie; messag=
es
>> are included in this throttler for their entire lifetime, not just
>> while waiting for dispatch).
>>
>>
>
> I've made a little progress isolating this.
>
> "osd client message size cap =3D =A05000000" makes the stall
> completely reproducible (which also means I can reproduce
> on two different network types, ethernet and IPoIB.), and I
> am able to generate graphs of throttled/receive/process time
> for each request received by an OSD (see attached SVG plot).
>
> Such plots suggest to me my problem is caused by stalled
> receives. =A0Using debug ms =3D 30 on my OSDs turns up instances
> of this:
>
> osd.0.log:4514502:2012-02-08 12:34:39.258276 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader wants 4194432 from dispatch throttler 0/=
25000000
> osd.0.log:4514503:2012-02-08 12:34:39.258298 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader got front 128
> osd.0.log:4514504:2012-02-08 12:34:39.258325 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader allocating new rx buffer at offset 0
> osd.0.log:4514507:2012-02-08 12:34:39.258423 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader reading nonblocking into 0x1656c000 len =
4194304
> osd.0.log:4514509:2012-02-08 12:34:39.259060 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader read 1369231 of 4194304
> osd.0.log:4546819:2012-02-08 12:35:35.468156 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader reading nonblocking into 0x166ba48f len =
2825073
> osd.0.log:4546820:2012-02-08 12:35:35.468189 7f6acec77700 --
> 172.17.131.32:6800/15199 >> 172.17.135.85:0/2712733083 pipe(0x2ef0000=
 sd=3D173
> pgs=3D7 cs=3D1 l=3D1).reader read 1448 of 2825073
>
> which I take to mean that the reader thread sat in poll() for 56 secs=
, in
> this case.
>
> I was able to correlate such stalls with tcpdump output collected on
> clients. =A0Here's an example from another run:
>
> 15:09:37.584600 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23631561, win 65535, options [nop,nop,TS val 1096144 ecr 1100575], le=
ngth 0
> 15:09:37.584613 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23631561:23663417, ack 1218, win 20904, options [nop,nop,TS val 11006=
15 ecr
> 1096144], length 31856
> 15:09:37.584655 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23663417:23695273, ack 1218, win 20904, options [nop,nop,TS val 11006=
15 ecr
> 1096144], length 31856
> 15:09:37.624476 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23695273, win 65535, options [nop,nop,TS val 1096184 ecr 1100615], le=
ngth 0
> 15:09:37.624489 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23695273:23727129, ack 1218, win 20904, options [nop,nop,TS val 11006=
55 ecr
> 1096184], length 31856
> 15:09:37.624532 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [P.=
], seq
> 23727129:23758985, ack 1218, win 20904, options [nop,nop,TS val 11006=
55 ecr
> 1096184], length 31856
> 15:09:37.664454 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23758985, win 65535, options [nop,nop,TS val 1096224 ecr 1100655], le=
ngth 0
> 15:09:37.664468 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23758985:23790841, ack 1218, win 20904, options [nop,nop,TS val 11006=
95 ecr
> 1096224], length 31856
> 15:09:37.664506 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23790841:23822697, ack 1218, win 20904, options [nop,nop,TS val 11006=
95 ecr
> 1096224], length 31856
> 15:09:37.706937 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23822697, win 65535, options [nop,nop,TS val 1096266 ecr 1100695], le=
ngth 0
> 15:09:37.706950 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23854553, ack 1218, win 20904, options [nop,nop,TS val 11007=
38 ecr
> 1096266], length 31856
> 15:09:37.706995 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [P.=
], seq
> 23854553:23886409, ack 1218, win 20904, options [nop,nop,TS val 11007=
38 ecr
> 1096266], length 31856
> 15:09:37.929946 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11009=
61 ecr
> 1096266], length 1448
> 15:09:38.376961 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11014=
08 ecr
> 1096266], length 1448
> 15:09:39.270947 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11023=
02 ecr
> 1096266], length 1448
> 15:09:41.056943 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11040=
88 ecr
> 1096266], length 1448
> 15:09:44.632946 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11076=
64 ecr
> 1096266], length 1448
> 15:09:51.784947 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11148=
16 ecr
> 1096266], length 1448
> 15:10:06.088945 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11291=
20 ecr
> 1096266], length 1448
> 15:10:34.728951 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 11577=
60 ecr
> 1096266], length 1448
> 15:11:31.944946 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1096266], length 1448
> 15:11:31.945075 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23824145, win 65535, options [nop,nop,TS val 1210496 ecr 1214976], le=
ngth 0
> 15:11:31.945091 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23886409:23889305, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 2896
> 15:11:31.945178 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23824145, win 65535, options [nop,nop,TS val 1210496 ecr
> 1214976,nop,nop,sack 1 {23886409:23887857}], length 0
> 15:11:31.945199 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23824145:23825593, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945207 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23825593:23827041, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945214 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23827041:23828489, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
>
> So in this case the client retransmitted for ~2 minutes with no respo=
nse
> from
> the OSD. =A0Note that during this time the client was talking to othe=
r OSDs on
> the
> same server.
>
> I want to try turning off GSO/GRO on my interfaces, but then
> I think I need to post to netdev...
>
> -- Jim

The network trace output looks weird, it either means all of the
packets between 23822697:23886409 were lost or a bug in the networking
stack. The application should have no effect on the acks that should
have been generated. Even if you assume one or more of the frames on
the wire between 23822697:23886409 were somehow lost, you would have
had to see some sort of duplicate acks with sack segments.

Is this a bunch of bare metal servers or are these virtual? If you
could tap the network just upstream of the OSD servers, it would help
narrow down where to look at. You could also just turning off GRO/GSO,
as you suggest, to see if it makes a difference.

 Sridhar
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
