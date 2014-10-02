From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding key/value interface
Date: Thu, 2 Oct 2014 22:47:40 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F809@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0080.outbound.protection.outlook.com ([157.56.110.80]:54592
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753212AbaJBWro convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 18:47:44 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage/Haomai,

I was going through the key/value store implementation and have one basic question regarding the way it is designed.

I think key/value interface is assuming there will be a filesystem on top of the device . I saw in mount you are accessing files like superblock/fsid. So, for example, /var/lib/ceph/osd/ceph-0 should be a filesystem path, right ?
If so, this may not be the case always as there are key/value stores which can work on the raw device. In that case, these files (superblock/fsid) also need to go in the key/value db.

Let me know if I am missing anything.

Thanks & Regards
Somnath



________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

