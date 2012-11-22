From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD Backup
Date: Thu, 22 Nov 2012 11:57:57 +0100
Message-ID: <50AE0535.8080904@profihost.ag>
References: <50ACD936.8060907@profihost.ag> <50ACDB85.4020006@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50839 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab2KVT6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:58:07 -0500
In-Reply-To: <50ACDB85.4020006@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 21.11.2012 14:47, schrieb Wido den Hollander:
> The snapshot isn't consistent since it has no way of telling the VM to
> flush it's buffers.
>
> To make it consistent you have to run "sync" (In the VM) just prior to
> creating the snapshot.

Mhm but between executing sync and executing snap is again time to store 
data.

> rbd export --snap BACKUP image1 /mnt/backup/image1.img
> losetup /mnt/backup/image1.img
>
> kpartx -a /dev/loop0
>
> Now you will have the partitions from the RBD image available in
> /dev/mapper/loop0pX
Works fine!

Greets,
Stefan
