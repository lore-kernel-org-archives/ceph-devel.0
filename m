From: sridhar basam <sri@basam.org>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Thu, 9 Feb 2012 20:26:06 -0500
Message-ID: <CAGnVnBm1hyXfk4Wnb57j3EYTwUwjSDYtHg_zPQ86B8vorgJ4Cw@mail.gmail.com>
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
	<CAGnVnB=beb2XMB55FfG7TgBeqa4gmb=O1S54=s+V6rANeoq3ug@mail.gmail.com>
	<4F3453A7.9000408@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64011 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab2BJB0H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2012 20:26:07 -0500
Received: by vcge1 with SMTP id e1so1514585vcg.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2012 17:26:06 -0800 (PST)
In-Reply-To: <4F3453A7.9000408@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 9, 2012 at 6:15 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 02/09/2012 03:40 PM, sridhar basam wrote:
>>
>> On Thu, Feb 9, 2012 at 3:53 PM, Jim Schutt<jaschut@sandia.gov> =A0wr=
ote:
>>>
>>> On 02/06/2012 11:35 AM, Gregory Farnum wrote:
>>>>
>>>>
>>>> On Mon, Feb 6, 2012 at 10:20 AM, Jim Schutt<jaschut@sandia.gov>
>>>> =A0wrote:
>>>>>
>>>>>
>>>>> On 02/06/2012 10:22 AM, Yehuda Sadeh Weinraub wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Mon, Feb 6, 2012 at 8:20 AM, Jim Schutt<jaschut@sandia.gov>
>>>>>> =A0wrote:
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> The above suggests to me that the slowdown is a result
>>>>>>> of requests not getting submitted at the same rate as
>>>>>>> when things are running well.
>>>>>>>
>>>>>>
>>>>>> Yeah, it really looks like that. My suggestions wouldn't help th=
ere.
>>>>>>
>>>>>> I do see that when things go well the number of writes per devic=
e is
>>>>>> capped at ~200 writes per second and the throughput per device i=
s
>>>>>> ~100MB/sec. Is 100MB/sec the expected device throughput?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Pretty much, at least for the outer tracks on a drive. =A0I've se=
en
>>>>> ~108 MB/s with dd to a block device. =A0Also, I've got 8 drives p=
er
>>>>> SAS adapter with 6 Gb/s links, so it seems unlikely to me that my
>>>>> disk subsystem is any sort of significant bottleneck.
>>>>
>>>>
>>>>
>>>> Well, you might try changing your throttling settings on the OSDs.
>>>> ms_dispatch_throttle_bytes defaults to 100<<20 (100MB) and is used=
 for
>>>> throttling dispatch; osd_max_client_bytes defaults to 500<<20 (500=
MB)
>>>> and is used to limit the amount of client data in memory (ie; mess=
ages
>>>> are included in this throttler for their entire lifetime, not just
>>>> while waiting for dispatch).
>>>>
>>>>
>>>
>>> I've made a little progress isolating this.
>>>
>>> "osd client message size cap =3D =A05000000" makes the stall
>>> completely reproducible (which also means I can reproduce
>>> on two different network types, ethernet and IPoIB.), and I
>>> am able to generate graphs of throttled/receive/process time
>>> for each request received by an OSD (see attached SVG plot).
>>>
>>> Such plots suggest to me my problem is caused by stalled
>>> receives. =A0Using debug ms =3D 30 on my OSDs turns up instances
>>> of this:
>>>
>>> osd.0.log:4514502:2012-02-08 12:34:39.258276 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader wants 4194432 from dispatch throttler =
0/25000000
>>> osd.0.log:4514503:2012-02-08 12:34:39.258298 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader got front 128
>>> osd.0.log:4514504:2012-02-08 12:34:39.258325 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader allocating new rx buffer at offset 0
>>> osd.0.log:4514507:2012-02-08 12:34:39.258423 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader reading nonblocking into 0x1656c000 le=
n 4194304
>>> osd.0.log:4514509:2012-02-08 12:34:39.259060 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader read 1369231 of 4194304
>>> osd.0.log:4546819:2012-02-08 12:35:35.468156 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader reading nonblocking into 0x166ba48f le=
n 2825073
>>> osd.0.log:4546820:2012-02-08 12:35:35.468189 7f6acec77700 --
>>> 172.17.131.32:6800/15199>> =A0172.17.135.85:0/2712733083 pipe(0x2ef=
0000
>>> sd=3D173
>>> pgs=3D7 cs=3D1 l=3D1).reader read 1448 of 2825073
>>>
>>> which I take to mean that the reader thread sat in poll() for 56 se=
cs, in
>>> this case.
>>>
>>> I was able to correlate such stalls with tcpdump output collected o=
n
>>> clients. =A0Here's an example from another run:
>>>
>>> 15:09:37.584600 IP 172.17.131.32.6808> =A0172.17.135.7.37045: Flags=
 [.],
>>> ack
>>> 23631561, win 65535, options [nop,nop,TS val 1096144 ecr 1100575], =
length
>>> 0
>>> 15:09:37.584613 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23631561:23663417, ack 1218, win 20904, options [nop,nop,TS val 110=
0615
>>> ecr
>>> 1096144], length 31856
>>> 15:09:37.584655 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23663417:23695273, ack 1218, win 20904, options [nop,nop,TS val 110=
0615
>>> ecr
>>> 1096144], length 31856
>>> 15:09:37.624476 IP 172.17.131.32.6808> =A0172.17.135.7.37045: Flags=
 [.],
>>> ack
>>> 23695273, win 65535, options [nop,nop,TS val 1096184 ecr 1100615], =
length
>>> 0
>>> 15:09:37.624489 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23695273:23727129, ack 1218, win 20904, options [nop,nop,TS val 110=
0655
>>> ecr
>>> 1096184], length 31856
>>> 15:09:37.624532 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [P.],
>>> seq
>>> 23727129:23758985, ack 1218, win 20904, options [nop,nop,TS val 110=
0655
>>> ecr
>>> 1096184], length 31856
>>> 15:09:37.664454 IP 172.17.131.32.6808> =A0172.17.135.7.37045: Flags=
 [.],
>>> ack
>>> 23758985, win 65535, options [nop,nop,TS val 1096224 ecr 1100655], =
length
>>> 0
>>> 15:09:37.664468 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23758985:23790841, ack 1218, win 20904, options [nop,nop,TS val 110=
0695
>>> ecr
>>> 1096224], length 31856
>>> 15:09:37.664506 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23790841:23822697, ack 1218, win 20904, options [nop,nop,TS val 110=
0695
>>> ecr
>>> 1096224], length 31856
>>> 15:09:37.706937 IP 172.17.131.32.6808> =A0172.17.135.7.37045: Flags=
 [.],
>>> ack
>>> 23822697, win 65535, options [nop,nop,TS val 1096266 ecr 1100695], =
length
>>> 0
>>> 15:09:37.706950 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23854553, ack 1218, win 20904, options [nop,nop,TS val 110=
0738
>>> ecr
>>> 1096266], length 31856
>>> 15:09:37.706995 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [P.],
>>> seq
>>> 23854553:23886409, ack 1218, win 20904, options [nop,nop,TS val 110=
0738
>>> ecr
>>> 1096266], length 31856
>>> 15:09:37.929946 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 110=
0961
>>> ecr
>>> 1096266], length 1448
>>> 15:09:38.376961 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 110=
1408
>>> ecr
>>> 1096266], length 1448
>>> 15:09:39.270947 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 110=
2302
>>> ecr
>>> 1096266], length 1448
>>> 15:09:41.056943 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 110=
4088
>>> ecr
>>> 1096266], length 1448
>>> 15:09:44.632946 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 110=
7664
>>> ecr
>>> 1096266], length 1448
>>> 15:09:51.784947 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 111=
4816
>>> ecr
>>> 1096266], length 1448
>>> 15:10:06.088945 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 112=
9120
>>> ecr
>>> 1096266], length 1448
>>> 15:10:34.728951 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 115=
7760
>>> ecr
>>> 1096266], length 1448
>>> 15:11:31.944946 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23822697:23824145, ack 1218, win 20904, options [nop,nop,TS val 121=
4976
>>> ecr
>>> 1096266], length 1448
>>> 15:11:31.945075 IP 172.17.131.32.6808> =A0172.17.135.7.37045: Flags=
 [.],
>>> ack
>>> 23824145, win 65535, options [nop,nop,TS val 1210496 ecr 1214976], =
length
>>> 0
>>> 15:11:31.945091 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23886409:23889305, ack 1218, win 20904, options [nop,nop,TS val 121=
4976
>>> ecr
>>> 1210496], length 2896
>>> 15:11:31.945178 IP 172.17.131.32.6808> =A0172.17.135.7.37045: Flags=
 [.],
>>> ack
>>> 23824145, win 65535, options [nop,nop,TS val 1210496 ecr
>>> 1214976,nop,nop,sack 1 {23886409:23887857}], length 0
>>> 15:11:31.945199 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23824145:23825593, ack 1218, win 20904, options [nop,nop,TS val 121=
4976
>>> ecr
>>> 1210496], length 1448
>>> 15:11:31.945207 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23825593:23827041, ack 1218, win 20904, options [nop,nop,TS val 121=
4976
>>> ecr
>>> 1210496], length 1448
>>> 15:11:31.945214 IP 172.17.135.7.37045> =A0172.17.131.32.6808: Flags=
 [.],
>>> seq
>>> 23827041:23828489, ack 1218, win 20904, options [nop,nop,TS val 121=
4976
>>> ecr
>>> 1210496], length 1448
>>>
>>> So in this case the client retransmitted for ~2 minutes with no res=
ponse
>>> from
>>> the OSD. =A0Note that during this time the client was talking to ot=
her OSDs
>>> on
>>> the
>>> same server.
>>>
>>> I want to try turning off GSO/GRO on my interfaces, but then
>>> I think I need to post to netdev...
>>>
>>> -- Jim
>>
>>
>> The network trace output looks weird, it either means all of the
>> packets between 23822697:23886409 were lost or a bug in the networki=
ng
>> stack.
>
>
> I suspect a bug in the stack, as at an application level I get
> the same sort of stalls whether I use IP over ethernet or IPoIB.
> I need to get traces for both cases to prove that it is the same
> stall...
>
>
>> The application should have no effect on the acks that should
>> have been generated. Even if you assume one or more of the frames on
>> the wire between 23822697:23886409 were somehow lost, you would have
>> had to see some sort of duplicate acks with sack segments.
>
>
> See the full trace of the recovery below....
>
>>
>> Is this a bunch of bare metal servers or are these virtual?
>
>
> Bare metal.
>
>
>> If you
>> could tap the network just upstream of the OSD servers, it would hel=
p
>> narrow down where to look at. You could also just turning off GRO/GS=
O,
>> as you suggest, to see if it makes a difference.
>
>
> Turning off GRO/GSO made no difference to application level behavior.
> Tomorrow I'll collect traces to see what happened.
>
> Thanks for taking a look.
>
> -- Jim
>
> Here's the trace:

Do you mind capturing to a pcap file and providing that. Makes it
easier to analyse things. If not, i understand. If you can make do the
capture on both ends, do it with a snaplen of 68 so that you get all
of the headers and there shouldn't be too much payload information in
the file.

I will take a look at the additional output and see if anything pops
out. I am assuming the below output was immediately after what you
posted in your earlier email.


 Sridhar

>
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
> 15:11:31.945225 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23824145, win 65535, options [nop,nop,TS val 1210496 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945325 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23828489, win 65535, options [nop,nop,TS val 1210496 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945338 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23828489:23829937, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945346 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23829937:23831385, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945352 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23831385:23832833, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945475 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23831385, win 65535, options [nop,nop,TS val 1210496 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945485 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23832833:23834281, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945491 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23834281:23835729, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945499 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23835729:23837177, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945508 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23832833, win 65535, options [nop,nop,TS val 1210496 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945515 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23837177:23838625, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945522 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23838625:23840073, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945582 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23834281, win 65535, options [nop,nop,TS val 1210496 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945592 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23840073:23841521, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945601 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23841521:23842969, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210496], length 1448
> 15:11:31.945611 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23837177, win 65535, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945618 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23842969:23844417, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945624 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23844417:23845865, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945631 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23845865:23847313, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945639 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23838625, win 65535, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945646 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23847313:23848761, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945653 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23848761:23850209, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945661 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23840073, win 65160, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945667 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23850209:23851657, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945674 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23851657:23853105, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945733 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23842969, win 62264, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945743 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23853105:23854553, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945750 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23854553:23856001, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945756 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23856001:23857449, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945765 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23844417, win 60816, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945772 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23857449:23858897, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945779 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23858897:23860345, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945787 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23848761, win 56472, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945795 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23860345:23861793, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945802 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23861793:23863241, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945808 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23863241:23864689, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945815 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23850209, win 55024, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945822 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23864689:23866137, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945828 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23866137:23867585, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945837 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23851657, win 53576, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945844 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23867585:23869033, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945850 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23869033:23870481, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945858 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23853105, win 52128, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945865 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23870481:23871929, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945872 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23871929:23873377, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945880 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23854553, win 50680, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945894 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23873377:23874825, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945901 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23874825:23876273, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945909 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23856001, win 49232, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945915 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23876273:23877721, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945922 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23877721:23879169, ack 1218, win 20904, options [nop,nop,TS val 12149=
76 ecr
> 1210497], length 1448
> 15:11:31.945931 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23857449, win 47784, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945937 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23879169:23880617, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 1448
> 15:11:31.945943 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23880617:23882065, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 1448
> 15:11:31.945951 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23858897, win 46336, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945956 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23882065:23883513, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 1448
> 15:11:31.945963 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23883513:23884961, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 1448
> 15:11:31.945971 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23860345, win 44888, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945977 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [P.=
], seq
> 23884961:23886409, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 1448
> 15:11:31.945984 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23889305:23890753, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 1448
> 15:11:31.945991 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23861793, win 43440, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.945999 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23890753:23893649, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946009 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23863241, win 41992, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946017 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23893649:23896545, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946025 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23864689, win 40544, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946032 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23896545:23899441, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946040 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23866137, win 39096, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946046 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23899441:23902337, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946056 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23867585, win 37648, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946063 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23902337:23905233, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946076 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23869033, win 36200, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946082 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23870481, win 34752, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946089 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23871929, win 33304, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946095 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23876273, win 28960, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946101 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23879169, win 26064, options [nop,nop,TS val 1210497 ecr
> 1214976,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946106 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23880617, win 24616, options [nop,nop,TS val 1210497 ecr
> 1214977,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946113 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23882065, win 23168, options [nop,nop,TS val 1210497 ecr
> 1214977,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946118 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23883513, win 21720, options [nop,nop,TS val 1210497 ecr
> 1214977,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946123 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23884961, win 20272, options [nop,nop,TS val 1210497 ecr
> 1214977,nop,nop,sack 1 {23886409:23889305}], length 0
> 15:11:31.946207 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23893649, win 11584, options [nop,nop,TS val 1210497 ecr 1214977], le=
ngth 0
> 15:11:31.946217 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23900889, win 5792, options [nop,nop,TS val 1210497 ecr 1214977], len=
gth 0
> 15:11:31.946225 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23903785, win 5792, options [nop,nop,TS val 1210497 ecr 1214977], len=
gth 0
> 15:11:31.946230 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23905233:23909577, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 4344
> 15:11:31.946425 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23906681, win 5792, options [nop,nop,TS val 1210497 ecr 1214977], len=
gth 0
> 15:11:31.946434 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23909577:23912473, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946444 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23909577, win 5792, options [nop,nop,TS val 1210497 ecr 1214977], len=
gth 0
> 15:11:31.946449 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23912473:23915369, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946676 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23912473, win 5792, options [nop,nop,TS val 1210497 ecr 1214977], len=
gth 0
> 15:11:31.946684 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23915369:23918265, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946694 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23915369, win 5792, options [nop,nop,TS val 1210497 ecr 1214977], len=
gth 0
> 15:11:31.946700 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23918265:23921161, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210497], length 2896
> 15:11:31.946855 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23921161, win 5792, options [nop,nop,TS val 1210498 ecr 1214977], len=
gth 0
> 15:11:31.946864 IP 172.17.135.7.37045 > 172.17.131.32.6808: Flags [.]=
, seq
> 23921161:23926953, ack 1218, win 20904, options [nop,nop,TS val 12149=
77 ecr
> 1210498], length 5792
> 15:11:31.947007 IP 172.17.131.32.6808 > 172.17.135.7.37045: Flags [.]=
, ack
> 23926953, win 5792, options [nop,nop,TS val 1210498 ecr 1214977], len=
gth 0
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
