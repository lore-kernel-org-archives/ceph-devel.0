From: Chris Dunlop <chris@onthe.net.au>
Subject: krbd + format=2 ?
Date: Mon, 3 Jun 2013 19:24:28 +1000
Message-ID: <20130603092428.GB28293@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:45259 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab3FCJYf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 05:24:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id D52E26148C
	for <ceph-devel@vger.kernel.org>; Mon,  3 Jun 2013 19:24:33 +1000 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OyM+lGptxP+t for <ceph-devel@vger.kernel.org>;
	Mon,  3 Jun 2013 19:24:28 +1000 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id C5DF5613E4
	for <ceph-devel@vger.kernel.org>; Mon,  3 Jun 2013 19:24:28 +1000 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id 260462AA8A8
	for <ceph-devel@vger.kernel.org>; Mon,  3 Jun 2013 19:24:29 +1000 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

Sage's recent pull message to Linus said:

----
Please pull the following Ceph patches from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This is a big pull.  Most of it is culmination of Alex's work to implement
RBD image layering, which is now complete (yay!).
----

Am I correct in thinking "RBD image layering... is now complete"
implies there should be full(?) support for format=2?

I pulled the for-linus branch (@ 3abef3b) on top of 3.10.0-rc4, and it's
letting me map a format=2 image (created under bobtail), however reading
from the block device returns zeros rather than the data. The same image
correctly shows data (NTFS filesystem) when mounted into kvm using librbd.

----
# uname -r
3.10.0-rc4-00010-g0326739
# rbd ls -l
NAME                   SIZE PARENT                       FMT PROT LOCK 
xxx                   1536G                                2
# rbd map rbd/xxx
# rbd showmapped
id pool image   snap device    
1  rbd  xxx     -    /dev/rbd1 
# dd if=/dev/rbd1 of=/tmp/xxx count=20480
20480+0 records in
20480+0 records out
10485760 bytes (10 MB) copied, 0.757754 s, 13.8 MB/s
# od -c /tmp/xxx | less
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
50000000
----


Cheers,

Chris
