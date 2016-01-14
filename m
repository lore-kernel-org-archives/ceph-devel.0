From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Thu, 14 Jan 2016 11:14:49 -0500
Message-ID: <20160114161448.GA18367@ultraspiritum.redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
 <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
 <20160112173248.GA8218@ultraspiritum.redhat.com>
 <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <831805509.11479927.1452787821164.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbcANQOu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jan 2016 11:14:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 7577419CBEF
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 16:14:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <831805509.11479927.1452787821164.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14/01/2016, Erwan Velu wrote:
> Thanks for your insights.=20
>=20
> I even wonder if the change of the daylight time saving could not trigger=
 that bug I'm thinking about.
> Especially if the server time is in local time .... That's an horrible vi=
sion :(

That, at least, is ruled out completely. Outright setting the time won't af=
fect
the monotonic clock.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWl8lyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jrRkH/2rOzVJEdBM1SKQO2u/4zu3C
nym7i77AHpcSBx0J5GYfZwcOncjiI2lAfV7tABkvYpBdzVScrhcRdyYwJOuqTTco
OWVJHJDVVY3xuNRYfh+9QgFHy2AgqolYPN7W/C9FpvetMSmKp/XTBQ4RPg1wEYDX
/3FVCrNJ5Ti6W9/jSqdwl+IfhGcfl3WN6iZikulapAp8a0uwWB4bqjW1drXqIaBz
584xxBxFsyC0E2lItFSUQJI7pQ1iV7aN4dPThMDTHYTXBOaS4luT1nH+DnBB85hb
kThLUVdN02KWQj9n8mog23UJGgKcIZKJgGWVFbcABvfo0WXiAcyDtDlzXvXWTUA=
=4toJ
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
