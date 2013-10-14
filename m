From: Loic Dachary <loic@dachary.org>
Subject: Re: rbd support in openstack-installer
Date: Mon, 14 Oct 2013 10:47:11 +0200
Message-ID: <525BAF8F.8040504@dachary.org>
References: <525B2DF7.6080106@dachary.org> <CA+0t2Lw=mBaurrjtB+Zg5MiFjfyxMQ6JfCBN-hGjhnW4f7=diQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KnJcj901nvH5B9KmrWi8iSugomKqja45G"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34459 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306Ab3JNIrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Oct 2013 04:47:13 -0400
In-Reply-To: <CA+0t2Lw=mBaurrjtB+Zg5MiFjfyxMQ6JfCBN-hGjhnW4f7=diQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Bode <bodepd@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Don Talton -X (dotalton - TSG at Cisco)" <dotalton@cisco.com>, "Robert Starmer (starmer)" <starmer@cisco.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KnJcj901nvH5B9KmrWi8iSugomKqja45G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 14/10/2013 08:31, Dan Bode wrote:>=20
>=20
>=20
> On Sun, Oct 13, 2013 at 4:34 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Dan,
>=20
>     I'm looking for the path of least resistance to add rbd support to =
https://github.com/CiscoSystems/openstack-installer/ Being unfamiliar wit=
h the data oriented approach it would be great to get your advice on the =
following.
>=20
>=20
>     * assume ceph has already been installed without cephx which simpli=
fies configuration. From the point of view of integration tests it means =
installing when vagrant is setup ( which I currently rely on ) or via htt=
ps://github.com/CiscoSystems/openstack-installer/tree/master/stack-builde=
r. Not sure if the post_config is where it
>=20
>     should be installed for test purposes. Not sure how to let it know =
what IP to use.
>=20
>=20
> I would really prefer not to use post_config for this purpose. I would =
much rather encode this logic into Puppet so that it's more consistent wi=
th the overall framework. It would be ok, even if the Puppet class simply=
 wrapped your provided script, and long as the script arguments are provi=
ded as class parameters. I've copied Don on this thread to see if perhaps=
 he already had Puppet content in mind for the configuration your script =
is performing:
>=20
> This is a bit more work, but provides the following advantages:
> - all data related to the ceph configuration being done by your script =
can be provided as a regular part of the data hierarchy (this answers you=
r question related to where you set the ip)
> - the data framework can be used to configure whether or not this confi=
guration is applied to a node. (from a testing perspective, I want whethe=
r or not to run tests for the ceph deployment to be a configuration setti=
ng for the deployment process, so that we can choose to deploy the 2_role=
 configuration, and select ceph or some other backend for testing)

I better understand the approach and it makes sense.=20


>=20
>     I could add this to cinder + nova because it's needed by both.
>=20
>=20
> do you mean add it to the stackforge modules?

Yes. At the moment they assume /etc/ceph/ceph.conf already exists. It imp=
lies either that ceph is deployed with a puppet module or that the ceph d=
eployment tool has access to cinder and nova hosts to write the /etc/ceph=
/ceph.conf. It looks like it would make sense to add a list of monitors=20

# [*rbd_mon_host*]
# (optional) The list of mons IPs
#

and if set

https://github.com/stackforge/puppet-cinder/blob/master/manifests/volume/=
rbd.pp

would create /etc/ceph/ceph.conf. The same could be done for nova.=20


>     I suppose it's what should be done since openstack-installer has no=
 template at the moment.
>=20
>     [global]
>     mon host =3D 192.168.242.100
>=20
>     * setting the default parameters
>=20
>     diff --git a/data/hiera_data/user.common.yaml b/data/hiera_data/use=
r.common.yaml
>     index 349eb1a..c38a0a4 100644
>     --- a/data/hiera_data/user.common.yaml
>     +++ b/data/hiera_data/user.common.yaml
>     @@ -48,3 +48,7 @@ swift_service_password: swift_pass
>      swift_hash: super_secret_swift_hash
>      glance::backend::swift::swift_store_key: secret_key
>      glance::backend::swift::swift_store_auth_address: '127.0.0.1'
>     +
>     +cinder::volume::rbd::rbd_pool: 'rbd'
>     +cinder::volume::rbd::glance_api_version: '2'
>     +cinder::volume::rbd::rbd_user: 'no cephx'
>=20
> =20
>=20
> I would rather this not be applied to the user common configuration. In=
 general, I intended for things in the user*.yaml files to be things that=
 a user provides (as opposed to things that need to be set by default for=
 a certain deployment model)
>=20
> I was discussing where this configuration goes with Don on Friday. Ther=
e are two possible options:
>=20
> 1. The following lines (https://github.com/CiscoSystems/openstack-insta=
ller/blob/master/manifests/setup.pp#L72-L73) can already be used to speci=
fy default configuration that should be applied when you select ceph as e=
ither the backend for glance or swift. In that case, it should be provide=
d in:
>=20
>   data/hiera_data/cinder_backend/rbd.yaml
>     and
>   data/hiera_data/glance_backend/rbd.yaml
>=20
> This way, that data is set when you select ceph as the backend for eith=
er of these services.
>=20
> The disadvantage is that you would have to duplicate the same data in b=
oth files (b/c a user could select ceph as the backend for glance or cind=
er or both).
>=20
> 2. The other alternative, is to create a new global_hiera_param that ca=
n be used to enable ceph, then set ceph specific data based on that varia=
ble:
>=20
>     data/hiera_data/ceph_enabled/true.yaml
>=20
> Out of those two options, I prefer #1 (b/c we don't have to add anythin=
g new to our hierarchy)

I created a pull request to support this thread with actual diffs.=20

https://github.com/CiscoSystems/openstack-installer/pull/150/files

The glance parameters are not exactly the same as the cinder parameters. =
How should hiera_data/glance_backend/rbd.yaml be referenced when specifyi=
ng the glance backend ? The logic is in place for cinder bus/t I'm not su=
re how this should be done for glance.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--KnJcj901nvH5B9KmrWi8iSugomKqja45G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJbr48ACgkQ8dLMyEl6F21ToQCbBIlFR4BC6slZv0OZohsccYfx
RfYAnioxj27AYf/cGyLR/pcBL3t+jrQl
=Zahq
-----END PGP SIGNATURE-----

--KnJcj901nvH5B9KmrWi8iSugomKqja45G--
