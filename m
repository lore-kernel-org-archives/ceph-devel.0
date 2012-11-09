From: Ben Poliakoff <benp@reed.edu>
Subject: Re: cephx auth issue
Date: Fri, 9 Nov 2012 10:08:03 -0800
Message-ID: <20121109180802.GD19901@garage.reed.edu>
References: <CACkq2mp21AdjQCpEzynbVht81Y-xzD0UXT16zt_EBEcy3ND92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from suede.reed.edu ([134.10.2.45]:60632 "EHLO suede.reed.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060Ab2KISOo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Nov 2012 13:14:44 -0500
Content-Disposition: inline
In-Reply-To: <CACkq2mp21AdjQCpEzynbVht81Y-xzD0UXT16zt_EBEcy3ND92Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Travis Rhoden <trhoden@gmail.com> [20121109 09:55]:
> I'm not sure what I've done wrong here:
>=20
> Things are okay as client.admin:
>=20
> # rbd -p images --id admin ls
> test
>=20
> But not as client.images:
>=20
> # rbd -p images --id images ls
> error: (1) Operation not permitted
>=20
> The privs/caps seem okay in ceph auth:
>=20
> # ceph auth list
> <snip>
> client.admin
> 	key: <snip>
> 	caps: [mds] allow
> 	caps: [mon] allow *
> 	caps: [osd] allow *
> client.images
> 	key: <snip>
> 	caps: [mon] allow r
> 	caps: [osd] allow rwx pool=3Dimages
> client.volumes
> 	key: <snip>
> 	caps: [mon] allow r
> 	caps: [osd] allow rwx pool=3Dvolumes, allow rx pool=3Dimages
>=20

I had a very similar problem after I upgraded my test cluster from
argonaut to 0.53.  For me it was a "caps" parsing issue involving the
'=3D' character (which has been fixed in 0.54.  A nice person on IRC
helped me out.  Updating the caps from something like this:

> 	caps: [osd] allow rwx pool=3Dvolumes, allow rx pool=3Dimages

To this:

  	caps: [osd] allow rwx pool volumes, allow rx pool images

=2E..fixed the issue for me.

Apparently in 0.54 parsing of '=3D' in a caps line will work properly
again.

Ben

--=20
________________________________________________________________________
pub   4096R/318B6A97 2009-05-11 Ben Poliakoff <benp@reed.edu>
 Primary key fingerprint: 3F23 EBC8 B73E 92B7 0A67  705A 8219 DCF0 318B 6A97

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUJ1GfYIZ3PAxi2qXAQhiehAAjAoLcof0hhngUfB7qZy24xOczIVOkysm
Hm6XnavM9rYKwoW2wBv76dJ2JFLC1JVcG4ujjIi6XAHYb9SpwcuNeHynAKgNxl2k
kk4Qf1vXRQ5lvPxxOJKNgT+liC8lw7mB2U3wlIO3njng1c/9T8Qx96ocmGXU0TB6
6jeboQOo6mdGxHzWPZTq2BjesS8rhajgpKgNvgwll5qaHcXNudg0LZ79raW5fj6g
O8YpCmHcyqIM4hRHqeeBl56lfLmpjFybQqp32sfPdo78TLUZuBEhYJbtgKfpnnid
WcS4FafTiU2UB51XWwwbLTG+YQibpCDXfiEoeidyxh2is66mhdzan99xy4E+DqWs
4A/GVeHiQO7fPXTSlUyeB8CyE6OEsKyszDMoh+LpEPnLBHDZO66PB96IHVPnvdPh
pPhQJ3X5sIxKk295pnIpqaoT/ICvjh1ebEV0KrLQ9D4pTRoZT+TECdpHP7QhofzW
0IxP8quC2Jk0x1+HsutDjw5v9VvP1b4rbYvxTVuvoTQUIwWliFoBCmRG9sftkZqT
tvXyxBoLLJq0GXYmor0SF1sdpl/TAmfLAE7oYUIYzWpfFlH7REVFBTNcUY3wwaqW
oNa0IO9ZIZc+lZhr010TV+lTbndWg20EmJ4YZasZ9q7u1WOxNC8USfcu8PtxxMz5
8R6GccASMvc=
=+vPS
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
