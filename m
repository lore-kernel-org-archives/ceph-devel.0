From: Loic Dachary <loic@dachary.org>
Subject: Re: rbd support in openstack-installer
Date: Tue, 15 Oct 2013 00:47:21 +0200
Message-ID: <525C7479.7090204@dachary.org>
References: <525B2DF7.6080106@dachary.org>	<CA+0t2Lw=mBaurrjtB+Zg5MiFjfyxMQ6JfCBN-hGjhnW4f7=diQ@mail.gmail.com>	<525BAF8F.8040504@dachary.org> <CA+0t2Lysy7Krk21EVriqBmbk+oQMnwWncE7zG10r5VMmDAhmMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HuSaLq4X5kww4vjsRGW8wROs5ujw8lJ7b"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:35182 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab3JNWrY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Oct 2013 18:47:24 -0400
In-Reply-To: <CA+0t2Lysy7Krk21EVriqBmbk+oQMnwWncE7zG10r5VMmDAhmMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Bode <bodepd@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Don Talton -X (dotalton - TSG at Cisco)" <dotalton@cisco.com>, "Robert Starmer (starmer)" <starmer@cisco.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HuSaLq4X5kww4vjsRGW8wROs5ujw8lJ7b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 14/10/2013 19:34, Dan Bode wrote:
>=20
>     On 14/10/2013 08:31, Dan Bode wrote:>
>     >
>     >
>     > On Sun, Oct 13, 2013 at 4:34 PM, Loic Dachary <loic@dachary.org <=
mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.or=
g>>> wrote:
>     >
>     >     Hi Dan,
>     >
>     >     I'm looking for the path of least resistance to add rbd suppo=
rt to https://github.com/CiscoSystems/openstack-installer/ Being unfamili=
ar with the data oriented approach it would be great to get your advice o=
n the following.
>     >
>     >
>     >     * assume ceph has already been installed without cephx which =
simplifies configuration. From the point of view of integration tests it =
means installing when vagrant is setup ( which I currently rely on ) or v=
ia https://github.com/CiscoSystems/openstack-installer/tree/master/stack-=
builder. Not sure if the post_config is where it
>     >
>     >     should be installed for test purposes. Not sure how to let it=
 know what IP to use.
>     >
>     >
>     > I would really prefer not to use post_config for this purpose. I =
would much rather encode this logic into Puppet so that it's more consist=
ent with the overall framework. It would be ok, even if the Puppet class =
simply wrapped your provided script, and long as the script arguments are=
 provided as class parameters. I've copied Don on this thread to see if p=
erhaps he already had Puppet content in mind for the configuration your s=
cript is performing:
>     >
>     > This is a bit more work, but provides the following advantages:
>     > - all data related to the ceph configuration being done by your s=
cript can be provided as a regular part of the data hierarchy (this answe=
rs your question related to where you set the ip)
>     > - the data framework can be used to configure whether or not this=
 configuration is applied to a node. (from a testing perspective, I want =
whether or not to run tests for the ceph deployment to be a configuration=
 setting for the deployment process, so that we can choose to deploy the =
2_role configuration, and select ceph or some other backend for testing)
>=20
>     I better understand the approach and it makes sense.
>=20
>=20
>     >
>     >     I could add this to cinder + nova because it's needed by both=
=2E
>     >
>     >
>     > do you mean add it to the stackforge modules?
>=20
>     Yes. At the moment they assume /etc/ceph/ceph.conf already exists. =
It implies either that ceph is deployed with a puppet module or that the =
ceph deployment tool has access to cinder and nova hosts to write the /et=
c/ceph/ceph.conf.
>=20
>=20
> Is that how ceph deploy works? That it remotely connects to hosts via s=
sh to perform remote configurations? In this use case, where would ceph-d=
eploy be run from?
>=20
> I think I would much rather this be performed on a compute instance b/c=
 AFAIK each compute needs to be configured to make this connection. I don=
't want us to be in a situation where we have to run Puppet on multiple n=
odes everytime that we want to bring up a compute instance.
> =20

ceph-deploy will not remotely connect if run from the host where the acti=
on need to be performed. I think it would make sense to run ceph-deploy a=
s a puppet helper, on the node that needs to be configured. It will notic=
e that the host to perform the action on is local and instead of ssh to i=
t, run the command directly.

When dealing with a compute host, libvirt will need to know which IP addr=
esses to use to connect to the ceph cluster. This is specified by the fol=
lowing in /etc/ceph/ceph.conf:

[global]
mon host =3D 192.168.0.10,192.168.5.10

It is the only way to provide this information to libvirt. glance can be =
configured to use a different file name

https://github.com/openstack/glance/blob/master/glance/store/rbd.py#L62-L=
63

and the most recent version of cinder also do

https://github.com/openstack/cinder/blob/master/cinder/volume/drivers/rbd=
=2Epy#L50

but grizzly does not=20

https://github.com/openstack/cinder/blob/stable/grizzly/cinder/volume/dri=
vers/rbd.py#L33

and in any case it cannot be specified in another way. From the discussio=
n we had during the Ceph day this week with Wido Den Hollander, Cloudstac=
k resolves this problem by encapsulating the "mon host" adresses in a mes=
sage broadcasted from a central place. But the message exchanged from cin=
der to nova does not contain this information and the code to interpret i=
t is not in

https://github.com/openstack/nova/blob/stable/grizzly/nova/virt/libvirt/v=
olume.py#L137

As long as the puppet master has the content of the "mon host" line, the =
/etc/ceph/ceph.conf file can be generated on each compute / glance / cind=
er host without the need to coordinate between themselves.=20

>=20
>     It looks like it would make sense to add a list of monitors
>=20
>     # [*rbd_mon_host*]
>     # (optional) The list of mons IPs
>     #
>=20
>     and if set
>=20
>     https://github.com/stackforge/puppet-cinder/blob/master/manifests/v=
olume/rbd.pp
>=20
>     would create /etc/ceph/ceph.conf. The same could be done for nova.
>=20
>=20
>     >     I suppose it's what should be done since openstack-installer =
has no template at the moment.
>     >
>     >     [global]
>     >     mon host =3D 192.168.242.100
>     >
>     >     * setting the default parameters
>     >
>     >     diff --git a/data/hiera_data/user.common.yaml b/data/hiera_da=
ta/user.common.yaml
>     >     index 349eb1a..c38a0a4 100644
>     >     --- a/data/hiera_data/user.common.yaml
>     >     +++ b/data/hiera_data/user.common.yaml
>     >     @@ -48,3 +48,7 @@ swift_service_password: swift_pass
>     >      swift_hash: super_secret_swift_hash
>     >      glance::backend::swift::swift_store_key: secret_key
>     >      glance::backend::swift::swift_store_auth_address: '127.0.0.1=
'
>     >     +
>     >     +cinder::volume::rbd::rbd_pool: 'rbd'
>     >     +cinder::volume::rbd::glance_api_version: '2'
>     >     +cinder::volume::rbd::rbd_user: 'no cephx'
>     >
>     >
>     >
>     > I would rather this not be applied to the user common configurati=
on. In general, I intended for things in the user*.yaml files to be thing=
s that a user provides (as opposed to things that need to be set by defau=
lt for a certain deployment model)
>     >
>     > I was discussing where this configuration goes with Don on Friday=
=2E There are two possible options:
>     >
>     > 1. The following lines (https://github.com/CiscoSystems/openstack=
-installer/blob/master/manifests/setup.pp#L72-L73) can already be used to=
 specify default configuration that should be applied when you select cep=
h as either the backend for glance or swift. In that case, it should be p=
rovided in:
>     >
>     >   data/hiera_data/cinder_backend/rbd.yaml
>     >     and
>     >   data/hiera_data/glance_backend/rbd.yaml
>     >
>     > This way, that data is set when you select ceph as the backend fo=
r either of these services.
>     >
>     > The disadvantage is that you would have to duplicate the same dat=
a in both files (b/c a user could select ceph as the backend for glance o=
r cinder or both).
>     >
>     > 2. The other alternative, is to create a new global_hiera_param t=
hat can be used to enable ceph, then set ceph specific data based on that=
 variable:
>     >
>     >     data/hiera_data/ceph_enabled/true.yaml
>     >
>     > Out of those two options, I prefer #1 (b/c we don't have to add a=
nything new to our hierarchy)
>=20
>     I created a pull request to support this thread with actual diffs.
>=20
>     https://github.com/CiscoSystems/openstack-installer/pull/150/files
>=20
>=20
> merged
>=20
> =20
>=20
>     The glance parameters are not exactly the same as the cinder parame=
ters. How should hiera_data/glance_backend/rbd.yaml be referenced when sp=
ecifying the glance backend ?=20
>=20
>=20
> Do you mean how is that data pulled into the configuration?
>=20
> have a look at data/hiera_global_data, this directory is used to select=
 the backends. You can add a user.yaml file to that directory and set:
>=20
>     glance_backend: rdb
>     cinder_backend: rdb
>=20
> This is not code that should be checked in, it should instead be config=
uration that should be driven by the deployment process (for the vagrant/=
basic_tests.sh method, it should be a env variable that is translated int=
o settings to be written into hiera_global_data/jenkins.yaml)
> =20

Understood. I should have read openstack-installer/data/README.md which e=
xplains it, sorry for the noise.

Cheers

>=20
>     The logic is in place for cinder bus/t I'm not sure how this should=
 be done for glance.
>=20
>     Cheers
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


--HuSaLq4X5kww4vjsRGW8wROs5ujw8lJ7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJcdHkACgkQ8dLMyEl6F22c7ACglASX34lLOxc+R/GpiJB2uxm/
BnEAoIHdSMf90hm8UWLvdQkOjBpybcYE
=T508
-----END PGP SIGNATURE-----

--HuSaLq4X5kww4vjsRGW8wROs5ujw8lJ7b--
