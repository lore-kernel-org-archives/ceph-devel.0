From: =?UTF-8?Q?S=C3=A9bastien_Han?= <sebastien.han@enovance.com>
Subject: =?UTF-8?Q?Re=3A_OpenStack_and_ceph_integration_with_puppet?=
Date: Tue, 8 Oct 2013 16:47:29 +0200
Message-ID: <etPan.52541b01.d34b6a8.167b7@leseb-mba.local>
References: <525413DE.9090405@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:43519 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab3JHOrc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 10:47:32 -0400
In-Reply-To: <525413DE.9090405@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>
Cc: Dan Bode <bodepd@gmail.com>

Hi Lo=C3=AFc,

Actually they are some steps that might be automated such as:

* set the virsh secret
* create both glance and cinder pools

Please take a look at:

*=C2=A0https://github.com/dontalton/puppet-cephdeploy/blob/master/manif=
ests/init.pp#L121
*=C2=A0https://github.com/dontalton/puppet-cephdeploy/blob/master/manif=
ests/osd.pp#L73

=46or the rest this might be already done but your puppet manifests.
Please also note that=C2=A0http://ceph.com/docs/next/rbd/rbd-openstack/=
 will need some updates for OpenStack Havana.

=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood.=E2=80=9D

Phone:=C2=A0+33 (0)1 49 70 99 72
Mail:=C2=A0sebastien.han@enovance.com
Address :=C2=A010, rue de la Victoire - 75009 Paris
Web :=C2=A0www.enovance.com=C2=A0-=C2=A0Twitter :=C2=A0@enovance

On October 8, 2013 at 4:18:00 PM, Loic Dachary (loic@dachary.org) wrote=
:

Hi Ceph, =20

Binding ceph to cinder and glance using puppet requires three steps: =20

* Deploy ceph ( with ceph-deploy, puppet, chef ... ) =20

* Follow the ceph documentation instructions ( valid for both cinder an=
d glance ) =20

http://ceph.com/docs/next/rbd/rbd-openstack/ =20

* Part of the above instructions can be skipped if the following are us=
ed =20

https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manifes=
ts/backend/rbd.pp =20
https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manifes=
ts/volume/rbd.pp =20

They take care of installing a package on the glance and cinder node an=
d writing the cinder and glance config files. =20

* Upgrading the librbd on the compute hosts to match the version of the=
 cluster ( ubuntu precise has bobtail but you may want at least cuttlef=
ish ) =20

I would be delighted to know if there is a simpler way. If not, would i=
t make sense to provide the puppet master with the IP of the monitors a=
nd admin rights so that it can automate http://ceph.com/docs/next/rbd/r=
bd-openstack/ ? =20

* install ceph-common on cinder hosts and python-ceph on glance hosts =20
* set the monitor addresses =20
* copy the keyring to cinder / glance =20
* create the client.volumes / client.images users ( support <=3D 0.53 ?=
 ) =20
* upgrade the librbd package on the compute hosts to the version matchi=
ng the cluster =20
* virsh secret-set-value the volume key on each compute host =20
* reload glance/nova/cinder where appropriate =20

The puppet master could even refresh the list of monitors from time to =
time and update the cinder/glance nodes accordingly. And it could do th=
e right thing depending on the target openstack version and ceph versio=
n. =20

Thoughts ? =20

-- =20
Lo=C3=AFc Dachary, Artisan Logiciel Libre =20
All that is necessary for the triumph of evil is that good people do no=
thing.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
