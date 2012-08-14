From: Sage Weil <sage@inktank.com>
Subject: weirdness upgrading to v0.48argonaut packages
Date: Tue, 14 Aug 2012 13:26:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208141324000.29021@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56704 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab2HNU0O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 16:26:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gcs@debian.hu
Cc: ceph-devel@vger.kernel.org

Hi Laszlo,

Because we moved mount.ceph from ceph-common to ceph-fs-common, upgrading 
to v0.48 can cause apt-get to complain (because mount.ceph is part of 
ceph-common).  One workaround is to do

 apt-get install ceph-common=v0.48argonaut ceph=v0.48argonaut

Is there something we should have done when making that change to avoid 
this problem, or is this an inevitable annoyance with rearranging the 
packages?  Is there a better workaround?

Thanks-
sage


http://tracker.newdream.net/issues/2945
