From: Loic Dachary <loic@dachary.org>
Subject: Re: tracker.ceph.com API
Date: Thu, 08 Jan 2015 15:46:23 +0100
Message-ID: <54AE983F.1040201@dachary.org>
References: <54ABC3E5.7040704@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XRmHIPGftFMuqxiknir5L5UC951n4nxR1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35393 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753877AbbAHOq1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jan 2015 09:46:27 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 076D7420B2
	for <ceph-devel@vger.kernel.org>; Thu,  8 Jan 2015 15:46:23 +0100 (CET)
In-Reply-To: <54ABC3E5.7040704@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XRmHIPGftFMuqxiknir5L5UC951n4nxR1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I was able to log on drop.ceph.com and check the logs at /home/cephtracke=
r/tracker.ceph.com/log but it shows (I tried basic auth instead of the ke=
y):

Started PUT "/issues/10281.xml" for 87.98.243.87 at 2015-01-08 06:39:15 -=
0800
Processing by IssuesController#update as XML
  Parameters: {"id"=3D>"10281"}
WARNING: Can't verify CSRF token authenticity
  Current user: loic (id=3D789)
  Rendered queries/_filters.html.erb (19.6ms)
  Rendered queries/_columns.html.erb (2.0ms)
  Rendered issues/_list.html.erb (143.5ms)
  Rendered issues/_sidebar.html.erb (7.2ms)
  Rendered issues/index.html.erb within layouts/base (189.0ms)
  Rendered plugins/redmine_backlogs/app/views/hooks/_rb_include_scripts.h=
tml.erb (3.1ms)
  Rendered text template (0.0ms)
Completed 200 OK in 317ms (Views: 0.6ms | ActiveRecord: 21.0ms)
Completed 200 OK in 652ms (Views: 408.8ms | ActiveRecord: 64.7ms)

which seems fine (except it does nothing ;-). I don't have enough redmine=
 expertise to debug this further. Could the "WARNING" really be a fatal e=
rror ?

Cheers

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


--XRmHIPGftFMuqxiknir5L5UC951n4nxR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSumD8ACgkQ8dLMyEl6F204WgCffuv919dBwGzKn5QL3P0c/Afm
K/8AoI4NZedOxzePz6Wo/vzeGHe+wKfS
=Texo
-----END PGP SIGNATURE-----

--XRmHIPGftFMuqxiknir5L5UC951n4nxR1--
