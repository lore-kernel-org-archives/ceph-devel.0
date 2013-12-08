From: Loic Dachary <loic@dachary.org>
Subject: Re: Forced push to master
Date: Mon, 09 Dec 2013 00:53:45 +0100
Message-ID: <52A50689.4070904@dachary.org>
References: <52A4F9F7.8010007@dachary.org> <52A4FCC2.20902@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NOrr3HMbwoelEn2wTHTnrtDNVBrg1mb35"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34279 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3LHXxr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Dec 2013 18:53:47 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id BE69F26394
	for <ceph-devel@vger.kernel.org>; Mon,  9 Dec 2013 00:53:45 +0100 (CET)
In-Reply-To: <52A4FCC2.20902@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NOrr3HMbwoelEn2wTHTnrtDNVBrg1mb35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 09/12/2013 00:12, Loic Dachary wrote:
>=20
>=20
> On 09/12/2013 00:00, Loic Dachary wrote:
>> Hi,
>>
>> I accidentally forced push to ceph master at 11pm CEST 8 december 2013=
 the following:
>>
>> https://github.com/ceph/ceph/commit/17e0a7b2942899e3f4307bf3e9c41bcb43=
04619d
>> https://github.com/ceph/ceph/commit/d5e44cf8b233e517d8f7f26cd556ad0ac1=
5714c1
>> https://github.com/ceph/ceph/commit/71f820503a96cafa9e99cca047c3183c37=
5408a8
>> https://github.com/ceph/ceph/commit/eefeb0e0ad54fe0179cbf71335a45ea17c=
0fa23b
>> https://github.com/ceph/ceph/commit/8253ff1e0b3b3a1680293c75f015a5cf5f=
5e34c6
>>
>> and may have discarded commits done after:
>>
>> https://github.com/ceph/ceph/commit/94da2153d1e131205c0e5e32601d0b6a9f=
6a3cfd
>>
>> which is a merge dated
>>
>> Date:   Sat Dec 7 20:59:22 2013 -0800
>>
>> I apologize for the inconvenience and trying to figure out more.
>=20
> http://gitbuilder.sepia.ceph.com/gitbuilder-quantal-amd64/#origin/maste=
r
>=20
> shows:
>=20
> BUILDING 	17e0a7b 	loic 	build log osd/OSDMap: add feature bit for TUNA=
BLES3 (=3D=3D CRUSH_V2)
> 	(Pending) 	d5e44cf 	loic 	mon/OSDMonitor: allow setting 'firefly' tuna=
bles
> 	...3... 	=09
> Warn 	94da215 	sage 	Warnings(1) Merge pull request #869 from ceph/wip-=
crush=20
>=20
> since gitbuilder reacts to every commit to master and that it did not p=
ick anything between 94da215 and the forced push, it is somewhat reassuri=
ng that no commit were lost. But I'm trying to find a way to be sure.
>=20

https://github.com/ceph/ceph/pulls?direction=3Ddesc&page=3D1&sort=3Dupdat=
ed&state=3Dclosed

shows the latest merges to master, most recent first. The most recent is =
again

https://github.com/ceph/ceph/pull/869 i.e. 94da215

If a commit was lost it was not done via the github interface.

>>
>> Cheers
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NOrr3HMbwoelEn2wTHTnrtDNVBrg1mb35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKlBokACgkQ8dLMyEl6F21IDACeK6G+s9SDl4gWYhwEKhEeI6Bz
x3kAmQF28G1pZuH9XhbfkZV7JFFMgCgi
=sQfW
-----END PGP SIGNATURE-----

--NOrr3HMbwoelEn2wTHTnrtDNVBrg1mb35--
