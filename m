From: Loic Dachary <loic@dachary.org>
Subject: Re: Swift tests failing randomly
Date: Mon, 11 Aug 2014 18:21:48 +0200
Message-ID: <53E8ED9C.5000601@dachary.org>
References: <53E7316D.3090808@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="t1BhQ1M2t8GMhTU4ASB4NtUcxPemae9UQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57521 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752555AbaHKQVz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Aug 2014 12:21:55 -0400
In-Reply-To: <53E7316D.3090808@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t1BhQ1M2t8GMhTU4ASB4NtUcxPemae9UQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

It looks like increasing the rgw idle timeout makes the problem go away (=
 https://github.com/ceph/ceph-qa-suite/pull/79 and http://tracker.ceph.co=
m/issues/8988 ). It previously was 300 sec which looks like a large value=
 already. Does this fix / workaround make sense to you ?

Cheers

On 10/08/2014 10:46, Loic Dachary wrote:
> Hi Yehuda,
>=20
> In the past few months the swift tests failed randomly and I was unfort=
unately unable to figure out why. Here are a few examples:
>=20
>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:=
stress-split-wip-9025-chunk-remapping-testing-basic-vps/406944
>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:=
stress-split-wip-9025-chunk-remapping-testing-basic-vps/406941
>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:=
stress-split-wip-9025-chunk-remapping-testing-basic-vps/406946
>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:=
stress-split-wip-9025-chunk-remapping-testing-basic-vps/406947
>=20
> and it has happened on every upgrade test run since I can remember. I f=
ail to see a pattern and cannot figure out what the real problem is. It w=
ould be really great if you could take a look. Even a hunch or a tip woul=
d be greatly appreciated :-)=20
>=20
> You can find more context in=20
>=20
> http://tracker.ceph.com/issues/8988
> http://tracker.ceph.com/issues/8016
> http://tracker.ceph.com/issues/7799
>=20
> and discussions at
>=20
> http://www.spinics.net/lists/ceph-devel/msg19933.html
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--t1BhQ1M2t8GMhTU4ASB4NtUcxPemae9UQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPo7Z0ACgkQ8dLMyEl6F22HMQCfSH5MNoVUWmR8TGtxRtf/sV0k
d0UAn0RSEBdOfsBNRPyN0RKAgg3apYLK
=pe3K
-----END PGP SIGNATURE-----

--t1BhQ1M2t8GMhTU4ASB4NtUcxPemae9UQ--
