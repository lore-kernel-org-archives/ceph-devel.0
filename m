From: Loic Dachary <loic@dachary.org>
Subject: Re: Docker task for teuthology
Date: Thu, 02 Jul 2015 15:07:21 +0200
Message-ID: <55953789.5090408@dachary.org>
References: <971548538.4673346.1435793765362.JavaMail.zimbra@redhat.com> <1354525906.4673455.1435793988737.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="APiKwgN9U62gwfrnPiD6ouwOkwSD4FW9x"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43701 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998AbbGBNHY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2015 09:07:24 -0400
In-Reply-To: <1354525906.4673455.1435793988737.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ivo Jimenez <ivo@redhat.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--APiKwgN9U62gwfrnPiD6ouwOkwSD4FW9x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/07/2015 01:39, Ivo Jimenez wrote:> Re-sending in plain text (origin=
al HTML message bounced)
>=20
> ----- Original Message -----=20
> From: "Ivo Jimenez" <ivo@redhat.com>=20
> To: "Loic Dachary" <ldachary@redhat.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Sent: Wednesday, July 1, 2015 4:36:05 PM=20
> Subject: Docker task for teuthology=20
>=20
>=20
> Hi Lo=C3=AFc,
>=20
> I=E2=80=99m a summer intern working at Red Hat on a project to bring no=
n-functional testing to Ceph [1]. Zack mentioned that you worked on havin=
g teuthology use containers to deploy ceph and run tests. I found your bl=
og posts and corresponding branches. Would it be possible for you to shar=
e your experience and the reason why you stopped working on that?=20

I did not stop working on it :-) It has been something I worked on the si=
de as a proof of concept and also to learn the teuthology code base. I've=
 recently spent more time on having the OpenStack backend working for rea=
l ( http://tracker.ceph.com/issues/6502 ) which leads to a series of chan=
ges that will eventually make it easier to implement the Docker backend. =
The reason for focusing on the OpenStack backend is that it scales where =
the Docker Backend can only run so many instances.

> Also, if you have time, could you please take a look at the initial cod=
e additions [2] that I=E2=80=99m working on? Any feedback would me much a=
ppreciated.

I did not know about https://github.com/signalfuse/maestro-ng, sound real=
ly interesting ! How is it different from https://github.com/GoogleCloudP=
latform/kubernetes or https://github.com/projectatomic or https://coreos.=
com/ ? I've no experience in any of them.=20

You're going in a direction I did not think about: adding a task instead =
of modifying teuthology itself. It's an interesting route and maybe bette=
r than the one I took which is to modify the lock/provision files, mostly=
, to create OpenStack machines instead of Downburst machines. I'm very in=
terested to know if that works out. Modifying the internals of teuthology=
 is more complicated and if your method works, it's likely to be simpler.=


I see you wrote tests which is much needed. I found that having integrati=
on tests is better than any kind of unit / functional testing because, in=
 the end, most of teuthology work is to properly assemble and run bits an=
d pieces that are external to it. In other words, without integration tes=
ts you cover only a fraction of the behavior even if you cover 100% of th=
e LOC.

Cheers

> thanks!=20
>=20
> [1]: http://tracker.ceph.com/projects/ceph/wiki/Testing_-_non-functiona=
l_tests
> [2]: https://github.com/ceph/teuthology/pull/558=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--APiKwgN9U62gwfrnPiD6ouwOkwSD4FW9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWVN4kACgkQ8dLMyEl6F22Y6QCeKCHgSUQFm4LBjD4EWgoscQEa
IeIAoL1/iuiZr+o4DO2UeTW2BElAusMc
=/Nv2
-----END PGP SIGNATURE-----

--APiKwgN9U62gwfrnPiD6ouwOkwSD4FW9x--
