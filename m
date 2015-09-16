From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Very slow recovery/peering with latest master
Date: Wed, 16 Sep 2015 03:04:12 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0074.outbound.protection.outlook.com ([207.46.100.74]:63520
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751806AbbIPDET convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 23:04:19 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I am seeing very slow recovery when I am adding OSDs with the latest master.
Also, If I just restart all the OSDs (no IO is going on in the cluster) , cluster is taking a significant amount of time to reach in active+clean state (and even detecting all the up OSDs).

I saw the recovery/backfill default parameters are now changed (to lower value) , this probably explains the recovery scenario , but, will it affect the peering time during OSD startup as well ?

Thanks & Regards
Somnath


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

