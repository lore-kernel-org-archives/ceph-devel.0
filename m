From: <Eric_YH_Chen@wiwynn.com>
Subject: RE: rbd map error with new rbd format
Date: Mon, 22 Oct 2012 09:04:17 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA03B0A2@GDC-CLDMBX-P02.whq.wistron>
References: <60E83269D669544E8069A09CB69135EA02DF21@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:56567 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2JVJEW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 05:04:22 -0400
Received: from GDC-CLDCAS-P02.whq.wistron (unverified [10.37.38.63]) by TWNHUMSW5.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta795d753d1c0a816731b8c@TWNHUMSW5.wistron.com> for <ceph-devel@vger.kernel.org>;
 Mon, 22 Oct 2012 17:04:15 +0800
In-Reply-To: <60E83269D669544E8069A09CB69135EA02DF21@GDC-CLDMBX-P02.whq.wistron>
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com


> At this point format 2 is understood by the kernel, and the
> infrastructure for opening parent images and the I/O path
> for clones is in progress. We estimate about 4-8 weeks for this,
> but you should check back then.
> Kernel 3.6 was already released, so this would probably go into 3.8 or
> 3.9.

Hi Josh:

Please let me clarify some point. 
If we want to map an RBD image to a kernel object, it may not ready until kernel 3.8 or 3.9.
But if we want to running qemu with RBD, it is ready in kernel 3.6, since QEMU can access it via librbd directly.
Do I correct? Thanks!


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Eric_YH_Chen@wiwynn.com
Sent: Thursday, October 18, 2012 4:01 PM
To: ceph-devel@vger.kernel.org
Cc: Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
Subject: Re: rbd map error with new rbd format

Hi, Josh:

> Yeah, format 2 and layering support is in progress for kernel rbd, but 
> not ready yet. The userspace side is all ready in the master branch, 
> but it takes more time to implement in the kernel.
> Btw, instead of --new-format you should use --format 2. It's in the 
> man page in the master branch.

As you mentioned before, http://www.spinics.net/lists/ceph-devel/msg08857.html
The kernel rbd is not ready at September, so we cannot map rbd to a device. 
Would you mind to estimate when will be available? And which version of kernel? (3.5 or 3.6?) Thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
