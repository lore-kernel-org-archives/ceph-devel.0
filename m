From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Increase in performance by increasing OSD's ?
Date: Wed, 21 Mar 2012 15:11:23 +0000 (UTC)
Message-ID: <loom.20120321T161007-745@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52517 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824Ab2CUPLm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Mar 2012 11:11:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SANCK-0000U0-8t
	for ceph-devel@vger.kernel.org; Wed, 21 Mar 2012 16:11:36 +0100
Received: from Static-18.46.99.14.tataidc.co.in ([Static-18.46.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 16:11:36 +0100
Received: from madhusudhana.u.acharya by Static-18.46.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 16:11:36 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Will increase in the number of OSD will increase performance in ceph
cluster? I mean to say, if ceph cluster is giving ~70MB/s with 3 OSD,
will increasing OSD number to 5, increase the performance to ~100MB/s ?

I have re-created my entire ceph cluster with CentOS 6.2 and kernel 
3.2.11 and ceph 0.43. When i ran some tests, the results are far
better than my first cluster results. But, they are not yet near to
a normal linux machine or a entry level NetApp storage box. I have tested 
with cp, rsync, rm and dd commands. The performance what I am getting from
ceph are not satisfactory (test with my actual work load is even 
worse). For instance, rsync of 10G directory took 84 mins to complete 
in Linux machine (in NetApp it was 89mins). But, the same rsync took like 
10hrs to copy 10G of data. 

I work in a semiconductor company as a NAS admin. We use NetApp storage
for all development and 99% we use NFS infrastrucure.
So, I am trying to get some results from ceph which is at-least near to an
entry level NetApp storage. 

I am pointing this bcz, when we call ceph as high performance storage, then
it should perform better compared to any generic storage or a linux server.

Let me know if there is any fine tune that i can do which can in turn increase 
the performance of the my ceph cluster.

