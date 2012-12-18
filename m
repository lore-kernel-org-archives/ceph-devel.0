From: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: rbd caching issue
Date: Tue, 18 Dec 2012 09:37:27 +0100
Message-ID: <50D02B47.3030606@filoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB174CAFE63EB1182F4576D35"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-10.de-punkt.de ([93.190.68.161]:39299 "EHLO
	mail-10.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab2LRIpJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 03:45:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-10.de-punkt.de (Postfix) with ESMTP id AC5C13A736
	for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 09:37:36 +0100 (CET)
Received: from mail-10.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-KyucCfUC2S for <ceph-devel@vger.kernel.org>;
	Tue, 18 Dec 2012 09:37:31 +0100 (CET)
Received: from [192.168.1.218] (p4FD06953.dip.t-dialin.net [79.208.105.83])
	(Authenticated sender: jens.rehpoehler@filoo.de)
	by mail-10.de-punkt.de (Postfix) with ESMTPSA id 30EA93A341
	for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 09:37:31 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB174CAFE63EB1182F4576D35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

i just received a mail of a customer. He reclaimed that the "ping
latency" of his VM rises, if he does a lot of IO
inside of the VM. I have done the same with a test VM.

I could reproduce this behavior. If i disable the rbd cache the VM IO is
slower but the latency is ok. Even SSH und other
programs are affected .... so its not a problem of slow ICMP.

Device Setting:

virtio0:
rbd:9997/vm-1171-disk-1.rbd:rbd_cache=3Dtrue:rbd_cache_size=3D16777216:rb=
d_cache_max_dirty=3D8388608:rbd_cache_target_dirty=3D4194304,cache=3Dnone=


normal ping:

64 bytes from 109.75.x.x: icmp_seq=3D38 ttl=3D56 time=3D29.2 ms
64 bytes from 109.75.x.x: icmp_seq=3D39 ttl=3D56 time=3D20.8 ms
64 bytes from 109.75.x.x: icmp_seq=3D40 ttl=3D56 time=3D22.4 ms

with lots of IO:

64 bytes from 109.75.x.x: icmp_seq=3D87 ttl=3D56 time=3D28.1 ms
64 bytes from 109.75.x.x: icmp_seq=3D88 ttl=3D56 time=3D665 ms
64 bytes from 109.75.x.x: icmp_seq=3D89 ttl=3D56 time=3D226 ms
64 bytes from 109.75.x.x: icmp_seq=3D90 ttl=3D56 time=3D179 ms
64 bytes from 109.75.x.x: icmp_seq=3D91 ttl=3D56 time=3D140 ms
64 bytes from 109.75.x.x: icmp_seq=3D92 ttl=3D56 time=3D25.6 ms
64 bytes from 109.75.x.x: icmp_seq=3D93 ttl=3D56 time=3D568 ms
64 bytes from 109.75.x.x: icmp_seq=3D94 ttl=3D56 time=3D405 ms
64 bytes from 109.75.x.x: icmp_seq=3D95 ttl=3D56 time=3D223 ms
64 bytes from 109.75.x.x: icmp_seq=3D96 ttl=3D56 time=3D24.5 ms
64 bytes from 109.75.x.x: icmp_seq=3D97 ttl=3D56 time=3D321 ms
64 bytes from 109.75.x.x: icmp_seq=3D98 ttl=3D56 time=3D391 ms
64 bytes from 109.75.x.x: icmp_seq=3D99 ttl=3D56 time=3D4200 ms
64 bytes from 109.75.x.x: icmp_seq=3D101 ttl=3D56 time=3D2194 ms

But if i disable caching:

virtio0: rbd:9997/vm-1171-disk-1.rbd:rbd_cache=3Dfalse,cache=3Dwriteback

with lots of IO:

64 bytes from 109.75.x.x: icmp_seq=3D62 ttl=3D56 time=3D22.1 ms
64 bytes from 109.75.x.x: icmp_seq=3D63 ttl=3D56 time=3D26.5 ms
64 bytes from 109.75.x.x: icmp_seq=3D64 ttl=3D56 time=3D30.7 ms
64 bytes from 109.75.x.x: icmp_seq=3D65 ttl=3D56 time=3D24.8 ms
64 bytes from 109.75.x.x: icmp_seq=3D66 ttl=3D56 time=3D21.9 ms

Can someone please explain me this behavior ? Why is the latency of the
VM spiky if i enable rbd caching ? I've played around with the caching
parameters
but with caching enabled its always the same.

KVM Version: 1.2.1
Ceph Version: ceph version 0.48.2argonaut
(commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)

Thanks a lot !!

--=20
mit freundlichen Gr=FCssen

Jens Rehp=F6hler

----------------------------------------------------------------------
filoo GmbH
Moltkestr. 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | Dr. C.Kunz
Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
Hotline: +49 5241 8673026| Fax: +49 5241 8673020

Folgen Sie uns auf:
Twitter: http://twitter.com/filoogmbh
Facebook: http://facebook.com/filoogmbh



--------------enigB174CAFE63EB1182F4576D35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDQK0oACgkQrXbD/qaJ+dPvcACeKoDXzGlreKassqualW/iqlzs
B0AAoJgLVA2AuvujoOcv9iZtdu1pocV8
=30Qa
-----END PGP SIGNATURE-----

--------------enigB174CAFE63EB1182F4576D35--
