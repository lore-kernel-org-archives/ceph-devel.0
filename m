From: Loic Dachary <loic@dachary.org>
Subject: Re: Backlog for the Ceph tracker
Date: Tue, 10 Nov 2015 16:45:59 +0100
Message-ID: <56421137.8080102@dachary.org>
References: <56420D01.1000708@dachary.org> <56420E8D.3060909@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DCfntWu3Fmbl2l87c7mkejBffGN2Ls9r5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58096 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753516AbbKJPqB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 10:46:01 -0500
In-Reply-To: <56420E8D.3060909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DCfntWu3Fmbl2l87c7mkejBffGN2Ls9r5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/11/2015 16:34, Loic Dachary wrote:
> But http://tracker.ceph.com/projects/ceph/agile_versions looks better :=
-)

It appears to be a crippled version of a proprietary product http://www.r=
edminecrm.com/projects/agile/pages/last

My vote would be to de-install it since it is even less flexible to use t=
han the custom query below. It is disapointing to loose a plugin because =
it is no longer maintained, but that's not something we can always forsee=
=2E IMHO, relying on a proprietary redmine plugin is not a safe bet and i=
t would be wise to not become dependent on it.

Cheers

> On 10/11/2015 16:28, Loic Dachary wrote:
>> Hi Sam,
>>
>> I crafted a custom query that could be used as a replacement for the b=
acklog plugin
>>
>>    http://tracker.ceph.com/projects/ceph/issues?query_id=3D86
>>
>> It displays issues that are features or tasks, grouped by target versi=
on and ordered by priority.
>>
>> I also created a v10.0.0 version so we can assign features we want for=
 this next version to it.
>>
>> If you feel that's not good enough, we can just throw it away, it's me=
rely a proposal ;-)
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--DCfntWu3Fmbl2l87c7mkejBffGN2Ls9r5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZCETcACgkQ8dLMyEl6F217VwCfepELmsd0vB7JX+gCW7IzT7/d
8ncAniymINwUBpOTz6nGgB8hViE1euxp
=HHB1
-----END PGP SIGNATURE-----

--DCfntWu3Fmbl2l87c7mkejBffGN2Ls9r5--
