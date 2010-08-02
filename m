From: Jonathan Dieter <jdieter@lesbg.com>
Subject: Re: how to build rpm for ceph 0.21 on Fedora
Date: Mon, 02 Aug 2010 11:58:06 +0300
Message-ID: <1280739486.2280.27.camel@jdlaptop.lesbg.loc>
References: <AANLkTimgak-e4vEs6omRssohcm5RJKm8LKV+uYPzKcTR@mail.gmail.com>
	 <1280739272.2280.25.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-UVfzRFL1bztTY7upe31c"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41653 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab0HBI6L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 04:58:11 -0400
Received: by fxm14 with SMTP id 14so1576941fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 01:58:10 -0700 (PDT)
In-Reply-To: <1280739272.2280.25.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


--=-UVfzRFL1bztTY7upe31c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-08-02 at 11:54 +0300, Jonathan Dieter wrote:
> I'd suggest using the builds at
> http://koji.fedoraproject.org/koji/packageinfo?packageID=3D10264 as a
> starting point.  Download the src rpm, install it, download the new
> sources and stick them in your ~/rpmbuild/SOURCES directory, update
> the .spec file to point to the new sources, and rpmbuild -ba
> ceph.spec. =20

Sorry for the duplicate emails, I thought the mailing list wouldn't take
the first email from a non-subscribed account.

Jonathan

--=-UVfzRFL1bztTY7upe31c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkxWiJ4ACgkQH3CnpFdSY1yvuACfca/Z1X+un6nqOoLpsC2M43Zn
Lc4AoM445BAYXL8egau5A1osEcFsQ01Q
=TE/R
-----END PGP SIGNATURE-----

--=-UVfzRFL1bztTY7upe31c--

