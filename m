From: Sage Weil <sage@newdream.net>
Subject: aarch64 test builds for trusty now available
Date: Thu, 24 Sep 2015 05:14:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509240509200.13834@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbbIXMOr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Sep 2015 08:14:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

We now have a gitbuilder up and running building test packages for arm64 
(aarch64).  The hardware for these builds has been graciously provided by 
Cavium (thank you!).

Trusty aarch64 users can now install packages with

 ceph-deploy install --dev BRANCH HOST

and build results are visible at

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-aarch64-basic/
http://gitbuilder.ceph.com/ceph-deb-trusty-aarch64-basic/ref/

I would love to expand this to include centos7 builds and to also have 
hardware to run make check (as we do on x86_64).  If you have reasonably 
powerful aarch64 hardware available and are willing to provide us with 
remote access please let me know off-list.

Thanks!
sage
