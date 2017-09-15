From: Sage Weil <sage@newdream.net>
Subject: Re: How do I "install" from source? Service binaries (and /etc/ceph)
 are missing after make install
Date: Fri, 15 Sep 2017 23:57:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709152355200.16664@piezo.novalocal>
References: <CACG+mBVY==QPieFqgP1Qf1tcibRJZS5LhU02Wsca+4q=o2EkFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40716 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdIOX5D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 19:57:03 -0400
In-Reply-To: <CACG+mBVY==QPieFqgP1Qf1tcibRJZS5LhU02Wsca+4q=o2EkFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henrique Fingler <hfingler@cs.utexas.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, 15 Sep 2017, Henrique Fingler wrote:
> I made some modifications to the source code and I'm trying to deploy it.
> 
>  The ceph-deploy fails because I dont want to do "ceph-deploy
> install", and even if I run "sudo make install" some service binaries
> are not found,  /etc/ceph and the dir on /var/ are not created.
> 
>  So now I'm just trying to do a manual deploy and I can't do the
> monitor part. I run everything, but when I try to actually launch the
> monitor, I can't. The manual says to run "sudo start ceph-mon
> id=node1" if I have ubuntu. Well, AWS's ubuntu doesn't use upstart so
> that doesn't work. I then tried "sudo /etc/init.d/ceph start
> mon.node1", but ceph doesn't exist in init.d.
> 
>  How is it created and who does it? Is it a symlink to the binary? Why
> doesn't "make install" do this automatically? Is there a script to do
> the delta between installing from a package manager and installing
> from source?

Try 'sudo make install' from the build dir.  You might need to change the 
prefix to /usr from /usr/local.  If you want to install just like the 
package would (or as close as you can get), look at debian/rules to see 
what is passed to cmake during the build.

Probably better is to actually build a package with dpkg-buildpackage...

sage
