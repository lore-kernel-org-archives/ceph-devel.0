From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: timed out in osd1 error in dmes
Date: Thu, 15 Mar 2012 07:46:31 +0000 (UTC)
Message-ID: <loom.20120315T084452-832@post.gmane.org>
References: <loom.20120313T083325-276@post.gmane.org> <4F5FACD8.8090902@dreamhost.com> <loom.20120314T051739-894@post.gmane.org> <Pine.LNX.4.64.1203141057030.11925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53700 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289Ab2COHqr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Mar 2012 03:46:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S85OV-0008Rm-U0
	for ceph-devel@vger.kernel.org; Thu, 15 Mar 2012 08:46:43 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 08:46:43 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 08:46:43 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> 
> These are harmless noise, BTW, you can ignore them.
> 
> Can you tell us how your OSDs are configured?  Where are the data 
> directories and journals located?  (The [osd] section of ceph.conf would 
> be helpful.)
> 
> Another useful piece of information would be the ceph-osd's raw 
> performance writing to the local disk+journal, which you can get with
> 
>  $ ceph tell osd.0 bench
> 
> You might want to check it for several nodes to see if it's consistent, 
> etc.
> 
Below are the results from above command run against all osd's


2012-03-15 13:06:19.980924 osd.0 -> 'bench: wrote 1024 MB in blocks of 
4096 KB in 67.474949 sec at 15540 KB/sec' (0)
2012-03-15 13:09:20.573176 osd.1 -> 'bench: wrote 1024 MB in blocks of 
4096 KB in 70.815932 sec at 14807 KB/sec' (0)
2012-03-15 13:11:57.895738 osd.2 -> 'bench: wrote 1024 MB in blocks of 
4096 KB in 60.370233 sec at 17369 KB/sec' (0)

Do you see any issues 

Thanks



