From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: SIGTERM and osd close
Date: Thu, 30 Jun 2016 15:45:56 +0000
Message-ID: <CY1PR0201MB182059A3B8115A640EB69BA985240@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0054.outbound.protection.outlook.com ([157.56.111.54]:20832
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752671AbcF3QKP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 12:10:15 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

When I use stop.sh without any argument, I suppose it calls pkill with SIGTERM on osds as well as other processes.

Does osd handle this signal and take care of closing all components?

I am specifically interested in if it closes objectstore -> keyvaluedb .

I don't see my code of keyvaluedb shutdown/close being called when I do ./stop.sh

Any argument or way to force this?

-Ramesh
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
