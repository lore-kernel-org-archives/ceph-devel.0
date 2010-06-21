From: Sage Weil <sage@newdream.net>
Subject: Re: ceph: splice_dentry error
Date: Mon, 21 Jun 2010 16:53:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006211651390.31636@cobra.newdream.net>
References: <hvnkai$3lg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52474 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab0FUXwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jun 2010 19:52:39 -0400
In-Reply-To: <hvnkai$3lg$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Mon, 21 Jun 2010, Thomas Mueller wrote:
> since 2 days 1 of my tests fail and crash my machine. 
> 
> the script crashing the machine is:
> http://github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-2 
> ( take lines 13 to 67 for standalone usage)
> 
> i can see these messages before my machine stops responding:
> 
> [11188.432605] ceph:  tid 67394 timed out on osd0, will reset osd
> [11530.455936] ceph: splice_dentry error ffff8800a4891d80 inode 
> ffff880100349d30 ino 10000001a4d.6
> [11530.455961] BUG: unable to handle kernel NULL pointer dereference at 
> 0000000000000078
> [11530.455964] IP: [<ffffffffa0734049>] update_dentry_lease+0x20/0x10a 
> [ceph]

I fixed the bug that allowed the splice_dentry error to result in a crash.  

I'm still a bit worried about the initial failure, though 
(d_materialize_unique returning an error).  I'll have to look closer at a 
test case to see if it's legitimate.  If you figure out how to produce 
those splice_dentry warnings on your console reliably, please let us know!

sage
