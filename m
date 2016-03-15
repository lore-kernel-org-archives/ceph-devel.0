From: Loic Dachary <loic@dachary.org>
Subject: Re: How to leverage ceph udev rules for containerized ceph
Date: Tue, 15 Mar 2016 07:38:45 +0100
Message-ID: <56E7ADF5.4060106@dachary.org>
References: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
 <56E7193C.50202@dachary.org>
 <CAGEA57d24BJgSxiJGryP=arC0Zn0TBpzGkMhWJ2JTMjD+KJoSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49663 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbcCOGi5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2016 02:38:57 -0400
In-Reply-To: <CAGEA57d24BJgSxiJGryP=arC0Zn0TBpzGkMhWJ2JTMjD+KJoSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Curtis <jicurtis@redhat.com>, "Chen, Huamin" <hchen@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 14/03/2016 21:28, Jim Curtis wrote:
> Hi Loic,
>=20
> The image is on the registry:
> https://access.redhat.com/search/#/container-images?q=3Dceph&p=3D1&so=
rt=3Drelevant&rows=3D12&srch=3Dany&documentKind=3DImageRepository
>=20
> It can be pulled from:
>=20
> registry.access.redhat.com/rhceph/rhceph-1.3-rhel7

Thanks ! I don't know how to retrieve the Dockerfile that was used to c=
reate this image from the registry, is there a command for this ?

>=20
> Huamin might also have some input on your comments.  I forgot to cc
> him on my original message and I'm not sure if he is subscribed to th=
e
> list.
>=20
> Jim C.
>=20
> On Mon, Mar 14, 2016 at 1:04 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Jim,
>>
>> On 14/03/2016 19:34, Jim Curtis wrote:
>>> Greeting ceph-devel,
>>>
>>> We are working on a ceph containerization project within Red Hat.  =
We
>>> have recently released our RHEL-based ceph container docker image a=
nd
>>> now we are moving on to handling a feature limitation with that ima=
ge.
>>>
>>> Specifically, the issue is that on our Atomic host, there is no cep=
h
>>> installed, so there are no ceph udev rules to trigger dynamic
>>> configuration of OSDs when a disk is plugged into the host.
>>
>> It would be convenient to have a standalone ceph-disk package (nativ=
e or pypi) that includes udev rules and init scripts.
>>
>>> What we would like to do is install our own set of ceph udev rules
>>> that would trigger the startup of our ceph docker container.  We wo=
uld
>>> like to leverage the current implementation of the ceph udev rules =
to
>>> do this.
>>
>> Let say we allocate a new partition type for each existing partition=
 type[1] so that ceph-disk knows it should docker run ceph-osd instead =
of running the ceph-osd daemon itself. If docker run ceph-osd has the s=
ame set of arguments as the ceph-osd daemon, the only thing to adapt is=
 how the init system handles a container with a name instead of a daemo=
n with a pid. Alternatively, ceph-disk could be instructed to delegate =
running the ceph-osd daemon to docker instead of using an init system. =
The later would make more sense to me because the semantic of an init s=
ystem is not perfectly aligned with the docker run / stop semantic.
>>
>> What I'm not sure about is how a ceph-osd running within a container=
 can be instructed to use a given device. The only way I know is to exp=
ose /dev with --privileged which is probably too much. Is --device=3D/d=
ev/sdb:/dev/sdb:rwm enough ? Is it possible, in case we only need to gr=
ant access to a partition used for journaling, to --device=3D/dev/sdc1:=
/dev/sdc1 ?
>>
>>> Also, since ceph-disk and Ceph's udev rules are tightly coupled and
>>> ceph-disk creates systemd or upstart rules for OSD daemons, does it
>>> make sense to add hooks in ceph-disk to start up a containerized OS=
D
>>> daemons either in systemd or upstart?
>>
>> Yes, but that would probably not be my first choice.
>>
>> Could you please provide the URL to the RHEL-based ceph container do=
cker image you released recently ?
>>
>> Cheers
>>
>>>
>>> Can somebody in this community help us with this?
>>>
>>> Thanks,
>>>
>>> Jim C.
>>
>> [1] https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rules#=
L4 etc.
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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
