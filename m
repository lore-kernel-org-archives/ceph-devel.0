From: Loic Dachary <loic@dachary.org>
Subject: Re: OpenStack and ceph integration with puppet
Date: Tue, 08 Oct 2013 19:03:19 +0100
Message-ID: <525448E7.5040604@dachary.org>
References: <525413DE.9090405@dachary.org> <etPan.52541b01.d34b6a8.167b7@leseb-mba.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3laLaaIQnrOqLjMAmEDxtT5D0fXvLbTkj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57401 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab3JHSDW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 14:03:22 -0400
In-Reply-To: <etPan.52541b01.d34b6a8.167b7@leseb-mba.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <sebastien.han@enovance.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Bode <bodepd@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3laLaaIQnrOqLjMAmEDxtT5D0fXvLbTkj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 08/10/2013 15:47, S=C3=A9bastien Han wrote:
> Hi Lo=C3=AFc,
>=20
> Actually they are some steps that might be automated such as:
>=20
> * set the virsh secret
> * create both glance and cinder pools

Where do you think it might already be automated ?

> Please take a look at:
>=20
> * https://github.com/dontalton/puppet-cephdeploy/blob/master/manifests/=
init.pp#L121
> * https://github.com/dontalton/puppet-cephdeploy/blob/master/manifests/=
osd.pp#L73

Right ! I overlooked this puppet module.

> For the rest this might be already done but your puppet manifests.

I plan to not write any manifest :-)

> Please also note that http://ceph.com/docs/next/rbd/rbd-openstack/ will=
 need some updates for OpenStack Havana.

Cheers

> =E2=80=93=E2=80=93=E2=80=93=E2=80=93
> S=C3=A9bastien Han
> Cloud Engineer
>=20
> "Always give 100%. Unless you're giving blood.=E2=80=9D
>=20
> Phone: +33 (0)1 49 70 99 72
> Mail: sebastien.han@enovance.com
> Address : 10, rue de la Victoire - 75009 Paris
> Web : www.enovance.com - Twitter : @enovance
>=20
> On October 8, 2013 at 4:18:00 PM, Loic Dachary (loic@dachary.org) wrote=
:
>=20
> Hi Ceph, =20
>=20
> Binding ceph to cinder and glance using puppet requires three steps: =20
>=20
> * Deploy ceph ( with ceph-deploy, puppet, chef ... ) =20
>=20
> * Follow the ceph documentation instructions ( valid for both cinder an=
d glance ) =20
>=20
> http://ceph.com/docs/next/rbd/rbd-openstack/ =20
>=20
> * Part of the above instructions can be skipped if the following are us=
ed =20
>=20
> https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manifes=
ts/backend/rbd.pp =20
> https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manifes=
ts/volume/rbd.pp =20
>=20
> They take care of installing a package on the glance and cinder node an=
d writing the cinder and glance config files. =20
>=20
> * Upgrading the librbd on the compute hosts to match the version of the=
 cluster ( ubuntu precise has bobtail but you may want at least cuttlefis=
h ) =20
>=20
> I would be delighted to know if there is a simpler way. If not, would i=
t make sense to provide the puppet master with the IP of the monitors and=
 admin rights so that it can automate http://ceph.com/docs/next/rbd/rbd-o=
penstack/ ? =20
>=20
> * install ceph-common on cinder hosts and python-ceph on glance hosts  =

> * set the monitor addresses =20
> * copy the keyring to cinder / glance =20
> * create the client.volumes / client.images users ( support <=3D 0.53 ?=
 ) =20
> * upgrade the librbd package on the compute hosts to the version matchi=
ng the cluster =20
> * virsh secret-set-value the volume key on each compute host =20
> * reload glance/nova/cinder where appropriate =20
>=20
> The puppet master could even refresh the list of monitors from time to =
time and update the cinder/glance nodes accordingly. And it could do the =
right thing depending on the target openstack version and ceph version.  =

>=20
> Thoughts ? =20
>=20
> -- =20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre =20
> All that is necessary for the triumph of evil is that good people do no=
thing.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--3laLaaIQnrOqLjMAmEDxtT5D0fXvLbTkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlJUSOcACgkQ8dLMyEl6F23nYQCXZZclFw+iAt9PRaEsnyzSrC/T
ewCgqBjAXZ33N9SDzVCISunevWRaqTI=
=bBHY
-----END PGP SIGNATURE-----

--3laLaaIQnrOqLjMAmEDxtT5D0fXvLbTkj--
