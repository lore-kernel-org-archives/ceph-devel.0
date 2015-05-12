From: Loic Dachary <loic@dachary.org>
Subject: Re: Merging PRs on the command line
Date: Wed, 13 May 2015 00:09:23 +0200
Message-ID: <55527A13.8040208@dachary.org>
References: <55527771.6060401@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SJQ2acQuTJaICRrHbWB6cgTVOGKXfmR6p"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34035 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933734AbbELWJ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 18:09:26 -0400
In-Reply-To: <55527771.6060401@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SJQ2acQuTJaICRrHbWB6cgTVOGKXfmR6p
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

That's handy, thank you :-)

Cheers

On 12/05/2015 23:58, Ken Dreyer wrote:
> Hi Loic,
>=20
> I was reading over some of the HOWTO docs in the wiki, and saw the step=
s
> here:
>=20
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_the_=
integration_branch
>=20
> It looks like you're using curl to get the title of the PR, populating
> the commit message, etc.
>=20
> I've found that GitHub's "hub" utility is really great for simplifying
> this. I typically merge PRs in GitHub by running the following in my
> local clone:
>=20
>   git checkout master
>   git pull
>   hub merge https://github.com/ceph/ceph/pull/4658
>   git commit --amend (to add my "Reviewed-by" line to the merge commit)=

>   git push
>=20
> The hub utility uses GitHub's APIs to automatically add a
> non-fast-forward commit with a "regular" commit message that looks
> more-or-less identical to the one that I'd get if I clicked the "Merge"=

> button in the web UI.
>=20
> The thing that sold me on this is that all the merge commits are
> authored by "kdreyer@redhat.com" instead of my personal email address. =
I
> found that when I clicked the "Merge" button in GitHub's web UI, the
> merge commits were authored by my primary email address for my
> "ktdreyer" GitHub UID, which isn't really what I want for Ceph.
>=20
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SJQ2acQuTJaICRrHbWB6cgTVOGKXfmR6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVSehMACgkQ8dLMyEl6F22G6gCghOE2I0RUE2Xy+49kuQPXX9wh
Ep8AoI+ahtHh85Rs2GIcL8knEWJLkJRH
=qniw
-----END PGP SIGNATURE-----

--SJQ2acQuTJaICRrHbWB6cgTVOGKXfmR6p--
