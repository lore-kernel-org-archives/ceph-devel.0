From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to compile Java-Rados.
Date: Mon, 16 Jul 2012 07:23:19 +0000 (UTC)
Message-ID: <loom.20120716T092022-386@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com> <loom.20120712T111906-426@post.gmane.org> <CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com> <loom.20120713T085715-195@post.gmane.org> <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com> <loom.20120716T061714-349@post.gmane.org> <C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu> <loom.20120716T072848-760@post.gmane.org> <CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44920 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326Ab2GPHXb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Jul 2012 03:23:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SqfeS-000750-TC
	for ceph-devel@vger.kernel.org; Mon, 16 Jul 2012 09:23:31 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 09:23:28 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 09:23:28 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Noah,

I printed the CONF_FILE and file and states,the printed as following,these 
are in ClusterStatsTest.java.

test:
    [junit] Running ClusterStatsTest
    [junit] conffile--->/etc/ceph/ceph.conf
    [junit] state-->CONFIGURING
    [junit] file--->/etc/ceph/ceph.conf
    [junit] state-->CONFIGURING
    [junit] Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.123 sec

BUILD FAILED
/home/ramu/java-rados/build.xml:134: Test ClusterStatsTest failed




