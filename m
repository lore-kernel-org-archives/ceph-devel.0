From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: understanding partprobe failure
Date: Thu, 17 Dec 2015 16:49:21 +0100
Message-ID: <CAOi1vP8+D9SpyGHMsnxWPM0Xs4yLPvK27=h8NG=Oy+Rbd=YvjQ@mail.gmail.com>
References: <5672A842.1030103@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34025 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbbLQPtW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 10:49:22 -0500
Received: by mail-wm0-f51.google.com with SMTP id l126so29333036wml.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 07:49:21 -0800 (PST)
In-Reply-To: <5672A842.1030103@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 17, 2015 at 1:19 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> I'm seeing a partprobe failure right after a disk was zapped with sgdisk --clear --mbrtogpt -- /dev/vdb:
>
> partprobe /dev/vdb failed : Error: Partition(s) 1 on /dev/vdb have been written, but we have been unable to inform the kernel of the change, probably because it/they are in use. As a result, the old partition(s) will remain in use. You should reboot now before making further changes.
>
> waiting 60 seconds (see the log below) and trying again succeeds. The partprobe call is guarded by udevadm settle to prevent udev actions from racing and nothing else goes on in the machine.
>
> Any idea how that could happen ?
>
> Cheers
>
> 2015-12-17 11:46:10,356.356 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:get_dm_uuid /dev/vdb uuid path is /sys/dev/block/253:16/dm/uuid
> 2015-12-17 11:46:10,357.357 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:Zapping partition table on /dev/vdb
> 2015-12-17 11:46:10,358.358 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/sgdisk --zap-all -- /dev/vdb
> 2015-12-17 11:46:10,365.365 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Caution: invalid backup GPT header, but valid main header; regenerating
> 2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:backup header from main header.
> 2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:
> 2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Warning! Main and backup partition tables differ! Use the 'c' and 'e' options
> 2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:on the recovery & transformation menu to examine the two tables.
> 2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:
> 2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Warning! One or more CRCs don't match. You should repair the disk!
> 2015-12-17 11:46:10,368.368 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:
> 2015-12-17 11:46:11,413.413 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:****************************************************************************
> 2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Caution: Found protective or hybrid MBR and corrupt GPT. Using GPT, but disk
> 2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:verification and recovery are STRONGLY recommended.
> 2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:****************************************************************************
> 2015-12-17 11:46:11,415.415 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Warning: The kernel is still using the old partition table.
> 2015-12-17 11:46:11,415.415 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:The new table will be used at the next reboot.
> 2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:GPT data structures destroyed! You may now partition the disk using fdisk or
> 2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:other utilities.
> 2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/sgdisk --clear --mbrtogpt -- /dev/vdb
> 2015-12-17 11:46:12,504.504 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Creating new GPT entries.
> 2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:Warning: The kernel is still using the old partition table.
> 2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:The new table will be used at the next reboot.
> 2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:The operation has completed successfully.
> 2015-12-17 11:46:12,506.506 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:Calling partprobe on zapped device /dev/vdb
> 2015-12-17 11:46:12,507.507 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udevadm settle --timeout=600
> 2015-12-17 11:46:15,427.427 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/partprobe /dev/vdb
> 2015-12-17 11:46:16,860.860 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:partprobe /dev/vdb failed : Error: Partition(s) 1 on /dev/vdb have been written, but we have been unable to inform the kernel of the change, probably because it/they are in use.  As a result, the old partition(s) will remain in use.  You should reboot now before making further changes.
> 2015-12-17 11:46:16,860.860 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:(ignored, waiting 60s)
> 2015-12-17 11:47:16,925.925 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udevadm settle --timeout=600
> 2015-12-17 11:47:19,681.681 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/partprobe /dev/vdb
> 2015-12-17 11:47:20,125.125 INFO:tasks.workunit.client.0.target167114233028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udevadm settle --timeout=600

Well, evidently something was using that partition.  This is on
openstack, right?  It probably makes it hard to debug, but trying to
reproduce and doing some tracing is probably the only way to get an
idea.

udevadm settle doesn't guarantee that a device (or one of its
partitions) isn't going to be busy - it just waits for udevd to empty
its queue.  Both sgdisk invocations complained about a busy device, is
it possible something external to udev was doing something with it?

Thanks,

                Ilya
