From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 18:34:22 +0100
Message-ID: <4F1AF71E.8070204@smart-weblications.de>
References: <4F1ABD5C.1000907@smart-weblications.de> <4F1AE704.6010005@widodh.nl> <4F1AE824.3000006@smart-weblications.de> <CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:53663 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803Ab2AURe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Jan 2012 12:34:29 -0500
In-Reply-To: <CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi,

Am 21.01.2012 18:01, schrieb Gregory Farnum:
>>
>> Well, this config used to work with 0.39 - i did not see any hint in=
 the relase
>> mail that i have to change something in the config - 0.40 should be =
mostly a
>> stabilization release...
>>
>> I can change the config etc and setup again when i am able to get my=
 data out of
>> the current installation.
>>
>>>>
>>>> i did set up ceph without cephx
>>>
>>> When did you enable cephx? Did you do so from the upgrade to 0.39 t=
o 0.40 or
>>> earlier?
>>
>> As stated above, i did not set up ceph with authentication. so there=
 was no
>> authentication used in 0.39 nor in 0.40
>>
>> But now somehow authentication seems to be enforced - at least that'=
s what i
>> read from the output that ceph -w gives me...
>=20
> Actually that might just be a red herring =97 check the monitor log t=
hat
> your ceph -w client tried to connect to and see what it says about th=
e
> connection attempt. :)


2012-01-21 18:31:04.073997 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.074472 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.074610 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.075132 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.075299 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.075960 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.076097 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.076494 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.076643 7f5fb6d08700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xcf3280 sd=3D10 pgs=3D0 cs=3D0 l=3D0).connect =
got BADAUTHORIZER
2012-01-21 18:31:04.547643 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.1
192.168.0.5:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd27000
2012-01-21 18:31:04.547670 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.2
192.168.0.6:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd26c00
2012-01-21 18:31:04.547682 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.3
192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd26900
2012-01-21 18:31:04.737547 7f5fb6601700 -- 192.168.0.4:6789/0 >> :/0
pipe(0xd03a00 sd=3D13 pgs=3D0 cs=3D0 l=3D0).accept sd=3D13
2012-01-21 18:31:04.737772 7f5fb6601700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xd03a00 sd=3D13 pgs=3D0 cs=3D0 l=3D0).accept c=
onnect_seq 0 vs
existing 0 state 1
2012-01-21 18:31:06.547711 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.1
192.168.0.5:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd26600
2012-01-21 18:31:06.547743 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.2
192.168.0.6:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd26300
2012-01-21 18:31:06.547755 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.3
192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd26000
2012-01-21 18:31:06.737632 7f5fb62fe700 -- 192.168.0.4:6789/0 >> :/0
pipe(0xd03c80 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept sd=3D12
2012-01-21 18:31:06.737863 7f5fb62fe700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xd03c80 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept c=
onnect_seq 0 vs
existing 0 state 1
2012-01-21 18:31:08.547765 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.1
192.168.0.5:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd28c00
2012-01-21 18:31:08.547787 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.2
192.168.0.6:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd28900
2012-01-21 18:31:08.547799 7f5fb7509700 -- 192.168.0.4:6789/0 --> mon.3
192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
0) v1 -- ?+0 0xd28600
2012-01-21 18:31:08.737640 7f5fb62fe700 -- 192.168.0.4:6789/0 >> :/0
pipe(0xd03a00 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept sd=3D12
2012-01-21 18:31:08.737872 7f5fb62fe700 -- 192.168.0.4:6789/0 >>
192.168.0.6:6789/0 pipe(0xd03a00 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept c=
onnect_seq 0 vs
existing 0 state 1


But still no clue what to do...

--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
