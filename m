From: Loic Dachary <loic@dachary.org>
Subject: Re: conditions for removing experimental feature marks
Date: Mon, 16 Feb 2015 10:16:47 +0100
Message-ID: <54E1B57F.3070201@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA6CEB8@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ArvWSBUGgScciqxep3FNeoS05dT3rPttB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44550 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755240AbbBPJQx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Feb 2015 04:16:53 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA6CEB8@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ArvWSBUGgScciqxep3FNeoS05dT3rPttB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/02/2015 08:37, Miyamae, Takeshi wrote:
> Dear Loic,
>=20
> Thank you for your help on the pull request of SHEC last week.
> We believe that marking experimental feature on SHEC was inevitable and=

> the way to restrict the feature is proper.
>=20
> By the way, could you let us know what are the conditions for removing
> experimental feature marks in the future?
> Are additional thorough tests required?

The next step is to run integration tests with the shec plugin. The integ=
ration tests have shown that the shec plugin does not disrupt anything. N=
ow we should check if it works properly under stress and upgrades. I crea=
ted two tickets for that purpose:

http://tracker.ceph.com/issues/10886 : integration / theuthology integrat=
ion / theuthology thrasher tests for the shec erasure code plugin
http://tracker.ceph.com/issues/10887 : erasure-code: allow upgrades for s=
hec plugins

It would be fantastic if you could work on http://tracker.ceph.com/issues=
/7291 : it would make the integration of new erasure code plugins easier.=
 I realize that it is infrastructure work not directly of interest to the=
 shec plugin implementation.

Running teuthology locally is non trivial, maybe we can provide you with =
access to the community lab so that you can run teuthology suites against=
 the existing teuthology cluster (i.e. http://pulpito.ceph.com/). Would y=
ou like me to ask ?=20

Cheers

> Best regards,
> Takeshi Miyamae
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ArvWSBUGgScciqxep3FNeoS05dT3rPttB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlThtX8ACgkQ8dLMyEl6F22D2ACfWNKJKNfKUKmaYVPo5YzmivQP
Ff0AoJwX66+fqEnhOB19Jmpe4V3CUCOs
=TAno
-----END PGP SIGNATURE-----

--ArvWSBUGgScciqxep3FNeoS05dT3rPttB--
