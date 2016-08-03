From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: CephFs performance data
Date: Wed, 3 Aug 2016 16:24:06 +0000
Message-ID: <BL2PR02MB211586BC32D5102FEE450C7AF4060@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:58344
	"EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757991AbcHCQY0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 12:24:26 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ben England (bengland@redhat.com)" <bengland@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ben,
Thanks for the first cut data on CephFS , it was really helpful.
Do you mind to send out the slides ?
Also, continuing the discussion on 4K SW throughput is ~1GB/S , if you are running test with direct IO, client Linux system can't coalesce the writes and I didn't see much coalescing at the OSD servers as well. Unless CephFS has some coalescing logic it will be good if we can find out how we are getting this bigger throughput for 4K. Let me know if I am missing something..

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
