From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Wed, 18 Jul 2012 08:42:38 -0700
Message-ID: <CAPrxi5_W_AghtjXLHNBQhv3Zbk_AyTBJOnDtvFYk9dh3H9VVrw@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
	<CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
	<loom.20120712T111906-426@post.gmane.org>
	<CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
	<loom.20120713T085715-195@post.gmane.org>
	<CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com>
	<loom.20120716T061714-349@post.gmane.org>
	<C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu>
	<loom.20120716T072848-760@post.gmane.org>
	<CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com>
	<alpine.DEB.2.00.1207160824220.9848@cobra.newdream.net>
	<CAPrxi5-2STepCif9aN1GyfTwFEzs56o5Nzg7NuHmBqq=7qWVEQ@mail.gmail.com>
	<loom.20120717T073350-472@post.gmane.org>
	<CAPrxi5_wA8sxJg6vN115E-sQO9LjT13dQFZ+2rqV4rPBborX_Q@mail.gmail.com>
	<loom.20120718T082223-738@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53192 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab2GRPmj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 11:42:39 -0400
Received: by yhmm54 with SMTP id m54so1691067yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 08:42:39 -0700 (PDT)
In-Reply-To: <loom.20120718T082223-738@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Please 'git pull' to grab the following change which solved the same
problem in my location tree:

diff --git a/src/test/ClusterTest.java b/src/test/ClusterTest.java
index 9b6bcb6..8b83bdd 100644
--- a/src/test/ClusterTest.java
+++ b/src/test/ClusterTest.java
@@ -25,13 +25,13 @@ public class ClusterTest {
         String val1, val2;

         /* set option to 2 and check that it set */
-        val1 = "2";
+        val1 = "true";
         cluster.setConfigOption(opt, val1);
         val2 = cluster.getConfigOption(opt);
         assertTrue(val1.compareTo(val2) == 0);

         /* make sure the option wasn't already 2 */
-        val1 = "1";
+        val1 = "false";
         cluster.setConfigOption(opt, val1);
         val2 = cluster.getConfigOption(opt);
         assertTrue(val1.compareTo(val2) == 0);


On Tue, Jul 17, 2012 at 11:24 PM, ramu <ramu.freesystems@gmail.com> wrote:
>     [junit] Running ClusterStatsTest
>     [junit] Tests run: 1, Failures: 0, Errors: 0, Time elapsed: 0.044 sec
>     [junit] Running ClusterTest
>     [junit] Tests run: 7, Failures: 1, Errors: 0, Time elapsed: 6.569 sec

good, no errors.

>
> BUILD FAILED
> /home/vutp/java-rados/build.xml:134: Test ClusterTest failed
>
> Total time: 10 seconds
>
> -->And also two txt files generated in Java-Rados directory one is TEST-
> ClusterStatsTest.txt in this file the text is ,
> Testsuite: ClusterStatsTest
> Tests run: 1, Failures: 0, Errors: 0, Time elapsed: 0.044 sec

no errors here either.

> Testcase: test_ClusterStats took 0.027 sec
>
> -->and one more txt file is TEST-ClusterTest.txt in this file the text is ,
>
> Testsuite: ClusterTest
> Tests run: 7, Failures: 1, Errors: 0, Time elapsed: 6.569 sec
>
> Testcase: test_ConfigOption took 0.026 sec
>         FAILED
>
> junit.framework.AssertionFailedError:
>         at ClusterTest.test_ConfigOption(Unknown Source)

So, it looks like we are down to one error?

>
> Testcase: test_getClusterStats took 0.005 sec
> Testcase: test_getInstancePointer took 0.004 sec
> Testcase: test_getVersion took 0.005 sec
> Testcase: test_PoolOperations took 1.821 sec
> Testcase: test_openIOContext took 2.134 sec
> Testcase: test_PoolList took 2.543 sec
>
> Thanks,
> Ramu.
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
