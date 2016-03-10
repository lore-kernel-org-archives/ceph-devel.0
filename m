From: Mike Christie <mchristi@redhat.com>
Subject: (unknown)
Date: Thu, 10 Mar 2016 00:34:30 -0600
Message-ID: <1457591672-17430-1-git-send-email-mchristi@redhat.com>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42468 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcCJGef (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 01:34:35 -0500
Subject: 
In-Reply-To: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ddiss@suse.de

The following patches made over the ceph master branch
implement OSD side support for VMware VAAI's Atomic Test
and Set (ATS) and Write Same (Zero) requests.

ATS is used for operations like locking and heartbeats. It
is implemented by as the SCSI COMPARE_AND_WRITE command which
requires the device to read N blocks, compare them to data
sent with the command, and if equal, write N blocks.

Zero is used to initialize blocks to zero. It is implemented
as the SCSI WRITE_SAME command which passes the device a
block's worth of data and has it write it multiple times.

This does not include support for XCOPY/extended copy. I
am still looking into this, but it seems it might be
difficult to support due to rbd being more tuned to cloning
entire devices. When we implement VASA, the cloneVirtualVolume
might be something we can support though.

More info on VAAI can be found here:
http://www.vmware.com/resources/techresources/10337

The krbd patches which use these requests are in vaai branch of
this tree:
https://github.com/mikechristie/linux-kernel

I did not submit them in this thread, because they depend on other
patches that are still being reviewed upstream and I did not want
to waste people's time reviewing them if they change. These OSD side
patches should be ok to review and merge, because the op format 
and implemention should not change.


