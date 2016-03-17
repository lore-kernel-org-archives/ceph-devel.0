From: Loic Dachary <loic@dachary.org>
Subject: Re: How to leverage ceph udev rules for containerized ceph
Date: Thu, 17 Mar 2016 16:24:14 +0100
Message-ID: <56EACC1E.6040102@dachary.org>
References: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58970 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935219AbcCQPYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2016 11:24:19 -0400
In-Reply-To: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Curtis <jicurtis@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Assuming disks are prepared using ceph-disk from within a container wit=
h access to /dev, activating using udev rules could probably be done by=
 prefixing all ceph-disk trigger in https://github.com/ceph/ceph/blob/m=
aster/udev/95-ceph-osd.rules with docker run ceph-osd ceph-disk trigger=
=2E And merely installing this udev rule file on the host.

The problem is that ceph-disk trigger relies on the init system (upstar=
t or systemd) to asynchronously run the ceph-disk activation. It does t=
hat so the udev action does not last longer than strictly necessary. If=
 systemd can run within the container, even if it does not have access =
to system services, it would be enough for the purpose of ceph-disk tri=
gger.

Another approach would be to rely on "docker run" to run ceph-disk acti=
vate in the background and make sure the udev action is short lived. Th=
at would be defeated if the ceph-osd docker image did not exist on the =
machine as docker run would have to download it, which can take a long =
time. However, it probably is safe to assume that a machine used to cep=
h-disk prepare disks via the ceph-osd container already has such an ima=
ge. Otherwise it would not have disks to activate anyway. The udev acti=
ons could then be run with ceph-disk trigger --sync (which does *not* d=
elegate to the init system).

Note that udev rules may fire actions that do not lead to a running cep=
h-osd. For instance, if /dev/sdb comes up with the journal while /dev/s=
dc has the data but is not there yet. The journal activation will fail =
and the container that tried to activate must be removed. When /dev/sdc=
 comes up, it will try to activate and succeed because /dev/sdb is ther=
e already and the journal can be found. The container that activated su=
ccessfully must keep running.

Cheers

On 14/03/2016 19:34, Jim Curtis wrote:
> Greeting ceph-devel,
>=20
> We are working on a ceph containerization project within Red Hat.  We
> have recently released our RHEL-based ceph container docker image and
> now we are moving on to handling a feature limitation with that image=
=2E
>=20
> Specifically, the issue is that on our Atomic host, there is no ceph
> installed, so there are no ceph udev rules to trigger dynamic
> configuration of OSDs when a disk is plugged into the host.
>=20
> What we would like to do is install our own set of ceph udev rules
> that would trigger the startup of our ceph docker container.  We woul=
d
> like to leverage the current implementation of the ceph udev rules to
> do this.
>=20
> Also, since ceph-disk and Ceph's udev rules are tightly coupled and
> ceph-disk creates systemd or upstart rules for OSD daemons, does it
> make sense to add hooks in ceph-disk to start up a containerized OSD
> daemons either in systemd or upstart?
>=20
> Can somebody in this community help us with this?
>=20
> Thanks,
>=20
> Jim C.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
