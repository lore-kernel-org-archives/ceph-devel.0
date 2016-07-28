From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: BLueStore Deadlock
Date: Thu, 28 Jul 2016 15:45:02 +0000
Message-ID: <BL2PR02MB2115C50415AD456393E9A5A6F4000@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <6AA21C22F0A5DA478922644AD2EC308C373B92BC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com ([104.47.33.50]:51856
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751406AbcG1PpG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2016 11:45:06 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C373B92BC@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Jianpeng,
Are you trying with latest master and still hitting the issue (seems so but confirming) ?
The following scenario should not be creating deadlock because of the following reason.

Onode->flush() is waiting on flush_lock() and from _txc_finish() it is releasing that before taking osr->qlock(). Am I missing anything ?

I got a deadlock in this path in one of my earlier changes in the following pull request (described in detail there) and it is fixed and merged.

https://github.com/ceph/ceph/pull/10220

If my theory is right , we are hitting deadlock because of some other reason may be. It seems you are doing WAL write , could you please describe the steps to reproduce ?

Thanks & Regards
Somnath

From: Ma, Jianpeng [mailto:jianpeng.ma@intel.com]
Sent: Thursday, July 28, 2016 1:46 AM
To: Somnath Roy
Cc: ceph-devel; Ma, Jianpeng
Subject: BLueStore Deadlock

Hi Roy:
     When do seqwrite w/ rbd+librbd, I met deadlock for bluestore. It can reproduce 100%.(based on 98602ae6c67637dbadddd549bd9a0035e5a2717)
By add message and this found this bug caused by bf70bcb6c54e4d6404533bc91781a5ef77d62033.
Consider this case:

tp_osd_tp                                              aio_complete_thread                                 kv_sync_thread
Rwlock(coll)                                            txc_finish_io                                                     _txc_finish
do_write                                                 lock(osr->qlock)                                               lock(osr->qlock)
do_read                                                  RLock(coll)                                                                     need osr->qlock to continue
onode->flush()                                            need coll readlock to continue
   need previous txc complete

But current I don't how to fix this.

Thanks!
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
