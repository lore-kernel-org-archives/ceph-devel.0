From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Upgrade from Jewel to Luminous. REQUIRE_JEWEL OSDMap [how to
 avoid in Gentoo in future]
Date: Mon, 4 Dec 2017 07:47:30 +0000
Message-ID: <robbat2-20171204T074150-153302641Z@orbis-terrarum.net>
References: <alpine.DEB.2.11.1711280308100.19791@piezo.novalocal>
 <CADfZm8c1+OhDO36BjYSqLCe-US0Nmvhw87kyUWduc_5X3hL7Pg@mail.gmail.com>
 <alpine.DEB.2.11.1711281308100.19791@piezo.novalocal>
 <CADfZm8dYLvGOFhtCGp1twwJopz4rUDS1EKqLCxYE_or+RndCrg@mail.gmail.com>
 <alpine.DEB.2.11.1711281844430.19791@piezo.novalocal>
 <CADfZm8dOAUnSJxHRvpNng9iOBHg1kyCauXY=VNt6z-kduSYtwg@mail.gmail.com>
 <alpine.DEB.2.11.1711300049560.8333@piezo.novalocal>
 <CADfZm8dd-ew+1HMDeDy_O8ewu2+-PyAHuAJn-mGLfMx2ZWn=BQ@mail.gmail.com>
 <alpine.DEB.2.11.1711300309540.2819@piezo.novalocal>
 <CADfZm8fjgE42ikdBBZ+44FL81EzaFyOd_Rp1D7B0Rj=-+escxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:34728 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752860AbdLDHrc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Dec 2017 02:47:32 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 26F0E33BEB4
        for <ceph-devel@vger.kernel.org>; Mon,  4 Dec 2017 07:47:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CADfZm8fjgE42ikdBBZ+44FL81EzaFyOd_Rp1D7B0Rj=-+escxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 05:36:13AM +0000, Cary wrote:
> Sage,
>=20
>  I accidentally upgraded one of my monitors to Mimic when installing
> the 9999 ebuild. That ebuild pulled the latest code from
> https://github.com/ceph/ceph.git which was Mimic. I uninstalled Mimic
> and installed Luminous 12.2.2. Then I was able to run "ceph osd set
> require_jewel_osds --yes-i-really-mean-it", and get my cluster to a
> healthy state running Luminous 12.2.1. I will update the rest of the
> cluster to Luminous 12.2.2 later.
Gentoo-specific:
Should the Gentoo maintainers restructure the generic -9999 to track tip of=
 branches?
Something like:
10.2.9999 - Jewel
12.2.9999 - Luminous
13.2.9999 - Mimic

Would this have helped avoid you accidentally running Mimic code on a
Luminous cluster?

I do have ebuilds for the above, since I worked on them...

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlok/ZFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTS2g//fO8dvSjYGsBiXcOYQRPMjuEFoKR1F5aJHhSy/Rrt8zm8j5CHQbLS8OvE
HzolCv/VpwcUM2ty71iaEnynp5D+fgonZMFxSWGVYlWTodWcCaD5bi/Jdxlwqa2K
eKcchzU/Y2k8Zc1eXtM2GyzNi9KdklfUQKJEwBTffcM6qBVTZwFsYru74/+YkoNc
X3Lx9OVmFr+qnssxM8MjAHFk9Ftohrb3ZS4albuD22iSLDU7Q8hzpUL0zITMNsAz
UTrDfRNCfkStxx9DY517BJuQRPVPKypjqC2d6viFJGpKn/785WkgkHKfDfRWoiNM
kOo2Y63P2R4EApRCY/1ZRa9QJkzKZTCewpbA0M/gu/dx28dfpwpUi9QkCmZtg/t3
CQ0bs/X/mcHUKOKsEEgmfSlWhtHad3/Qc/f37PNwTGQoDGoVkxqEwAIt0OxDHarz
H7LsdhUR3qGyLKD9EU4N2tNiGb4EJ4TLW2iJO95GfwHuZu+VCt28cUORi1Ks32TC
HZauDYa8qOymNjLSisDYw3JmnTKuQJyxwyP+ExmSF/IXYChpVOe43Uv+ACVXDSk3
8G8/ibncmMLp6Pqo3gRmpkBYgvT0wwuxP4EfqhYrOS5tSoztzpt1SMqGydLW1TOC
/oQ/sJDdSQNap0IVf+3tKwr0k4PGAJgVDFvF9lhUOq+o3PUgSbY=
=44K6
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
