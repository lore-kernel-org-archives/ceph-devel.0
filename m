From: Sage Weil <sweil@redhat.com>
Subject: systemd status
Date: Tue, 28 Jul 2015 12:13:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177AbbG1TNw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 15:13:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: osynge@suse.com, ceph-devel@vger.kernel.org

Hey,

I've finally had some time to play with the systemd integration branch on 
fedora 22.  It's in wip-systemd and my current list of issues includes:

- after mon creation ceph-create-keys isn't run automagically
  - Personally I kind of hate how it was always run on mon startup and not 
just during cluster creation so I wouldn't mind *so* much if this became 
an explicit step, maybe triggered by ceph-deploy, after mon create.

- udev's attempt to trigger ceph-disk isn't working for me.  the osd 
service gets started but the mount isn't present and it fails to start.  
I'm a systemd noob and haven't sorted out how to get udev to log something 
meaningful to debug it.  Perhaps we should merge in the udev + 
systemd revamp patches here too...

- ceph-detect-init is only recently unbroken in master for fedora 22.

- ceph-deploy doesn't know that fedora should be systemd yet.

- ceph-deploy has a wip-systemd branch with a few things so far:
  - on mon create, we unconditionally systemctl enable ceph.target.  
i think osd create and mds create and rgw create should do the same thing, 
since the ceph.target is a catch-all bucket for any ceph service, and i 
don't think we want to enable it on install?
  - rgw create and mds create don't work yet
  - osd create doesn't enable ceph.target

- I'm guessing my ceph.spec changes to install teh systemd unit files 
aren't quite right... please review!  The gitbuilder turnaround is so slow 
it's hard to iterate and I don't really know what I'm doing here.

Owen, I'd like to get this just a tad bit more functional and then merge 
ASAP, then up any issues in the weeks leading up to infernalis.  What say 
ye?

sage

