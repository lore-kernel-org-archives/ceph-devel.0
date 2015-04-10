From: Sage Weil <sweil@redhat.com>
Subject: crush issues in v0.94 hammer
Date: Thu, 9 Apr 2015 17:35:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504091732340.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbbDJAfe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Apr 2015 20:35:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

We've identified two issues with CRUSH in the initial hammer release:

 - some crush hierarchies (those that use bucket type 5, usually "rack") 
will incorrectly believe they require a new crush feature bit.  This may 
prevent old clients (pre-hammer, or any kernel client) from connecting to 
the cluster.

 - the new straw2 bucket types will crash with bucket items with crush 
weight 0.

Both issues are fixed in the hammer development branch and will be fixed 
in 0.94.1, which will be out shortly.  If you hit either of these issues 
you can get packages directly from the gitbuilder 
(gitbuilder.ceph.com/*/ref/hammer), or wait for 0.94.1 before upgrading.

Thanks!
sage
