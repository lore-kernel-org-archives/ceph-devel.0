From: Loic Dachary <loic@dachary.org>
Subject: Re: git submodule deinit
Date: Thu, 05 Mar 2015 23:30:10 +0100
Message-ID: <54F8D8F2.6020808@dachary.org>
References: <54F8C745.7030508@dachary.org> <54F8C90E.8070906@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="v3vNUKHcMSciOpIVT5MqtOkqTO5vpdjVv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53548 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbbCEWaO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 17:30:14 -0500
In-Reply-To: <54F8C90E.8070906@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v3vNUKHcMSciOpIVT5MqtOkqTO5vpdjVv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/03/2015 22:22, Ken Dreyer wrote:
> On 03/05/2015 02:14 PM, Loic Dachary wrote:
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
>>
>> Cheers
>>
>=20
> I recently discovered that some of the gitbuilders (at least the Red
> Hat-based ones) use a git version 1.8.5.3 built directly from source
> and installed into /srv.
>=20
> https://github.com/ceph/autobuild-ceph/blob/master/fabfile.py#L1078
>=20
> The packager side of me cannot stop my eyebrow from involuntarily
> twitching at this, but the hacker side of me suspects you may be able
> to just call this install_git() function on Ubuntu Precise.

Thanks for the hint !

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--v3vNUKHcMSciOpIVT5MqtOkqTO5vpdjVv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT42PIACgkQ8dLMyEl6F21CAACgp8tiJvVyXTj9263JCOp4byii
JGQAnAkFB5JMtkcjVkqQ9tibSXNBJCZ/
=nac9
-----END PGP SIGNATURE-----

--v3vNUKHcMSciOpIVT5MqtOkqTO5vpdjVv--
