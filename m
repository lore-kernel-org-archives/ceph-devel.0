From: Varada Kari <Varada.Kari@sandisk.com>
Subject: BlueFS log compaction pull request
Date: Wed, 13 Jul 2016 17:54:06 +0000
Message-ID: <BLUPR0201MB1908C37601716BDD6E83E456E2310@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <BLUPR0201MB190873CA81F829C611254F7AE23F0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <BLUPR0201MB190838B7819BC102F553A2BFE2310@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:19834
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751916AbcGMRzA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2016 13:55:00 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

Have generated a pull request for the log compaction. Will split them
into simpler commits.

https://github.com/ceph/ceph/pull/10285

please share your comments.

Some pending tasks in the list.

1. Fault/crash injection in bluefs log flush and log compaction.
   Planning use some combination of bdev_inject_flush and some hooks in
bluefs. Do you have anything specific in your mind?

2. Adding more commentary in the code path.

3. Adding unit test cases for replay and crash recovery.

Please add, if you have any more tasks in your list.


Thanks,
varada
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
