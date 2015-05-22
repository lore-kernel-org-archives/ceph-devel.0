From: Loic Dachary <loic@dachary.org>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Fri, 22 May 2015 12:43:08 +0200
Message-ID: <555F083C.9080700@dachary.org>
References: <55362279.5060105@dachary.org> <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net> <5555F85B.3000407@dachary.org> <alpine.DEB.2.00.1505151205220.10788@cobra.newdream.net> <555654E8.1030806@dachary.org> <5559DF5E.4090706@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IAMsqndwNWmisJCxQvpjjBfJjDJbSvifs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49104 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752120AbbEVKnL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 06:43:11 -0400
In-Reply-To: <5559DF5E.4090706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IAMsqndwNWmisJCxQvpjjBfJjDJbSvifs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping ?

On 18/05/2015 14:47, Loic Dachary wrote:
> Hi Sage,
>=20
> The following are now in the firefly branch.=20
>=20
> https://github.com/ceph/ceph/pull/4697 which includes fixes for http://=
tracker.ceph.com/issues/11622 and http://tracker.ceph.com/issues/11604
> https://github.com/ceph/ceph/pull/4556 OSD::load_pgs: we need to handle=
 the case where an upgrade from earlier versions which ignored non-existe=
nt pgs resurrects a pg with a prehistoric osdmap =20
>=20
> Do you think we should prepare to release firefly v0.80.10 ? If yes the=
 branch will be handed over to QE for further testing.
>=20
> Cheers
>=20
> On 15/05/2015 22:19, Loic Dachary wrote:
>>
>>
>> On 15/05/2015 21:05, Sage Weil wrote:
>>> On Fri, 15 May 2015, Loic Dachary wrote:
>>>> Hi Sage,
>>>>
>>>> On 21/04/2015 17:52, Sage Weil wrote:
>>>>> The bulk of it is ceph-objectstore-tool, which is important to get =
into a=20
>>>>> release, IMO.  David, are these being tested in the firefly thrashi=
ng=20
>>>>> tests yet?
>>>>>
>>>>> The only other one I'm worried about is
>>>>>
>>>>> 6fd3dfa osd: do not ignore deleted pgs on startup
>>>>>
>>>>> Sam, I assume the recent hammer upgrade issue is would bite firefly=
 folks=20
>>>>> who upgrade too?
>>>>
>>>> A backport of "OSD::load_pgs: we need to handle the case where an up=
grade from earlier versions which ignored non-existent pgs resurrects a p=
g with a prehistoric osdmap" http://tracker.ceph.com/issues/11429 found a=
t https://github.com/ceph/ceph/pull/4556 has been successfully tested on =
firefly at http://pulpito.ceph.com/loic-2015-05-13_00:01:26-rados-firefly=
-backports---basic-multi/ and in a rados suite run that completed today h=
ttp://tracker.ceph.com/issues/11090#rados.
>>>>
>>>> Provided https://github.com/ceph/ceph/pull/4556 is merged, do you th=
ink we should prepare to release firefly v0.80.10 ?
>>>
>>> As Yehuda mentioned the other open issue is the rgw multipart corrupt=
ion. =20
>>> I'm guessing we want to include that?
>>
>> Yes, we will include and test the http://tracker.ceph.com/issues/11622=
 and http://tracker.ceph.com/issues/11604 backports.
>>
>> Cheers
>>
>>>
>>> sage
>>>
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>> On Tue, 21 Apr 2015, Loic Dachary wrote:
>>>>>
>>>>>> Hi Sage,
>>>>>>
>>>>>> The firefly branch has a number of fixes ( http://tracker.ceph.com=
/issues/11090#Release-information ) and has been used for upgrade tests i=
n the past few weeks. A few other issues have been backported since and a=
re being tested in the integration branch ( http://tracker.ceph.com/issue=
s/11090#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f79-int=
egration-branch-april-2015 ).=20
>>>>>>
>>>>>> Do you think these changes deserve a firefly v0.80.10 release ? Sh=
ould we ask each lead for their approval ? Or is it better to keep backpo=
rting what needs to be and wait a few weeks ?
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> --=20
>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>
>>>>
>>>> --=20
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IAMsqndwNWmisJCxQvpjjBfJjDJbSvifs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfCDwACgkQ8dLMyEl6F20cqQCgqeeP+YN3Lp7jXRYuFEYfcqq6
FjwAnA18bZycteYyoo9Rvmdf7zL7maEa
=fpS5
-----END PGP SIGNATURE-----

--IAMsqndwNWmisJCxQvpjjBfJjDJbSvifs--
