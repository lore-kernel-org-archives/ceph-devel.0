From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Probable memory leak in Hammer write path ?
Date: Sun, 28 Jun 2015 00:57:03 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDAF9DF@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0090.outbound.protection.outlook.com ([157.56.110.90]:12800
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752056AbbF1A5H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Jun 2015 20:57:07 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
I am chasing a substantial memory leak in latest Hammer code base in the write path since yesterday and wanted to know if anybody else is also observing this or not. This is as simple as running a fio-rbd random_write workload in my single OSD server with say block size 16K and num_jobs = 8. I am seeing memory is increasing very substantially and eventually OSD stopped responding.
I tried it on two different servers (just to make sure since I was playing with lot of kernel param of late), but results are similar.
Digging down the code and short circuiting different layers, I got the following.

1. Seeing the nature of leak, it seems the entire transaction is leaking.

2.  Code is deleting the transaction with a help of C_DeleteTransaction context and commenting out the following line and deleting the transaction (op_t) from submit_transaction(), seems resolved the leak.

  /*op_t->register_on_applied(
    new ObjectStore::C_DeleteTransaction(op_t));*/


3. In my case, I short circuited the queue_transaction and that's why it is working, but in reality, we can't delete the transaction from submit_transaction(). Code seems to be doing proper way , but I am not able to find out yet why it is leaking memory during deleting it async way.

Appreciate if anybody try out latest hammer building from source and confirm the behavior.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

