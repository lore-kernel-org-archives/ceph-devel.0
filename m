From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Mon, 16 Jul 2012 00:12:59 -0700
Message-ID: <CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
	<CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
	<loom.20120712T111906-426@post.gmane.org>
	<CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
	<loom.20120713T085715-195@post.gmane.org>
	<CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com>
	<loom.20120716T061714-349@post.gmane.org>
	<C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu>
	<loom.20120716T072848-760@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44100 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2GPHNA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 03:13:00 -0400
Received: by ghrr11 with SMTP id r11so4709497ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 00:12:59 -0700 (PDT)
In-Reply-To: <loom.20120716T072848-760@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Ramu,

I receive the same error code in my installation when the
CEPH_CONF_FILE environment variable contains an invalid path. Could
you please verify that the path you are using points to a valid Ceph
configuration?

Thanks,
- Noah

On Sun, Jul 15, 2012 at 10:32 PM, ramu <ramu.freesystems@gmail.com> wrote:
>
> Hi Noah,
>
> I tried but am getting following error in terminal ,
>
> Buildfile: /home/vu/java-rados/build.xml
>
> makedir:
>
> compile-rados:
>
> compile-tests:
>
> jar:
>
> test:
>     [junit] Running ClusterStatsTest
>     [junit] Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec
>
> BUILD FAILED
> /home/vu/java-rados/build.xml:134: Test ClusterStatsTest failed
>
> Total time: 1 second
>
> and one more error file
> is /home/vu/java-rados/TEST-ClusterStatsTest.txt in that file the text is like
> this,
>
> Testsuite: ClusterStatsTest
> Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec
>
> Testcase: test_ClusterStats took 0.022 sec
>         Caused an ERROR
> conf_read_file: ret=-22
> net.newdream.ceph.rados.RadosException: conf_read_file: ret=-22
>         at net.newdream.ceph.rados.Cluster.native_conf_read_file(Native Method)
>         at net.newdream.ceph.rados.Cluster.readConfigFile(Unknown Source)
>         at ClusterStatsTest.setup(Unknown Source)
>
> Thanks,
> Ramu.
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
