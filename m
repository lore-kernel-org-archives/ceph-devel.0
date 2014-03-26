From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Wed, 26 Mar 2014 03:35:24 +0100
Message-ID: <1395801324.2076.47.camel@localhost>
References: <1395736765.2823.29.camel@localhost> <53317BC2.9010700@ieee.org>
	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>
	 <5331D2E8.6060002@ieee.org>
	 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
	 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>
	 <1395781847.2076.21.camel@localhost>
	 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
	 <1395782577.2076.23.camel@localhost>
	 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
	 <1395783675.2076.26.camel@localhost>
	 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
	 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>
	 <5332075F.8080105@ieee.org> <1395788695.2076.35.camel@localhost>
	 <53321896.1080606@ieee.org> <1395797596.2076.43.camel@localhost>
	 <1395798658.2076.45.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:47155 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaCZCf3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 22:35:29 -0400
In-Reply-To: <1395798658.2076.45.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Le mercredi 26 mars 2014 =C3=A0 02:50 +0100, Olivier Bonvalet a =C3=A9c=
rit :
> Le mercredi 26 mars 2014 =C3=A0 02:33 +0100, Olivier Bonvalet a =C3=A9=
crit :
> > Thanks for your patch.
> >=20
> > This is an output of a crash case :
> >=20
> > Mar 26 02:31:18 alg kernel: [  965.366895] rbd_img_obj_callback: ba=
d image object request information:
> > Mar 26 02:31:18 alg kernel: [  965.366905] obj_request ffff880224bc=
9528
> > Mar 26 02:31:18 alg kernel: [  965.366909]     ->object_name <(null=
)>
> > Mar 26 02:31:18 alg kernel: [  965.366913]     ->offset 0
> > Mar 26 02:31:18 alg kernel: [  965.366917]     ->length 4096
> > Mar 26 02:31:18 alg kernel: [  965.366921]     ->type 0x1
> > Mar 26 02:31:18 alg kernel: [  965.366925]     ->flags 0x3
> > Mar 26 02:31:18 alg kernel: [  965.366929]     ->img_request       =
    (null)
> > Mar 26 02:31:18 alg kernel: [  965.366933]     ->which 4294967295
> > Mar 26 02:31:18 alg kernel: [  965.366936]     ->xferred 4096
> > Mar 26 02:31:18 alg kernel: [  965.366940]     ->result 0
> > Mar 26 02:31:18 alg kernel: [  965.366943]     ->kref 0
> > Mar 26 02:31:18 alg kernel: [  965.366947] img_request ffff880222f4=
fb50
> > Mar 26 02:31:18 alg kernel: [  965.366950]     ->snap 0xfffffffffff=
ffffe
> > Mar 26 02:31:18 alg kernel: [  965.366954]     ->offset 1417662464
> > Mar 26 02:31:18 alg kernel: [  965.366957]     ->length 16384
> > Mar 26 02:31:18 alg kernel: [  965.366960]     ->flags 0x0
> > Mar 26 02:31:18 alg kernel: [  965.366963]     ->obj_request_count =
0
> > Mar 26 02:31:18 alg kernel: [  965.366966]     ->next_completion 2
> > Mar 26 02:31:18 alg kernel: [  965.366969]     ->xferred 16384
> > Mar 26 02:31:18 alg kernel: [  965.366973]     ->result 0
> > Mar 26 02:31:18 alg kernel: [  965.366976]     ->obj_requests head =
ffff880222f4fbb0
> > Mar 26 02:31:18 alg kernel: [  965.366980]     ->kref 0
> > Mar 26 02:31:18 alg kernel: [  965.366985]=20
> > Mar 26 02:31:18 alg kernel: [  965.366985] Assertion failure in rbd=
_img_obj_callback() at line 2165:
> > Mar 26 02:31:18 alg kernel: [  965.366985]=20
> > Mar 26 02:31:18 alg kernel: [  965.366985] 	rbd_assert(which =3D=3D=
 img_request->next_completion);
> > Mar 26 02:31:18 alg kernel: [  965.366985]=20
> > Mar 26 02:31:18 alg kernel: [  965.367185] ------------[ cut here ]=
------------
> > Mar 26 02:31:18 alg kernel: [  965.367241] kernel BUG at drivers/bl=
ock/rbd.c:2165!
> >=20
> >=20
> > I hope it can help.
> >=20
> >=20
> > --
>=20
> and a second one, very similar :
>=20
> Mar 26 02:48:27 alg kernel: [  681.167833] rbd_img_obj_callback: bad =
image object request information:
> Mar 26 02:48:27 alg kernel: [  681.167836] obj_request ffff88022e1e28=
28
> Mar 26 02:48:27 alg kernel: [  681.167837]     ->object_name <(null)>
> Mar 26 02:48:27 alg kernel: [  681.167838]     ->offset 0
> Mar 26 02:48:27 alg kernel: [  681.167839]     ->length 4096
> Mar 26 02:48:27 alg kernel: [  681.167840]     ->type 0x1
> Mar 26 02:48:27 alg kernel: [  681.167840]     ->flags 0x3
> Mar 26 02:48:27 alg kernel: [  681.167841]     ->img_request         =
  (null)
> Mar 26 02:48:27 alg kernel: [  681.167842]     ->which 4294967295
> Mar 26 02:48:27 alg kernel: [  681.167843]     ->xferred 4096
> Mar 26 02:48:27 alg kernel: [  681.167844]     ->result 0
> Mar 26 02:48:27 alg kernel: [  681.167844]     ->kref 0
> Mar 26 02:48:27 alg kernel: [  681.167845] img_request ffff88021f555f=
10
> Mar 26 02:48:27 alg kernel: [  681.167846]     ->snap 0xfffffffffffff=
ffe
> Mar 26 02:48:27 alg kernel: [  681.167847]     ->offset 28072464384
> Mar 26 02:48:27 alg kernel: [  681.167847]     ->length 16384
> Mar 26 02:48:27 alg kernel: [  681.167848]     ->flags 0x0
> Mar 26 02:48:27 alg kernel: [  681.167849]     ->obj_request_count 0
> Mar 26 02:48:27 alg kernel: [  681.167850]     ->next_completion 2
> Mar 26 02:48:27 alg kernel: [  681.167850]     ->xferred 16384
> Mar 26 02:48:27 alg kernel: [  681.167851]     ->result 0
> Mar 26 02:48:27 alg kernel: [  681.167852]     ->obj_requests head ff=
ff88021f555f70
> Mar 26 02:48:27 alg kernel: [  681.167853]     ->kref 0
> Mar 26 02:48:27 alg kernel: [  681.167854]=20
> Mar 26 02:48:27 alg kernel: [  681.167854] Assertion failure in rbd_i=
mg_obj_callback() at line 2165:
> Mar 26 02:48:27 alg kernel: [  681.167854]=20
> Mar 26 02:48:27 alg kernel: [  681.167854] 	rbd_assert(which =3D=3D i=
mg_request->next_completion);
> Mar 26 02:48:27 alg kernel: [  681.167854]=20
> Mar 26 02:48:27 alg kernel: [  681.168117] ------------[ cut here ]--=
----------
> Mar 26 02:48:27 alg kernel: [  681.168211] kernel BUG at drivers/bloc=
k/rbd.c:2165!
>=20
>=20
> --

And a last one. As you said, it looks like to be same problem, each
time :

Mar 26 03:32:53 murmillia kernel: [  533.506391] rbd_img_obj_callback: =
bad image object request information:
Mar 26 03:32:53 murmillia kernel: [  533.506395] obj_request ffff88024f=
e73da8
Mar 26 03:32:53 murmillia kernel: [  533.506396]     ->object_name <(nu=
ll)>
Mar 26 03:32:53 murmillia kernel: [  533.506397]     ->offset 0
Mar 26 03:32:53 murmillia kernel: [  533.506398]     ->length 24576
Mar 26 03:32:53 murmillia kernel: [  533.506399]     ->type 0x1
Mar 26 03:32:53 murmillia kernel: [  533.506400]     ->flags 0x3
Mar 26 03:32:53 murmillia kernel: [  533.506400]     ->img_request     =
      (null)
Mar 26 03:32:53 murmillia kernel: [  533.506401]     ->which 4294967295
Mar 26 03:32:53 murmillia kernel: [  533.506402]     ->xferred 24576
Mar 26 03:32:53 murmillia kernel: [  533.506403]     ->result 0
Mar 26 03:32:53 murmillia kernel: [  533.506404]     ->kref 0
Mar 26 03:32:53 murmillia kernel: [  533.506405] img_request ffff880256=
f0cad8
Mar 26 03:32:53 murmillia kernel: [  533.506405]     ->snap 0xfffffffff=
ffffffe
Mar 26 03:32:53 murmillia kernel: [  533.506406]     ->offset 676373299=
20
Mar 26 03:32:53 murmillia kernel: [  533.506407]     ->length 40960
Mar 26 03:32:53 murmillia kernel: [  533.506408]     ->flags 0x0
Mar 26 03:32:53 murmillia kernel: [  533.506409]     ->obj_request_coun=
t 0
Mar 26 03:32:53 murmillia kernel: [  533.506410]     ->next_completion =
2
Mar 26 03:32:53 murmillia kernel: [  533.506410]     ->xferred 40960
Mar 26 03:32:53 murmillia kernel: [  533.506411]     ->result 0
Mar 26 03:32:53 murmillia kernel: [  533.506412]     ->obj_requests hea=
d ffff880256f0cb38
Mar 26 03:32:53 murmillia kernel: [  533.506413]     ->kref 0
Mar 26 03:32:53 murmillia kernel: [  533.506414]=20
Mar 26 03:32:53 murmillia kernel: [  533.506414] Assertion failure in r=
bd_img_obj_callback() at line 2165:
Mar 26 03:32:53 murmillia kernel: [  533.506414]=20
Mar 26 03:32:53 murmillia kernel: [  533.506414] 	rbd_assert(which =3D=3D=
 img_request->next_completion);
Mar 26 03:32:53 murmillia kernel: [  533.506414]=20
Mar 26 03:32:53 murmillia kernel: [  533.506620] ------------[ cut here=
 ]------------


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
