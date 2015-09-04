From: Sage Weil <sweil@redhat.com>
Subject: be nice to the gitbuilders -- don't push to ceph.git
Date: Fri, 4 Sep 2015 09:10:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509040908200.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57371 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759823AbbIDQKD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Sep 2015 12:10:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 9B718A37CB
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2015 16:10:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t84GA1XZ004458
	for <ceph-devel@vger.kernel.org>; Fri, 4 Sep 2015 12:10:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a friendly reminder to *only* push things to ceph.git that you 
need a build for (to run qa against).  Please push everything else to your 
private clone and issue your pull request from that.

The gitbuilders aren't able to keep up with the ceph.git branch update 
frequency, which means we often have to wait half a day before we get the 
build we *do* need to run teuthology.

Thanks!
sage
