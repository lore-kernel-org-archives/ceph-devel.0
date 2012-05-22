From: Sage Weil <sage@inktank.com>
Subject: Re: write cache disabling recommendations for journal and storage
 disks ?
Date: Tue, 22 May 2012 07:41:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205220736390.26515@cobra.newdream.net>
References: <d287d282-620a-4f13-afe6-2a0f603600c1@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51216 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840Ab2EVOlx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 10:41:53 -0400
In-Reply-To: <d287d282-620a-4f13-afe6-2a0f603600c1@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 22 May 2012, Alexandre DERUMIER wrote:
> Hi, I have some questions about disabling write cache
> "
> http://ceph.com/docs/master/config-cluster/file-system-recommendations/
> 
> Ceph aims for data safety, which means that when the application receives notice that data was written to the disk, that data was actually written to the disk. For old kernels (<2.6.33), disable the write cache if the journal is on a raw disk. Newer kernels should work fine.
> 
> Use hdparm to disable write caching on the hard disk:
> 
> hdparm -W 0 /dev/hda 0
> "

To clarify: on newer kernels, calling fsync() or fdatasync() flushes the 
disk's write cache, so this isn't something you need to worry about at 
all.

> Cache on journal disk:
> 
> what happen if we have a powerfailure, if data are in cache of journal 
> disk (ssd with/without supercapicitor) (so write is ack, but not really 
> write on disk).

The ack is only sent if the client requests it, and normally the client 
does not.  Which means the client didn't get the ack, and will resend the 
request to the other replicas once the failed OSD is marked down.

> Cache on disks storage:
> what happen if we have a powerfailure,if write is commited to journal, 
> but write are in cache of storage disks and not yet on the platters ?

On newer kernels, the file system is careful to flush the disk cache any 
time durability matters (e.g., during a journal commit); there is no need 
to disable it on that disk.  If the write is durable in the journal, it 
will be applied to the fs on ceph-osd restart.

> Maybe the best way is to disable write cache on both (journal and 
> storage disks) ?

If you have an old kernel, disable it on the journal, and (if you're using 
ext3) mount with -o discard.  On newer kernels, I believe discard is 
(finally) the default.

sage
