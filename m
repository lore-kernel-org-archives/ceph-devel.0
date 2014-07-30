From: Loic Dachary <loic@dachary.org>
Subject: Re: giant and hammer dates
Date: Wed, 30 Jul 2014 10:59:43 +0600
Message-ID: <53D87BBF.2020408@dachary.org>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HDNfA1xTApdHADtwbVMviNU6c7GOo8IlB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50634 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751020AbaG3FAA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 01:00:00 -0400
In-Reply-To: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HDNfA1xTApdHADtwbVMviNU6c7GOo8IlB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

=46rom my (biased) point of view, the upside is that it will give me more=
 time to complete the locally repairable code for Giant ;-). The downside=
 is that it puts a little less pressure to improve the tools and methods =
that make a rapid release cycles possible (i.e. unit tests, bug tracking,=
 patch acceptance workflow, package building/gitbuilder, teuthology, pulp=
ito, upgrades testing, ...). In a perfect world Ceph could sustain a thre=
e month release cycle without inconveniencing anyone. A longer release cy=
cle (five or six months) would encourage even more complex / bigger chang=
es within a release cycle. It would also probably encourage Ceph develope=
rs to forget about the release process tools during two or three months a=
nd not improve them as they should be.

IMHO the test cycle is significantly slowing down the release process and=
 a faster, more comprehensive test cycle would help a lot.=20

Each commit should be unit / functional tested within seconds, locally (s=
ee https://github.com/ceph/ceph/blob/master/src/test/osd/types.cc#L1295 f=
or instance). It is usually more difficult to diagnose / fix a border cas=
e when it is discovered during integration tests (i.e. teuthology) rather=
 than with a unit / functional test designed for it. Creating unit tests =
is often problematic because some of the code base cannot be easily isola=
ted. With a continuous effort to re-arrange parts of the code to be more =
test friendly, this can eventually be resolved.

Every commit proposed to master should be run against the relevant teutho=
logy suite to help the reviewer. The problem here is that it requires mor=
e resources than what Ceph currently has. Harvesting more machines, makin=
g it possible for people and organizations amicable to Ceph to easily don=
ate virtual machines could probably help.

This deserves a separate discussions but I wanted to expand on what I mea=
nt by "test cycle" and its impact on the release cycle.=20

Cheers

On 30/07/2014 05:11, Sage Weil wrote:
> We've talked a bit about moving to a ~4 month (instead of 3 month)=20
> cadence.  I'm still inclined in this direction because it means fewer=20
> stable releases that we will be maintaining and a longer and (hopefully=
)=20
> more productive interval to do real work in between.
>=20
> The other key point is that we don't want a repeat of the firefly delay=
=2E =20
> I think we should stay as close to a train model as we can.  If somethi=
ng=20
> isn't ready by freeze, let it wait for the next cycle.  We shouldn't be=
=20
> cramming things in at the end, especially big things.  As a general rul=
e,=20
> big things should be merged early in the cycle so that we have lots of =

> time to shake out the issues that only come out of lots of testing and =

> aren't obvious from code review.
>=20
> Anyway, how about:
>=20
>           Freeze         Approx Release
>   Giant   Mon Sep  1     Mon Sep 29
>   Hammer  Mon Jan  4     Mon Feb  2
>=20
> That gives us another month for Giant, then September to shake out=20
> anything issues.  And then three full months before the Hammer freeze.
>=20
> What say ye?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--HDNfA1xTApdHADtwbVMviNU6c7GOo8IlB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPYe78ACgkQ8dLMyEl6F2111ACgha6UMxxQvzf/hg9JQ3EON+xu
cCsAn0GtA+qTOENIBafYGGmkRYKQdzQv
=qU2N
-----END PGP SIGNATURE-----

--HDNfA1xTApdHADtwbVMviNU6c7GOo8IlB--
