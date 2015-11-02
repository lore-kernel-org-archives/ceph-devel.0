From: Sage Weil <sage@redhat.com>
Subject: ordered writeback for rbd client cache
Date: Mon, 2 Nov 2015 11:54:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511021150250.3903@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39156 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbKBTyF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 14:54:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: stephen.l.blinick@intel.com, jdurgin@redhat.com

Just found this:

	https://www.usenix.org/conference/fast13/technical-sessions/presentation/koller

which should be helpful in constructing a persistent client-side writeback 
cache for RBD that preserves consistency.

sage
