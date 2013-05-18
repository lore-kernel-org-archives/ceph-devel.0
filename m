From: James Harper <james.harper@bendigoit.com.au>
Subject: windows rbd
Date: Sat, 18 May 2013 01:22:42 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B57B57E55@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:59981 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3ERBXL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 21:23:11 -0400
Received: from mail.bendigoit.com.au ([203.16.207.99] helo=BITCOM1.int.sbss.com.au)
	by smtp1.bendigoit.com.au with esmtp (Exim 4.69)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1UdVrP-0002qw-2t
	for ceph-devel@vger.kernel.org; Sat, 18 May 2013 11:22:59 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What would be the bare minimum to be implemented for a windows rbd kernel driver? In the Linux kernel I can see a drivers/block/rbd.c, which in turn uses net/ceph/*. There is also fs/ceph/* for the filesystem stuff.

Is a windows client even a worthwhile exercise? I know I can use an iscsi gateway or something like that but that adds complexity and probably latency, and kind of takes away from the distributed nature of ceph.

The other advantage of a native driver is that it could be integrated better with snapshot functionality for VSS, reducing system load for backups.

I can see one project to create a windows driver but it appears to be aborted... http://code.google.com/p/cephwin/

Is anyone else working on this at the moment?

James


