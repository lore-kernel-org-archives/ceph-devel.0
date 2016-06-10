From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 14:50:33 -0400
Message-ID: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbcFJSvG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 14:51:06 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E8D41390D
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 18:51:06 +0000 (UTC)
Received: from ultraspiritum.eng.arb.redhat.com ([10.17.150.166])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u5AIp5wp007254
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 14:51:06 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Terriffically Tentacular Teammates,

I come not with a multilateral trade deal, but with a request for
comments.

In our code base we have CephContext. In daemons and official Ceph
Utilities, we have g_ceph_context. I believe CephContext does not show
proper separation of concerns.

Some of its contents (debugging flags, file locations, and the log
levels used by the dout, initialized cryptographic subsystems, the
admin socket, and others) are relevant to the process as a whole.

Others (such as the monitor address, fsid, cluster and public network,
CrushLocation, and so forth) are relevant to the cluster.

I would like to split CephContext between its process-relevant subset
and its cluster-relevant subset and move the process-relevant portion
into a global variable in libcommon. Cluster-relevant parts would be
plumbed into subsystems the way CephContext is now.

The improved separation of concerns would make it easier to write
utilities that connect to multiple clusters, which sounds like it will
be increasingly important with the work people have done on
replication and the notion of 'pop-up' Ceph clusters for specific
workloads.

It would also make the code more modular and reusable. Several pieces
that could be reasonably made into libraries (such as the MDS or OSD)
or incorporated into non-daemon code (like the erasure code system)
can't be now. They could be re-plumbed, but having to thread a
CephContext around just to log messages is unappealing.

It would also be cleaner not having to plumb a CephContext in to every
point in libcommon that checks the time or prints to the log.

If I were to do this, my plan would be:

1. Separate configuration variables into process and cluster
2. Create a global 'ProcessContext' class. Move some elements of
   CephContext into it and the process-relevant configuration
   options. Have the configuration parser write to both locations, and
   have CephContext carry references to alias the relevant members of
   the global.
3. Create a ClusterContext (perhaps as a base to CephContext holding
   all non-aliased members).
4. Subsystem by subsystem remove uses of CephContext, replacing some
   with ClusterContext.
5. When all uses of CephContext are removed, remove the class.

Does this seem reasonable?

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
