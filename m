From: Loic Dachary <loic@dachary.org>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Fri, 15 May 2015 15:44:59 +0200
Message-ID: <5555F85B.3000407@dachary.org>
References: <55362279.5060105@dachary.org> <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ijtASEm4reua29ohkleju5Hk1v1e3Mu6H"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35822 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422697AbbEONpF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 09:45:05 -0400
In-Reply-To: <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>, dzafman@redhat.com, sjust@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ijtASEm4reua29ohkleju5Hk1v1e3Mu6H
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 21/04/2015 17:52, Sage Weil wrote:
> The bulk of it is ceph-objectstore-tool, which is important to get into=
 a=20
> release, IMO.  David, are these being tested in the firefly thrashing=20
> tests yet?
>=20
> The only other one I'm worried about is
>=20
> 6fd3dfa osd: do not ignore deleted pgs on startup
>=20
> Sam, I assume the recent hammer upgrade issue is would bite firefly fol=
ks=20
> who upgrade too?

A backport of "OSD::load_pgs: we need to handle the case where an upgrade=
 from earlier versions which ignored non-existent pgs resurrects a pg wit=
h a prehistoric osdmap" http://tracker.ceph.com/issues/11429 found at htt=
ps://github.com/ceph/ceph/pull/4556 has been successfully tested on firef=
ly at http://pulpito.ceph.com/loic-2015-05-13_00:01:26-rados-firefly-back=
ports---basic-multi/ and in a rados suite run that completed today http:/=
/tracker.ceph.com/issues/11090#rados.

Provided https://github.com/ceph/ceph/pull/4556 is merged, do you think w=
e should prepare to release firefly v0.80.10 ?

Cheers

>=20
> sage
>=20
>=20
> On Tue, 21 Apr 2015, Loic Dachary wrote:
>=20
>> Hi Sage,
>>
>> The firefly branch has a number of fixes ( http://tracker.ceph.com/iss=
ues/11090#Release-information ) and has been used for upgrade tests in th=
e past few weeks. A few other issues have been backported since and are b=
eing tested in the integration branch ( http://tracker.ceph.com/issues/11=
090#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f79-integra=
tion-branch-april-2015 ).=20
>>
>> Do you think these changes deserve a firefly v0.80.10 release ? Should=
 we ask each lead for their approval ? Or is it better to keep backportin=
g what needs to be and wait a few weeks ?
>>
>> Cheers
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ijtASEm4reua29ohkleju5Hk1v1e3Mu6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVV+FsACgkQ8dLMyEl6F20rSQCfX2V/915CNI4AXaTsvmfh4p3S
i0QAoJ+UnLuSQQzv4qYiQhAsqLTuaVVN
=iz0D
-----END PGP SIGNATURE-----

--ijtASEm4reua29ohkleju5Hk1v1e3Mu6H--
