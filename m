From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: rbd map automation woes
Date: Tue, 22 Apr 2014 11:58:03 +0200
Message-ID: <CABt9es9b2EzSn9apkEs940GMktTyssV7BjeZUPK2GV3RW5b0BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:65439 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbaDVJ6F convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 05:58:05 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so4033621lbi.22
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 02:58:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

Hello,

We're doing some rbd map automation and a week ago we had a problem
where an rbd map failed and the system contained the following error:

systemd-udevd[138]: worker [24919] /devices/virtual/block/rbd28 timeout=
; kill it
systemd-udevd[138]: seq 6903 '/devices/virtual/block/rbd28' killed
systemd-udevd[138]: worker [24919] terminated by signal 9 (Killed)

Afterwards the system had a problematic state where the block device
was mapped but no symlink was created for it in /dev/rbd/$pool/$name.
This caused us to investigate the problem and realized udevd is
responsible for creating this symlink and it had for some reason timed
out. My guess is that ceph/rbd had some temporary slowness or
connectivity issue (which is normal and expected). The big problem
here is that rbd map relies on the udev system to complete and this
architecture/dependency makes rbd mapping unautomatable:

"It's completely wrong to launch any long running task from a udev
rule and you should expect that it will be killed."

http://lists.freedesktop.org/archives/systemd-devel/2012-November/00739=
0.html

We could always use retry wrappers and other ugly race barriers (we
already do) around rbd mapping and unmapping even though it's a huge
architecture smell but not even that helps us in this case because the
rbd map can both fail and have side effect that causes subsequent
retries to also fail. Commands with side effects are okay-ish as long
as they guarantee that they are idempotent, but in this case we don't
even have this guarantee.

This caused us to consider switching to using raw rbd numbers to avoid
depending on the udev system at all. Unfortunately the design of "rbd
map" strive to be a "unix 'worse is better' side effect" rather than a
pure mathematical function that takes a pool and a block name and
returns an id allocated for it. This causes the actual allocated id
after a map to be unknown and prevents this raw-number workaround. If
you get stuck in the intermediary state you also have to manually look
in the system log to understand what number was actually allocated to
know what "rbd unmap" command to run to get back to square zero.

Note that if rbd is designed with the assumption that a human is
punching in one command at a time then the current architecture is
fine, otherwise there is some guarantees that is currently missing
IMO.

I would appreciate any thoughts or feedback on this.

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
