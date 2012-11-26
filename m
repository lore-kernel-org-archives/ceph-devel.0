From: Sage Weil <sage@inktank.com>
Subject: wip-crush
Date: Mon, 26 Nov 2012 09:01:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211260852530.945@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49673 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab2KZRBz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 12:01:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: caleb.miles@inktank.com
Cc: ceph-devel@vger.kernel.org

Hi Caleb-

Do you mind looking at wip-crush today?  First we should demonstrate with 
the crushtool tests that the change is in fact a Good Thing.  Setting lots 
of osds out inside a host and then doing chooseleaf over host should do 
it.

Then the compatibility bit hijinx need to be reviewed.  I'd like to get 
the feature bit into bobtail as that will accellerate our timeline for 
changing the defaults, but we need to be sure it is the right thing.

Thanks!
sage
