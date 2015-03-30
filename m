From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Creating and deploying OSDs in parallel
Date: Mon, 30 Mar 2015 15:32:19 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB60C4@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0080.outbound.protection.outlook.com ([157.56.111.80]:22629
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752720AbbC3PcW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 11:32:22 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
I am planning to modify our deployment script so that it can create and deploy multiple OSDs in parallel to the same host as well as on different hosts.
Just wanted to check if there is any problem to run say 'ceph-deploy osd create' etc. in parallel while deploying cluster.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

