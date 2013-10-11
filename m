From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Fri, 11 Oct 2013 17:32:22 +0200
Message-ID: <52581A06.2000706@dachary.org>
References: <52580F9B.3080607@dachary.org>	<525816D8.3000609@dachary.org> <CAHX4EnM8C=wy+ixFQu5XJOGo6=6gW6NfkU6=oC7s66X0+UTbWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PVArrWnwhqrkelKClibeqbV9wI3LKbWok"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60761 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3JKPcZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 11:32:25 -0400
In-Reply-To: <CAHX4EnM8C=wy+ixFQu5XJOGo6=6gW6NfkU6=oC7s66X0+UTbWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: darren.birkett@gmail.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PVArrWnwhqrkelKClibeqbV9wI3LKbWok
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 11/10/2013 17:25, Darren Birkett wrote:
> Hi Loic,
>=20
> I wonder is it also worth discussing the state of the 'official' chef c=
ookbooks?
>=20
> https://github.com/ceph/ceph-cookbooks
>=20
> We're interested in these at Rackspace, since we already deploy OpenSta=
ck using our own chef cookbooks:
>=20
> https://github.com/rcbops/chef-cookbooks
>=20
> We plan on pulling in the ceph cookbooks for the rados cluster deployme=
nts, and we have some working POC code inside our other recipes to do the=
 OpenStack specific config for RBD.
>=20
> - Darren

I suspect there is a fragmentation of the work with Chef and probably Sal=
t, Ansible etc. I've not done any research in this area though. Don't you=
 think it deserves a separate discussion ?

Cheers

>=20
>=20
> On 11 October 2013 16:18, Loic Dachary <loic@dachary.org <mailto:loic@d=
achary.org>> wrote:
>=20
>     Someone kindly pointed out that I did not mention the day :-) Here =
are the complete informations:
>=20
>     Tuesday 15th October 2013
>=20
>     16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain =
09:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>=20
>     San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.86=
6.432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germa=
ny: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>=20
>     Room code: 208324756
>     Access code: 208324756
>=20
>     On 11/10/2013 16:47, Loic Dachary wrote:
>     > Hi Ceph,
>     >
>     > What about we discuss the state of Ceph deployment in the context=
 of puppet and / or OpenStack ? If nothing else, it will be a good opport=
unity for all people actively working in this area to touch base. The pro=
posed agenda is to list and possibly clarify the existing methods and may=
be find ways to share the effort.
>     >
>     > The conference call details are a the end of the mail and it will=
 be timeboxed to 30 minutes. There are a number of projects and I made a =
short list below to avoid confusion during the call. Feel free to edit / =
add if I misreprensented you or the project you're associated with ;-)
>     >
>     > Cheers
>     >
>     > * deploy ceph : ceph-deploy
>     >
>     >   for test / POC purposes
>     >   https://github.com/ceph/ceph-deploy
>     >
>     >   maintainer: Alfredo Deza
>     >
>     > * deploy ceph with puppet : puppet-cephdeploy
>     >
>     >   relies on ceph-deploy
>     >   https://github.com/dontalton/puppet-cephdeploy/
>     >
>     >   maintainer: Don Talton
>     >
>     > * deploy ceph with puppet : puppet-ceph
>     >
>     >   developped in 2012 but still useful
>     >   https://github.com/enovance/puppet-ceph
>     >
>     >   maintainer: community
>     >
>     > * ceph + openstack : ceph docs
>     >
>     >   manual integration
>     >   http://ceph.com/docs/next/rbd/rbd-openstack/
>     >    maintainer: John Wilkins + Josh Durgin
>     >
>     > * ceph + openstack with puppet : stackforge
>     >
>     >   https://github.com/stackforge/puppet-glance/blob/stable/grizzly=
/manifests/backend/rbd.pp
>     >   https://github.com/stackforge/puppet-cinder/blob/stable/grizzly=
/manifests/volume/rbd.pp
>     >
>     >   maintainer: community
>     >
>     > * ceph + openstack with puppet : COI
>     >
>     >   targeting Cisco use case
>     >   https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifes=
ts/ceph
>     >   http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation
>     >
>     >   maintainer : Don Talton + Robert Starmer
>     >
>     > * ceph + openstack with puppet : mirantis
>     >
>     >   in the context of Fuel
>     >   https://github.com/Mirantis/fuel/tree/master/deployment/puppet/=
ceph
>     >   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/=
cinder/manifests/volume/ceph.pp
>     >   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/=
glance/manifests/backend/ceph.pp
>     >
>     >   maintainer : Andrew Woodward
>     >
>     > * openstack with puppet : openstack-installer
>     >
>     >   data driven approach to deploy OpenStack
>     >   https://github.com/CiscoSystems/openstack-installer/
>     >
>     >   maintainer: Robert Starmer + Dan Bode
>     >
>     >
>     > 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountai=
n 09:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>     >
>     > San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.=
866.432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Ger=
many: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>     >
>     > Room code: 208324756
>     > Access code: 208324756
>     >
>     > Cheers
>     >
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people d=
o nothing.
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--PVArrWnwhqrkelKClibeqbV9wI3LKbWok
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJYGgYACgkQ8dLMyEl6F22ipQCcDDFY/rjkANTcSzR6FHvp7t91
wtsAniTkn/OmkP8scMVslZukgnUyhbUO
=hxLx
-----END PGP SIGNATURE-----

--PVArrWnwhqrkelKClibeqbV9wI3LKbWok--
