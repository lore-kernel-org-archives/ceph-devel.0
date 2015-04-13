From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding newstore performance
Date: Mon, 13 Apr 2015 23:53:53 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD78CA3@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0093.outbound.protection.outlook.com ([207.46.100.93]:25772
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750935AbbDMXx6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 19:53:58 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I was doing some preliminary performance testing of newstore on a single OSD (SSD) , single replication setup. Here is my findings so far.

Test:
-----

        64K random writes with QD= 64 using fio_rbd.

Results :
----------

        1. With all default settings, I am seeing very spiky performance. FIO is reporting between 0-~1K random write IOPS with many times IO stops at 0s...Tried with bigger overlay max size value but results are similar...

        2. Next I set the newstore_overlay_max = 0 and I got pretty stable performance ~800-900 IOPS (write duration is short though).

        3. I tried to tweak all the settings one by one but not much benefit anywhere.

        4. One interesting observation here, in my setup if I set newstore_sync_queue_transaction = true , I am getting iops ~600-700..Which is ~100 less.
             This is quite contrary to my keyvaluestore experiment where I got ~3X improvement by doing sync  writes !

        5. Filestore performance in the similar setup is ~1.6K after 1 TB of data write.

I am trying to figure out from the code what exactly this overlay writes does. Any insight/explanation would be helpful here.

I am planning to do some more experiment with newstore including WA comparison between filestore vs newstore. Will publish the result soon.

Thanks & Regards
Somnath





________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

