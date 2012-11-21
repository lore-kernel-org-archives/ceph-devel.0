From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD Backup
Date: Wed, 21 Nov 2012 21:47:49 +0800
Message-ID: <50ACDB85.4020006@widodh.nl>
References: <50ACD936.8060907@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:39616 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2KUNsA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 08:48:00 -0500
In-Reply-To: <50ACD936.8060907@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 11/21/2012 09:37 PM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> is there a recommanded way to backup rbd images / disks?
>
> Or is it just
> rbd snap create BACKUP
> rbd export BACKUP

You should use:

rbd export --snap BACKUP <img> <dest>

> rbd snap rm BACKUP
>
> Is the snap needed at all? Or is an export save? Is there a way to make
> sure the image is consistent?
>

While reading rbd.cc it doesn't seem like running export on a running VM 
is safe, so you should snapshot before.

The snapshot isn't consistent since it has no way of telling the VM to 
flush it's buffers.

To make it consistent you have to run "sync" (In the VM) just prior to 
creating the snapshot.

> Is it possible to use the BACKUP file as a loop device or something else
> so that i'm able to mount the partitions from the backup file?
>

You can do something like:

rbd export --snap BACKUP image1 /mnt/backup/image1.img
losetup /mnt/backup/image1.img
kpartx -a /dev/loop0

Now you will have the partitions from the RBD image available in 
/dev/mapper/loop0pX

Wido

> Thanks!
>
> Greets Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
