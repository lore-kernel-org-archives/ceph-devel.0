From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sun, 22 Jan 2012 13:25:43 +0100
Message-ID: <4F1C0047.6030908@smart-weblications.de>
References: <4F1ABD5C.1000907@smart-weblications.de> <4F1AE704.6010005@widodh.nl> <4F1AE824.3000006@smart-weblications.de> <CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com> <4F1AF955.9030103@smart-weblications.de> <CAC-hyiG6-CVi1F6iwZQNhReMoRvYg3K-NGn4h9s8LOJPEHNR7A@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:59120 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335Ab2AVMZn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 22 Jan 2012 07:25:43 -0500
In-Reply-To: <CAC-hyiG6-CVi1F6iwZQNhReMoRvYg3K-NGn4h9s8LOJPEHNR7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Am 22.01.2012 02:19, schrieb Yehuda Sadeh Weinraub:
> On Sat, Jan 21, 2012 at 9:43 AM, Smart Weblications GmbH - Florian
> Wiessner <f.wiessner@smart-weblications.de> wrote:
>>
>> 2) v1 -- ?+0 0x184dc00
>> 2012-01-21 18:42:36.758683 7f60e26e0700 -- 192.168.0.6:6789/0 --> mo=
n.3
>> 192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c=
22c73d name
>> 2) v1 -- ?+0 0x184d900
>> 2012-01-21 18:42:36.759270 7f60e6d62700 cephx: verify_authorizer_rep=
ly exception
>> in decode_decrypt with AQAM+RpP0JI9LRAAWyy1Flf5X6RUVxEjhAEFtg=3D=3D
>> 2012-01-21 18:42:36.759287 7f60e6d62700 -- 192.168.0.6:6789/0 >>
>> 192.168.0.4:6789/0 pipe(0xc91500 sd=3D9 pgs=3D0 cs=3D0 l=3D0).failed=
 verifying authorize
>> reply
>> ^C
>>
>>
> Can you verify that there's no 'auth supported' line in your mon ceph=
=2Econf?
>=20
> Also, try running (with correct <ceph.conf>):
>=20
> # ceph-conf --lookup -c <ceph.conf> 'auth supported' --name mon.2
>=20
> or just:
>=20
> # ceph-conf --lookup -c <ceph.conf> 'auth supported'
node04:/tmp# ceph-conf --lookup -c /etc/ceph/ceph.conf 'auth supported'=
 --name mon.2
none
node04:/tmp# ceph-conf --lookup -c /etc/ceph/ceph.conf 'auth supported'=
 --name mon.0
none


i now explicitly set auth supported =3D none, but still it is not worki=
ng :(




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
