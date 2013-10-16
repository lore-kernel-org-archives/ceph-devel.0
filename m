From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Wed, 16 Oct 2013 21:26:34 +0200
Message-ID: <525EE86A.7030407@dachary.org>
References: <52580F9B.3080607@dachary.org> <525816D8.3000609@dachary.org> <525D61CD.5010707@dachary.org> <525EE69C.7090602@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="krGql5xMvXUl3ljkl4xnS6tgj2cA0G8or"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37534 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab3JPT0g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 15:26:36 -0400
In-Reply-To: <525EE69C.7090602@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--krGql5xMvXUl3ljkl4xnS6tgj2cA0G8or
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Danny,

There was a thread to figure out a central place to work on puppet ceph m=
odules. It's still undecided, you're very welcome to contribute :-)

https://groups.google.com/a/puppetlabs.com/forum/#!topic/puppet-openstack=
/ibnrmXBAxVg

My preference is for having puppet-ceph under the umbrella of stackforge.=
=20

Cheers

On 16/10/2013 21:18, Danny Al-Gaaf wrote:
> Hi,
>=20
> I've overseen this call, sorry. Is there any meeting results or a log?
>=20
> I asked because we (Deutsche Telekom AG) forked our puppet-ceph module
> from the enovance puppet-ceph (deploying ceph without ceph-deploy) and
> we plan to contribute our code back to the community into the source
> project.
>=20
> You can find our code here:
> https://github.com/TelekomCloud/puppet-ceph/tree/rc/eisbrecher
>=20
> Or the basic changes without RadosGW support in my repo:
> https://github.com/dalgaaf/puppet-ceph/tree/feature/wip-da-rework-and-s=
implify
>=20
> If you have any questions about the code, ask me since I didn't update
> the documentation to reflect the new code yet.
>=20
> Regards,
>=20
> Danny
>=20
> Am 15.10.2013 17:39, schrieb Loic Dachary:
>> Hi,
>>
>> The call was rescheduled one hour later. It is now:
>>
>> 17:30-18:00 UTC / 13:30-14:00 US-Eastern / 11:30-12:00 US-Mountain 10:=
30-11:00 US-Pacific / 19:30-20:00 Europe-Central
>>
>> Phone numbers : http://www.cisco.com/web/about/doing_business/conferen=
cing/index.html
>>
>> Room code: 208324756
>> Access code: 208324756
>>
>> Cheers
>>
>> On 11/10/2013 17:18, Loic Dachary wrote:
>>> Someone kindly pointed out that I did not mention the day :-) Here ar=
e the complete informations:
>>>
>>> Tuesday 15th October 2013
>>>
>>> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09=
:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>>>
>>> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.=
432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany=
: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>>>
>>> Room code: 208324756
>>> Access code: 208324756
>>>
>>> On 11/10/2013 16:47, Loic Dachary wrote:
>>>> Hi Ceph,
>>>>
>>>> What about we discuss the state of Ceph deployment in the context of=
 puppet and / or OpenStack ? If nothing else, it will be a good opportuni=
ty for all people actively working in this area to touch base. The propos=
ed agenda is to list and possibly clarify the existing methods and maybe =
find ways to share the effort.
>>>>
>>>> The conference call details are a the end of the mail and it will be=
 timeboxed to 30 minutes. There are a number of projects and I made a sho=
rt list below to avoid confusion during the call. Feel free to edit / add=
 if I misreprensented you or the project you're associated with ;-)
>>>>
>>>> Cheers
>>>>
>>>> * deploy ceph : ceph-deploy
>>>>
>>>>   for test / POC purposes
>>>>   https://github.com/ceph/ceph-deploy
>>>>
>>>>   maintainer: Alfredo Deza
>>>>
>>>> * deploy ceph with puppet : puppet-cephdeploy
>>>>
>>>>   relies on ceph-deploy
>>>>   https://github.com/dontalton/puppet-cephdeploy/
>>>>
>>>>   maintainer: Don Talton
>>>>
>>>> * deploy ceph with puppet : puppet-ceph
>>>>
>>>>   developped in 2012 but still useful
>>>>   https://github.com/enovance/puppet-ceph
>>>>
>>>>   maintainer: community
>>>>
>>>> * ceph + openstack : ceph docs
>>>>
>>>>   manual integration
>>>>   http://ceph.com/docs/next/rbd/rbd-openstack/
>>>>    maintainer: John Wilkins + Josh Durgin
>>>>
>>>> * ceph + openstack with puppet : stackforge
>>>>
>>>>   https://github.com/stackforge/puppet-glance/blob/stable/grizzly/ma=
nifests/backend/rbd.pp
>>>>   https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/ma=
nifests/volume/rbd.pp
>>>>
>>>>   maintainer: community
>>>>
>>>> * ceph + openstack with puppet : COI
>>>>
>>>>   targeting Cisco use case
>>>>   https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/=
ceph
>>>>   http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation
>>>>
>>>>   maintainer : Don Talton + Robert Starmer
>>>>
>>>> * ceph + openstack with puppet : mirantis
>>>>
>>>>   in the context of Fuel
>>>>   https://github.com/Mirantis/fuel/tree/master/deployment/puppet/cep=
h
>>>>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cin=
der/manifests/volume/ceph.pp
>>>>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/gla=
nce/manifests/backend/ceph.pp
>>>>
>>>>   maintainer : Andrew Woodward
>>>>
>>>> * openstack with puppet : openstack-installer
>>>>
>>>>   data driven approach to deploy OpenStack
>>>>   https://github.com/CiscoSystems/openstack-installer/
>>>>
>>>>   maintainer: Robert Starmer + Dan Bode
>>>>
>>>>
>>>> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 0=
9:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>>>>
>>>> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866=
=2E432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germ=
any: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>>>>
>>>> Room code: 208324756
>>>> Access code: 208324756
>>>>
>>>> Cheers
>>>>
>>>
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--krGql5xMvXUl3ljkl4xnS6tgj2cA0G8or
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJe6GoACgkQ8dLMyEl6F23UDgCgryFYO8XDa6UaneDnNT1/Krpi
7yMAni9Ia2uyWTDTmWy8D8mXDcAi5IcO
=mf2M
-----END PGP SIGNATURE-----

--krGql5xMvXUl3ljkl4xnS6tgj2cA0G8or--
