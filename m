From: Sage Weil <sage@inktank.com>
Subject: a few deb updates
Date: Tue, 1 Apr 2014 14:44:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404011443380.22715@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54909 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaDAVol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Apr 2014 17:44:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-maintainers@ceph.com
Cc: ceph-devel@vger.kernel.org

Can someone please review

	https://github.com/ceph/ceph/pull/1581

There are a couple of minor packages changes here that could use a second 
look.  Mostly just shifting things into ceph-common from ceph (since they 
can be used by clients too).

Thanks!
sage

