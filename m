From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding ceph rbd write path
Date: Sat, 4 Apr 2015 00:17:24 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB9849@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0076.outbound.protection.outlook.com ([65.55.169.76]:57832
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751844AbbDDARb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Apr 2015 20:17:31 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi Sage/Sam,
Here is my understanding on ceph rbd write path.

1. Based on the image order rbd will decide the rados object size, say 4MB.

2. Now, from application say 64K chunks are being written to the rbd image.

3. rbd will calculate the objectids (one of the 4MB objects) and start populating the 4MB objects with 64K chunks.

4. Now, for each of this 64K chunk OSD will write 2 setattrs and the OMAP attrs.

If the above flow is correct, it is updating the same metadata for every 64K chunk write to the same object (and same pg). So, my question is, is there any way to optimize (coalesce) that in either rbd/osd layer ?
I couldn't find any way in the osd layer as it is holding pg->lock till a transaction complete. But, is there any way in the rbd side so that it can intelligently stage/coalesce the writes for the same object and do a batch commit?
This should definitely improve WA/performance for seq writes, may not be much for random though.

Let me know your opinion on this.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

