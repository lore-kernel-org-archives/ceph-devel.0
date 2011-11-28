From: Andre Noll <maan@systemlinux.org>
Subject: Re: [PATCH/RFC 5/6] doc: Add missing documentation for osd pool
 get.
Date: Mon, 28 Nov 2011 20:27:03 +0100
Message-ID: <20111128192703.GB8944@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
 <1322489076-31364-1-git-send-email-maan@systemlinux.org>
 <1322489076-31364-6-git-send-email-maan@systemlinux.org>
 <CAF3hT9Aqa9xpn9CGQiUFuVZz_Lp5SpqtVpN5D5h=mPnmLLC_kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:59072 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab1K1TZL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 14:25:11 -0500
Content-Disposition: inline
In-Reply-To: <CAF3hT9Aqa9xpn9CGQiUFuVZz_Lp5SpqtVpN5D5h=mPnmLLC_kw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 10:37, Gregory Farnum wrote:
> > + =C2=A0 =C2=A0 =C2=A0 * ``pg_num``: See above.
> > + =C2=A0 =C2=A0 =C2=A0 * ``pgp_num``: See above.
> > + =C2=A0 =C2=A0 =C2=A0 * ``lpg_num``: The localized pg number.
> > + =C2=A0 =C2=A0 =C2=A0 * ``lpgp_num``: The number of localized pgs.
> The lpg_num and lpgp_num are analogous to the pg_num and the pgp_num =E2=
=80=94
> the lpg_num is the number of local PGs, and the lpgp_num is the number
> used for placing them. This matters less for the local PGs than the
> regular PGs but it can still control where the replicas are placed.

Thanks for the clarification. I will update the patch accordingly.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7T4IcACgkQWto1QDEAkw/FHgCfeEpLcuH7hNtkiiEahhG0vMhj
UIgAn1y6HLb/6O5i2Rb1Pi/QJ2m9yQCe
=8JOA
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
