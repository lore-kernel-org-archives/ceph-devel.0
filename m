From: Sage Weil <sage@inktank.com>
Subject: ceph-crush-location hook
Date: Wed, 30 Oct 2013 14:17:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310301412230.23435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50650 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3J3VRV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 17:17:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

There is a provsion in the startup scripts that will move your osd to the 
correct position in the crush map on startup.  By default, this sets the 
host based on hostname and then pulls in any fields defined in 'osd crush 
location' in ceph.conf.

This is useful but not sufficiently flexible for users who have multiple 
types of devices and non-trivial crush trees.  I just merged a new helper 
into master called ceph-crush-location that implements the above basic 
behavior (and is now called by the sysvinit and upstart startup scripts).  
However, you can now implement your own hook by setting 'osd crush 
location hook = /path/to/my/script' and implement whatever logic you want.  
The script just needs to output an appropriate list of key/value pairs 
when called like so:

 $ ceph-crush-location --cluster ceph --id 0 --type osd
 host=vapre root=default

The other change is that the default hook checks either '$type crush 
location' (e.g. osd crush location) or, if that is empty, 'crush 
location'.  In the very near future the clients will also understand the 
'crush location' option and use that for localizing their reads when 
appropriate (e.g., for hadoop or read-only rbd images).  That means that 
updating your chef/puppet/juju or other provisioning tools to define 
'crush location' in /etc/ceph/ceph.conf will make all of this stuff Just 
Work.

sage
