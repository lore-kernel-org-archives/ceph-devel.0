From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: NFS re-exporting CEPH cluster
Date: Thu, 24 May 2012 05:14:56 +0000 (UTC)
Message-ID: <loom.20120524T071113-43@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39785 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab2EXFPL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 May 2012 01:15:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SXQOC-0004Nu-Fs
	for ceph-devel@vger.kernel.org; Thu, 24 May 2012 07:15:08 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 07:15:08 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 07:15:08 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
Can anyone tried re-exporting CEPH cluster via NFS with success (I mean to 
say, mount the CEPH cluster in one of the machine and then export that via 
NFS to clients)? I need to do this bcz of my client kernel version and some
EDA tools compatibility.Can someone suggest me how I can successfully 
re-export CEPH over NFS ?


Thanks
__M

