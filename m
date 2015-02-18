From: Sage Weil <sweil@redhat.com>
Subject: disk failure prediction
Date: Wed, 18 Feb 2015 15:20:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502181514400.24259@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbbBRXUi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Feb 2015 18:20:38 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-calamari@ceph.com

Interesting paper at FAST:

	https://www.usenix.org/system/files/conference/fast15/fast15-paper-ma.pdf

Short version: reallocated sectors correllates with impending disk 
failures (this sounds like what Sandon has been telling us for ages) and 
by preemptively replacing disks with impending failures reduced EMC's rate 
of triple-failures by 80%, and looking at the joint failure probability 
within each raid set reduces the failure rate by 98%.  We wouldn't see 
quite the same results since our "raid sets" are effectively entire pools, 
but this seems like a strong case for adding smart monitoring to the osds 
or to calamari already and doing some preemptive disk replacement.

sage
