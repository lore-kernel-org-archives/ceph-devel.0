From: Sage Weil <sage@inktank.com>
Subject: master vs firefly branch
Date: Mon, 28 Apr 2014 13:56:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404281354510.26929@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56417 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbaD1U4C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Apr 2014 16:56:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-qa <ceph-qa@ceph.com>

We're separating the two branches now, so please be sure that anything 
destined for firefly (which should be almost nothing at this point) needs 
to target the firefly branch.  This will let us start integrating 
post-firefly stuff into master now.

Thanks!
sage

