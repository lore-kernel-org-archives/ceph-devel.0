From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: BlueStore Transaction + collection
Date: Fri, 15 Jul 2016 00:19:17 +0000
Message-ID: <BL2PR02MB2115BF3FDC6BE2CC21A1DF51F4330@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0080.outbound.protection.outlook.com ([104.47.37.80]:27328
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751247AbcGOATU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2016 20:19:20 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Hi Sage/Sam,
I am seeing we are using vector of collections within _txc_add_transaction() (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L5206). I always thought all ops within a transaction will be having same collection id.
What is the scenario (or use case) where we may have ops with different collection ids within a transaction.
Also, I saw in BlueStore we are storing the first_collection (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.h#L893)  among these op->cid.
I couldn't understand the reason as only place we are using that to trim the collection cache during _txc_finish -> _osr_reap_done(). If there is multiple collections within a txc op , why only first one is used.

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
