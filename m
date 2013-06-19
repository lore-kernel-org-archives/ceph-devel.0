From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: ceph in linux-next
Date: Wed, 19 Jun 2013 10:13:41 +1000
Message-ID: <20130619101341.4873c5030311c3526054b4a0@canb.auug.org.au>
References: <alpine.DEB.2.00.1306181009140.31132@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__19_Jun_2013_10_13_41_+1000_mX/tqxahGQ8tDdJn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:49021 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933187Ab3FSANv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 20:13:51 -0400
In-Reply-To: <alpine.DEB.2.00.1306181009140.31132@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: linux-next@vger.kernel.org, ceph-devel@vger.kernel.org

--Signature=_Wed__19_Jun_2013_10_13_41_+1000_mX/tqxahGQ8tDdJn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On Tue, 18 Jun 2013 10:12:30 -0700 (PDT) Sage Weil <sage@inktank.com> wrote:
>
> A while back I asked to switch the ceph branch in linux-next from master=
=20
> to testing, but upon further reflection I'd like to switch it back: we're=
=20
> hitting various cases where we want to carry patches that we're running=20
> through our QA that aren't destined for the next merge window.
>=20
> That is,
>=20
>   git://github.com/ceph/ceph-client.git master

OK, done.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__19_Jun_2013_10_13_41_+1000_mX/tqxahGQ8tDdJn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRwPe5AAoJEECxmPOUX5FEAZUP/iThMZOYAZ8KIeqF/sKAwgw6
MQEpsMxpvcNo+nmfrPxk0bzaDbYzNxaLYI2alhFj7V8WCG7y6A1Ftoytc9WbAc1k
pqIBltX2Gz1KmAGx39foJStwT6vczpHFU2OOc8m/7tWpOtTip3fUSbt+wP4MPPmq
Sf4COIlJxBw1fjM2LQcuzcceVHWFlwX869DK263+cjwZbeRhglKJpjOZ7gsUf34s
PY4YbMxCzHFxHaIoQonzOeFDZWtOOWALfrQ20FTBBjAY1paU9/FrlJ+L9XsSxvUr
lSW+iZjtGi6X1qLcupOA1UB3NHQIdcDQ44gSngknlid7HrQ8P0XPTxbNZsEvB31H
8fTw+GOVqAI/q0zjHTFBWbF0rqd7axauveQR73Tqom+45ViSYFi4ufLOSTwWaNjM
DSU0vy+JzPvCmPTtXpHlXDBUuX7tXqjftoe2r6AodvRnFzh81WX+IG8/RbOrQJ19
Wbox02qlulgZ4oL7MM9FtMPFfV+oSaFW8WjpOw6Yotiz9ZLBP+Q3KecbI84NKX9B
sA3Hdj7ykxirgVlkk6u8io0TrIQd23xMZ+fMwwz3VcKL+CJgIOqPC+uUWoC1dfm2
F1r1OX2KjrvzlpH7F7hgyY41n5DM0yDlJGMPnQN2MWWPK275g25qVtg9200iHOsh
0hxsZMumE2Mwd6/uUvyc
=HRdK
-----END PGP SIGNATURE-----

--Signature=_Wed__19_Jun_2013_10_13_41_+1000_mX/tqxahGQ8tDdJn--
