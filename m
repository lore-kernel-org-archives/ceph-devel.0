From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RGW + erasure coding
Date: Wed, 6 May 2015 01:35:49 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD86F12@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0075.outbound.protection.outlook.com ([157.56.110.75]:12231
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751697AbbEFBfx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 21:35:53 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I am planning to setup RGW on top of Erasure coded pool. RGW stores all of its data in the .rgw.buckets pool and I am planning to configure this pool as erasure-coded. I think configuring all other rgw pools as replicated should be fine as they don't store lot of data.
Please let me know if I am missing anything, any comments/suggestion/performance tuning insight  on this will be very helpful.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

