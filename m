From: Loic Dachary <loic@dachary.org>
Subject: Pyramid Erasure Code plugin (draft)
Date: Fri, 17 Jan 2014 10:48:10 +0100
Message-ID: <52D8FC5A.5090905@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WOWA8evwF137hNlpNhjjnUU049oPKHnsn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46197 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbaAQJsM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 04:48:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WOWA8evwF137hNlpNhjjnUU049oPKHnsn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

I spent some time this week trying to figure out something that would be =
reasonably generic, readable from the sysadmin point of view and simple t=
o implement. The input of the plugin is here:

http://tracker.ceph.com/issues/7146#note-1

The json structure describes the pyramid and associates an erasure code m=
ethod with each layer, including parameters. The mapping describes how ch=
unks relate to the list of OSDs obtained from crush. For instance in |^00=
0111^| the | are ignored ( whitespace is confusing because it's not easy =
to figure out visually how many of them there are ), ^ marks a coding chu=
nk, any other character is a data chunk. The pyramid encoding function re=
ads this and encode the first three data chunks with one coding chunk. Th=
e re-ordering of the chunks is done by the pyramid code and the underlyin=
g erasure code method does not need to know anything about it. There is n=
o copy involved, it re-orders pointers ( bufferptr ).

Here is a draft (not compiling not working but the logic looks right to m=
e) implementation:

encode :=20
https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCodePlugi=
nPyramid/ErasureCodePyramid.cc#L250

decode :=20
https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCodePlugi=
nPyramid/ErasureCodePyramid.cc#L367

The plugins for each layer would be loaded at init time :

https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCodePlugi=
nPyramid/ErasureCodePyramid.cc#L83

with as much consistency checks as possible, for instance:

https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCodePlugi=
nPyramid/ErasureCodePyramid.cc#L102

so that runtime can assume constraints are enforced. Please let me know i=
f you see something that does not look right, this is a draft, it can be =
reworked 100% ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--WOWA8evwF137hNlpNhjjnUU049oPKHnsn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLY/FoACgkQ8dLMyEl6F20A4ACePvy4dX+H7dkcYxhWkLP+7qaV
7W8AoLvJBMa/nsGBnctJIOltWDz3MyXT
=wdjh
-----END PGP SIGNATURE-----

--WOWA8evwF137hNlpNhjjnUU049oPKHnsn--
