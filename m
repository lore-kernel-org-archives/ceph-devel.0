From: Loic Dachary <loic@dachary.org>
Subject: Re: How can OSD udev rules race with lvm at boot time ?
Date: Wed, 30 Nov 2016 07:15:01 +0100
Message-ID: <022ec982-0897-a285-b07d-757ce738a76c@dachary.org>
References: <29b296db-034b-f91d-b7fe-b3f3f86a1df1@dachary.org>
 <CAPed3OELgYa3+ieferaHvzJ7k8GzSFLN9gTKEEDjO_UHgay=zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33091 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbcK3GQG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 01:16:06 -0500
In-Reply-To: <CAPed3OELgYa3+ieferaHvzJ7k8GzSFLN9gTKEEDjO_UHgay=zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ruben,

On 14/11/2016 21:29, Ruben Kerkhof wrote:
> On Mon, Nov 14, 2016 at 11:26 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
> 
> Hi Loic,
> 
> I really appreciate you looking into this. While as a workaround for
> this issue I stopped using LVM on my Ceph nodes, I'd like to go back
> to LVM eventually.
>>
>> It looks like OSD udev rules race with LVM at boot time. In a nutshell, if /var/lib/ceph is on a LVM volume different from /, udev may fire events trying to start OSDs before the LVM volume is mounted and fail. This problem has been reported a few times over the past months and I believe it is real.
> 
> Just thinking out loud, but does udev make any guarantees at all about
> filesystems being available (and writable) when udev rules run?
> 
>> I don't think there is any safeguard preventing such a race and it makes sense to me that it can happen sometimes. I'd like to reproduce it reliably to assert this is the reason why it happens. And, more importantly, to figure out a fix and verify it works. So far all my attemps have failed: the OSD comes back up every time. The details about this issue are at http://tracker.ceph.com/issues/17889
>>
>> If someone has ideas about how to handle this, it would be most welcome :-)
> 
> I'm trying to follow how osds are activated since this has been a
> mystery for me so far.
> Please bear with my, but this is how I understand it works:
> 
> - the ceph udev rules call ceph-disk trigger when udev detects a
> device / partition suitable for ceph based on GPT uuids.
> - ceph-disk trigger restarts an instantiated service, let's say
> ceph-disk@/dev/sda.service. (properly escaped). This is asynchronous.
> - ceph-disk.service calls ceph-disk trigger --sync /dev/sda
> - ceph-disk trigger --sync /dev/sda calls ceph-disk activate /dev/sda
> 
> Now the first thing ceph-disk/main.py does (always) is mkdir
> /var/lib/ceph, and take a file lock on
> /var/lib/ceph/tmp/ceph-disk.prepare.lock and
> /var/lib/ceph/tmp/ceph-disk.activate.lock.
> Unless I'm mistaken this doesn't actually seem to be needed in the
> ceph-disk trigger case.

It is necessary when trigger is called as a side effect of preparing a disk. After the partition is created, it will trigger the udev/trigger sequence you described above. And we do not want that sequence to interfere with an ongoing disk preparation. Similarly, if two udev events try to activate the osd at the same time, we do not want both to run in parallel. It is idempotent and there is no harm in running activation multiple times in sequence.

> Then we could add a RequiresMountsFor=/var/lib/ceph to
> ceph-disk.service and be done with it.

I think we already have that by default, unfortunately.

> As for how to reproduce the issue, one thought that comes to mind is
> if you're testing this in a vm, perhaps you could put and I/O cap on
> the disks, and this will improve your change of invoking the race.

Maybe it's a race between ceph-disk@.service and ceph-osd@.service, amplified by lvm. I'm trying to explore that at http://tracker.ceph.com/issues/17889#note-20

Cheers

>> --
>> Loïc Dachary, Artisan Logiciel Libre
> 
> Kind regards,
> 
> Ruben Kerkhof
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
