From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: TOO SLOW data write speed and delete.. NEED HELP
Date: Tue, 13 Mar 2012 10:39:33 +0000 (UTC)
Message-ID: <loom.20120313T113524-750@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49152 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760303Ab2CMKjo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Mar 2012 06:39:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7P8o-0005cs-JJ
	for ceph-devel@vger.kernel.org; Tue, 13 Mar 2012 11:39:42 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 11:39:42 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 11:39:42 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
Can someone PLEASE help me to understand why data copying (simple cp
or rsync) is SO slow in CEPH ? And delete command (\rm -rf) for removing
a small (175M) directory is taking so much of time. Because of this,
i am not able to complete evaluation of ceph using my actual workload. 

I am hereby requesting all to help me in finding out the reason for 
slow write/delete in my ceph cluster. I am really trying hard to 
complete the evaluation with actual workload but not able to copy the
data whats required for evaluation to ceph cluster bcz of slow copy.

I really appreciate any help on this.

Thanks in advance
Madhusudhan

