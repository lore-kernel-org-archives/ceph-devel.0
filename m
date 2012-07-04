From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: monitor not starting
Date: Wed, 04 Jul 2012 19:02:15 +0200
Message-ID: <4FF47717.1030401@smart-weblications.de>
References: <4FF42CD7.1060000@smart-weblications.de> <D2569975C9B14D6B974C162C58FA7401@inktank.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:50989 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751369Ab2GDRCC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 13:02:02 -0400
In-Reply-To: <D2569975C9B14D6B974C162C58FA7401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 04.07.2012 18:25, schrieb Gregory Farnum:
>=20
>=20
> On Wednesday, July 4, 2012 at 4:45 AM, Smart Weblications GmbH - Flor=
ian Wiessner wrote:
>=20
>> Hi List,
>>
>>
>> i today upgraded from 0.43 to 0.48 and now i have one monitor which =
does not
>> want to start up anymore:
>>
>> ceph version 0.48argonaut-125-g4e774fb
>> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
>> 1: /usr/bin/ceph-mon() [0x52f9c9]
>> 2: (()+0xeff0) [0x7fb08dd11ff0]
>> 3: (gsignal()+0x35) [0x7fb08c4f41b5]
>> 4: (abort()+0x180) [0x7fb08c4f6fc0]
>> 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fb08cd88dc5]
>> 6: (()+0xcb166) [0x7fb08cd87166]
>> 7: (()+0xcb193) [0x7fb08cd87193]
>> 8: (()+0xcb28e) [0x7fb08cd8728e]
>> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char con=
st*)+0x940)
>> [0x55b310]
>> 10: /usr/bin/ceph-mon() [0x497317]
>> 11: (Monitor::init()+0xc5a) [0x4857fa]
>> 12: (main()+0x2789) [0x46ac79]
>> 13: (__libc_start_main()+0xfd) [0x7fb08c4e0c8d]
>> 14: /usr/bin/ceph-mon() [0x468309]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to
>> interpret this.
>>
>> --- end dump of recent events ---
>>
>>
>> How can i find out why it does not startup anymore? osd and mds is r=
unning fine..
> Is that all the output you get? There should be a line somewhere whic=
h says what the assert is, and what line number it's on. :)


Is this what you are looking for:
2012-07-04 11:20:24.448430 7f423d943780  1 mon.3@-1(probing) e1 init fs=
id
4553d0f6-1b31-4ba5-9d97-edae55bcaab4
2012-07-04 11:20:24.448994 7f423d943780 -1 mon/Paxos.cc: In function 'b=
ool
Paxos::is_consistent()' thread 7f423d943780 time 2012-07-04 11:20:24.44=
8637
mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1))

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x497317]
 2: (Monitor::init()+0xc5a) [0x4857fa]
 3: (main()+0x2789) [0x46ac79]
 4: (__libc_start_main()+0xfd) [0x7f423bcfbc8d]
 5: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- begin dump of recent events ---
    -3> 2012-07-04 11:20:24.447613 7f423d943780  1 store(/data/ceph/mon=
) mount
    -2> 2012-07-04 11:20:24.447722 7f423d943780  0 ceph version
0.48argonaut-125-g4e774fb (commit:4e774fbcb38fd6883232b72352512a5f8e4a6=
6e8),
process ceph-mon, pid 7436
    -1> 2012-07-04 11:20:24.448430 7f423d943780  1 mon.3@-1(probing) e1=
 init
fsid 4553d0f6-1b31-4ba5-9d97-edae55bcaab4
     0> 2012-07-04 11:20:24.448994 7f423d943780 -1 mon/Paxos.cc: In fun=
ction
'bool Paxos::is_consistent()' thread 7f423d943780 time 2012-07-04 11:20=
:24.448637
mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1))

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x497317]
 2: (Monitor::init()+0xc5a) [0x4857fa]
 3: (main()+0x2789) [0x46ac79]
 4: (__libc_start_main()+0xfd) [0x7f423bcfbc8d]
 5: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- end dump of recent events ---
2012-07-04 11:20:24.449567 7f423d943780 -1 *** Caught signal (Aborted) =
**
 in thread 7f423d943780


>=20
> And while you're at it, is the rest of the cluster in fact working? I=
 don't think 0.43 to 0.48 is an upgrade path we tested.
>=20

Anyway, i removed the mon and did a ceph-mon --mkfs with the 3 mons tha=
t were
still working after the upgrade and got it up and running again.

Yes, the cluster is still working after the upgrade. Also upgraded to l=
inux
3.4.4 - it feels like the ceph-fuse and kernel ceph client is a little =
less
robust than in 0.43...

when i start copying from /ceph to other mp, then it seems that for the=
 copy
operation or in general for any operation, /ceph is unusable to other p=
rocesses
which then makes the client behave very sluggish... :(

i can send you the contents of the monitor directory where it did not w=
ork after
the upgrade if you want me to..
--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

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
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
