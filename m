From: Wido den Hollander <wido@widodh.nl>
Subject: btrfs_alloc_free_block
Date: Thu, 12 Apr 2012 10:45:23 +0200
Message-ID: <4F869623.7000005@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54284 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab2DLIp0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 04:45:26 -0400
Received: from [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37] (unknown [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id C7014402EC
	for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 10:45:23 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I just noticed some issues in my cluster where a couple of OSDs would 
commit suicide due to I/O timeouts.

A quick check showed me: http://pastebin.com/uU1MJRPh

I killed (clean shutdown) osd.1 in this case and tried to start it 
again, that seemed to go well, but then the btrfs mount failed: 
http://pastebin.com/F1nSb67y

"btrfs: open_ctree failed"

root@atom0:/var/log/ceph# service ceph start osd.1
=== osd.1 ===
Mounting Btrfs on atom0:/var/lib/ceph/osd.1
Scanning for Btrfs filesystems
mount: wrong fs type, bad option, bad superblock on /dev/sdc,
        missing codepage or helper program, or other error
        In some cases useful info is found in syslog - try
        dmesg | tail  or so

failed: 'modprobe btrfs ; btrfs device scan || btrfsctl -a ; egrep -q 
'^[^ ]+ /var/lib/ceph/osd.1' /proc/mounts || mount -t btrfs -o noatime 
/dev/disk/by-id/scsi-SATA_WDC_WD20EARS-00_WD-WCAZA3231872 
/var/lib/ceph/osd.1'
root@atom0:/var/log/ceph#

Has anyone seen this behavior with the 3.3.0 kernel?

My main concern is the fact that my filesystem won't mount anymore and I 
have to re-format the whole OSD. This open_ctree problem keeps coming back.

Wido
