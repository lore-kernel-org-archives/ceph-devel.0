From: Sage Weil <sage@inktank.com>
Subject: radosstriper build failure on i386
Date: Wed, 25 Jun 2014 14:28:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406251427470.24410@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58325 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbaFYV2m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 17:28:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sebastien.ponce@cern.ch
Cc: ceph-devel@vger.kernel.org

Hi Sebastien,

There are several build errors we didn't notice before merging in 
radosstriper:

	http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-saucy-i386-basic/log.cgi?log=31b59d6626f64d4f5f4a1960b4084eaea7ed79f0

Do you mind taking a look?

Thanks!
sage
