From: Sage Weil <sage@inktank.com>
Subject: ceph-standalone
Date: Sun, 23 Feb 2014 12:30:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57137 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaBWUay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 15:30:54 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3BBA280069
	for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 12:30:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 13BA280069
	for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 12:30:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One idea kicking around is to create a simple ceph-standalone package that 
is meant to make it really easy to play around with Ceph.  It would:

- depend on all the relevant ceph packages
- install a simple, generic ceph.conf for use on localhost (or perhaps 
whatever /etc/hosts has for our hostname)
- mkfs and start up a mon
- start up an osd (or two?) in /var/lib/ceph (no dedicated disk/volume)
- start an mds
- add an apache2 site in /etc/apache2/sites-available (or whatever)

The idea would be to do

$ sudo apt-get install ceph-standalone
$ ceph -s
[...]

and have a usable mini-cluster.  That makes it really easy for users to 
play with the basics, like:

$ mkdir /mnt/ceph
$ sudo ceph-fuse /mnt/ceph

$ rbd create ...
$ rbd map ...

$ curl http://localhost:8000/
<more rgw stuff>

Does this sound useful?  Any takers?
sage
