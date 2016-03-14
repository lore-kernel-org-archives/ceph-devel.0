From: Jim Curtis <jicurtis@redhat.com>
Subject: Re: How to leverage ceph udev rules for containerized ceph
Date: Mon, 14 Mar 2016 13:28:12 -0700
Message-ID: <CAGEA57d24BJgSxiJGryP=arC0Zn0TBpzGkMhWJ2JTMjD+KJoSA@mail.gmail.com>
References: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
	<56E7193C.50202@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34849 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbcCNU2N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 16:28:13 -0400
Received: by mail-io0-f177.google.com with SMTP id g203so237178860iof.2
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 13:28:13 -0700 (PDT)
In-Reply-To: <56E7193C.50202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "Chen, Huamin" <hchen@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic,

The image is on the registry:
https://access.redhat.com/search/#/container-images?q=3Dceph&p=3D1&sort=
=3Drelevant&rows=3D12&srch=3Dany&documentKind=3DImageRepository

It can be pulled from:

registry.access.redhat.com/rhceph/rhceph-1.3-rhel7

Huamin might also have some input on your comments.  I forgot to cc
him on my original message and I'm not sure if he is subscribed to the
list.

Jim C.

On Mon, Mar 14, 2016 at 1:04 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Jim,
>
> On 14/03/2016 19:34, Jim Curtis wrote:
>> Greeting ceph-devel,
>>
>> We are working on a ceph containerization project within Red Hat.  W=
e
>> have recently released our RHEL-based ceph container docker image an=
d
>> now we are moving on to handling a feature limitation with that imag=
e.
>>
>> Specifically, the issue is that on our Atomic host, there is no ceph
>> installed, so there are no ceph udev rules to trigger dynamic
>> configuration of OSDs when a disk is plugged into the host.
>
> It would be convenient to have a standalone ceph-disk package (native=
 or pypi) that includes udev rules and init scripts.
>
>> What we would like to do is install our own set of ceph udev rules
>> that would trigger the startup of our ceph docker container.  We wou=
ld
>> like to leverage the current implementation of the ceph udev rules t=
o
>> do this.
>
> Let say we allocate a new partition type for each existing partition =
type[1] so that ceph-disk knows it should docker run ceph-osd instead o=
f running the ceph-osd daemon itself. If docker run ceph-osd has the sa=
me set of arguments as the ceph-osd daemon, the only thing to adapt is =
how the init system handles a container with a name instead of a daemon=
 with a pid. Alternatively, ceph-disk could be instructed to delegate r=
unning the ceph-osd daemon to docker instead of using an init system. T=
he later would make more sense to me because the semantic of an init sy=
stem is not perfectly aligned with the docker run / stop semantic.
>
> What I'm not sure about is how a ceph-osd running within a container =
can be instructed to use a given device. The only way I know is to expo=
se /dev with --privileged which is probably too much. Is --device=3D/de=
v/sdb:/dev/sdb:rwm enough ? Is it possible, in case we only need to gra=
nt access to a partition used for journaling, to --device=3D/dev/sdc1:/=
dev/sdc1 ?
>
>> Also, since ceph-disk and Ceph's udev rules are tightly coupled and
>> ceph-disk creates systemd or upstart rules for OSD daemons, does it
>> make sense to add hooks in ceph-disk to start up a containerized OSD
>> daemons either in systemd or upstart?
>
> Yes, but that would probably not be my first choice.
>
> Could you please provide the URL to the RHEL-based ceph container doc=
ker image you released recently ?
>
> Cheers
>
>>
>> Can somebody in this community help us with this?
>>
>> Thanks,
>>
>> Jim C.
>
> [1] https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rules#L=
4 etc.
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
