From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to compile Java-Rados.
Date: Wed, 18 Jul 2012 06:24:02 +0000 (UTC)
Message-ID: <loom.20120718T082223-738@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com> <loom.20120713T085715-195@post.gmane.org> <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com> <loom.20120716T061714-349@post.gmane.org> <C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu> <loom.20120716T072848-760@post.gmane.org> <CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com> <alpine.DEB.2.00.1207160824220.9848@cobra.newdream.net> <CAPrxi5-2STepCif9aN1GyfTwFEzs56o5Nzg7NuHmBqq=7qWVEQ@mail.gmail.com> <loom.20120717T073350-472@post.gmane.org> <CAPrxi5_wA8sxJg6vN115E-sQO9LjT13dQFZ+2rqV4rPBborX_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35836 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab2GRGYQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Jul 2012 02:24:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SrNgE-0002AL-6G
	for ceph-devel@vger.kernel.org; Wed, 18 Jul 2012 08:24:15 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 08:24:14 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 08:24:14 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Noah,

After reinstalled java-rados,when I run ant test now am getting follwing 
error in terminal,
Buildfile: /home/vutp/java-rados/build.xml

makedir:

compile-rados:

compile-tests:
    [javac] Compiling 1 source file to /home/vutp/java-rados/build/test

jar:

test:
    [junit] Running ClusterStatsTest
    [junit] Tests run: 1, Failures: 0, Errors: 0, Time elapsed: 0.044 sec
    [junit] Running ClusterTest
    [junit] Tests run: 7, Failures: 1, Errors: 0, Time elapsed: 6.569 sec

BUILD FAILED
/home/vutp/java-rados/build.xml:134: Test ClusterTest failed

Total time: 10 seconds

-->And also two txt files generated in Java-Rados directory one is TEST-
ClusterStatsTest.txt in this file the text is ,
Testsuite: ClusterStatsTest
Tests run: 1, Failures: 0, Errors: 0, Time elapsed: 0.044 sec
Testcase: test_ClusterStats took 0.027 sec

-->and one more txt file is TEST-ClusterTest.txt in this file the text is ,

Testsuite: ClusterTest
Tests run: 7, Failures: 1, Errors: 0, Time elapsed: 6.569 sec

Testcase: test_ConfigOption took 0.026 sec
        FAILED

junit.framework.AssertionFailedError:
        at ClusterTest.test_ConfigOption(Unknown Source)

Testcase: test_getClusterStats took 0.005 sec
Testcase: test_getInstancePointer took 0.004 sec
Testcase: test_getVersion took 0.005 sec
Testcase: test_PoolOperations took 1.821 sec
Testcase: test_openIOContext took 2.134 sec
Testcase: test_PoolList took 2.543 sec

Thanks,
Ramu.





