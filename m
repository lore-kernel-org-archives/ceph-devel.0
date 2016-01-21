From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: inconsistent rados semantics between automake/cmake builds
Date: Thu, 21 Jan 2016 12:48:08 -0500
Message-ID: <20160121174808.GA20010@ultraspiritum.redhat.com>
References: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
 <CADRKj5RFKdLWWAaWg1EtTtJB+g3FigoEm3=xJ2+FCostq7fp4A@mail.gmail.com>
 <20160121170305.GA32590@ultraspiritum.redhat.com>
 <CAB2gnbUG6kJF40kcDTcHHjXS5TeLALnTBfF1wFVCGE8PTxeSeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43180 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545AbcAURsK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jan 2016 12:48:10 -0500
Content-Disposition: inline
In-Reply-To: <CAB2gnbUG6kJF40kcDTcHHjXS5TeLALnTBfF1wFVCGE8PTxeSeg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>, Orit Wasserman <owasserm@redhat.com>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/01/2016, Noah Watkins wrote:
> It's easy for me to reproduce. What would you like me to run?

Sorry about that, I had misread the message I responded to and thought
it was still bound up with RadosGW. I'm running your test case, I should
have a patch sometime soon to fix it.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWoRnTXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jID4IAJpfDNQNT5ygRycabEmwd8gZ
Mes2iaap2/bUyAhbATyu++ltnDX2pL9QIN80JdZzYV8kvCiGHy3xJ629z27oSSEU
Hb2pDMKVofcQvyvAfkbiDjVOiEPmXos7/J3ywoa8ukFkSJn1rnksRlpr65231OpO
5Jt48NjrvQiWXVKxT9FHzAi0yG9W5qR3yWGBN292G2AL0aSfYpX6ihMMvbO7Mst4
jjVz5DOvCClZswC4v0sVYj8uPvQJPxVEdUsaXZAGM7DmqGBkyrtOmNkIMYNicjzt
ehmRcfUzaBaPAoUHbedxuuQ+tnIs7U+QRPBC51lRd2UgQ0dSSTZd91OMQHuiQoI=
=PccP
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
