From: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Subject: Re: mount via ceph-fuse is failing
Date: Fri, 9 Mar 2012 16:39:21 +0000 (UTC)
Message-ID: <loom.20120309T173712-992@post.gmane.org>
References: <loom.20120309T081725-352@post.gmane.org> <Pine.LNX.4.64.1203090819310.11669@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43256 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758171Ab2CIQjg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Mar 2012 11:39:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S62qr-0002c4-Ry
	for ceph-devel@vger.kernel.org; Fri, 09 Mar 2012 17:39:33 +0100
Received: from Static-146.73.99.14.tataidc.co.in ([Static-146.73.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 17:39:33 +0100
Received: from madhusudhana.u.acharya by Static-146.73.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 17:39:33 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:

> 
> On Fri, 9 Mar 2012, Madhusudhan wrote:
> > Hi,
> > When i try to mount ceph file systems via fuse, its failing. 
> > 
> > 
> > [root <at> ceph-node-9 ~]# ceph-fuse -m 
10.25.12.123,10.25.12.124,10.25.12.125:/ 
> > /mnt/macharya_ceph/
> > ceph-fuse[18533]: starting ceph client
> > ceph-fuse[18533]: starting fuse
> > fuse: unknown option `big_writes'
> > 2012-03-08 23:12:52.100276 7ffff7ab3760 fuse_lowlevel_new failed
> > ceph-fuse[18533]: fuse finished with error 33
> > ceph-fuse[18532]: mount failed: (33) Numerical argument out of domain
> 
> What OS are you running, and which version of FUSE is installed?  
> 'big_writes' is probablay a newish option.  We can probably make it fall 
> back to leaving it off if it isn't recognized.
> 
> sage
> 
> > 
> > 
> > what can be the issue ? 
> > 
> > Thanks
> > __M
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
I sm running CentOS 5.6 with 3.0.9 version

[root@ceph-node-5 ~]# uname -a
Linux ceph-node-5 3.0.9 #3 SMP Tue Feb 21 16:59:41 IST 2012 x86_64 x86_64 x86_64 
GNU/Linux


Below is fuse version
[root@ceph-node-5 ~]# ceph-fuse -V
ceph-fuse[29094]: starting ceph client
ceph-fuse[29094]: starting fuse
FUSE library version: 2.7.4
fusermount version: 2.7.4




