From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: SIGTERM and osd close
Date: Thu, 30 Jun 2016 18:44:22 +0000
Message-ID: <BL2PR02MB2115AA87DE1F8A1929FB6887F4240@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CY1PR0201MB182059A3B8115A640EB69BA985240@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:63216
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751973AbcF3S7I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 14:59:08 -0400
In-Reply-To: <CY1PR0201MB182059A3B8115A640EB69BA985240@CY1PR0201MB1820.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You need to call it from BlueStore::umount() I guess for cleanup work..

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ramesh Chander
Sent: Thursday, June 30, 2016 8:46 AM
To: ceph-devel@vger.kernel.org
Subject: SIGTERM and osd close

Hi All,

When I use stop.sh without any argument, I suppose it calls pkill with SIGTERM on osds as well as other processes.

Does osd handle this signal and take care of closing all components?

I am specifically interested in if it closes objectstore -> keyvaluedb .

I don't see my code of keyvaluedb shutdown/close being called when I do ./stop.sh

Any argument or way to force this?

-Ramesh
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
