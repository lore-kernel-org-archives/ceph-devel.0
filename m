From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD Backup
Date: Thu, 22 Nov 2012 13:08:30 -0800
Message-ID: <50AE944E.4030704@inktank.com>
References: <50ACD936.8060907@profihost.ag> <50ACDB85.4020006@widodh.nl> <50AE0535.8080904@profihost.ag> <50AE24FD.8090103@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46450 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab2KVVIe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 16:08:34 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6084450pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 13:08:34 -0800 (PST)
In-Reply-To: <50AE24FD.8090103@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/22/2012 05:13 AM, Wido den Hollander wrote:
>
>
> On 11/22/2012 06:57 PM, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> Am 21.11.2012 14:47, schrieb Wido den Hollander:
>>> The snapshot isn't consistent since it has no way of telling the VM to
>>> flush it's buffers.
>>>
>>> To make it consistent you have to run "sync" (In the VM) just prior to
>>> creating the snapshot.
>>
>> Mhm but between executing sync and executing snap is again time to store
>> data.
>>
>
> True. That is always a problem with snapshots. I always regard data
> written to disk in the last 30 seconds as being in the "danger zone".
>
> When you use libvirt and QCOW2 as a backing store for your virtual
> machine you can also snapshot with libvirt. It will not only snapshot
> the disk, but it will also store the memory contents from the virtual
> machine so you have a consistent state of the virtual machine.
>
> This has a drawback however, since when you give the VM 16GB of memory,
> you have to store 16GB of data.
>
> Right now this doesn't work yet with RBD, but there is a feature request
> in the tracker. I can't seem to find it right now.
>
> What you could do is:
>
> $ ssh root@virtual-machine "sync"
> $ rbd snap create vm-disk@snap1
> $ rbd export --snap snap1 vm-disk /mnt/backup/vm-disk_snap1.img
>
> This way you have a pretty consistent snapshot.

You can get an entirely consistent snapshot using xfs_freeze to
stop I/O to the fs until you thaw it. It's done at the vfs level
these days, so it works on all filesystems.

Josh

>>> rbd export --snap BACKUP image1 /mnt/backup/image1.img
>>> losetup /mnt/backup/image1.img
>>>
>>> kpartx -a /dev/loop0
>>>
>>> Now you will have the partitions from the RBD image available in
>>> /dev/mapper/loop0pX
>> Works fine!
>>
>> Greets,
>> Stefan

