From: Loic Dachary <loic@dachary.org>
Subject: Re: git submodule deinit
Date: Fri, 06 Mar 2015 18:17:22 +0100
Message-ID: <54F9E122.6080304@dachary.org>
References: <54F8C745.7030508@dachary.org> <54F8E1D5.4090104@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rQM08AIHpXX9oIvDR5f6CrMXNlcSQdfR8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54012 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbbCFRRZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Mar 2015 12:17:25 -0500
In-Reply-To: <54F8E1D5.4090104@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rQM08AIHpXX9oIvDR5f6CrMXNlcSQdfR8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Danny,

On 06/03/2015 00:08, Danny Al-Gaaf wrote:
> Am 05.03.2015 um 22:14 schrieb Loic Dachary:
>> Hi Danny,
>>
>> Unfortunately it looks like submodule deinit requires a version of
>> git that's not in precise.
>>
>> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-bas=
ic/log.cgi?log=3D9a0ac62a9cf27573d5345143a3bc6c6b737031db
>>
>>  + git submodule deinit -f .
>>
>> error: pathspec 'deinit' did not match any file(s) known to git.
>>
>> error: pathspec '-f' did not match any file(s) known to git.
>>
>> I'll revert that and go back to rm until we find a better way.
>=20
> 'git submodule deinit' was introduced in git 1.8.2(-rc3), 4. Mar 2013,
> it is quite old, the upcoming git version is 2.3.2.

$ git --version
git version 1.7.9.5

>=20
> Which version is used in precise? The code of deinit is only a script.
> This may could also be integrated in the existing gitbuilder code as a
> helper function. if there is no way to update git to an newer version.

Adding such a helper to autobuild-ceph/build-ceph.sh & all to get rid of =
the explicit rm would be a great idea.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--rQM08AIHpXX9oIvDR5f6CrMXNlcSQdfR8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT54SIACgkQ8dLMyEl6F23HNACfcKsduWjMAHsnUTyppijtG7GK
Wr0AnRlkA/Yh0GMscgpu64+K4rGSn9Gq
=Hly2
-----END PGP SIGNATURE-----

--rQM08AIHpXX9oIvDR5f6CrMXNlcSQdfR8--
