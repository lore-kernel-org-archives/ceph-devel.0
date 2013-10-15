From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Tue, 15 Oct 2013 17:39:57 +0200
Message-ID: <525D61CD.5010707@dachary.org>
References: <52580F9B.3080607@dachary.org> <525816D8.3000609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pp2L9IJ5d0VaiSvLxKroWNsWQkovNP77k"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:36128 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3JOPkA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Oct 2013 11:40:00 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 170D026398
	for <ceph-devel@vger.kernel.org>; Tue, 15 Oct 2013 17:39:58 +0200 (CEST)
In-Reply-To: <525816D8.3000609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pp2L9IJ5d0VaiSvLxKroWNsWQkovNP77k
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The call was rescheduled one hour later. It is now:

17:30-18:00 UTC / 13:30-14:00 US-Eastern / 11:30-12:00 US-Mountain 10:30-=
11:00 US-Pacific / 19:30-20:00 Europe-Central

Phone numbers : http://www.cisco.com/web/about/doing_business/conferencin=
g/index.html

Room code: 208324756
Access code: 208324756

Cheers

On 11/10/2013 17:18, Loic Dachary wrote:
> Someone kindly pointed out that I did not mention the day :-) Here are =
the complete informations:
>=20
> Tuesday 15th October 2013
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
> On 11/10/2013 16:47, Loic Dachary wrote:
>> Hi Ceph,
>>
>> What about we discuss the state of Ceph deployment in the context of p=
uppet and / or OpenStack ? If nothing else, it will be a good opportunity=
 for all people actively working in this area to touch base. The proposed=
 agenda is to list and possibly clarify the existing methods and maybe fi=
nd ways to share the effort.
>>
>> The conference call details are a the end of the mail and it will be t=
imeboxed to 30 minutes. There are a number of projects and I made a short=
 list below to avoid confusion during the call. Feel free to edit / add i=
f I misreprensented you or the project you're associated with ;-)
>>
>> Cheers
>>
>> * deploy ceph : ceph-deploy
>>
>>   for test / POC purposes
>>   https://github.com/ceph/ceph-deploy
>>
>>   maintainer: Alfredo Deza
>>
>> * deploy ceph with puppet : puppet-cephdeploy
>>
>>   relies on ceph-deploy
>>   https://github.com/dontalton/puppet-cephdeploy/
>>
>>   maintainer: Don Talton
>>
>> * deploy ceph with puppet : puppet-ceph
>>
>>   developped in 2012 but still useful
>>   https://github.com/enovance/puppet-ceph
>>
>>   maintainer: community
>>
>> * ceph + openstack : ceph docs
>>
>>   manual integration
>>   http://ceph.com/docs/next/rbd/rbd-openstack/
>>    maintainer: John Wilkins + Josh Durgin
>>
>> * ceph + openstack with puppet : stackforge
>>
>>   https://github.com/stackforge/puppet-glance/blob/stable/grizzly/mani=
fests/backend/rbd.pp
>>   https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/mani=
fests/volume/rbd.pp
>>
>>   maintainer: community
>>
>> * ceph + openstack with puppet : COI
>>
>>   targeting Cisco use case
>>   https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/ce=
ph
>>   http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation
>>
>>   maintainer : Don Talton + Robert Starmer
>>
>> * ceph + openstack with puppet : mirantis
>>
>>   in the context of Fuel
>>   https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
>>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinde=
r/manifests/volume/ceph.pp
>>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glanc=
e/manifests/backend/ceph.pp
>>
>>   maintainer : Andrew Woodward
>>
>> * openstack with puppet : openstack-installer
>>
>>   data driven approach to deploy OpenStack
>>   https://github.com/CiscoSystems/openstack-installer/
>>
>>   maintainer: Robert Starmer + Dan Bode
>>
>>
>> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09:=
30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>>
>> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.4=
32.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany:=
 +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>>
>> Room code: 208324756
>> Access code: 208324756
>>
>> Cheers
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--pp2L9IJ5d0VaiSvLxKroWNsWQkovNP77k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJdYc0ACgkQ8dLMyEl6F21GRQCfbYIpLejB5nWpuDHJ9Gcd9Z3/
HDUAn3Q6BPRsb1SbJrHcOJFAzBLLHZb+
=FcV2
-----END PGP SIGNATURE-----

--pp2L9IJ5d0VaiSvLxKroWNsWQkovNP77k--
