From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: XFS xattr limit and Ceph
Date: Thu, 15 Oct 2015 14:54:57 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F31743F40@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0093.outbound.protection.outlook.com ([157.56.110.93]:52512
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751782AbbJOOzA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 10:55:00 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,
Why we are using XFS max inline xattr value as 10 only ?

OPTION(filestore_max_inline_xattrs_xfs, OPT_U32, 10)

XFS is supporting 1k limit I guess. Is there any performance reason behind that ?

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

