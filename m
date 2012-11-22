From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD Backup
Date: Thu, 22 Nov 2012 21:13:33 +0800
Message-ID: <50AE24FD.8090103@widodh.nl>
References: <50ACD936.8060907@profihost.ag> <50ACDB85.4020006@widodh.nl> <50AE0535.8080904@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52308 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab2KVSiC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:38:02 -0500
In-Reply-To: <50AE0535.8080904@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 11/22/2012 06:57 PM, Stefan Priebe - Profihost AG wrote:
> Hi,
>
> Am 21.11.2012 14:47, schrieb Wido den Hollander:
>> The snapshot isn't consistent since it has no way of telling the VM to
>> flush it's buffers.
>>
>> To make it consistent you have to run "sync" (In the VM) just prior to
>> creating the snapshot.
>
> Mhm but between executing sync and executing snap is again time to store
> data.
>

True. That is always a problem with snapshots. I always regard data 
written to disk in the last 30 seconds as being in the "danger zone".

When you use libvirt and QCOW2 as a backing store for your virtual 
machine you can also snapshot with libvirt. It will not only snapshot 
the disk, but it will also store the memory contents from the virtual 
machine so you have a consistent state of the virtual machine.

This has a drawback however, since when you give the VM 16GB of memory, 
you have to store 16GB of data.

Right now this doesn't work yet with RBD, but there is a feature request 
in the tracker. I can't seem to find it right now.

What you could do is:

$ ssh root@virtual-machine "sync"
$ rbd snap create vm-disk@snap1
$ rbd export --snap snap1 vm-disk /mnt/backup/vm-disk_snap1.img

This way you have a pretty consistent snapshot.

Wido

>> rbd export --snap BACKUP image1 /mnt/backup/image1.img
>> losetup /mnt/backup/image1.img
>>
>> kpartx -a /dev/loop0
>>
>> Now you will have the partitions from the RBD image available in
>> /dev/mapper/loop0pX
> Works fine!
>
> Greets,
> Stefan
