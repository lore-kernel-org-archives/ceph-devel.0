From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Newbie questions
Date: Mon, 01 Oct 2012 22:30:43 +1000
Message-ID: <k4c2dj$s3i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46760 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab2JAMfH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Oct 2012 08:35:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TIfDE-0008WC-6S
	for ceph-devel@vger.kernel.org; Mon, 01 Oct 2012 14:35:04 +0200
Received: from 124-170-67-40.dyn.iinet.net.au ([124.170.67.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 14:35:04 +0200
Received: from a.nielsen by 124-170-67-40.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 14:35:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I've been investigating cluster filesystems for a while now, and I have a few 
questions about Ceph I hope you don't mind me asking here.  This is in the 
context of using Ceph as a POSIX filesystem and alternative to something like NFS.

   1. Is Ceph stable enough for "real" use yet?  I read that upgrading to 
v0.48 required a reformat, which I imagine would be a bit of an issue in a 
production system.  Is this how upgrades are normally done?  Is anyone running 
Ceph in a production environment with real data yet?

   2. Why does the wiki say that you can run one or three monitor daemons, but 
running two is worse than one?  Wouldn't running two be less work than running 
three?

   3. If I have multiple disks in a machine that I can dedicate to Ceph, is it 
better to RAID them and present Ceph with a single filesystem, or do you get 
better results by giving Ceph a filesystem on each disk and letting it look 
after the striping and any faulty disks?

   4. How resilient is the system?  I can find a lot of information saying one 
node can go away without any data loss, but does that mean losing a second 
node will take everything down?  Can you configure it such that every node has 
a complete copy of the cluster, so as long as any one node survives, all the 
data is available?

   5. Given that the cluster filesystem contains files, which are then stored 
as other files in a different filesystem, does this affect performance much? 
I'm thinking of something like a git repository which accesses file metadata a 
lot, and seems to suffer a bit if it's not running off a local disk.

Hopefully I'm not asking questions which are already covered in the 
documentation - if so please point me in the right direction.

Many thanks,
Adam.

