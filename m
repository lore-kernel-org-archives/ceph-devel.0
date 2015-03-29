From: Loic Dachary <loic@dachary.org>
Subject: Re: Script to extract backports log
Date: Sun, 29 Mar 2015 20:44:55 +0200
Message-ID: <55184827.1090603@dachary.org>
References: <CAHJ4zokWQ0T5RTMvToTgS_YZxPgQV11XTxKGaUX+gnzj5u1B0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="epjX57hxgBJPkkntHBuqBXgFoWxts1ACn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38457 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752318AbbC2SpC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Mar 2015 14:45:02 -0400
In-Reply-To: <CAHJ4zokWQ0T5RTMvToTgS_YZxPgQV11XTxKGaUX+gnzj5u1B0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alistair Israel <aisrael@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--epjX57hxgBJPkkntHBuqBXgFoWxts1ACn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

On 29/03/2015 19:27, Alistair Israel wrote:
> Hi, Lo=C3=AFc.
>=20
> Well, got some 'quality' coding time in over the weekend and managed
> to hack this out:
> https://gist.github.com/aisrael/b2b78d9dfdd176a232b9
>=20
> You'll need GitPython (pip install gitpython). I managed to get
> hyperlinks to issues, to the commits themselves, and even snuck in the
> names of the people who've signed off on the commit.

It's going to be helpful to start with the release notes but it will need=
 manual editing.

>=20
> What I can't figure out is how to get the simple component or module
> name. For example, from how to get from "common/buffer.cc" (#6003) to
> "buffer".
>=20

I don't think it can be done automatically.

> Also, using a related issue and commit, how to combine two related
> ones. For example, #6614 is related to #6003, and in the release notes
> both are listed as a single item.

One idea would be to group commits that are in the same branch together ?=
 When a merge is found, git log xxx^1..xxx^2 will list the commits that b=
elong to the branch that has been merged. All commits in this branch pres=
umably relate to the same topic.

> Finally, do you think I should exclude commits starting with "qa:" or
> "test/...:"?

Yes, they are not relevant ;-)

I included your snippet in the HOWTO write the release notes at http://tr=
acker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_release_notes =
which is linked from http://tracker.ceph.com/projects/ceph-releases/wiki/=
HOWTO.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--epjX57hxgBJPkkntHBuqBXgFoWxts1ACn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUYSCcACgkQ8dLMyEl6F22IXACgtIvkXDpHuO7nUHNngefcD2gn
Ie4An2US1C6SUiOARN+jEgvDMBrAZvU/
=3GlF
-----END PGP SIGNATURE-----

--epjX57hxgBJPkkntHBuqBXgFoWxts1ACn--
