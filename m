From: Loic Dachary <loic@dachary.org>
Subject: Re: Firefly EOL date - still Jan 2016?
Date: Fri, 13 Nov 2015 23:02:39 +0100
Message-ID: <56465DFF.5060605@dachary.org>
References: <CALqRxCy7hGSXOo5B_iKLcoGB-MroBoo04JT7fHiwtEdb+=-NeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XSHTfTuaAhmcDDCan5CK5fmANUVCAR67J"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60389 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957AbbKMWCl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Nov 2015 17:02:41 -0500
In-Reply-To: <CALqRxCy7hGSXOo5B_iKLcoGB-MroBoo04JT7fHiwtEdb+=-NeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XSHTfTuaAhmcDDCan5CK5fmANUVCAR67J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

On 13/11/2015 22:15, Ken Dreyer wrote:
> Hi folks,
>=20
> This is mainly directed at the stable release team members
> (http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO), since
> they are the ones doing the work of backporting :)
>=20
> On http://docs.ceph.com/docs/master/releases/, it says the estimated
> EOL for Firefly is Jan 2016, which is coming up soon.
>=20
> Does anyone on the stable release team have an interest in doing
> releases beyond that date, or should we announce that as a firm date?

Although we're heading in this direction, publishing a point release stil=
l depends on resources that are not limited to the stable release team. I=
deally, in the not too far future, someone from the stable release team c=
ould answer "I'll keep publishing releases" and really be able to do it a=
ll by her/himself.

As of today, running the integration tests can partially be done using an=
 OpenStack tenant and no access to the sepia lab. But some of them (rgw i=
n particular) still need work. There is no need for the gitbuilders becau=
se the teuthology-openstack creates the necessary package on demand, but =
corner cases were fixed this week and there probably are a few others.

The other blocker is the release process which still require significant =
manual intervention, privileged access and undocumented knowledge. This i=
s improving quickly but we're not yet at a stage where an unprivileged th=
ird party is able to run it independently.

I'm under the impression that firefly will indeed be EOL early next year =
because:

 * it is currently impractical for community members to test and publish =
a release
 * the backport activity gradually slowed down as users migrate to hammer=


I hope that my answer will be different by the time Jewel retires :-) The=
 larger goal is to establish a light weight development process that requ=
ires as little resources as possible. Let say adding a patch to a stable =
release, running all the tests and publishing the release can be done wit=
hin a week real time, a few hours of work and less than 1,000 USD to pay =
for the cloud resources. IMHO it is unlikely to expect stable releases fr=
om a community of developers if the effort/cost is significantly higher.

Cheers
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


--XSHTfTuaAhmcDDCan5CK5fmANUVCAR67J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZGXf8ACgkQ8dLMyEl6F23QUwCguPfF4KXT7IMMBleSqz0SM5n8
5F8An2E4BWvXNB2xJ9YxH0JusM7LpuxZ
=a4DZ
-----END PGP SIGNATURE-----

--XSHTfTuaAhmcDDCan5CK5fmANUVCAR67J--
