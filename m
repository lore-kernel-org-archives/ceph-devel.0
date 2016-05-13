From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: ceph osd on shared storage
Date: Fri, 13 May 2016 02:36:22 +0000
Message-ID: <CY1PR02MB21239C991F3F277CC542DA47F4740@CY1PR02MB2123.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0073.outbound.protection.outlook.com ([65.55.169.73]:43601
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753226AbcEMCug convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 22:50:36 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
I have a storage array that is shared between say 4 hosts. Each host can see all the drives and that's why trying to mount OSDs configured to the drives. End result is not good.
I want a specific OSD to come up on a specific host even if a host is seeing all the drives on a chassis. Is there any way in the ceph deployment script so that I can address this ?
This will be very helpful in case of shared storage model in the following way.

1. Today if we do a zone (HW or SW) and attach some set of OSDs to a particular host , that host down OSDs will be inaccessible and recovery will kick off even if storage is just fine.

2. But, in the shared model we can have an external agent that can detect host failure and can make the same OSD pop up on the other available host.

3. Once the faulty host is replaced, same OSD can go back to old host.

4. This will save a lot of time cluster will be spending on recovery otherwise.

I know there are some dev effort required , but, is this sound sane and worth an effort ?
Any feedback is much appreciated.

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
