From: Miles Fidelman <mfidelman@meetinghouse.net>
Subject: ceph for small cluster?
Date: Sun, 30 Dec 2012 16:38:31 -0500
Message-ID: <50E0B457.70200@meetinghouse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from server1.neighborhoods.net ([207.154.13.48]:35537 "EHLO
	server1.neighborhoods.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab2L3Vp1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Dec 2012 16:45:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by server1.neighborhoods.net (Postfix) with ESMTP id 4502CCC0DE
	for <ceph-devel@vger.kernel.org>; Sun, 30 Dec 2012 16:38:33 -0500 (EST)
Received: from server1.neighborhoods.net ([127.0.0.1])
	by localhost (server1.neighborhoods.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1Erb8XIRnTmA for <ceph-devel@vger.kernel.org>;
	Sun, 30 Dec 2012 16:38:32 -0500 (EST)
Received: from new-host-2.home (pool-71-184-234-147.bstnma.fios.verizon.net [71.184.234.147])
	by server1.neighborhoods.net (Postfix) with ESMTPSA id D95FCCC0DD
	for <ceph-devel@vger.kernel.org>; Sun, 30 Dec 2012 16:38:31 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Folks,

I'm wondering how ceph would work in a small cluster that supports a mix 
of engineering and modest production (email, lists, web server for 
several small communities).

Specifically, we have a rack with 4 medium-horsepower servers, each with 
4 disk drives, running Xen (debian dom0 and domUs) - all linked together 
w/ 4 gigE ethernets.

Currently, 2 of the servers are running a high-availability 
configuration, using DRBD to mirror specific volumes, and pacemaker for 
failover.

For a while, I've been looking for a way to replace DRBD with something 
that would mirror across more than 2 servers - so that we could migrate 
VMs arbitrarily - and that will work without splitting up compute vs. 
storage nodes (for the short term, at least, we're stuck with rack space 
and server limitations).

The thing that looks closest to filling the bill is Sheepdog (at least 
architecturally) - but it only provides a KVM interface. GlusterFS, 
xTreemFS, and Ceph keep coming up as possibles - with ceph's rbd 
interface looking like the easiest to integrate.

Which leads me to two questions:

- On a theoretical level, does using ceph as a storage pool for this 
kind of small cluster make any sense (notably, I'd see running an OSD, a 
MDS, a MON, and client DomUs on each of the 4 nodes, using LVM to pool 
all the storage and it seems like folks recommend XFS as a production 
filesystem)

- On a practical level, has anybody tried building this kind of small 
cluster, and if so, what kind of results have you had?

Comments and suggestions please!

Thank you very much,

Miles Fidelman

-- 
In theory, there is no difference between theory and practice.
In practice, there is.   .... Yogi Berra

