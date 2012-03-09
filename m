From: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Subject: Is ceph cluster time sensitive
Date: Fri, 9 Mar 2012 15:05:25 +0000 (UTC)
Message-ID: <loom.20120309T160103-320@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51776 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757049Ab2CIPFj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Mar 2012 10:05:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S61Nv-0006J4-IP
	for ceph-devel@vger.kernel.org; Fri, 09 Mar 2012 16:05:36 +0100
Received: from Static-146.73.99.14.tataidc.co.in ([Static-146.73.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 16:05:35 +0100
Received: from madhusudhana.u.acharya by Static-146.73.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 16:05:35 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
Just wanted to know if ceph cluster is time sensitive. will there
be any issue if the date and time differs between client machine
and ceph cluster? do their time has to be in sync to work 
properly? if time differs, will there be any performance issue ?

Any plans to include exports/quotas in ceph file system ?
it will be a beauty if we have above to options, so that the space
in ceph cluster can be effectively allocated to client system.



