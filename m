From: Loic Dachary <loic@dachary.org>
Subject: Re: preparing v0.80.11
Date: Tue, 26 May 2015 22:44:43 +0200
Message-ID: <5564DB3B.2050208@dachary.org>
References: <5562DEEC.5060602@dachary.org> <5564D772.9080909@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uSMwQtimS2VB89IUwOJ7nXVJr5VNBq2QB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51304 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752089AbbEZUop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 16:44:45 -0400
In-Reply-To: <5564D772.9080909@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uSMwQtimS2VB89IUwOJ7nXVJr5VNBq2QB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

https://github.com/ceph/ceph/commits/firefly-backports has been reset wit=
h https://github.com/SUSE/ceph/commits/firefly-backports and http://ceph.=
com/gitbuilder.cgi are building it.

Cheers

On 26/05/2015 22:28, Nathan Cutler wrote:
> Hi Loic:
>=20
> The first round of 0.80.11 backports, including all trivial backports (=
where "trivial" is defined as those I was able to do by myself without he=
lp), is now ready for integration testing in the "firefly-backports" bran=
ch of the SUSE fork:
>=20
> https://github.com/SUSE/ceph/commits/firefly-backports
>=20
> The non-trivial backports (on which I hereby solicit help) are:
>=20
> http://tracker.ceph.com/issues/11699 Objecter: resend linger ops on spl=
it
> http://tracker.ceph.com/issues/11700 make the all osd/filestore thread =
pool suicide timeouts separately configurable
> http://tracker.ceph.com/issues/11704 erasure-code: misalignment
> http://tracker.ceph.com/issues/11720 rgw deleting S3 objects leaves __s=
hadow_ objects behind
>=20
> Nathan

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uSMwQtimS2VB89IUwOJ7nXVJr5VNBq2QB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVk2zsACgkQ8dLMyEl6F20KkgCfU07SjDg+2tnThkNQId+ld+Cw
KFUAmwRasZh9IdfTI1uEFj/neTEBWOa0
=Y1y/
-----END PGP SIGNATURE-----

--uSMwQtimS2VB89IUwOJ7nXVJr5VNBq2QB--
