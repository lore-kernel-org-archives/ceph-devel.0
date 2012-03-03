From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: ceph tree in linux-next
Date: Sat, 3 Mar 2012 18:22:41 +1100
Message-ID: <20120303182241.bbdb98825505b8632c742942@canb.auug.org.au>
References: <Pine.LNX.4.64.1203022138440.15833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__3_Mar_2012_18_22_41_+1100_SI7CT=TK0n0ELmP5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:41025 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab2CCHW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Mar 2012 02:22:59 -0500
In-Reply-To: <Pine.LNX.4.64.1203022138440.15833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

--Signature=_Sat__3_Mar_2012_18_22_41_+1100_SI7CT=TK0n0ELmP5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On Fri, 2 Mar 2012 21:41:00 -0800 (PST) Sage Weil <sage@newdream.net> wrote:
>
> The Ceph kernel tree has moved[1], and we've reworked the way we're=20
> managing commits in our tree.  Can you update linux-next to pull from
>=20
> 	git://github.com/ceph/ceph-client.git#master
>=20
> That'll ensure that anything we've tested and reviewed gets into -next=20
> without us having to remember to push a for-next branch.

Well, I can't really use your master branch because it has 3 commits on
the top of it that modify btrfs and are also not signed and do not look
like they are destined for Linus.

I need a clean branch that contains only what you will be sending to Linus.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__3_Mar_2012_18_22_41_+1100_SI7CT=TK0n0ELmP5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPUcbBAAoJEECxmPOUX5FEyuIP/0t3i2HBQ/aMkbRbJQ93lpwP
Db4UjjYe6LNblkZelCswUmuOdrbYtYYRYLacKpl3WMbZBgslF9oDUhLujvX3bxXK
ak/DUy71R34x3/v66BhaaaQ0apFpCniT+h20YujwAUBSRU1ZqFNdNISpBYlwcBtd
YqMEzIamiMA6uHTxuDvJrXGxEOyC8BvEOVdYrYlwRjTUXnMHTxi7fbzhiAxd1opf
oqLfbvOccG9cakrWSln2qO5OAXPqOd6LHUnS2UWffJUrk42zMyqi3gQa6XyJjisZ
8MZ9GxPmzm7apfADb58PAzsSIPlETEOZjOIKcKP54loHVmDYe3R+gamKfDKP2p2g
4egYyckxlGBZ7WOvGIl0sV84czbakp8wvyaLIe76pkH2D8qClvbxPZtifmTJdBM1
a4eEYRDeMIRUv8Xyiy6L6jf1vvKo31xCO177By/noI6sD20NLrcORW+4fpH6TQ2a
TKuUYssAiIN2n/haLMkM8ZmSYzDotm6lZ6KwDSKihxMbMbiu82tyQdNUOYM47otu
nlYvdHXyiLuWs0fmh/jUj12ddgmS7TZkRFYGAkW7p66UROWv6wjpZv2d4T2+NAE3
YOCLR0kyZCs+//BYqlmm0/78FUib2uRB9ev8t6xc7Tt9SZPvif+1dHYcPToXZVQ3
SSaOHHmnFccvzJ+EIEHc
=YeSW
-----END PGP SIGNATURE-----

--Signature=_Sat__3_Mar_2012_18_22_41_+1100_SI7CT=TK0n0ELmP5--
