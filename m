From: James Harper <james.harper@bendigoit.com.au>
Subject: SMART monitoring
Date: Fri, 27 Dec 2013 00:26:19 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B68565E03@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:57564 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab3L0A03 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Dec 2013 19:26:29 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1VwLFy-0001hK-Do
	for ceph-devel@vger.kernel.org; Fri, 27 Dec 2013 11:26:26 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What would be the best approach to integrate SMART with ceph, for the predictive failure case?

Assuming you agree with SMART diagnosis of an impending failure, would it be better to automatically start migrating data off the OSD (reduce the weight to 0?), or to just prompt the user to replace the disk (which requires no monitoring on ceph's part)? The former would ensure that redundancy is maintained at all times without any user interaction.

And what about the bad sector case? Assuming you are using something like btrfs with redundant copies of metadata, and assuming that is enough to keep the metadata consistent, what should be done in the case of a small number of fs errors? Can ceph handle getting an i/o error on one of its files inside the osd and just read from the replica, or should the entire osd just be failed and let ceph rebalance the data itself?

Thanks

James
