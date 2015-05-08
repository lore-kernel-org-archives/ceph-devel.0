From: Loic Dachary <loic@dachary.org>
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 08 May 2015 17:13:36 +0200
Message-ID: <554CD2A0.3040101@dachary.org>
References: <554C7CE5.4070600@dachary.org> <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com> <554CC970.3040701@dachary.org> <209815215.14051495.1431097392961.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eM0w8xb96NAJdkq7a3x03xiuGhDl3Rp4p"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59989 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752699AbbEHPNi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 11:13:38 -0400
In-Reply-To: <209815215.14051495.1431097392961.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eM0w8xb96NAJdkq7a3x03xiuGhDl3Rp4p
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/05/2015 17:03, Jason Dillaman wrote:
> Since it sounds like the next hammer release is more or less ready, my =
vote would be that the fix can wait until the next release.  Since it wil=
l only occur if the new exclusive lock feature is enabled (disabled on im=
ages by default) and the connection between librbd and the OSD is reset w=
ith writeback data waiting in the cache, it sounds like a rare enough iss=
ue.
>=20
> Final decision rests w/ Josh.

Ok :-) Would you be so kind as to point me to the corresponding issue in =
the tracker for reference ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--eM0w8xb96NAJdkq7a3x03xiuGhDl3Rp4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVM0qAACgkQ8dLMyEl6F20hUQCdGvd3RpspbeC4nb6LQCVnDZZm
c9UAoMNojUHWItTvLwP1BWbW054OMvBs
=U52O
-----END PGP SIGNATURE-----

--eM0w8xb96NAJdkq7a3x03xiuGhDl3Rp4p--
