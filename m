From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: How to leverage ceph udev rules for containerized ceph
Date: Wed, 16 Mar 2016 08:27:42 -0400
Message-ID: <CAL-2WbH=OBtSTm=ivTATJc6AEZfaNNx4DpS=Uu7Xu3tW9QjNcA@mail.gmail.com>
References: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
 <56E7193C.50202@dachary.org> <CAGEA57d24BJgSxiJGryP=arC0Zn0TBpzGkMhWJ2JTMjD+KJoSA@mail.gmail.com>
 <56E7ADF5.4060106@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37846 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbcCPM2E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 08:28:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so70041034wmp.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 05:28:02 -0700 (PDT)
In-Reply-To: <56E7ADF5.4060106@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Jim Curtis <jicurtis@redhat.com>, "Chen, Huamin" <hchen@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Mar 15, 2016 at 2:38 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 14/03/2016 21:28, Jim Curtis wrote:
>> Hi Loic,
>>
>> The image is on the registry:
>> https://access.redhat.com/search/#/container-images?q=3Dceph&p=3D1&s=
ort=3Drelevant&rows=3D12&srch=3Dany&documentKind=3DImageRepository
>>
>> It can be pulled from:
>>
>> registry.access.redhat.com/rhceph/rhceph-1.3-rhel7
>
> Thanks ! I don't know how to retrieve the Dockerfile that was used to=
 create this image from the registry, is there a command for this ?

It was built from the docker branch of github.com/ceph/ceph-docker

>
>>
>> Huamin might also have some input on your comments.  I forgot to cc
>> him on my original message and I'm not sure if he is subscribed to t=
he
>> list.
>>
>> Jim C.
>>
>> On Mon, Mar 14, 2016 at 1:04 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Jim,
>>>
>>> On 14/03/2016 19:34, Jim Curtis wrote:
>>>> Greeting ceph-devel,
>>>>
>>>> We are working on a ceph containerization project within Red Hat. =
 We
>>>> have recently released our RHEL-based ceph container docker image =
and
>>>> now we are moving on to handling a feature limitation with that im=
age.
>>>>
>>>> Specifically, the issue is that on our Atomic host, there is no ce=
ph
>>>> installed, so there are no ceph udev rules to trigger dynamic
>>>> configuration of OSDs when a disk is plugged into the host.
>>>
>>> It would be convenient to have a standalone ceph-disk package (nati=
ve or pypi) that includes udev rules and init scripts.
>>>
>>>> What we would like to do is install our own set of ceph udev rules
>>>> that would trigger the startup of our ceph docker container.  We w=
ould
>>>> like to leverage the current implementation of the ceph udev rules=
 to
>>>> do this.
>>>
>>> Let say we allocate a new partition type for each existing partitio=
n type[1] so that ceph-disk knows it should docker run ceph-osd instead=
 of running the ceph-osd daemon itself. If docker run ceph-osd has the =
same set of arguments as the ceph-osd daemon, the only thing to adapt i=
s how the init system handles a container with a name instead of a daem=
on with a pid. Alternatively, ceph-disk could be instructed to delegate=
 running the ceph-osd daemon to docker instead of using an init system.=
 The later would make more sense to me because the semantic of an init =
system is not perfectly aligned with the docker run / stop semantic.
>>>
>>> What I'm not sure about is how a ceph-osd running within a containe=
r can be instructed to use a given device. The only way I know is to ex=
pose /dev with --privileged which is probably too much. Is --device=3D/=
dev/sdb:/dev/sdb:rwm enough ? Is it possible, in case we only need to g=
rant access to a partition used for journaling, to --device=3D/dev/sdc1=
:/dev/sdc1 ?

We're currently running it privileged and mounting in /dev.  The main
reason for mounting in /dev is to be able to create partitions.
Provisioning and activating are separate steps, so could be done
differently, but they currently operate the same way in our tech
preview.

>>>
>>>> Also, since ceph-disk and Ceph's udev rules are tightly coupled an=
d
>>>> ceph-disk creates systemd or upstart rules for OSD daemons, does i=
t
>>>> make sense to add hooks in ceph-disk to start up a containerized O=
SD
>>>> daemons either in systemd or upstart?
>>>
>>> Yes, but that would probably not be my first choice.
>>>
>>> Could you please provide the URL to the RHEL-based ceph container d=
ocker image you released recently ?
>>>
>>> Cheers
>>>
>>>>
>>>> Can somebody in this community help us with this?
>>>>
>>>> Thanks,
>>>>
>>>> Jim C.
>>>
>>> [1] https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rules=
#L4 etc.
>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Daniel
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
