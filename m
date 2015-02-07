From: Loic Dachary <loic@dachary.org>
Subject: Re: tracker.ceph.com API
Date: Sat, 07 Feb 2015 10:06:58 +0100
Message-ID: <54D5D5B2.8060203@dachary.org>
References: <54ABC3E5.7040704@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="R0otRT8aeTg8CEIThm38ShtlBlH7GTXoB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40207 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751405AbbBGJHA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Feb 2015 04:07:00 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 5481A420B5
	for <ceph-devel@vger.kernel.org>; Sat,  7 Feb 2015 10:06:58 +0100 (CET)
In-Reply-To: <54ABC3E5.7040704@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0otRT8aeTg8CEIThm38ShtlBlH7GTXoB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/01/2015 12:15, Loic Dachary wrote:
> Hi,
>=20
> I tried various things to update tracker.ceph.com from the command line=
 but failed. The best result I have is the following:
>=20
> cat /tmp/a.xml
>=20
> <issue>
>   <id>10281</id>
>   <subject>firefly: make check fails on fedora 20 (1)</subject>
>   <custom_fields type=3D"array">
>     <custom_field name=3D"Backport" id=3D"2">
>       <value>firefly</value>
>     </custom_field>
>   </custom_fields>
> </issue>
>=20
> curl --http1.0 --verbose -T /tmp/a.xml http://tracker.ceph.com/issues/1=
0281.xml?key=3Dcd9a99820b4e7543a

The content-type was missing:

curl --http1.0 --verbose --header 'Content-type: application/xml' -T /tmp=
/a.xml http://tracker.ceph.com/issues/10281.xml?key=3Dcd9a99820b4e7543a

works :-)

>=20
> * Hostname was NOT found in DNS cache
> *   Trying 64.90.32.38...
> * Connected to tracker.ceph.com (64.90.32.38) port 80 (#0)
>> PUT /issues/10281.xml?key=3Dcd9a99820b4e7543a3c HTTP/1.0
>> User-Agent: curl/7.35.0
>> Host: tracker.ceph.com
>> Accept: */*
>> Content-Length: 239
>>
> * We are completely uploaded and fine
> < HTTP/1.1 200 OK
> < Date: Tue, 06 Jan 2015 11:05:55 GMT
> * Server Apache/2.2.22 (Ubuntu) is not blacklisted
> < Server: Apache/2.2.22 (Ubuntu)
> < X-Powered-By: Phusion Passenger (mod_rails/mod_rack) 3.0.13
> < X-UA-Compatible: IE=3DEdge,chrome=3D1
> < Cache-Control: no-cache
> < X-Request-Id: eb302e17961997bafade5739f48a7183
> < X-Runtime: 1.375926
> < X-Rack-Cache: invalidate, pass
> < Set-Cookie: _redmine_session=3DBAh7BkkiD3Nlc3Npb25faWQGOgZFRkkZTIwY2Y=
5NWYzYTE5BjsAVA%3D%3D--a2a2fd48f300f5c8c9; path=3D/; HttpOnly
> < Set-Cookie: autologin=3D; path=3D/; expires=3DThu, 01-Jan-1970 00:00:=
00 GMT
> < Status: 200
> < Content-Length: 0
> < Connection: close
> < Content-Type: application/xml; charset=3Dutf-8
> <
> * Closing connection 0
>=20
> but most of the time I get:
>=20
> * Hostname was NOT found in DNS cache
> *   Trying 64.90.32.38...
> * Connected to tracker.ceph.com (64.90.32.38) port 80 (#0)
>> PUT /issues/10281.xml?key=3Dcd9a99820b4e7543a3ce82febce4970b3dfb6b86 H=
TTP/1.0
>> User-Agent: curl/7.35.0
>> Host: tracker.ceph.com
>> Accept: */*
>> Content-Length: 239
>>
> * We are completely uploaded and fine
> * Empty reply from server
> * Connection #0 to host tracker.ceph.com left intact
>=20
> Am I doing something wrong ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--R0otRT8aeTg8CEIThm38ShtlBlH7GTXoB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTV1bIACgkQ8dLMyEl6F21vnwCgxWYZTS6mf+W62uL7G6OqQO6P
ct4AoLqY0Gq32ONWr6nFUvu9Bj+Ud7v5
=o2X0
-----END PGP SIGNATURE-----

--R0otRT8aeTg8CEIThm38ShtlBlH7GTXoB--
