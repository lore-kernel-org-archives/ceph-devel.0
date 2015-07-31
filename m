From: Owen Synge <osynge@suse.com>
Subject: Re: systemd status
Date: Fri, 31 Jul 2015 15:23:26 +0200
Message-ID: <55BB76CE.9020009@suse.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:46858 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751130AbbGaNZF (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 31 Jul 2015 09:25:05 -0400
In-Reply-To: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 07/28/2015 09:13 PM, Sage Weil wrote:
> Hey,
> 
> I've finally had some time to play with the systemd integration branch on 
> fedora 22.  It's in wip-systemd and my current list of issues includes:
> 
> - after mon creation ceph-create-keys isn't run automagically
>   - Personally I kind of hate how it was always run on mon startup and not 
> just during cluster creation so I wouldn't mind *so* much if this became 
> an explicit step, maybe triggered by ceph-deploy, after mon create.

I agree.

> - udev's attempt to trigger ceph-disk isn't working for me.  the osd 
> service gets started but the mount isn't present and it fails to start.

I have not had this issue with suse, I will investigate soon.

> I'm a systemd noob and haven't sorted out how to get udev to log something 
> meaningful to debug it.  Perhaps we should merge in the udev + 
> systemd revamp patches here too...
> 
> - ceph-detect-init is only recently unbroken in master for fedora 22.

noted. I have never yet tested the systemd patches on anything but
opensuse and SLE12.

> - ceph-deploy doesn't know that fedora should be systemd yet.

One of ceph or ceph-deploy has to change this first. I propose ceph.

> - ceph-deploy has a wip-systemd branch with a few things so far:
>   - on mon create, we unconditionally systemctl enable ceph.target.  
> i think osd create and mds create and rgw create should do the same thing, 
> since the ceph.target is a catch-all bucket for any ceph service, and i 
> don't think we want to enable it on install?
>   - rgw create and mds create don't work yet
>   - osd create doesn't enable ceph.target

rgw does work on suse, but I noticed a bug in the patches you where
working on, I am looking at the other issues, you raise.

https://github.com/SUSE/ceph/commit/08c805c18dd994d7b2c4c521a209bb50310b1bbd


Note mds is some thing I have never tested but have never even used the mds.

> - I'm guessing my ceph.spec changes to install teh systemd unit files 
> aren't quite right... please review!  The gitbuilder turnaround is so slow 
> it's hard to iterate and I don't really know what I'm doing here.

Yes I found this too on suse, I think I am near fixing these issues for
suse. Once they are fixed I will once again look at fedora.


Best regards

Owen
