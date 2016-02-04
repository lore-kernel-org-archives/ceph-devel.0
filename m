From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: reducing buffer allocations
Date: Thu, 4 Feb 2016 22:43:36 +0000
Message-ID: <CY1PR0201MB1897C54EB50EA1194D9DB2DDE8D10@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0080.outbound.protection.outlook.com ([157.56.110.80]:65378
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932106AbcBDWni convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 17:43:38 -0500
In-Reply-To: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks like another place for small_vector ;-)


Allen Samuels
Software Architect, Fellow, Systems and Software Solutions

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, February 04, 2016 2:33 PM
To: ceph-devel@vger.kernel.org
Subject: reducing buffer allocations

https://github.com/ceph/ceph/pull/5534

does two things: (1) combine the buffer::raw reference count and buffer into a single allocation (ala make_shared), and (2) convert buffer::list into an intrusive_list, while embedding N (=3) buffer::ptr's in the buffer::raw so that most buffers require only 1 allocation (provided they aren't on more than N lists).

This needs a rebase, and some benchmarking.  But before I pull it up, is this the right direction?  I saw little benefit from (2) after doing (1), but I was doing a really simple microbenchmark.  Do we want both, or just 1, or is there an alternative we should consider?

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
