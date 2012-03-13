From: Bryan Wright <bkw1a@ayesha.phys.virginia.edu>
Subject: Trying to build "ceph-client-standalone" under kernel 2.6.32
Date: Tue, 13 Mar 2012 14:55:33 +0000 (UTC)
Message-ID: <loom.20120313T154901-294@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34567 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148Ab2CMPAL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Mar 2012 11:00:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7TCm-0003hj-8R
	for ceph-devel@vger.kernel.org; Tue, 13 Mar 2012 16:00:04 +0100
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 16:00:04 +0100
Received: from bkw1a by ayesha.phys.Virginia.EDU with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 16:00:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

     I'm trying to build the kernel client, following the directions here:

http://ceph.newdream.net/wiki/Building_kernel_client

I'm doing this under 32-bit CentOS 5.7 with a 2.6.32 kernel.  (Ultimately, I'll
have both 32-bit and 64-bit clients.)  My understanding is that the fuse
implementation won't work on 32-bit clients because fuse can't deal with ceph's
long inode numbers on that platform, so I'm trying to compile a kernel module
that I can maintain with dkms.

     The problem is that when I try "make -C libceph", I get errors of the form:

/usr/src/ceph-client-standalone/libceph/ceph_common.c:9:28: error:
keys/ceph-type.h: No such file or directory


      What am I doing wrong here?  Any advice would be appreciated.

                                              Thanks,
                                              Bryan


