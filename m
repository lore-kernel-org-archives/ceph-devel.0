From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 18:43:49 +0100
Message-ID: <4F1AF955.9030103@smart-weblications.de>
References: <4F1ABD5C.1000907@smart-weblications.de> <4F1AE704.6010005@widodh.nl> <4F1AE824.3000006@smart-weblications.de> <CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:42803 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780Ab2AURn4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Jan 2012 12:43:56 -0500
In-Reply-To: <CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Am 21.01.2012 18:01, schrieb Gregory Farnum:
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

this is what i get on the second running ceph node:

2012-01-21 18:42:34.759225 7f60e6d62700 cephx: verify_authorizer_reply =
exception
in decode_decrypt with AQAK+RpPWKY9LRAASh86sPjNxkbAa7lZLuPFfQ=3D=3D
2012-01-21 18:42:34.759245 7f60e6d62700 -- 192.168.0.6:6789/0 >>
192.168.0.4:6789/0 pipe(0xc91500 sd=3D9 pgs=3D0 cs=3D0 l=3D0).failed ve=
rifying authorize
reply
2012-01-21 18:42:36.753924 7f60e11d2700 -- 192.168.0.6:6789/0 >> :/0
pipe(0x1853c80 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept sd=3D12
2012-01-21 18:42:36.754035 7f60e2ee1700 -- 192.168.0.6:6789/0 <=3D=3D m=
ds.?
192.168.0.6:6800/3222 1 =3D=3D=3D=3D auth(proto 0 26 bytes epoch 0) v1 =
=3D=3D=3D=3D 56+0+0
(2774746219 0 0) 0x1842e00 con 0x184b280
2012-01-21 18:42:36.758634 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon.0
192.168.0.4:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
2) v1 -- ?+0 0x1850000
2012-01-21 18:42:36.758654 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon.1
192.168.0.5:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
2) v1 -- ?+0 0x184dc00
2012-01-21 18:42:36.758683 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon.3
192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c=
73d name
2) v1 -- ?+0 0x184d900
2012-01-21 18:42:36.759270 7f60e6d62700 cephx: verify_authorizer_reply =
exception
in decode_decrypt with AQAM+RpP0JI9LRAAWyy1Flf5X6RUVxEjhAEFtg=3D=3D
2012-01-21 18:42:36.759287 7f60e6d62700 -- 192.168.0.6:6789/0 >>
192.168.0.4:6789/0 pipe(0xc91500 sd=3D9 pgs=3D0 cs=3D0 l=3D0).failed ve=
rifying authorize
reply
^C


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
