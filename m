From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to compile Java-Rados.
Date: Fri, 13 Jul 2012 07:00:40 +0000 (UTC)
Message-ID: <loom.20120713T085715-195@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44623 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab2GMHAz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Jul 2012 03:00:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SpZrw-0003S0-PG
	for ceph-devel@vger.kernel.org; Fri, 13 Jul 2012 09:00:53 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 09:00:52 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 09:00:52 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Noah,

When Iam running ant command Build successful,but in dist folder only 
librados.jar is came ,there is no libjavarados.a.

After i run the ant test ,it is showing error is,
makedir:

compile-rados:

compile-tests:

jar:

test:
[junit] Running ClusterStatsTest
[junit] Tests run: 1, Failures: 0, Errors: 2, Time elapsed: 0.026 sec

BUILD FAILED
/home/vu/java-rados/build.xml:134: Test ClusterStatsTest failed

Total time: 1 second

Thanks,
Ramu.









