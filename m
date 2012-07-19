From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to compile Java-Rados.
Date: Thu, 19 Jul 2012 03:38:18 +0000 (UTC)
Message-ID: <loom.20120719T053505-362@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com> <loom.20120713T085715-195@post.gmane.org> <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com> <loom.20120716T061714-349@post.gmane.org> <C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu> <loom.20120716T072848-760@post.gmane.org> <CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com> <alpine.DEB.2.00.1207160824220.9848@cobra.newdream.net> <CAPrxi5-2STepCif9aN1GyfTwFEzs56o5Nzg7NuHmBqq=7qWVEQ@mail.gmail.com> <loom.20120717T073350-472@post.gmane.org> <CAPrxi5_wA8sxJg6vN115E-sQO9LjT13dQFZ+2rqV4rPBborX_Q@mail.gmail.com> <loom.20120718T
 082223-738@post.gmane.org> <CAPrxi5_W_AghtjXLHNBQhv3Zbk_AyTBJOnDtvFYk9dh3H9VVrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60887 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852Ab2GSDih (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Jul 2012 23:38:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SrhZQ-0001xP-S8
	for ceph-devel@vger.kernel.org; Thu, 19 Jul 2012 05:38:33 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:38:32 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:38:32 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Noah,

Thank u for your reply,it is working fine but Iam getting one more error
in terminal is,BUILD FAILED
/home/vu/java-rados/build.xml:134: Test IOContextTest failed

Total time: 43 seconds

and in TEST-IOContextTest.txt file the error is,

Testsuite: IOContextTest
Tests run: 11, Failures: 1, Errors: 0, Time elapsed: 32.302 sec

Testcase: test_toString took 1.791 sec
Testcase: test_getCluster took 2.116 sec
Testcase: test_getPoolStats took 2.364 sec
Testcase: test_setLocatorKey took 2.046 sec
Testcase: test_write took 3.109 sec
Testcase: test_writeFull took 3.188 sec
Testcase: test_getLastVersion took 2.46 sec
Testcase: test_append took 3.505 sec
Testcase: test_truncate took 3.423 sec
Testcase: test_getsetAttribute took 3.161 sec
Testcase: test_getObjects took 5.101 sec
        FAILED

junit.framework.AssertionFailedError:
        at IOContextTest.test_getObjects(Unknown Source)

Thanks,
Ramu.

