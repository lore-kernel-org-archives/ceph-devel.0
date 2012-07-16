From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Sun, 15 Jul 2012 21:19:37 -0700
Message-ID: <C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com> <loom.20120713T085715-195@post.gmane.org> <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com> <loom.20120716T061714-349@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35537 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab2GPETj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 00:19:39 -0400
Received: by pbbrp8 with SMTP id rp8so9392947pbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 21:19:39 -0700 (PDT)
In-Reply-To: <loom.20120716T061714-349@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Ramu,

Well, it looks like copying the library files worked. Did you 

  export CEPH_CONF_FILE=/path/to/ceph.conf

before running 'ant test' ?

- Noah

On Jul 15, 2012, at 9:17 PM, ramu wrote:

> Hi Noah,
> 
> I copied all /src/native/.libs/ to dist folder and tried ant test iam getting 
> this error,
> 
> Testsuite: ClusterStatsTest
> Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec
> 
> Testcase: test_ClusterStats took 0.022 sec
> Caused an ERROR
> conf_read_file: ret=-22
> net.newdream.ceph.rados.RadosException: conf_read_file: ret=-22
> at net.newdream.ceph.rados.Cluster.native_conf_read_file(Native Method)
> at net.newdream.ceph.rados.Cluster.readConfigFile(Unknown Source)
> at ClusterStatsTest.setup(Unknown Source)
> 
> Thanks,
> Ramu.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

