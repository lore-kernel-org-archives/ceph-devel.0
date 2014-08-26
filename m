From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Tue, 26 Aug 2014 19:29:22 +0530
Message-ID: <87ha0zibjk.fsf@gmail.com>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com> <CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com> <alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net> <CANA9Uk468XOE1cr935HY1y+tSnu-xp6QPaj7uCpZNQbJhg-pOA@mail.gmail.com> <CABBk=J8+3K28M-RNf+ULx0TnTMmGxdymJDLeFMft-EX8PhS_4A@mail.gmail.com> <CANA9Uk58WqPoH-mGiuNiXwfJK1YJtozxOjhgmDeKDq585xqx9w@mail.gmail.com> <CANA9Uk5u5q4CGDPat+rdPVY=e-bYA6gG+aii6zMAoxUdK+CQuA@mail.gmail.com> <CABBk=J9Au5aX7AKnbM5d=1HOpd2EAdcteyn=uNSZ2jn9UK9HJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:51631 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758316AbaHZOOv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Aug 2014 10:14:51 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so22190671pdj.15
        for <ceph-devel@vger.kernel.org>; Tue, 26 Aug 2014 07:14:50 -0700 (PDT)
In-reply-to: <CABBk=J9Au5aX7AKnbM5d=1HOpd2EAdcteyn=uNSZ2jn9UK9HJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: M Ranga Swami Reddy <swamireddy@gmail.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Yehuda Sadeh writes:

> At the moment we don't support this api call. Adding it should be
> pretty easy, and it's definitely something that could be done with the
> help of a willing community member.
>
> Yehuda
>
Hi,

I have a basic implementation for S3 get bucket location, which returns
the region of the bucket.[1] For the "default" region it returns the
empty string similiar to s3 (which returns empty string for the
"default" us-east region).=20

Please let me know whether this is acceptable (or if I have missed
something obvious), and what else needs to be done in order to get this
in. Once I have a review on code I'll try to update the docs & examples
regarding this call.


[1] https://github.com/ceph/ceph/pull/2329

Thanks
=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJT/JYQAAoJEPnwZB8bZe1fqVcH+gPP+tjmU0MZgAYHrT1EEJ5z
ItDnLd341Ll5ld1DbrPwpw3Rttwo5AmxBDBgpErMULEAnbhzelLyGOjrSghQeBSx
HyazQPThAh0hNWFckVRcIaepPEQkNaTgY47YraCm79vItVoYBN8pPkVxIPMwT1Rd
AAMH/4hepPd/OvoS8sBq/GYZJe/xeyeH497u/vZC9aQKRnmjcUxDqdc3r2als9Uf
PBWWSfKO7ADJsrZwsX75WU2KmMsbuKrY8XV4iLfP3l0aGcNi0XJQdBaq2Bh1B0kZ
Wyy1dMJ9jhMZyYRF5HJj8u89+thW7hh9sgKxf7n2oDrANk+XZwYpkOFMh0hVmvk=
=qSLE
-----END PGP SIGNATURE-----
--=-=-=--
