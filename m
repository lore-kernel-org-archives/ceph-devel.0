From: Christian Kauhaus <kc@flyingcircus.io>
Subject: Re: [ceph-users] Blocked requests after "osd in"
Date: Fri, 11 Dec 2015 15:14:48 +0100
Message-ID: <566ADA58.3070905@flyingcircus.io>
References: <5667FC6E.5080600@flyingcircus.io>
 <B0751415-538E-471E-B310-76812C3C374C@schermer.cz>
 <56683B9E.8070201@flyingcircus.io>
 <CAANLjFqUoGTFSYrdwCwRw0apfXJN61SeS7FiXb0A_Bxtu4PJJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="w6fKRsIWeswEhu1uQsJwUm8bn9n3DsMJn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.gocept.net ([195.62.125.19]:52656 "EHLO mail.gocept.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbbLKOO4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Dec 2015 09:14:56 -0500
In-Reply-To: <CAANLjFqUoGTFSYrdwCwRw0apfXJN61SeS7FiXb0A_Bxtu4PJJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w6fKRsIWeswEhu1uQsJwUm8bn9n3DsMJn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 10.12.2015 um 06:38 schrieb Robert LeBlanc:
> Since I'm very interested in
> reducing this problem, I'm willing to try and submit a fix after I'm
> done with the new OP queue I'm working on. I don't know the best
> course of action at the moment, but I hope I can get some input for
> when I do try and tackle the problem next year.

Is there already a ticket present for this issue in the bug tracker? I th=
ink
this is an import issue.

Regards

Christian

--=20
Dipl-Inf. Christian Kauhaus <>< =C2=B7 kc@flyingcircus.io =C2=B7 +49 345 =
219401-0
Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
HR Stendal 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, Chri=
stian Zagrodnick


--w6fKRsIWeswEhu1uQsJwUm8bn9n3DsMJn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJWatpYAAoJEDxNM5Hh8d3oVC4H/1No7zWLMrGh1op1QQNv0Yu+
zDo3McDKpNPSp4xolcBRmbuj3ErAQY4xlNmNGftQdgk6dXWEYBxMVA04bDYj3Yq6
sGNncTG5uxjgSevgH6uWVhZgEE9R4RhEQQ2kXapKv+0dowd6US/6pSEpfqRynQ1o
xtd1fOrHoChuTmzHDK01fvKWZ+LnwtgQx+CRdU2Bgn0h2wp6IWNYoAxBfl/MHRkp
zjN/hlYc3Ov0NxgXVroG4VC70oYG4ojyyINNCus+iIZoOo8IonhBqTQGFGqsh3DN
tFKZDo/OpOnffyzChia+yxeyA4zD1K7GR1+SbtoZwnfhHStjjvg8oF+BerrNEKE=
=pc6w
-----END PGP SIGNATURE-----

--w6fKRsIWeswEhu1uQsJwUm8bn9n3DsMJn--
