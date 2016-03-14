From: Loic Dachary <loic@dachary.org>
Subject: Re: How to leverage ceph udev rules for containerized ceph
Date: Mon, 14 Mar 2016 21:04:12 +0100
Message-ID: <56E7193C.50202@dachary.org>
References: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43499 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbcCNUEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 16:04:16 -0400
In-Reply-To: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Curtis <jicurtis@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Jim,

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

It would be convenient to have a standalone ceph-disk package (native o=
r pypi) that includes udev rules and init scripts.=20

> What we would like to do is install our own set of ceph udev rules
> that would trigger the startup of our ceph docker container.  We woul=
d
> like to leverage the current implementation of the ceph udev rules to
> do this.

Let say we allocate a new partition type for each existing partition ty=
pe[1] so that ceph-disk knows it should docker run ceph-osd instead of =
running the ceph-osd daemon itself. If docker run ceph-osd has the same=
 set of arguments as the ceph-osd daemon, the only thing to adapt is ho=
w the init system handles a container with a name instead of a daemon w=
ith a pid. Alternatively, ceph-disk could be instructed to delegate run=
ning the ceph-osd daemon to docker instead of using an init system. The=
 later would make more sense to me because the semantic of an init syst=
em is not perfectly aligned with the docker run / stop semantic.

What I'm not sure about is how a ceph-osd running within a container ca=
n be instructed to use a given device. The only way I know is to expose=
 /dev with --privileged which is probably too much. Is --device=3D/dev/=
sdb:/dev/sdb:rwm enough ? Is it possible, in case we only need to grant=
 access to a partition used for journaling, to --device=3D/dev/sdc1:/de=
v/sdc1 ?=20

> Also, since ceph-disk and Ceph's udev rules are tightly coupled and
> ceph-disk creates systemd or upstart rules for OSD daemons, does it
> make sense to add hooks in ceph-disk to start up a containerized OSD
> daemons either in systemd or upstart?

Yes, but that would probably not be my first choice.

Could you please provide the URL to the RHEL-based ceph container docke=
r image you released recently ?

Cheers

>=20
> Can somebody in this community help us with this?
>=20
> Thanks,
>=20
> Jim C.

[1] https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rules#L4 =
etc.

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
