From: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Subject: Too slow data copying in ceph cluster
Date: Fri, 9 Mar 2012 07:03:50 +0000 (UTC)
Message-ID: <loom.20120309T075843-941@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35722 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab2CIHEC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Mar 2012 02:04:02 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S5trs-0003od-0f
	for ceph-devel@vger.kernel.org; Fri, 09 Mar 2012 08:04:00 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 08:03:59 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 08:03:59 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I am trying to evaluate ceph cluster by using our actual workload.
I need almost 500G of data to be copied to ceph cluster in order
for doing workload test. But, 500G copying is taking a lot of time
(Coping started at 8.30AM PST time Thursday, 8th March). Its 
more than 12hrs and copying didn't completed. Can you please help
me to understand this delay ?

I have 2 MDS (one active, one standby), 3 monitors and 3 OSD's 
running. All 8 hosts are same OS/patch level running centos 5.6
with kernel 3.0.9 version.



