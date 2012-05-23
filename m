From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Re: Huge MDS log crashing the cluster
Date: Wed, 23 May 2012 10:33:03 +0000 (UTC)
Message-ID: <loom.20120523T122902-865@post.gmane.org>
References: <loom.20120522T130047-937@post.gmane.org> <CADvuQRFtccEPA4k7X8R-_gGvPzz6Zt13Za1buPjp_5ufY-zk4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44241 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab2EWKdZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 May 2012 06:33:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SX8sY-0005az-GK
	for ceph-devel@vger.kernel.org; Wed, 23 May 2012 12:33:20 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 12:33:18 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 12:33:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tv <at> inktank.com> writes:
> The default logrotate script installed by ceph.deb rotates log files
> daily and preserves 7 days of logs. If your /var is tiny, or you have
> heavy debugging turned on, you probably need to rotate more often and
> retain fewer log files. Or, if you're not using the debs, you'll need
> to provide some other means of rotating the log files.

In order to log rotate, we need to stop the deamon accessing the log file 
and them rename it right? I have removed the log file using rm command to 
check whether it will release the space, but even after the file removal, 
my /var partition is still full. 

So, do I have to stop MDS deamon and then remove the log file ? i am not 
finding any command through which i can stop MDS on node. Can you please
let me know how i can safely stop the MDS and then start it back ?

Thanks


