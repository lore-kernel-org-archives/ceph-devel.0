From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding rbd --image-shared and --shared <tag>
Date: Mon, 9 Mar 2015 19:48:15 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282CA4CD@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0099.outbound.protection.outlook.com ([157.56.111.99]:56352
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752710AbbCITsU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 15:48:20 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
My assumption was I can't map the same image from two clients (and run IO concurrently)  as this can corrupt the image. But, in the latest rbd cli I saw --image-shared and --shared<tag>, wondering what is the use case of this ?
This means that I can now map same image from two different clients and run IO in active-active mode ?
What is the difference between --image-shared and --shared<tag> ?
Is there any restriction on the operation allowed in this mode ?
Appreciate any information on this.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

