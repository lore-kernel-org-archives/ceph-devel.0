From: Loic Dachary <loic@dachary.org>
Subject: OpenStack and ceph integration with puppet
Date: Tue, 08 Oct 2013 16:17:02 +0200
Message-ID: <525413DE.9090405@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4TT45nlCU5k1PjAnfIVswNtvtbbfvtDIm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57198 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab3JHORh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 10:17:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Bode <bodepd@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4TT45nlCU5k1PjAnfIVswNtvtbbfvtDIm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Binding ceph to cinder and glance using puppet requires three steps:

* Deploy ceph ( with ceph-deploy, puppet, chef ... )

* Follow the ceph documentation instructions ( valid for both cinder and =
glance )

  http://ceph.com/docs/next/rbd/rbd-openstack/

* Part of the above instructions can be skipped if the following are used=


  https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manifes=
ts/backend/rbd.pp
  https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manifes=
ts/volume/rbd.pp

  They take care of installing a package on the glance and cinder node an=
d writing the cinder and glance config files.

* Upgrading the librbd on the compute hosts to match the version of the c=
luster ( ubuntu precise has bobtail but you may want at least cuttlefish =
)

I would be delighted to know if there is a simpler way. If not, would it =
make sense to provide the puppet master with the IP of the monitors and a=
dmin rights so that it can automate http://ceph.com/docs/next/rbd/rbd-ope=
nstack/ ?

  * install ceph-common on cinder hosts and python-ceph on glance hosts
  * set the monitor addresses
  * copy the keyring to cinder / glance
  * create the client.volumes / client.images users ( support <=3D 0.53 ?=
 )
  * upgrade the librbd package on the compute hosts to the version matchi=
ng the cluster
  * virsh secret-set-value the volume key on each compute host
  * reload glance/nova/cinder where appropriate

The puppet master could even refresh the list of monitors from time to ti=
me and update the cinder/glance nodes accordingly. And it could do the ri=
ght thing depending on the target openstack version and ceph version.

Thoughts ?

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--4TT45nlCU5k1PjAnfIVswNtvtbbfvtDIm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJUE98ACgkQ8dLMyEl6F22sqACfSddGG3qTQ25uQJ6bNVRohXqb
q9wAnj9bjnC2sh/hoo+RVY2LFYlmFxkT
=w8eM
-----END PGP SIGNATURE-----

--4TT45nlCU5k1PjAnfIVswNtvtbbfvtDIm--
