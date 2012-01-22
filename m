From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 17:19:52 -0800
Message-ID: <CAC-hyiG6-CVi1F6iwZQNhReMoRvYg3K-NGn4h9s8LOJPEHNR7A@mail.gmail.com>
References: <4F1ABD5C.1000907@smart-weblications.de>
	<4F1AE704.6010005@widodh.nl>
	<4F1AE824.3000006@smart-weblications.de>
	<CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
	<4F1AF955.9030103@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40708 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab2AVBTx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Jan 2012 20:19:53 -0500
Received: by yhoo21 with SMTP id o21so840717yho.19
        for <ceph-devel@vger.kernel.org>; Sat, 21 Jan 2012 17:19:52 -0800 (PST)
In-Reply-To: <4F1AF955.9030103@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Sat, Jan 21, 2012 at 9:43 AM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
>
> Am 21.01.2012 18:01, schrieb Gregory Farnum:
> >>
> >> As stated above, i did not set up ceph with authentication. so the=
re was no
> >> authentication used in 0.39 nor in 0.40
> >>
> >> But now somehow authentication seems to be enforced - at least tha=
t's what i
> >> read from the output that ceph -w gives me...
> >
> > Actually that might just be a red herring =97 check the monitor log=
 that
> > your ceph -w client tried to connect to and see what it says about =
the
> > connection attempt. :)
>
> this is what i get on the second running ceph node:
>
> 2012-01-21 18:42:34.759225 7f60e6d62700 cephx: verify_authorizer_repl=
y exception
> in decode_decrypt with AQAK+RpPWKY9LRAASh86sPjNxkbAa7lZLuPFfQ=3D=3D
> 2012-01-21 18:42:34.759245 7f60e6d62700 -- 192.168.0.6:6789/0 >>
> 192.168.0.4:6789/0 pipe(0xc91500 sd=3D9 pgs=3D0 cs=3D0 l=3D0).failed =
verifying authorize
> reply
> 2012-01-21 18:42:36.753924 7f60e11d2700 -- 192.168.0.6:6789/0 >> :/0
> pipe(0x1853c80 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept sd=3D12
> 2012-01-21 18:42:36.754035 7f60e2ee1700 -- 192.168.0.6:6789/0 <=3D=3D=
 mds.?
> 192.168.0.6:6800/3222 1 =3D=3D=3D=3D auth(proto 0 26 bytes epoch 0) v=
1 =3D=3D=3D=3D 56+0+0
> (2774746219 0 0) 0x1842e00 con 0x184b280
> 2012-01-21 18:42:36.758634 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon=
=2E0
> 192.168.0.4:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c2=
2c73d name
> 2) v1 -- ?+0 0x1850000
> 2012-01-21 18:42:36.758654 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon=
=2E1
> 192.168.0.5:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c2=
2c73d name
> 2) v1 -- ?+0 0x184dc00
> 2012-01-21 18:42:36.758683 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon=
=2E3
> 192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c2=
2c73d name
> 2) v1 -- ?+0 0x184d900
> 2012-01-21 18:42:36.759270 7f60e6d62700 cephx: verify_authorizer_repl=
y exception
> in decode_decrypt with AQAM+RpP0JI9LRAAWyy1Flf5X6RUVxEjhAEFtg=3D=3D
> 2012-01-21 18:42:36.759287 7f60e6d62700 -- 192.168.0.6:6789/0 >>
> 192.168.0.4:6789/0 pipe(0xc91500 sd=3D9 pgs=3D0 cs=3D0 l=3D0).failed =
verifying authorize
> reply
> ^C
>
>
Can you verify that there's no 'auth supported' line in your mon ceph.c=
onf?

Also, try running (with correct <ceph.conf>):

#=A0ceph-conf --lookup -c <ceph.conf> 'auth supported' --name mon.2

or just:

#=A0ceph-conf --lookup -c <ceph.conf> 'auth supported'


and you can also try adding 'auth supported =3D none' in your ceph.conf=
=2E

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
