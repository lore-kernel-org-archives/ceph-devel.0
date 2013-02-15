From: Sage Weil <sage@inktank.com>
Subject: experimental dmcrypt support
Date: Thu, 14 Feb 2013 17:57:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302141748510.11259@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45834 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759811Ab3BOB5n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 20:57:43 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7EFAC80060
	for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 17:57:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 57E3080060
	for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 17:57:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Alexandre and I have been working on adding basic dm-crypt support to 
ceph-disk-prepare/activate.  At this point it is working reasonably well, 
but before we move forward I thought I'd see if anyone has 
feedback/comments on the implementation.

The initial goals are very simple: transparently dm-crypt the volumes for 
the osd data and journal befor we use them, and store the keys somewhere 
on the local host (currently /etc/ceph/dmcrypt-keys).  Eventually we'll 
want to something more sophisticated there--there is a whole industry to 
supprot key management and compliance for this sort of thing--but slotting 
that in later should be pretty simple.

For now, the basic process looks like this:

 ceph-disk-prepare --dmcrypt DATADISK [JOURNALDISK]

When --dmcrypt is passed, we generate a unique UUID for the data and 
journal both (the data one matches the OSD uuid), and label the 
GPT partitions.  We also set the type to special "dmcrypted osd" and 
"dmcrypted journal" types.  The dm-crypt mapped devices appear in 
/dev/mapper/$UUID, so the journal symlink inside the data dir of the 
data volume points there.  Keys are stored in 
/etc/ceph/dmcrypt-keys/$UUID.

Normally, to activate an OSD, a udev rule triggres on teh osd partition 
type and runs ceph-disk-active.  In this case, it's slightly more 
complicated.  A udev rule triggers on the encrypted journal partition type 
and starts dm-crypt (using the key in /etc/ceph/...).  For the encrypted 
osd partition, we first start dm-crypt, then run ceph-disk-activate on the 
resulting /dev/mapper/$UUID volume.

That's basically it.  Leveraging udev makes this pretty simple, and should 
be portable to any distro (vs, say, using upstart events to do the same 
steps).

Later, we may want to add some super-simple key management so that the 
keys are stored on the monitor instead of in a local directory, but for 
some users at least this is sufficient (where the concern is really about 
disposal of disks).

See wip-dmcrypt in ceph.git to take a look.

Thanks!
sage
