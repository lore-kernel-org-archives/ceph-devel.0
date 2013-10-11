From: Loic Dachary <loic@dachary.org>
Subject: Ceph and puppet and OpenStack : open conference call
Date: Fri, 11 Oct 2013 16:47:55 +0200
Message-ID: <52580F9B.3080607@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5XfGaCvsEtHQ94O7DdRdeQnXiwOkbh4oe"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60668 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3JKOr6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 10:47:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5XfGaCvsEtHQ94O7DdRdeQnXiwOkbh4oe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

What about we discuss the state of Ceph deployment in the context of pupp=
et and / or OpenStack ? If nothing else, it will be a good opportunity fo=
r all people actively working in this area to touch base. The proposed ag=
enda is to list and possibly clarify the existing methods and maybe find =
ways to share the effort.

The conference call details are a the end of the mail and it will be time=
boxed to 30 minutes. There are a number of projects and I made a short li=
st below to avoid confusion during the call. Feel free to edit / add if I=
 misreprensented you or the project you're associated with ;-)

Cheers

* deploy ceph : ceph-deploy

  for test / POC purposes
  https://github.com/ceph/ceph-deploy

  maintainer: Alfredo Deza

* deploy ceph with puppet : puppet-cephdeploy

  relies on ceph-deploy
  https://github.com/dontalton/puppet-cephdeploy/

  maintainer: Don Talton

* deploy ceph with puppet : puppet-ceph

  developped in 2012 but still useful
  https://github.com/enovance/puppet-ceph

  maintainer: community

* ceph + openstack : ceph docs

  manual integration
  http://ceph.com/docs/next/rbd/rbd-openstack/
   maintainer: John Wilkins + Josh Durgin

* ceph + openstack with puppet : stackforge

  https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manifes=
ts/backend/rbd.pp
  https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manifes=
ts/volume/rbd.pp

  maintainer: community

* ceph + openstack with puppet : COI

  targeting Cisco use case
  https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/ceph
  http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation

  maintainer : Don Talton + Robert Starmer

* ceph + openstack with puppet : mirantis

  in the context of Fuel
  https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
  https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinder/m=
anifests/volume/ceph.pp
  https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glance/m=
anifests/backend/ceph.pp

  maintainer : Andrew Woodward

* openstack with puppet : openstack-installer

  data driven approach to deploy OpenStack
  https://github.com/CiscoSystems/openstack-installer/

  maintainer: Robert Starmer + Dan Bode


16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09:30-=
10:00 US-Pacific / 18:30-19:00 Europe-Central

San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.432.=
9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany: +4=
9.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666

Room code: 208324756
Access code: 208324756

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.





--5XfGaCvsEtHQ94O7DdRdeQnXiwOkbh4oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJYD5wACgkQ8dLMyEl6F20DnACZAYT0U9L6CjX/TpG5R3MacTrO
nZAAoJH2nGZUs85FP0A8XfT50hjMsPjl
=1j4o
-----END PGP SIGNATURE-----

--5XfGaCvsEtHQ94O7DdRdeQnXiwOkbh4oe--
