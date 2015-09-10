From: Sage Weil <sage@newdream.net>
Subject: Re: Failed on starting osd-daemon after upgrade giant-0.87.1 to
 hammer-0.94.3
Date: Thu, 10 Sep 2015 15:23:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509090954410.12362@cobra.newdream.net>
References: <tencent_42C775740D2FE9D03D12EA84@qq.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54486 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbIJWXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 18:23:30 -0400
In-Reply-To: <tencent_42C775740D2FE9D03D12EA84@qq.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?zfXI8Q==?= <wangrui@tvmining.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi!

On Wed, 9 Sep 2015, ?? wrote:
> Hi all:
> 
> I got on error after upgrade my ceph cluster from giant-0.87.2 to hammer-0.94.3, my local environment is:
> CentOS 6.7 x86_64
> Kernel 3.10.86-1.el6.elrepo.x86_64
> HDD: XFS, 2TB
> Install Package: ceph.com official RPMs x86_64
> 
> step 1: 
> Upgrade MON server from 0.87.1 to 0.94.3, all is fine!
> 
> step 2: 
> Upgrade OSD server from 0.87.1 to 0.94.3. i just upgrade two servers and noticed that some osds can not started!
> server-1 have 4 osds, all of them can not started;
> server-2 have 3 osds, 2 of them can not started, but 1 of them successfully started and work in good.
> 
> Error log 1:
> service ceph start osd.4
> /var/log/ceph/ceph-osd.24.log 
> (attachment file: ceph.24.log)
> 
> Error log 2:
> /usr/bin/ceph-osd -c /etc/ceph/ceph.conf -i 4 -f
>  (attachment file: cli.24.log)

This looks a lot like a problem with a stray directory that older versions 
did not clean up (#11429)... but not quite.  Have you deleted pools in the 
past? (Can you attach a 'ceph osd dump'?)?  Also, i fyou start the osd 
with 'debug osd = 20' and 'debug filestore = 20' we can see which PG is 
problematic.  If you install the 'ceph-test' package which contains 
ceph-kvstore-tool, the output of 

 ceph-kvstore-tool /var/lib/ceph/osd/ceph-$id/current/db list

would also be helpful.

Thanks!
sage
