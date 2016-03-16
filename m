From: Loic Dachary <loic@dachary.org>
Subject: Re: How to leverage ceph udev rules for containerized ceph
Date: Wed, 16 Mar 2016 14:13:53 +0100
Message-ID: <56E95C11.1070504@dachary.org>
References: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
 <56E7193C.50202@dachary.org>
 <CAGEA57d24BJgSxiJGryP=arC0Zn0TBpzGkMhWJ2JTMjD+KJoSA@mail.gmail.com>
 <56E7ADF5.4060106@dachary.org>
 <CAL-2WbH=OBtSTm=ivTATJc6AEZfaNNx4DpS=Uu7Xu3tW9QjNcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37302 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbcCPNN7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 09:13:59 -0400
In-Reply-To: <CAL-2WbH=OBtSTm=ivTATJc6AEZfaNNx4DpS=Uu7Xu3tW9QjNcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>
Cc: Jim Curtis <jicurtis@redhat.com>, "Chen, Huamin" <hchen@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 16/03/2016 13:27, Daniel Gryniewicz wrote:
> On Tue, Mar 15, 2016 at 2:38 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>
>>
>> On 14/03/2016 21:28, Jim Curtis wrote:
>>> Hi Loic,
>>>
>>> The image is on the registry:
>>> https://access.redhat.com/search/#/container-images?q=3Dceph&p=3D1&=
sort=3Drelevant&rows=3D12&srch=3Dany&documentKind=3DImageRepository
>>>
>>> It can be pulled from:
>>>
>>> registry.access.redhat.com/rhceph/rhceph-1.3-rhel7
>>
>> Thanks ! I don't know how to retrieve the Dockerfile that was used t=
o create this image from the registry, is there a command for this ?
>=20
> It was built from the docker branch of github.com/ceph/ceph-docker
>=20
>>
>>>
>>> Huamin might also have some input on your comments.  I forgot to cc
>>> him on my original message and I'm not sure if he is subscribed to =
the
>>> list.
>>>
>>> Jim C.
>>>
>>> On Mon, Mar 14, 2016 at 1:04 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>> Hi Jim,
>>>>
>>>> On 14/03/2016 19:34, Jim Curtis wrote:
>>>>> Greeting ceph-devel,
>>>>>
>>>>> We are working on a ceph containerization project within Red Hat.=
  We
>>>>> have recently released our RHEL-based ceph container docker image=
 and
>>>>> now we are moving on to handling a feature limitation with that i=
mage.
>>>>>
>>>>> Specifically, the issue is that on our Atomic host, there is no c=
eph
>>>>> installed, so there are no ceph udev rules to trigger dynamic
>>>>> configuration of OSDs when a disk is plugged into the host.
>>>>
>>>> It would be convenient to have a standalone ceph-disk package (nat=
ive or pypi) that includes udev rules and init scripts.
>>>>
>>>>> What we would like to do is install our own set of ceph udev rule=
s
>>>>> that would trigger the startup of our ceph docker container.  We =
would
>>>>> like to leverage the current implementation of the ceph udev rule=
s to
>>>>> do this.
>>>>
>>>> Let say we allocate a new partition type for each existing partiti=
on type[1] so that ceph-disk knows it should docker run ceph-osd instea=
d of running the ceph-osd daemon itself. If docker run ceph-osd has the=
 same set of arguments as the ceph-osd daemon, the only thing to adapt =
is how the init system handles a container with a name instead of a dae=
mon with a pid. Alternatively, ceph-disk could be instructed to delegat=
e running the ceph-osd daemon to docker instead of using an init system=
=2E The later would make more sense to me because the semantic of an in=
it system is not perfectly aligned with the docker run / stop semantic.
>>>>
>>>> What I'm not sure about is how a ceph-osd running within a contain=
er can be instructed to use a given device. The only way I know is to e=
xpose /dev with --privileged which is probably too much. Is --device=3D=
/dev/sdb:/dev/sdb:rwm enough ? Is it possible, in case we only need to =
grant access to a partition used for journaling, to --device=3D/dev/sdc=
1:/dev/sdc1 ?
>=20
> We're currently running it privileged and mounting in /dev.  The main
> reason for mounting in /dev is to be able to create partitions.
> Provisioning and activating are separate steps, so could be done
> differently, but they currently operate the same way in our tech
> preview.

It's also a valid option with the upside of not requiring any change.

>>>>
>>>>> Also, since ceph-disk and Ceph's udev rules are tightly coupled a=
nd
>>>>> ceph-disk creates systemd or upstart rules for OSD daemons, does =
it
>>>>> make sense to add hooks in ceph-disk to start up a containerized =
OSD
>>>>> daemons either in systemd or upstart?
>>>>
>>>> Yes, but that would probably not be my first choice.
>>>>
>>>> Could you please provide the URL to the RHEL-based ceph container =
docker image you released recently ?
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>> Can somebody in this community help us with this?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Jim C.
>>>>
>>>> [1] https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rule=
s#L4 etc.
>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> Daniel
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
