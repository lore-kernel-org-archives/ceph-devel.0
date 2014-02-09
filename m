From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 0/4] Ceph fixes for 3.12.y
Date: Sun, 09 Feb 2014 18:49:59 +0000
Message-ID: <1391971799.25202.78.camel@deadeye.wl.decadent.org.uk>
References: <1388448831-10324-1-git-send-email-sage@inktank.com>
	 <20131231051551.GA29973@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-rJzRkqL2tEn1LsD8Bpmb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41289 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375AbaBISuF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Feb 2014 13:50:05 -0500
In-Reply-To: <20131231051551.GA29973@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: stable@vger.kernel.org, ceph-devel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>


--=-rJzRkqL2tEn1LsD8Bpmb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-12-30 at 21:15 -0800, Greg KH wrote:
> On Mon, Dec 30, 2013 at 04:13:47PM -0800, Sage Weil wrote:
> > Hi,
> >=20
> > These patches are for 3.12.y stable.  All have been retested and
> > reference the original commit.  They can also be pulled from
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git fo=
r-stable-3.12.5
> >=20
> > if that is preferred.
>=20
> Now applied, and I also added patches 2 and 3 to the 3.10 and 3.4-stable
> trees as well.  If that was incorrect, please let me know.

I've also queued up those two for 3.2.

Ben.

--=20
Ben Hutchings
If at first you don't succeed, you're doing about average.

--=-rJzRkqL2tEn1LsD8Bpmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAUvfN1+e/yOyVhhEJAQpYQA/5AVFdmzCBpUZcoOFVJJReDt0O9n960NEZ
hCifJ38NWv9cBY1Cu7L3ksfMB2tMN65cI1Y2amapqtUmOPMJ7xGWLXpJyJ9og0vQ
s3fOkt8Bsos+LnUhR0Hfndubl5gFJVJizc0W4FiqKLrUNroQWkoUMRshqwi0Xw3S
2VRTFoR0fQ2ddS8wrcgYb6YHpxPqERnSxrVybNPIMGMqlsilyzMXlx7Srk+Ujwk0
r1561lkcxgkKYbwPlthspajEDQbiqwezEiiugLnij0egVPwmku7ydEPoKjC8SUAH
LbyABD1uOI8o85hQdfFY6X6ChI+LqpqPU5BS1IMDPAtLBhcZvAAqrrAw9a9aRokI
D1JCTuwUMjaRMIP+eo8vJ0JTods53IPM3c9xxhh5UVMvGgk66mHl7/uEW0RV6Ko7
U+rWqalWEsDD6YyfiXLG6qwYvBz3s6jVhTrCQ40Xjq8hwoBOtsagSgvRxJjc4ytS
Lvn2TxU/wW+ykGO7eOAhHuHqfR6+K6zP7y+F2OnAcnL3tfiSxVAnUAH2WiKbcrOJ
zuxL1tsm0GJzaLAHO9OoLhuqRtF4egnqzTZ1D4JZxX/ke9rxYOvOmfM2jJgAcqKH
KFCABPRdKWNt1F30Dv/B7zWZdZctMyWHJ4TJ+LAZ2yqtIxNpeBrxfzJi8jXyJrwI
zkALo+jeu5I=
=0RV3
-----END PGP SIGNATURE-----

--=-rJzRkqL2tEn1LsD8Bpmb--
