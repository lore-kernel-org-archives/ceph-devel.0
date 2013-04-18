From: James Harper <james.harper@bendigoit.com.au>
Subject: poor write performance
Date: Thu, 18 Apr 2013 11:46:34 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:45592 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965330Ab3DRMLX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 08:11:23 -0400
Received: from [2001:388:e000:712:a5ca:4fd3:14f:ad5d] (helo=BITCOM1.int.sbss.com.au)
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1USnIT-0006Zk-PV
	for ceph-devel@vger.kernel.org; Thu, 18 Apr 2013 21:46:37 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm doing some basic testing so I'm not really fussed about poor performance, but my write performance appears to be so bad I think I'm doing something wrong.

Using dd to test gives me kbytes/second for write performance for 4kb block sizes, while read performance is acceptable (for testing at least). For dd I'm using iflag=direct for read and oflag=direct for write testing.

My setup, approximately, is:

Two OSD's
. 1 x 7200RPM SATA disk each
. 2 x gigabit cluster network interfaces each in a bonded configuration directly attached (osd to osd, no switch)
. 1 x gigabit public network
. journal on another spindle

Three MON's
. 1 each on the OSD's
. 1 on another server, which is also the one used for testing performance

I'm using debian packages from ceph which are version 0.56.4

For comparison, my existing production storage is 2 servers running DRBD with iSCSI to the initiators which run Xen on top of a (C)LVM volumes on top of the iSCSI. Performance not spectacular but acceptable. The servers in question are the same specs as the servers I'm testing on.

Where should I start looking for performance problems? I've tried running some of the benchmark stuff in the documentation but I haven't gotten very far...

Thanks

James

