From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to compile Java-Rados.
Date: Mon, 16 Jul 2012 05:32:49 +0000 (UTC)
Message-ID: <loom.20120716T072848-760@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com> <loom.20120713T085715-195@post.gmane.org> <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com> <loom.20120716T061714-349@post.gmane.org> <C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37235 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab2GPFdG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Jul 2012 01:33:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sqdva-0002No-QR
	for ceph-devel@vger.kernel.org; Mon, 16 Jul 2012 07:33:02 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 07:33:02 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 07:33:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi Noah,

I tried but am getting following error in terminal ,

Buildfile: /home/vu/java-rados/build.xml

makedir:

compile-rados:

compile-tests:

jar:

test:
    [junit] Running ClusterStatsTest
    [junit] Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec

BUILD FAILED
/home/vu/java-rados/build.xml:134: Test ClusterStatsTest failed

Total time: 1 second

and one more error file 
is /home/vu/java-rados/TEST-ClusterStatsTest.txt in that file the text is like 
this,

Testsuite: ClusterStatsTest
Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec

Testcase: test_ClusterStats took 0.022 sec
        Caused an ERROR
conf_read_file: ret=-22
net.newdream.ceph.rados.RadosException: conf_read_file: ret=-22
        at net.newdream.ceph.rados.Cluster.native_conf_read_file(Native Method)
        at net.newdream.ceph.rados.Cluster.readConfigFile(Unknown Source)
        at ClusterStatsTest.setup(Unknown Source)

Thanks,
Ramu.



