From: Loic Dachary <loic@dachary.org>
Subject: Re: Some gitbuilders not working
Date: Fri, 09 Jan 2015 11:33:33 +0100
Message-ID: <54AFAE7D.5070402@dachary.org>
References: <54AF7B4C.6010305@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="V3N4RVGGnCEm64fw6vL8dTvPGKJfiVXPT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35878 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757331AbbAIKdg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 05:33:36 -0500
In-Reply-To: <54AF7B4C.6010305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V3N4RVGGnCEm64fw6vL8dTvPGKJfiVXPT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi David,

On 09/01/2015 07:55, David Zafman wrote:
>=20
> We are seeing gitbuilder failures.  This is what I saw on one.
>
> error: Failed build dependencies:
> xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64

This is because https://github.com/ceph/ceph/pull/3036 was recently merge=
d. However, https://github.com/ceph/autobuild-ceph/pull/19 added xmlstarl=
et about a month ago. Maybe some gitbuilder machines were not updated acc=
ordingly. If I'm not mistaken this is a manual process but I'm not sure e=
xactly how to do it myself.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--V3N4RVGGnCEm64fw6vL8dTvPGKJfiVXPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSvrn0ACgkQ8dLMyEl6F22orACdHmkLM6gD8+fNdyiEDHrruIGz
AT8AnRaR39VoRr0jFihWJ7r5ZjmPDkQ3
=MNR9
-----END PGP SIGNATURE-----

--V3N4RVGGnCEm64fw6vL8dTvPGKJfiVXPT--
