From: Sage Weil <sage@inktank.com>
Subject: simple key management for dm-crypt
Date: Thu, 20 Jun 2013 23:00:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306202249260.30991@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47144 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161146Ab3FUGAc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 02:00:32 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3C01E803BB
	for <ceph-devel@vger.kernel.org>; Thu, 20 Jun 2013 23:00:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1560F803BB
	for <ceph-devel@vger.kernel.org>; Thu, 20 Jun 2013 23:00:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A set of simple dm-crypt hooks were included in cuttlefish that allow you 
to easily use dm-crypt beneath the disks consumed by ceph-osd.  The 
current solution is pretty limited in that the dm-crypt keys are just 
stored in /etc/ceph.  They don't help if a machine is stolen, but they do 
allow you to throw away data disks without worrying about data being 
compromised.

The monitor has a simple key/value storage service that we can use to 
store the dm-crypt keys.  Having them stored by a simple keyserver (the 
mon) means the boot disk can be discard along with the data disks, 
provided an attacker doesn't have access to the network before the keys 
are revoked.  The challenge is deciding how to manage them all.

There are at least two keys:

 1) $osd_data/keyring has the cephx key that ceph-osd uses to authenticate 
    and join the cluster.  It's normally stored in the data dir, and would 
    thus be encrypted and inaccessible without the dm-crypt key.
 2) The dm-crypt key is used to decrypt the block device so that the osd 
    data and/or journal can be mounted.

If we store the dm-crypt key on the mon, then there is also a third key:

 3) A second cephx key should be used to access the monitor to obtain the 
    dm-crypt key for the local disks.

I'm not sure what the best way to handle #3 is.  A per-host key could be 
used here, but it makes it harder to move disks around between hosts, 
unless all host key scould access any disk key (which seems unwise). 
Alternatively, a #3 key could be stored in a tiny unencrypted partition of 
the osd/data disk.  This isn't really my area, but I think this is roughly 
how most 'key management systems' would work.  Disks are useless without 
access to the mon/keyserver, which provides admins with a safe centralized 
place to revoke keys.

Are there any users who are looking for this type of protection?  I don't 
want to spend any time putting this together until we have a clearer 
picture of what people's real requirements are...

sage
