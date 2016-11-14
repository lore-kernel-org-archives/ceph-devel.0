From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: How can OSD udev rules race with lvm at boot time ?
Date: Mon, 14 Nov 2016 21:29:28 +0100
Message-ID: <CAPed3OELgYa3+ieferaHvzJ7k8GzSFLN9gTKEEDjO_UHgay=zw@mail.gmail.com>
References: <29b296db-034b-f91d-b7fe-b3f3f86a1df1@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36535 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbcKNU3z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 15:29:55 -0500
Received: by mail-ua0-f177.google.com with SMTP id b35so71928999uaa.3
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 12:29:49 -0800 (PST)
In-Reply-To: <29b296db-034b-f91d-b7fe-b3f3f86a1df1@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 14, 2016 at 11:26 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,

Hi Loic,

I really appreciate you looking into this. While as a workaround for
this issue I stopped using LVM on my Ceph nodes, I'd like to go back
to LVM eventually.
>
> It looks like OSD udev rules race with LVM at boot time. In a nutshell, i=
f /var/lib/ceph is on a LVM volume different from /, udev may fire events t=
rying to start OSDs before the LVM volume is mounted and fail. This problem=
 has been reported a few times over the past months and I believe it is rea=
l.

Just thinking out loud, but does udev make any guarantees at all about
filesystems being available (and writable) when udev rules run?

> I don't think there is any safeguard preventing such a race and it makes =
sense to me that it can happen sometimes. I'd like to reproduce it reliably=
 to assert this is the reason why it happens. And, more importantly, to fig=
ure out a fix and verify it works. So far all my attemps have failed: the O=
SD comes back up every time. The details about this issue are at http://tra=
cker.ceph.com/issues/17889
>
> If someone has ideas about how to handle this, it would be most welcome :=
-)

I'm trying to follow how osds are activated since this has been a
mystery for me so far.
Please bear with my, but this is how I understand it works:

- the ceph udev rules call ceph-disk trigger when udev detects a
device / partition suitable for ceph based on GPT uuids.
- ceph-disk trigger restarts an instantiated service, let's say
ceph-disk@/dev/sda.service. (properly escaped). This is asynchronous.
- ceph-disk.service calls ceph-disk trigger --sync /dev/sda
- ceph-disk trigger --sync /dev/sda calls ceph-disk activate /dev/sda

Now the first thing ceph-disk/main.py does (always) is mkdir
/var/lib/ceph, and take a file lock on
/var/lib/ceph/tmp/ceph-disk.prepare.lock and
/var/lib/ceph/tmp/ceph-disk.activate.lock.
Unless I'm mistaken this doesn't actually seem to be needed in the
ceph-disk trigger case.
Then we could add a RequiresMountsFor=3D/var/lib/ceph to
ceph-disk.service and be done with it.

As for how to reproduce the issue, one thought that comes to mind is
if you're testing this in a vm, perhaps you could put and I/O cap on
the disks, and this will improve your change of invoking the race.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

Kind regards,

Ruben Kerkhof
