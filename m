From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-ci.git?
Date: Mon, 18 May 2015 10:09:08 +0200
Message-ID: <55599E24.6040208@dachary.org>
References: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dflBwc3ep2vJ6XQVXsKqjr5MXn5IfUO1O"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36917 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbbERIJK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 04:09:10 -0400
In-Reply-To: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dflBwc3ep2vJ6XQVXsKqjr5MXn5IfUO1O
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 18/05/2015 06:40, Sage Weil wrote:
> As the number of people contributing code grows, we've added more and m=
ore=20
> people to the github ceph org who have write access to ceph.git.  Those=
=20
> people can merge pull requests and can also push branches directly to t=
he=20
> repo.
>=20
> We also use ceph.git as a source for the test build infrastrucure=20
> (gitbuilders) to generate packages for QA or hot fixes and make check=20
> tests.  This leads to an every-growing body of wip-* branches in the re=
po=20
> (which is annoying), and also means that in order to build something to=
=20
> test in QA you also get the ability to (say) push directly to master.
>=20
> How about we instead
>=20
>  - create a second repo named something like ceph-ci.git (that's the be=
st=20
> I can come up with at the moment)=20
>  - add this as a second source for all gitbuilders (they can poll a lis=
t)
>  - move all wip-* branches here
>  - create a new github team with contributing developers who can push t=
o=20
> this repo and are trusted not to wreak havoc on the builders
>  - remove all the cruft from ceph.git, so that it's just master, next, =
the=20
> stable branches, release tags, and anything else similarly important.
>  - restrict ceph.git write access to core developers
>=20
> This will improve security somewhat and reduce the risk of an accidenta=
l=20
> push to an important branch.
>=20
> It may also reduce the risk associated with accidental force pushes=20
> (something we've hemmed and hawed about recently) by limiting the circl=
e=20
> of people who can write to ceph.git and also changing workflows so that=
 it=20
> is almost never used directly...

Having a reference repository for releases only, would be a great move.

One problem with promoting http://github.com/ceph/ceph to that role is th=
at while the migration is in progress there will be two queues of pull re=
quests, the new one at http://github.com/ceph-ci/ceph and the old one at =
http://github.com/ceph/ceph. Given our current flow of pull requests the =
migration will probably take about three months. And after that, since it=
's not possible to forbid pull requests on github.com (you can disable is=
sues but not pull requests on a given repository) there will forever be a=
 flow of misdirected pull requests against the old repository.

Maybe it would be better to keep http://github.com/ceph/ceph as it is and=
 create a release repository (say https://git.ceph.com/?p=3Dceph-release.=
git) to only have the stable, master and next branches. Contributors who =
accidentally force push master on http://github.com/ceph/ceph would have =
the comfort of knowing that master on https://git.ceph.com/?p=3Dceph-rele=
ase.git can be trusted to be a reference.

Updating https://git.ceph.com/?p=3Dceph-release.git could be done by a ga=
te instead of trusting a group of people with it. The gate could be as si=
mple as a cron job mirroring a predefined list of stable branches from ht=
tp://github.com/ceph/ceph to https://git.ceph.com/?p=3Dceph-release.git. =
Although it could evolve into something more sophisticated in the future =
(such as *not* mirroring a branch for which the gitbuilders are red), thi=
s simple minded mirror would already effectively protect us against a for=
ce push, because the mirroring command would be setup in a way that does =
not allow force push. In the event of a force push on http://github.com/c=
eph/ceph, the mirror would fail and the force pushed branch on http://git=
hub.com/ceph/ceph can conveniently be reset to the latest from https://gi=
t.ceph.com/?p=3Dceph-release.git.

Although https://git.ceph.com/?p=3Dceph-release.git could be setup as htt=
p://github.com/ceph/ceph-release, it has a few disadvantages (pull reques=
ts can be misdirected to it, the repository cannot be set to protect agai=
nst force push).

As time passes existing workflows (releases for instance) can gradually/o=
pportunistically migrate from using http://github.com/ceph/ceph as a sour=
ce to https://git.ceph.com/?p=3Dceph-release.git, to benefit from a more =
stable source. But even if they don't, the worst that can happen is that =
they temporarily suffer from a forced push, just as they currently do.

Cheers

>=20
> ?
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--dflBwc3ep2vJ6XQVXsKqjr5MXn5IfUO1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVZniQACgkQ8dLMyEl6F21vMACfTst0p1Nv3aWqnVySjRpCiTxo
dOwAnjx01J+KE/daPvBWBELT6QVE5gKd
=XX/q
-----END PGP SIGNATURE-----

--dflBwc3ep2vJ6XQVXsKqjr5MXn5IfUO1O--
