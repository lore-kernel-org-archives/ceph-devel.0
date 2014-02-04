From: Loic Dachary <loic@dachary.org>
Subject: Re: controlling erasure code chunk size
Date: Tue, 04 Feb 2014 17:17:55 +0100
Message-ID: <52F112B3.6050502@dachary.org>
References: <52EE6128.209@dachary.org>	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>	<CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>	<3472A07E6605974CBC9BC573F1BC02E4AE6C12B4@CERNXCHG41.cern.ch> <CA+4uBUYROX1gWuBzkUgxTN4Vc2+62BfXq8Ch5FHPQbvKHU8Jsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q1dH1o8TSr1lB8dq6uF7seMs59o61OBa9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:32915 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbaBDQR7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 11:17:59 -0500
In-Reply-To: <CA+4uBUYROX1gWuBzkUgxTN4Vc2+62BfXq8Ch5FHPQbvKHU8Jsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q1dH1o8TSr1lB8dq6uF7seMs59o61OBa9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> For w=3D(multiple of 8) we could probably skip the (*sizeof(int)) and g=
et the chunksize factor 4 down ... Loic we should check if this is ok wit=
h the Jerasure implementation .... I wonder if we should have 'packetsize=
' as a plugin parameter or we should just adjust the packetsize based on =
the desired chunk_size to get it close.

You are correct : the packet size is best adapted to the object size (or =
stripe size) rather than being set once for all. However Sam wants to use=
 a fixed stripe size and we don't need this flexibility right now.=20

I don't fully understand the alignment requirements of Jerasure. Since we=
're using Cauchy because it is the fastest, here is how I understand its =
alignment constraints. I copied them from the original encode/decode meth=
ods found in jerasure into the get_alignment method whithout understandin=
g the details.

* each chunk memory address must be aligned to allow=20
https://github.com/ceph/ceph/blob/v0.76/src/osd/ErasureCodePluginJerasure=
/vectorop.h to be used by https://github.com/ceph/ceph/blob/v0.76/src/osd=
/ErasureCodePluginJerasure/galois.c#L748 . This is done without reading f=
rom get_alignment() because each buffer is created with https://github.co=
m/ceph/ceph/blob/v0.76/src/common/buffer.cc#L519 buffer::create_page_alig=
ned which calls https://github.com/ceph/ceph/blob/v0.76/src/common/buffer=
=2Ecc#L235 posix_memalign with an alignment of CEPH_PAGE_SIZE which is la=
rge enough. It is implicit though and it would be better to explicitly se=
t this constraint.

https://github.com/ceph/ceph/blob/v0.76/src/osd/ErasureCodePluginJerasure=
/ErasureCodeJerasure.cc#L288

* each chunk size must be a multiple of get_alignment() and in the case o=
f the Cauch techniques it means:
** being a multiple of sizeof(int) (why?)
** being a multiple of LARGEST_VECTOR_WORDSIZE (because https://github.co=
m/ceph/ceph/blob/v0.76/src/osd/ErasureCodePluginJerasure/galois.c#L748)
** being a multiple of k*w*packetsize (because each chunk contains k pack=
ets of packets size and each packet is made of words of size w)

I would be grateful if you could explain what the sizeof(int) is about. A=
lso, I understand that k*w*packetsize should be a multiple of LARGEST_VEC=
TOR_WORDSIZE but I don't understand why you would multiply the alignment =
to achieve this. Is it be enough to if (alignment % LARGEST_VECTOR_WORDSI=
ZE) alignment +=3D alignment % LARGEST_VECTOR_WORDSIZE ?=20

Thanks in advance for your patience :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Q1dH1o8TSr1lB8dq6uF7seMs59o61OBa9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLxErMACgkQ8dLMyEl6F23P/gCfcdgo2bVJ9B3xw8tqcMNqUDDE
4V8An21pWxZrG/U6Ox1jGNLg4qTthNmA
=GPqa
-----END PGP SIGNATURE-----

--Q1dH1o8TSr1lB8dq6uF7seMs59o61OBa9--
