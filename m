From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Recovery question
Date: Mon, 23 Feb 2015 20:55:39 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B72DE@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0095.outbound.protection.outlook.com ([65.55.169.95]:23687
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751995AbbBWUzp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Feb 2015 15:55:45 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,
Can anyone help me understand what will happen in the following scenarios ?

1. Current PG map : 3.5 -> OSD[1,2,3]

2. 1 is down and new map : 3.5 -> OSD[2,3,4]

3. Need to for backfill recovery for 4 and it started

4. Meanwhile OSD 1 came up , it was down for short amount of time

5. Will pg 3.5 mapping change considering OSD 1 recovery could be log based ?

6. Also, if OSD 4 recovery could be log based, will there be any change in pg map if OSD 1 is up during the recovery ?

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

