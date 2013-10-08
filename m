From: Dmitry Borodaenko <dborodaenko@mirantis.com>
Subject: Re: OpenStack and ceph integration with puppet
Date: Tue, 8 Oct 2013 16:26:51 -0700
Message-ID: <CAM0pNLPi_un=2EQ+V+Lp+gifTTr0aTNHHQPGfq8xe3wb-huq2g@mail.gmail.com>
References: <525413DE.9090405@dachary.org>
	<etPan.52541b01.d34b6a8.167b7@leseb-mba.local>
	<525448E7.5040604@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:52882 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab3JHX0x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 19:26:53 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so21621wes.22
        for <ceph-devel@vger.kernel.org>; Tue, 08 Oct 2013 16:26:52 -0700 (PDT)
In-Reply-To: <525448E7.5040604@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <sebastien.han@enovance.com>, Ceph Development <ceph-devel@vger.kernel.org>, Dan Bode <bodepd@gmail.com>

Loic,

You might also find the Fuel manifests for Ceph useful:
https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinder/m=
anifests/volume/ceph.pp
https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glance/m=
anifests/backend/ceph.pp

We've been working on these for the last couple of months with the
goal of fully automating deployment of OpenStack environments with
Ceph as storage backend, and we're close to an official release of
=46uel that will support this configuration. It automates a lot of stuf=
f
all the way from drive partitioning for OSDs up to generating and
configuring keys for Cinder and Glance pools. You'd need the rest of
=46uel to make the most out of it, but you can also provide the missing
bits by tweaking the provided site.pp.

Regards,
Dmitry Borodaenko

On Tue, Oct 8, 2013 at 11:03 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 08/10/2013 15:47, S=E9bastien Han wrote:
>> Hi Lo=EFc,
>>
>> Actually they are some steps that might be automated such as:
>>
>> * set the virsh secret
>> * create both glance and cinder pools
>
> Where do you think it might already be automated ?
>
>> Please take a look at:
>>
>> * https://github.com/dontalton/puppet-cephdeploy/blob/master/manifes=
ts/init.pp#L121
>> * https://github.com/dontalton/puppet-cephdeploy/blob/master/manifes=
ts/osd.pp#L73
>
> Right ! I overlooked this puppet module.
>
>> For the rest this might be already done but your puppet manifests.
>
> I plan to not write any manifest :-)
>
>> Please also note that http://ceph.com/docs/next/rbd/rbd-openstack/ w=
ill need some updates for OpenStack Havana.
>
> Cheers
>
>> =96=96=96=96
>> S=E9bastien Han
>> Cloud Engineer
>>
>> "Always give 100%. Unless you're giving blood.=94
>>
>> Phone: +33 (0)1 49 70 99 72
>> Mail: sebastien.han@enovance.com
>> Address : 10, rue de la Victoire - 75009 Paris
>> Web : www.enovance.com - Twitter : @enovance
>>
>> On October 8, 2013 at 4:18:00 PM, Loic Dachary (loic@dachary.org) wr=
ote:
>>
>> Hi Ceph,
>>
>> Binding ceph to cinder and glance using puppet requires three steps:
>>
>> * Deploy ceph ( with ceph-deploy, puppet, chef ... )
>>
>> * Follow the ceph documentation instructions ( valid for both cinder=
 and glance )
>>
>> http://ceph.com/docs/next/rbd/rbd-openstack/
>>
>> * Part of the above instructions can be skipped if the following are=
 used
>>
>> https://github.com/stackforge/puppet-glance/blob/stable/grizzly/mani=
fests/backend/rbd.pp
>> https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/mani=
fests/volume/rbd.pp
>>
>> They take care of installing a package on the glance and cinder node=
 and writing the cinder and glance config files.
>>
>> * Upgrading the librbd on the compute hosts to match the version of =
the cluster ( ubuntu precise has bobtail but you may want at least cutt=
lefish )
>>
>> I would be delighted to know if there is a simpler way. If not, woul=
d it make sense to provide the puppet master with the IP of the monitor=
s and admin rights so that it can automate http://ceph.com/docs/next/rb=
d/rbd-openstack/ ?
>>
>> * install ceph-common on cinder hosts and python-ceph on glance host=
s
>> * set the monitor addresses
>> * copy the keyring to cinder / glance
>> * create the client.volumes / client.images users ( support <=3D 0.5=
3 ? )
>> * upgrade the librbd package on the compute hosts to the version mat=
ching the cluster
>> * virsh secret-set-value the volume key on each compute host
>> * reload glance/nova/cinder where appropriate
>>
>> The puppet master could even refresh the list of monitors from time =
to time and update the cinder/glance nodes accordingly. And it could do=
 the right thing depending on the target openstack version and ceph ver=
sion.
>>
>> Thoughts ?
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>



--=20
Dmitry Borodaenko
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
