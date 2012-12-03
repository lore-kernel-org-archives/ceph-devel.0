From: Payal <payalsharma7@yahoo.com>
Subject: java-rados =?utf-8?b?fA==?= Error while running test case
Date: Mon, 3 Dec 2012 08:43:18 +0000 (UTC)
Message-ID: <loom.20121203T092236-630@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54952 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab2LCIt4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Dec 2012 03:49:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TfRj2-0006V2-Hv
	for ceph-devel@vger.kernel.org; Mon, 03 Dec 2012 09:50:05 +0100
Received: from NSG-Static-094.122.71.182.airtel.in ([NSG-Static-094.122.71.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 09:50:04 +0100
Received: from payalsharma7 by NSG-Static-094.122.71.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 09:50:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am working on a sample app to test the object storage and connectivity with
the CEPH cluster(basically an app that talk directly to the Ceph object store).
Initially the aim is to keep 1 CEPH cluster on 1 VM and try the object
operations through 2nd VM. We won't be using RADOS Gateway, CEPH FS  and Block
devices. 

Environment : 2 Virtual machines
Both- carries: Ubuntu 12.04 and Java 7.
A)  On 1st VM I have installed CEPH Cluster and its showing Health OK for
cluster( all default settings as of now)

B) On 2nd VM, I have placed the code (java to c native)
"https://github.com/noahdesu/java-rados"
  On this 2nd VM I ve also added the stable release packages  and installed
packages mentioned in "http://ceph.com/docs/master/install/debian/"

The build for the code has been successful. Both the files "dist/librados.jar"
and "dist/libjavarados.a" are placed in dist folder as expected. Also the host
name and IP address of the 1st VM machine has been given in the ceph.conf file
placed in 2nd VM machine.
      But on running the test  "$ant test" from 2nd VM, I am getting the below
mentioned error. The instructions mentioned under README of the java-rados link
have been followed but I am not clear with the statement : "If Ceph/RADOS is
installed under standard system paths", also to which packages/jar the custom
CEPH/Rados for the include and lib refers to ?:

Error :
Testsuite: ClusterStatsTest
Tests run: 1, Failures: 0, Errors: 2, Time elapsed: 0.052 sec

Testcase: test_ClusterStats took 0.025 sec
    Caused an ERROR
no javarados in java.library.path
java.lang.UnsatisfiedLinkError: no javarados in java.library.path
    at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1860)
    at java.lang.Runtime.loadLibrary0(Runtime.java:845)
    at java.lang.System.loadLibrary(System.java:1084)
    at net.newdream.ceph.rados.Cluster.<clinit>(Unknown Source)
    at ClusterStatsTest.setup(Unknown Source)

    Caused an ERROR
null
java.lang.NullPointerException
    at ClusterStatsTest.destroy(Unknown Source)


Let me know if you need more information on this.

Thanks in advance.




