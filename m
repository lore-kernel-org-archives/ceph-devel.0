From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Fri, 11 Oct 2013 17:18:48 +0200
Message-ID: <525816D8.3000609@dachary.org>
References: <52580F9B.3080607@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CKPIatIRpRd1CexUn6Ugj5bQv3xqqxvWT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60726 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab3JKPSu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 11:18:50 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 1F3D626394
	for <ceph-devel@vger.kernel.org>; Fri, 11 Oct 2013 17:18:49 +0200 (CEST)
In-Reply-To: <52580F9B.3080607@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CKPIatIRpRd1CexUn6Ugj5bQv3xqqxvWT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Someone kindly pointed out that I did not mention the day :-) Here are th=
e complete informations:

Tuesday 15th October 2013

16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09:30-=
10:00 US-Pacific / 18:30-19:00 Europe-Central

San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.432.=
9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany: +4=
9.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666

Room code: 208324756
Access code: 208324756

On 11/10/2013 16:47, Loic Dachary wrote:
> Hi Ceph,
>=20
> What about we discuss the state of Ceph deployment in the context of pu=
ppet and / or OpenStack ? If nothing else, it will be a good opportunity =
for all people actively working in this area to touch base. The proposed =
agenda is to list and possibly clarify the existing methods and maybe fin=
d ways to share the effort.
>=20
> The conference call details are a the end of the mail and it will be ti=
meboxed to 30 minutes. There are a number of projects and I made a short =
list below to avoid confusion during the call. Feel free to edit / add if=
 I misreprensented you or the project you're associated with ;-)
>=20
> Cheers
>=20
> * deploy ceph : ceph-deploy
>=20
>   for test / POC purposes
>   https://github.com/ceph/ceph-deploy
>=20
>   maintainer: Alfredo Deza
>=20
> * deploy ceph with puppet : puppet-cephdeploy
>=20
>   relies on ceph-deploy
>   https://github.com/dontalton/puppet-cephdeploy/
>=20
>   maintainer: Don Talton
>=20
> * deploy ceph with puppet : puppet-ceph
>=20
>   developped in 2012 but still useful
>   https://github.com/enovance/puppet-ceph
>=20
>   maintainer: community
>=20
> * ceph + openstack : ceph docs
>=20
>   manual integration
>   http://ceph.com/docs/next/rbd/rbd-openstack/
>    maintainer: John Wilkins + Josh Durgin
>=20
> * ceph + openstack with puppet : stackforge
>=20
>   https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manif=
ests/backend/rbd.pp
>   https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manif=
ests/volume/rbd.pp
>=20
>   maintainer: community
>=20
> * ceph + openstack with puppet : COI
>=20
>   targeting Cisco use case
>   https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/cep=
h
>   http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation
>=20
>   maintainer : Don Talton + Robert Starmer
>=20
> * ceph + openstack with puppet : mirantis
>=20
>   in the context of Fuel
>   https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinder=
/manifests/volume/ceph.pp
>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glance=
/manifests/backend/ceph.pp
>=20
>   maintainer : Andrew Woodward
>=20
> * openstack with puppet : openstack-installer
>=20
>   data driven approach to deploy OpenStack
>   https://github.com/CiscoSystems/openstack-installer/
>=20
>   maintainer: Robert Starmer + Dan Bode
>=20
>=20
> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09:3=
0-10:00 US-Pacific / 18:30-19:00 Europe-Central
>=20
> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.43=
2.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany: =
+49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>=20
> Room code: 208324756
> Access code: 208324756
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--CKPIatIRpRd1CexUn6Ugj5bQv3xqqxvWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJYFtgACgkQ8dLMyEl6F20T8gCguBtIy9t16U7z26jhHwAmfKNi
5s8An1HtYGbvK1gG+NORqYKAa25C9YsN
=NTN6
-----END PGP SIGNATURE-----

--CKPIatIRpRd1CexUn6Ugj5bQv3xqqxvWT--
