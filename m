From: Sage Weil <sweil@redhat.com>
Subject: arg parsing broken for floats
Date: Sun, 24 May 2015 16:23:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505241620350.24110@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbbEXXXG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 May 2015 19:23:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajesh Nambiar <rajesh.n@msystechnologies.com>
Cc: ceph-devel@vger.kernel.org, jdurgin@redhat.com

The objectcacher stress test failures in qa appear to be due ot the recent 
argparse changes.  See

	http://tracker.ceph.com/issues/11620

and commit

commit b15f6d0231b8f9a3bfe1c1137935fd63ccd8cc17
Author: Rajesh Nambiar <rajesh.n@msystechnologies.com>
Date:   Tue Apr 7 23:39:07 2015 -0700

     Fix to some of the command line parsing (including rbd)

The result is:

$ ./ceph_test_objectcacher_stress --ops 1000 --percent-read 0.90 --delay-ns 0 --objects 10 --max-op-size 4096 --client-oc-max-dirty 0
./ceph_test_objectcacher_stress: The option value '0.90' is invalid

Do you mind taking a look?

Thanks!
sage

