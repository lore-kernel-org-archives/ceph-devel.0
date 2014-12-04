From: Sage Weil <sweil@redhat.com>
Subject: fadvise status
Date: Wed, 3 Dec 2014 22:56:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412022136370.24518@cobra.newdream.net>
References: <6AA21C22F0A5DA478922644AD2EC308C8F9021@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaLDG4z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Dec 2014 01:56:55 -0500
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C8F9021@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org

Hey,

I'm getting caught up after being out most of last week.  I see:

https://github.com/ceph/ceph/pull/2964

	client side librados and librbd changes.  ready to go

https://github.com/ceph/ceph/pull/2988

	osd changes.  look good, but needs a rebase (merge conflict?) and 
a test.  I think at this point you should rebase everything into a single 
branch so that you can use the client-side stuff to add some simple 
functional tests in ceph_test_rados_api_[a]io.

https://github.com/ceph/ceph/pull/2817

	I think this is superceded by the above changes.. can we just 
close it?

Thanks!
sage

