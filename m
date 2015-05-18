From: Loic Dachary <loic@dachary.org>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Mon, 18 May 2015 14:47:26 +0200
Message-ID: <5559DF5E.4090706@dachary.org>
References: <55362279.5060105@dachary.org> <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net> <5555F85B.3000407@dachary.org> <alpine.DEB.2.00.1505151205220.10788@cobra.newdream.net> <555654E8.1030806@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UMiQE9nqT3THXFqOh5RjjxBDgke5LCnPQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37060 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752292AbbERMr3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 08:47:29 -0400
In-Reply-To: <555654E8.1030806@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>, dzafman@redhat.com, sjust@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UMiQE9nqT3THXFqOh5RjjxBDgke5LCnPQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

The following are now in the firefly branch.=20

https://github.com/ceph/ceph/pull/4697 which includes fixes for http://tr=
acker.ceph.com/issues/11622 and http://tracker.ceph.com/issues/11604
https://github.com/ceph/ceph/pull/4556 OSD::load_pgs: we need to handle t=
he case where an upgrade from earlier versions which ignored non-existent=
 pgs resurrects a pg with a prehistoric osdmap =20

Do you think we should prepare to release firefly v0.80.10 ? If yes the b=
ranch will be handed over to QE for further testing.

Cheers

On 15/05/2015 22:19, Loic Dachary wrote:
>=20
>=20
> On 15/05/2015 21:05, Sage Weil wrote:
>> On Fri, 15 May 2015, Loic Dachary wrote:
>>> Hi Sage,
>>>
>>> On 21/04/2015 17:52, Sage Weil wrote:
>>>> The bulk of it is ceph-objectstore-tool, which is important to get i=
nto a=20
>>>> release, IMO.  David, are these being tested in the firefly thrashin=
g=20
>>>> tests yet?
>>>>
>>>> The only other one I'm worried about is
>>>>
>>>> 6fd3dfa osd: do not ignore deleted pgs on startup
>>>>
>>>> Sam, I assume the recent hammer upgrade issue is would bite firefly =
folks=20
>>>> who upgrade too?
>>>
>>> A backport of "OSD::load_pgs: we need to handle the case where an upg=
rade from earlier versions which ignored non-existent pgs resurrects a pg=
 with a prehistoric osdmap" http://tracker.ceph.com/issues/11429 found at=
 https://github.com/ceph/ceph/pull/4556 has been successfully tested on f=
irefly at http://pulpito.ceph.com/loic-2015-05-13_00:01:26-rados-firefly-=
backports---basic-multi/ and in a rados suite run that completed today ht=
tp://tracker.ceph.com/issues/11090#rados.
>>>
>>> Provided https://github.com/ceph/ceph/pull/4556 is merged, do you thi=
nk we should prepare to release firefly v0.80.10 ?
>>
>> As Yehuda mentioned the other open issue is the rgw multipart corrupti=
on. =20
>> I'm guessing we want to include that?
>=20
> Yes, we will include and test the http://tracker.ceph.com/issues/11622 =
and http://tracker.ceph.com/issues/11604 backports.
>=20
> Cheers
>=20
>>
>> sage
>>
>>>
>>> Cheers
>>>
>>>>
>>>> sage
>>>>
>>>>
>>>> On Tue, 21 Apr 2015, Loic Dachary wrote:
>>>>
>>>>> Hi Sage,
>>>>>
>>>>> The firefly branch has a number of fixes ( http://tracker.ceph.com/=
issues/11090#Release-information ) and has been used for upgrade tests in=
 the past few weeks. A few other issues have been backported since and ar=
e being tested in the integration branch ( http://tracker.ceph.com/issues=
/11090#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f79-inte=
gration-branch-april-2015 ).=20
>>>>>
>>>>> Do you think these changes deserve a firefly v0.80.10 release ? Sho=
uld we ask each lead for their approval ? Or is it better to keep backpor=
ting what needs to be and wait a few weeks ?
>>>>>
>>>>> Cheers
>>>>>
>>>>> --=20
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>>
>>> --=20
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UMiQE9nqT3THXFqOh5RjjxBDgke5LCnPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVZ314ACgkQ8dLMyEl6F22SXwCfbHo99G0IR/n8aMHP1gCjh3Ae
JM0AniHDGc8RmwAfNAMUYTMv/yST9jDc
=Cc4c
-----END PGP SIGNATURE-----

--UMiQE9nqT3THXFqOh5RjjxBDgke5LCnPQ--
