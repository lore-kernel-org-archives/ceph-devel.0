From: Sage Weil <sweil@redhat.com>
Subject: wip-ceph-disk
Date: Tue, 12 Aug 2014 17:48:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408121747240.3413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51024 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbaHMAse (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 20:48:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: adeza@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey Alfredo,

Can you take a look at these ceph-disk changes?

	https://github.com/ceph/ceph/pull/2247

The first few you saw yesterday, but the last few fix up ceph-disk list to 
do something useful when dmcrypt is used...

Thanks!
sage

