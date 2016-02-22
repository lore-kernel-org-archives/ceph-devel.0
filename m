From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: ceph-deploy disk partition alignment
Date: Mon, 22 Feb 2016 18:27:57 +0000
Message-ID: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0094.outbound.protection.outlook.com ([207.46.100.94]:52896
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753885AbcBVS2A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Feb 2016 13:28:00 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I am seeing ceph-deploy is creating data partition from sector 1 ignoring what sgdisk is recommending (256 in my disk). Basically, it should be aligned with physical sector size (reported in /sys/block/<device>/queue/physical_block_size). In my case it is 16K physical and 4K logical...256 is perfectly fine as sgdisk/fdisk internally decides.
Disk performance will be severely impacted because of partitioning this way from ceph-deploy , any reason why we are doing like this ?

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
