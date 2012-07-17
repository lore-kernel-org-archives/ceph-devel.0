From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Tue, 17 Jul 2012 08:42:33 -0700
Message-ID: <CAPrxi5_wA8sxJg6vN115E-sQO9LjT13dQFZ+2rqV4rPBborX_Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62622 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab2GQPmd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 11:42:33 -0400
Received: by yhmm54 with SMTP id m54so506951yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 08:42:33 -0700 (PDT)
In-Reply-To: <loom.20120717T073350-472@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 16, 2012 at 10:39 PM, ramu <ramu.freesystems@gmail.com> wrote:
> Hi Noah,
>
> Testcase: test_ClusterStats took 0.036 sec
>         Caused an ERROR
> rados_connect: ret=-1
> net.newdream.ceph.rados.RadosException: rados_connect: ret=-1
>         at net.newdream.ceph.rados.Cluster.native_connect(Native Method)
>         at net.newdream.ceph.rados.Cluster.connect(Unknown Source)

That return code, -1, should correspond to -EPERM. I don't see this
error code in the rados client code. Are you able to use the same
ceph.conf file to connect and interact with RADOS using a interface
other than the Java wrappers?

Checking the OSD logs might reveal the problem... do you have these available?
