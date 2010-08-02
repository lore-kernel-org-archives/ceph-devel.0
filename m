From: Jonathan Dieter <jdieter@gmail.com>
Subject: Re: how to build rpm for ceph 0.21 on Fedora
Date: Mon, 02 Aug 2010 11:51:07 +0300
Message-ID: <1280739067.2280.24.camel@jdlaptop.lesbg.loc>
References: <AANLkTimgak-e4vEs6omRssohcm5RJKm8LKV+uYPzKcTR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-k6+w1iNn+Vx/mmaQdBNN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58103 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab0HBIvM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 04:51:12 -0400
Received: by fxm14 with SMTP id 14so1575100fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 01:51:10 -0700 (PDT)
In-Reply-To: <AANLkTimgak-e4vEs6omRssohcm5RJKm8LKV+uYPzKcTR@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


--=-k6+w1iNn+Vx/mmaQdBNN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-08-02 at 16:32 +0800, Xiaoguang Liu wrote:
> This may be a silly question, but I am really not a developer.
>=20
> The wiki has an article, but it is out of date and not apply very well.
>=20
> Can anyone enlight me on this?

I'd suggest using the builds at
http://koji.fedoraproject.org/koji/packageinfo?packageID=3D10264 as a
starting point.  Download the src rpm, install it, download the new
sources and stick them in your ~/rpmbuild/SOURCES directory, update
the .spec file to point to the new sources, and rpmbuild -ba
ceph.spec. =20

If there are any problems, either post to the list or email the
maintainer.

FWIW, the maintainer has been very responsive to update requests when
I've emailed him, so maybe you just want to email him asking him to
update.

Jonathan


--=-k6+w1iNn+Vx/mmaQdBNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkxWhvsACgkQH3CnpFdSY1xlKACeK/AfGVzwJanxo6y8xlU/Qk/9
ge0AnjmjoSJ9wWqGdCKTSaCOR99euUAI
=aOYF
-----END PGP SIGNATURE-----

--=-k6+w1iNn+Vx/mmaQdBNN--

