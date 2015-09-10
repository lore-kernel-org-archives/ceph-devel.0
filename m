From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding journal replay
Date: Thu, 10 Sep 2015 20:30:28 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE41F48@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0077.outbound.protection.outlook.com ([157.56.111.77]:2552
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750963AbbIJUaf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 16:30:35 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage et. al,
Could you please let me know what will happen during journal replay in this scenario ?

1. Say last committed seq is 3 and after that one more independent transaction with say 4 came. Transaction seq 4, has say delete xattr, delete object, create a new object,  set xattr

2. Seq 4 is committed in journal and in half way of applying (say all deletes are done , and created new object but set xattr not done) system crashed.

3. During restart OSD will try to replay seq 4.

Now, my understanding is, it will blindly run the entire transaction again. But..

1. Delete will fail since the file doesn't exists.

2. It will create the new object again even if it is already created , probably get an already exist error (?)

Question is, how it will determine the error is because of filesystem corruption or half executed transaction ?
 I saw in the code we are ignoring these errors during replay , is it correct ?
Any information on this will be helpful.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

