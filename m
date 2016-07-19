From: Srikar <srikar.kumar@gmail.com>
Subject: Developer =?utf-8?b?TW9kZV9RdWVyeQ==?=
Date: Tue, 19 Jul 2016 14:11:06 +0000 (UTC)
Message-ID: <loom.20160719T153936-718@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52300 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbcGSOLi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2016 10:11:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1bPVkE-0002gM-I9
	for ceph-devel@vger.kernel.org; Tue, 19 Jul 2016 16:11:35 +0200
Received: from 115.119.152.66.static-hyderabad.vsnl.net.in ([115.119.152.66.static-hyderabad.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 16:11:34 +0200
Received: from srikar.kumar by 115.119.152.66.static-hyderabad.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 16:11:34 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
      I am testing the development mode cluster by adding debugs and
checking benchmarks. I went through below documents.
http://docs.ceph.com/docs/master/dev/quick_guide/
http://docs.ceph.com/docs/master/dev/dev_cluster_deployement/

So far I added debugs in the following files "rados.cc" and "IoCtxImpl.cc"
and "OSD.cc". According to my understanding after deploying a development 
mode, it will create a fake cluster. I am able to see the debugs added in
"rados.cc" and "IoCtxImpl.cc" files but unable to see the debugs related 
to "OSD.cc", when I try to bring an existing osd daemon in the cluster up 
or down.If it creates a fake cluster, does that mean it will create psuedo
OSD's ? Do I need to perform operations on them for checking the debugs? If
it is how can I check them?
Thanks & Regards,
S.Srikar.

