From: Loic Dachary <loic@dachary.org>
Subject: Re: OpenStack and ceph integration with puppet
Date: Wed, 09 Oct 2013 22:30:38 +0100
Message-ID: <5255CAFE.10304@dachary.org>
References: <525413DE.9090405@dachary.org>	<etPan.52541b01.d34b6a8.167b7@leseb-mba.local>	<525448E7.5040604@dachary.org> <CAM0pNLPi_un=2EQ+V+Lp+gifTTr0aTNHHQPGfq8xe3wb-huq2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nUEnXc7ewUpScGxo6nIs7h81ufDqUnv5m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58663 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab3JIVal (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Oct 2013 17:30:41 -0400
In-Reply-To: <CAM0pNLPi_un=2EQ+V+Lp+gifTTr0aTNHHQPGfq8xe3wb-huq2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dmitry Borodaenko <dborodaenko@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dan Bode <bodepd@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nUEnXc7ewUpScGxo6nIs7h81ufDqUnv5m
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On 09/10/2013 00:26, Dmitry Borodaenko wrote:
> Loic,
>=20
> You might also find the Fuel manifests for Ceph useful:
> https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
> https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinder/m=
anifests/volume/ceph.pp

The

"ceph auth get-or-create ..."

looks like a worthy contribution to

https://github.com/stackforge/puppet-cinder/blob/master/manifests/volume/=
rbd.pp

Is there a reason why it would not be relevant in this context ?

> https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glance/m=
anifests/backend/ceph.pp
>=20
> We've been working on these for the last couple of months with the
> goal of fully automating deployment of OpenStack environments with
> Ceph as storage backend, and we're close to an official release of
> Fuel that will support this configuration. It automates a lot of stuff
> all the way from drive partitioning for OSDs up to generating and
> configuring keys for Cinder and Glance pools. You'd need the rest of
> Fuel to make the most out of it, but you can also provide the missing
> bits by tweaking the provided site.pp.

Thanks for the pointers !

Cheers

>=20
> Regards,
> Dmitry Borodaenko
>=20
> On Tue, Oct 8, 2013 at 11:03 AM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 08/10/2013 15:47, S=E9bastien Han wrote:
>>> Hi Lo=EFc,
>>>
>>> Actually they are some steps that might be automated such as:
>>>
>>> * set the virsh secret
>>> * create both glance and cinder pools
>>
>> Where do you think it might already be automated ?
>>
>>> Please take a look at:
>>>
>>> * https://github.com/dontalton/puppet-cephdeploy/blob/master/manifest=
s/init.pp#L121
>>> * https://github.com/dontalton/puppet-cephdeploy/blob/master/manifest=
s/osd.pp#L73
>>
>> Right ! I overlooked this puppet module.
>>
>>> For the rest this might be already done but your puppet manifests.
>>
>> I plan to not write any manifest :-)
>>
>>> Please also note that http://ceph.com/docs/next/rbd/rbd-openstack/ wi=
ll need some updates for OpenStack Havana.
>>
>> Cheers
>>
>>> =96=96=96=96
>>> S=E9bastien Han
>>> Cloud Engineer
>>>
>>> "Always give 100%. Unless you're giving blood.=94
>>>
>>> Phone: +33 (0)1 49 70 99 72
>>> Mail: sebastien.han@enovance.com
>>> Address : 10, rue de la Victoire - 75009 Paris
>>> Web : www.enovance.com - Twitter : @enovance
>>>
>>> On October 8, 2013 at 4:18:00 PM, Loic Dachary (loic@dachary.org) wro=
te:
>>>
>>> Hi Ceph,
>>>
>>> Binding ceph to cinder and glance using puppet requires three steps:
>>>
>>> * Deploy ceph ( with ceph-deploy, puppet, chef ... )
>>>
>>> * Follow the ceph documentation instructions ( valid for both cinder =
and glance )
>>>
>>> http://ceph.com/docs/next/rbd/rbd-openstack/
>>>
>>> * Part of the above instructions can be skipped if the following are =
used
>>>
>>> https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manif=
ests/backend/rbd.pp
>>> https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manif=
ests/volume/rbd.pp
>>>
>>> They take care of installing a package on the glance and cinder node =
and writing the cinder and glance config files.
>>>
>>> * Upgrading the librbd on the compute hosts to match the version of t=
he cluster ( ubuntu precise has bobtail but you may want at least cuttlef=
ish )
>>>
>>> I would be delighted to know if there is a simpler way. If not, would=
 it make sense to provide the puppet master with the IP of the monitors a=
nd admin rights so that it can automate http://ceph.com/docs/next/rbd/rbd=
-openstack/ ?
>>>
>>> * install ceph-common on cinder hosts and python-ceph on glance hosts=

>>> * set the monitor addresses
>>> * copy the keyring to cinder / glance
>>> * create the client.volumes / client.images users ( support <=3D 0.53=
 ? )
>>> * upgrade the librbd package on the compute hosts to the version matc=
hing the cluster
>>> * virsh secret-set-value the volume key on each compute host
>>> * reload glance/nova/cinder where appropriate
>>>
>>> The puppet master could even refresh the list of monitors from time t=
o time and update the cinder/glance nodes accordingly. And it could do th=
e right thing depending on the target openstack version and ceph version.=

>>>
>>> Thoughts ?
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people do =
nothing.
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>=20
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--nUEnXc7ewUpScGxo6nIs7h81ufDqUnv5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJVyv4ACgkQ8dLMyEl6F20w4QCghPeb9fR1Hs/NguyGvjMYRAAm
22sAnA74Dd6DZfuJYrPRVmiF4xmsWzXs
=wl/L
-----END PGP SIGNATURE-----

--nUEnXc7ewUpScGxo6nIs7h81ufDqUnv5m--
