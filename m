From: Loic Dachary <loic@dachary.org>
Subject: controlling which OSD goes to which PG / testing a fix
Date: Mon, 11 May 2015 13:51:08 +0200
Message-ID: <555097AC.6000000@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WKSKPSoSQfwDr8cnsjba3XCx7upgXj5hf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32861 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753179AbbEKLvL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 07:51:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shylesh Kumar <shmohan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WKSKPSoSQfwDr8cnsjba3XCx7upgXj5hf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry I did not get a chance to answer in time to your question on IRC.=20

<shylesh> loicd: a ruleset having  {step take osd.0
<shylesh>         step emit
<shylesh> }  should choose osd.0 for all pgs right=20
<shylesh> wats the error with this crushmap ruleset http://pastebin.com/y=
Xn1t4sU
<shylesh> i want all pgs to be on [0,1,3] which is working as expected
<shylesh> but if 3 goesdown i want it to be [0,1,4] .. this is not happen=
ing=20
<loicd> shylesh: hi !
<loicd> shylesh: looking at http://pastebin.com/yXn1t4sU (answering here =
because that's the channel where non dev questions are best archived)
<loicd> shylesh: that's a very unusual crush map. You want to precisely c=
ontrol the order in which the OSDs are assigned to a placement group, is =
that right ?=20
<loicd> If that's so, maybe your use case would be better served by other=
 means. What are you trying to achieve ? Measure the bandwidth between OS=
Ds during repair maybe ?=20
<shylesh> loicd: I want one group of PG mapped to [0,1,3] and another gro=
up of pgs(may be from different pool) mapped to [0,1,2] and I will mark 3=
 as out and 2 as down=20
<shylesh> so that new group becomes [0,1,4] , osd4 will have degraded and=
 misplaced pgs to get mapped
<shylesh> there is a fix i want to test , degraded pgs should get priorit=
y over misplaced pgs
<shylesh> so now i want to see on osd4 degraded will be recovered first a=
nd then misplaced
<shylesh> now the mapping is working fine but if suppose 2 goes down i wi=
ll be left with [0,1] for some reason 4 is not joining the replica group

Could you show the fix that you want to test ? I may be able to figure ou=
t a simpler strategy to verify that it does what is expected.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WKSKPSoSQfwDr8cnsjba3XCx7upgXj5hf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVQl6wACgkQ8dLMyEl6F21xJACbBq9EG5O3uBdWkxABywmrGqnC
giQAoIcu4p0lBJ3UN8NvUgYWUZuc6+4D
=5DSe
-----END PGP SIGNATURE-----

--WKSKPSoSQfwDr8cnsjba3XCx7upgXj5hf--
