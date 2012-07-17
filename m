From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to compile Java-Rados.
Date: Tue, 17 Jul 2012 05:39:20 +0000 (UTC)
Message-ID: <loom.20120717T073350-472@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com> <loom.20120713T085715-195@post.gmane.org> <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com> <loom.20120716T061714-349@post.gmane.org> <C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu> <loom.20120716T072848-760@post.gmane.org> <CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com> <alpine.DEB.2.00.1207160824220.9848@cobra.newdream.net> <CAPrxi5-2STepCif9aN1GyfTwFEzs56o5Nzg7NuHmBqq=7qWVEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33571 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab2GQFje (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Jul 2012 01:39:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sr0VP-0006tJ-NJ
	for ceph-devel@vger.kernel.org; Tue, 17 Jul 2012 07:39:32 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 07:39:31 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 07:39:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Noah,

I hardcoded CONF_FIL="/etc/ceph/ceph.conf"; and commented 
//System.getProperty("CEPH_CONF_FILE"); in RadosTestUtils.java.
And run the ant and after run ant test,but iam getting same error.

Buildfile: /home/vu/java-rados/build.xml

makedir:

compile-rados:

compile-tests:
    [javac] Compiling 1 source file to /home/vu/java-rados/build/test

jar:

test:
    [junit] Running ClusterStatsTest
    [junit] Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.068 sec

BUILD FAILED
/home/vu/java-rados/build.xml:134: Test ClusterStatsTest failed

Total time: 2 seconds
and in TEST-ClusterStatsTest.txt file also getting same errors,

Testsuite: ClusterStatsTest
Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.068 sec

Testcase: test_ClusterStats took 0.036 sec
        Caused an ERROR
rados_connect: ret=-1
net.newdream.ceph.rados.RadosException: rados_connect: ret=-1
        at net.newdream.ceph.rados.Cluster.native_connect(Native Method)
        at net.newdream.ceph.rados.Cluster.connect(Unknown Source)
        at ClusterStatsTest.setup(Unknown Source)
-->How to give CEPH_ARGS.

Thanks,
Ramu.

