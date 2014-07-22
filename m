From: Sage Weil <sweil@redhat.com>
Subject: wip-memstore and wip-objectstore
Date: Tue, 22 Jul 2014 07:50:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407220747400.15853@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54748 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaGVOuL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 10:50:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomaiwang@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Haomai,

Do you mind looking at wip-memstore at 

	https://github.com/ceph/ceph/pull/2125

A couple minor fixes and then we can enable it in ceph_test_objectstore.

Also, I would love any feedback on wip-objectstore

	https://github.com/ceph/ceph/pull/2124

That one is RFC at this point.  I'm trying to simplify the ObjectStore 
interface as much as possible.

Thanks!
sage

	
