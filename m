From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: rbd map automation woes
Date: Tue, 22 Apr 2014 21:58:47 +0200
Message-ID: <CABt9es8xehAUFNNk7GPMk5CjAeESpazEyA+j=TQgPXjEkacUXQ@mail.gmail.com>
References: <CABt9es9b2EzSn9apkEs940GMktTyssV7BjeZUPK2GV3RW5b0BQ@mail.gmail.com>
	<CALFYKtACugAXVP=7RAt=bxFBMWnKOAT7O9S53KttOuJnTMenyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:35273 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237AbaDVT6t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 15:58:49 -0400
Received: by mail-la0-f43.google.com with SMTP id c6so97312lan.30
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 12:58:48 -0700 (PDT)
In-Reply-To: <CALFYKtACugAXVP=7RAt=bxFBMWnKOAT7O9S53KttOuJnTMenyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

On Tue, Apr 22, 2014 at 12:29 PM, Ilya Dryomov <ilya.dryomov@inktank.co=
m> wrote:
> On Tue, Apr 22, 2014 at 1:58 PM, Hannes Landeholm <hannes@jumpstarter=
=2Eio> wrote:
>> Hello,
>>
>> We're doing some rbd map automation and a week ago we had a problem
>> where an rbd map failed and the system contained the following error=
:
>>
>> systemd-udevd[138]: worker [24919] /devices/virtual/block/rbd28 time=
out; kill it
>> systemd-udevd[138]: seq 6903 '/devices/virtual/block/rbd28' killed
>> systemd-udevd[138]: worker [24919] terminated by signal 9 (Killed)
>>
>> Afterwards the system had a problematic state where the block device
>> was mapped but no symlink was created for it in /dev/rbd/$pool/$name=
=2E
>> This caused us to investigate the problem and realized udevd is
>> responsible for creating this symlink and it had for some reason tim=
ed
>> out. My guess is that ceph/rbd had some temporary slowness or
>> connectivity issue (which is normal and expected). The big problem
>> here is that rbd map relies on the udev system to complete and this
>> architecture/dependency makes rbd mapping unautomatable:
>>
>> "It's completely wrong to launch any long running task from a udev
>> rule and you should expect that it will be killed."
>>
>> http://lists.freedesktop.org/archives/systemd-devel/2012-November/00=
7390.html
>
> Not exactly sure what happened there, but that task is by no means lo=
ng
> running.  It's a small shell script that pokes some sysfs attributes
> and outputs a name of the symlink for udev to create.

Yeah, I just figured that a temporary network problem, load spike etc
could cause the sysfs operation to be blocked for a while and this
should ideally just make the rbd map just take a longer time, not make
it fail mid operation. Since udev explicitly claim that they will
never support anything that could run for a "longer" time it will
introduce failures. Even if the probability is low because it requires
some coincidental states the probability of it happening regularly
approaches 100% as the number of mappings and unmappings you make
approaches a sufficiently large value. Timeouts and sleeps are anti
patterns when building automated robust systems.

>>
>> We could always use retry wrappers and other ugly race barriers (we
>> already do) around rbd mapping and unmapping even though it's a huge
>> architecture smell but not even that helps us in this case because t=
he
>> rbd map can both fail and have side effect that causes subsequent
>> retries to also fail. Commands with side effects are okay-ish as lon=
g
>> as they guarantee that they are idempotent, but in this case we don'=
t
>> even have this guarantee.
>>
>> This caused us to consider switching to using raw rbd numbers to avo=
id
>> depending on the udev system at all. Unfortunately the design of "rb=
d
>> map" strive to be a "unix 'worse is better' side effect" rather than=
 a
>> pure mathematical function that takes a pool and a block name and
>> returns an id allocated for it. This causes the actual allocated id
>> after a map to be unknown and prevents this raw-number workaround. I=
f
>> you get stuck in the intermediary state you also have to manually lo=
ok
>> in the system log to understand what number was actually allocated t=
o
>> know what "rbd unmap" command to run to get back to square zero.
>>
>> Note that if rbd is designed with the assumption that a human is
>> punching in one command at a time then the current architecture is
>> fine, otherwise there is some guarantees that is currently missing
>> IMO.
>
> Our qa scripts have the same problem (retry loops, etc.).  I have
> a branch (that will hopefully make it into 0.81) that makes 'rbd map'
> output the device node it created:
>
>     $ sudo rbd map foo/bar
>     /dev/rbd3
>
> It also adds the guarantee that 'rbd map' will not return until the
> device node is created and can be stat(2)ed, open(2)ed, etc, and that
> 'rbd unmap' will not return until the device node is gone.  It uses
> libudev to achieve that, and so it still depends on udev, but I don't
> think there is a sane way to get around udev on modern systems.
>
> Thanks,
>
>                 Ilya

Okay, it's unfortunate that it still depends on udev but we would
really appreciate to have those guarantees.

Does the "rbd returning the new device node" feature also depend on ude=
v?

Also, is this branch public? I'd like to have a look.

Thank you for your time,
--
Hannes Landeholm
Co-founder & CTO
Jumpstarter - www.jumpstarter.io

=E2=98=8E +46 72 301 35 62
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
