From: Sage Weil <sage@inktank.com>
Subject: on disk encryption
Date: Sat, 15 Sep 2012 04:54:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41422 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab2IOLyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Sep 2012 07:54:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dustin.kirkland@gmail.com

Hey,

A common requirement that's come up in conversation a few times now is 
on-disk, at-rest encryption.  Usually, this is really just about making 
sure the bits on an individual disk are useless in isolation, so that 
drives can be safely discarded or RMAed without compromising customer 
data.

I suspect the simplest way to accomplish this would be through something 
like dm-crypt.  The trick would be keeping the keys for the osd's block 
device and journal elsewhere.

One option would be to use the monitor as a lock box to securely store the 
disk encryption key, secured by the osd's existing cephx key is provided.  
The startup scripts (triggered via upstart, sysvinit, whatever) would need 
to get the keyring off the disk (separate, unencrypted partition?), get 
the disk key from the monitor, set up the dm-crypt devices, mount the 
osd's fs, and then start ceph-osd.  An attacker in possession of a 
recovered disk would be need network connectivity to the cluster (prior to 
the keys getting revoked/destroyed) in order to decrypt it.

Looking forward, another option might be to implement encryption inside 
btrfs (placeholder fields are there in the disk format, introduced along 
with the compression code way back when).  This would let ceph-osd handle 
more of the key handling internally and do something like, say, only 
encrypt the current/ and snap_*/ subdirectories.  

Other ideas?  Thoughts?

sage

