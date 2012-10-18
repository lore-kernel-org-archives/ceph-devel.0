From: <Eric_YH_Chen@wiwynn.com>
Subject: Re: rbd map error with new rbd format
Date: Thu, 18 Oct 2012 08:01:04 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA02DF21@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw2.wistron.com ([220.128.89.22]:51139 "EHLO
	TWNHUMSW2.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab2JRIGJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Oct 2012 04:06:09 -0400
Received: from GDC-CLDCAS-P03.whq.wistron (unverified [10.37.38.64]) by TWNHUMSW2.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta781064a47c0a816701c90@TWNHUMSW2.wistron.com> for <ceph-devel@vger.kernel.org>;
 Thu, 18 Oct 2012 16:03:31 +0800
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, Josh:

> Yeah, format 2 and layering support is in progress for kernel rbd,
> but not ready yet. The userspace side is all ready in the master
> branch, but it takes more time to implement in the kernel.
> Btw, instead of --new-format you should use --format 2. It's in
> the man page in the master branch.

As you mentioned before, http://www.spinics.net/lists/ceph-devel/msg08857.html
The kernel rbd is not ready at September, so we cannot map rbd to a device. 
Would you mind to estimate when will be available? And which version of kernel? (3.5 or 3.6?)  
Thanks!
